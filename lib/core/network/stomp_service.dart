import 'dart:async';
import 'dart:convert';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import '../config/env_config.dart';
import '../utils/logger.dart';

/// Connection status for the UI to consume
enum StompConnectionState {
  disconnected,
  connecting,
  connected,
  error,
}

/// A wrapper around StompClient to handle authentication and app-specific logic
class StompService {
  StompClient? _client;
  
  final _stateController = StreamController<StompConnectionState>.broadcast();
  Stream<StompConnectionState> get stateStream => _stateController.stream;
  
  StompConnectionState _currentState = StompConnectionState.disconnected;
  StompConnectionState get currentState => _currentState;

  /// Connect to the STOMP server
  void connect({required String accessToken}) {
    if (_currentState == StompConnectionState.connected || 
        _currentState == StompConnectionState.connecting) {
      return;
    }

    _updateState(StompConnectionState.connecting);

    final wsUrl = EnvConfig.wsBaseUrl; // e.g. wss://api.nonstop.app/ws/v1/chat
    
    _client = StompClient(
      config: StompConfig(
        url: wsUrl,
        onConnect: _onConnect,
        onWebSocketError: (dynamic error) => _onError(error),
        onStompError: (StompFrame frame) => _onError(frame.body),
        onDisconnect: (StompFrame frame) => _onDisconnect(frame),
        // Pass the access token in the headers for handshake authentication
        stompConnectHeaders: {
          'Authorization': 'Bearer $accessToken',
        },
        webSocketConnectHeaders: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    _client?.activate();
  }

  void disconnect() {
    _client?.deactivate();
    _updateState(StompConnectionState.disconnected);
  }

  /// Subscribe to a specific topic (e.g. a chat room)
  /// Returns a function to unsubscribe.
  void Function() subscribe({
    required String destination, 
    required void Function(Map<String, dynamic>) callback
  }) {
    if (_client == null || !_client!.connected) {
      AppLogger.w('Attempted to subscribe while disconnected: $destination');
      return () {};
    }

    AppLogger.i('Subscribing to: $destination');
    
    return _client!.subscribe(
      destination: destination,
      callback: (StompFrame frame) {
        if (frame.body != null) {
          try {
            final data = jsonDecode(frame.body!);
            callback(data);
          } catch (e) {
            AppLogger.e('Failed to decode STOMP message: $e');
          }
        }
      },
    );
  }

  /// Send a message to a destination
  void send({
    required String destination,
    required Map<String, dynamic> body,
  }) {
    if (_client == null || !_client!.connected) {
      AppLogger.e('Attempted to send message while disconnected');
      return;
    }

    _client!.send(
      destination: destination,
      body: jsonEncode(body),
    );
  }

  void _onConnect(StompFrame frame) {
    AppLogger.i('STOMP Connected');
    _updateState(StompConnectionState.connected);
  }

  void _onError(dynamic error) {
    AppLogger.e('STOMP Error: $error');
    _updateState(StompConnectionState.error);
    // StompClient handles reconnection logic internally via config
  }

  void _onDisconnect(StompFrame frame) {
    AppLogger.i('STOMP Disconnected');
    _updateState(StompConnectionState.disconnected);
  }

  void _updateState(StompConnectionState newState) {
    _currentState = newState;
    _stateController.add(newState);
  }
}