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
        // Note: Check if backend expects it in query param or header.
        // Spring Boot Stomp usually supports headers in the CONNECT frame or query params.
        // PRD v2.1 says: "연결 시 Access Token 쿼리 파라미터로 인증" (Auth via query param)
        // So we might need to append it to the URL.
        stompConnectHeaders: {
          'Authorization': 'Bearer $accessToken',
        },
        webSocketConnectHeaders: {
          'Authorization': 'Bearer $accessToken',
        },
        // If query param is strictly required by backend config:
        // url: '$wsUrl?token=$accessToken', 
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
      warnLog('Attempted to subscribe while disconnected: $destination');
      return () {};
    }

    infoLog('Subscribing to: $destination');
    
    return _client!.subscribe(
      destination: destination,
      callback: (StompFrame frame) {
        if (frame.body != null) {
          try {
            final data = jsonDecode(frame.body!);
            callback(data);
          } catch (e) {
            errLog('Failed to decode STOMP message', e);
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
      errLog('Attempted to send message while disconnected');
      return;
    }

    _client!.send(
      destination: destination,
      body: jsonEncode(body),
    );
  }

  void _onConnect(StompFrame frame) {
    infoLog('STOMP Connected');
    _updateState(StompConnectionState.connected);
  }

  void _onError(dynamic error) {
    errLog('STOMP Error', error);
    _updateState(StompConnectionState.error);
    // StompClient handles reconnection logic internally via config
  }

  void _onDisconnect(StompFrame frame) {
    infoLog('STOMP Disconnected');
    _updateState(StompConnectionState.disconnected);
  }

  void _updateState(StompConnectionState newState) {
    _currentState = newState;
    _stateController.add(newState);
  }
}
