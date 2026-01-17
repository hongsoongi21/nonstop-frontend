import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../config/env_config.dart';
import '../config/app_config.dart';
import '../utils/logger.dart';

/// WebSocket connection states
enum WebSocketState { disconnected, connecting, connected, reconnecting, error }

/// WebSocket message types (extendable)
enum WebSocketMessageType { auth, message, typing, presence, ping, pong, error }

/// WebSocket message wrapper
class WebSocketMessage {
  final WebSocketMessageType type;
  final Map<String, dynamic> data;
  final DateTime timestamp;

  WebSocketMessage({
    required this.type,
    required this.data,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory WebSocketMessage.fromJson(Map<String, dynamic> json) {
    return WebSocketMessage(
      type: WebSocketMessageType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => WebSocketMessageType.message,
      ),
      data: json['data'] ?? {},
      timestamp: json['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['timestamp'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'data': data,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  @override
  String toString() => 'WebSocketMessage(type: ${type.name}, data: $data)';
}

/// WebSocket client with auto-reconnection and health monitoring
class WebSocketClient {
  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  Timer? _pingTimer;
  Timer? _reconnectTimer;

  final StreamController<WebSocketState> _stateController =
      StreamController<WebSocketState>.broadcast();
  final StreamController<WebSocketMessage> _messageController =
      StreamController<WebSocketMessage>.broadcast();

  WebSocketState _currentState = WebSocketState.disconnected;
  int _reconnectAttempts = 0;
  String? _authToken;

  /// Stream of connection state changes
  Stream<WebSocketState> get connectionState => _stateController.stream;

  /// Stream of incoming messages
  Stream<WebSocketMessage> get messages => _messageController.stream;

  /// Current connection state
  WebSocketState get currentState => _currentState;

  /// Check if currently connected
  bool get isConnected => _currentState == WebSocketState.connected;

  /// Check if connection is healthy (connected and responding to pings)
  bool get isHealthy => isConnected && _pingTimer?.isActive == true;

  /// Connect to WebSocket server
  Future<void> connect(String token) async {
    if (_currentState == WebSocketState.connecting ||
        _currentState == WebSocketState.connected) {
      return;
    }

    _authToken = token;
    _updateState(WebSocketState.connecting);

    try {
      final uri = Uri.parse(EnvConfig.wsBaseUrl);
      _channel = WebSocketChannel.connect(uri);

      await _channel!.ready;
      _updateState(WebSocketState.connected);

      // Set up message subscription
      _subscription = _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDisconnected,
      );

      // Send authentication
      await sendMessage(
        WebSocketMessage(
          type: WebSocketMessageType.auth,
          data: {'token': token},
        ),
      );

      // Start ping timer for health monitoring
      _startPingTimer();

      // Reset reconnect attempts on successful connection
      _reconnectAttempts = 0;
    } catch (e) {
      AppLogger.e('WebSocket connection failed: $e');
      _updateState(WebSocketState.error);
      _scheduleReconnect();
    }
  }

  /// Disconnect from WebSocket server
  Future<void> disconnect() async {
    _updateState(WebSocketState.disconnected);

    _pingTimer?.cancel();
    _reconnectTimer?.cancel();
    _subscription?.cancel();

    await _channel?.sink.close(status.goingAway);
    _channel = null;
    _authToken = null;
  }

  /// Send message to server
  Future<void> sendMessage(WebSocketMessage message) async {
    if (!isConnected || _channel == null) {
      throw Exception('WebSocket not connected');
    }

    try {
      final jsonString = jsonEncode(message.toJson());
      _channel!.sink.add(jsonString);

      if (!kReleaseMode) {
        AppLogger.i('📤 WebSocket sent: ${message.toString()}');
      }
    } catch (e) {
      AppLogger.e('Failed to send WebSocket message: $e');
      rethrow;
    }
  }

  /// Handle incoming messages
  void _onMessage(dynamic rawMessage) {
    try {
      final jsonData = jsonDecode(rawMessage as String) as Map<String, dynamic>;
      final message = WebSocketMessage.fromJson(jsonData);

      if (!kReleaseMode) {
        AppLogger.i('📥 WebSocket received: ${message.toString()}');
      }

      // Handle ping/pong for health monitoring
      if (message.type == WebSocketMessageType.ping) {
        _handlePing();
        return;
      }

      if (message.type == WebSocketMessageType.pong) {
        _handlePong();
        return;
      }

      // Emit message to listeners
      _messageController.add(message);
    } catch (e) {
      AppLogger.e('Failed to parse WebSocket message: $e');
    }
  }

  /// Handle WebSocket errors
  void _onError(Object error) {
    AppLogger.e('WebSocket error: $error');
    _updateState(WebSocketState.error);
    _scheduleReconnect();
  }

  /// Handle disconnection
  void _onDisconnected() {
    AppLogger.w('WebSocket disconnected');
    _updateState(WebSocketState.disconnected);
    _scheduleReconnect();
  }

  /// Update connection state
  void _updateState(WebSocketState newState) {
    if (_currentState != newState) {
      _currentState = newState;
      _stateController.add(newState);

      if (!kReleaseMode) {
        AppLogger.i('🔄 WebSocket state: ${newState.name}');
      }
    }
  }

  /// Schedule reconnection with exponential backoff
  void _scheduleReconnect() {
    if (_reconnectAttempts >= AppConfig.wsMaxReconnectAttempts) {
      AppLogger.e('Max reconnection attempts reached');
      return;
    }

    _updateState(WebSocketState.reconnecting);

    final delay =
        AppConfig.wsReconnectDelay *
        (1 << _reconnectAttempts); // Exponential backoff
    final clampedDelay = delay.inMilliseconds.clamp(0, 30000); // Max 30 seconds

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(Duration(milliseconds: clampedDelay), () {
      _reconnectAttempts++;
      if (_authToken != null) {
        connect(_authToken!);
      }
    });

    if (!kReleaseMode) {
      AppLogger.i(
        '⏰ Reconnecting in ${clampedDelay}ms (attempt $_reconnectAttempts)',
      );
    }
  }

  /// Start ping timer for health monitoring
  void _startPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(AppConfig.wsPingInterval, (_) {
      if (isConnected) {
        sendMessage(
          WebSocketMessage(
            type: WebSocketMessageType.ping,
            data: {'timestamp': DateTime.now().millisecondsSinceEpoch},
          ),
        );
      }
    });
  }

  /// Handle incoming ping
  void _handlePing() {
    // Respond with pong
    sendMessage(
      WebSocketMessage(
        type: WebSocketMessageType.pong,
        data: {'timestamp': DateTime.now().millisecondsSinceEpoch},
      ),
    );
  }

  /// Handle incoming pong (connection is healthy)
  void _handlePong() {
    // Connection is responding, keep ping timer active
    // This indicates the connection is healthy
  }

  /// Dispose of resources
  void dispose() {
    disconnect();
    _stateController.close();
    _messageController.close();
  }
}