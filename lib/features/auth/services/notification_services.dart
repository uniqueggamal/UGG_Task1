import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:internship_task/core/constants/app_endpoints.dart';

// ============================================================
// BACKGROUND HANDLER (must be top-level)
// ============================================================

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Background FCM message received.');
  debugPrint('Message ID: ${message.messageId}');
  debugPrint('Title: ${message.notification?.title}');
  debugPrint('Body: ${message.notification?.body}');
  debugPrint('Data: ${message.data}');
  // Keep lightweight. No BuildContext / UI here.
}

// ============================================================
// EXCEPTION
// ============================================================

class NotificationException implements Exception {
  final String message;
  NotificationException(this.message);

  @override
  String toString() => message;
}

// ============================================================
// SERVICE
// ============================================================

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const _androidChannelId = 'default_notification_channel';
  static const _androidChannelName = 'Default Notifications';

  // ============================================================
  // INITIALIZATION
  // ============================================================

  Future<void> initialize() async {
    // Register background handler as early as possible (also in main.dart)
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _initializeLocalNotifications();
    await _requestPermission();
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await getFcmToken();
    _listenForTokenRefresh();
    _listenForForegroundMessages();
    _listenForNotificationOpen();
    await _handleInitialMessage();
  }

  // ============================================================
  // LOCAL NOTIFICATIONS
  // ============================================================

  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings: initializationSettings, // ← named
      onDidReceiveNotificationResponse: _handleNotificationTap,
    );

    await _createAndroidNotificationChannel();
  }

  Future<void> _createAndroidNotificationChannel() async {
    const channel = AndroidNotificationChannel(
      _androidChannelId,
      _androidChannelName,
      description: 'Notifications from the application.',
      importance: Importance.high,
    );

    final androidPlugin = _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.createNotificationChannel(channel);

    // Android 13+
    await androidPlugin?.requestNotificationsPermission();
  }

  void _handleNotificationTap(NotificationResponse response) {
    debugPrint('Notification tapped. Payload: ${response.payload}');
    // TODO: parse payload and navigate if needed
  }

  // ============================================================
  // PERMISSION
  // ============================================================

  Future<NotificationSettings> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    debugPrint('Notification permission: ${settings.authorizationStatus}');
    return settings;
  }

  Future<NotificationSettings> getPermissionStatus() {
    return _messaging.getNotificationSettings();
  }

  // ============================================================
  // FCM TOKEN
  // ============================================================

  Future<String?> getFcmToken() async {
    try {
      final token = await _messaging.getToken();
      debugPrint('FCM token: $token');
      return token;
    } catch (e) {
      debugPrint('Failed to get FCM token: $e');
      return null;
    }
  }

  void _listenForTokenRefresh() {
    _messaging.onTokenRefresh.listen(
      (newToken) {
        debugPrint('FCM token refreshed: $newToken');
        // Register with backend when user is authenticated
      },
      onError: (error) {
        debugPrint('FCM token refresh error: $error');
      },
    );
  }

  Future<void> deleteFcmToken() async {
    try {
      await _messaging.deleteToken();
      debugPrint('FCM token deleted.');
    } catch (e) {
      debugPrint('Failed to delete FCM token: $e');
      throw NotificationException('Unable to delete FCM token.');
    }
  }

  // ============================================================
  // REGISTER TOKEN WITH LARAVEL
  // ============================================================

  Future<void> registerFcmToken({
    required String fcmToken,
    required String sanctumToken,
  }) async {
    final client = HttpClient();

    try {
      final request = await client.postUrl(Uri.parse(ApiEndpoints.fcmToken));

      request.headers.contentType = ContentType.json;
      request.headers.set(HttpHeaders.acceptHeader, 'application/json');
      request.headers.set(
        HttpHeaders.authorizationHeader,
        'Bearer $sanctumToken',
      );

      request.write(jsonEncode({'token': fcmToken}));

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      debugPrint('\nPOST: ${ApiEndpoints.fcmToken}');
      debugPrint('Status: ${response.statusCode}');
      debugPrint('Response: $responseBody');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return;
      }

      if (response.statusCode == 401) {
        throw NotificationException('Unauthorized request.');
      }
      if (response.statusCode == 422) {
        throw NotificationException('Invalid FCM token information.');
      }
      if (response.statusCode >= 500) {
        throw NotificationException('Server error. Please try again later.');
      }

      throw NotificationException(
        'FCM token registration failed. Status code: ${response.statusCode}',
      );
    } on NotificationException {
      rethrow;
    } on SocketException {
      throw NotificationException('Unable to connect to the server.');
    } on FormatException {
      throw NotificationException('Invalid response received from the server.');
    } finally {
      client.close();
    }
  }

  // ============================================================
  // FOREGROUND
  // ============================================================

  void _listenForForegroundMessages() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        debugPrint('Foreground FCM message received.');
        debugPrint('Message ID: ${message.messageId}');
        debugPrint('Title: ${message.notification?.title}');
        debugPrint('Body: ${message.notification?.body}');
        debugPrint('Data: ${message.data}');

        final notification = message.notification;
        if (notification == null) return;

        await showLocalNotification(
          title: notification.title ?? 'Notification',
          body: notification.body ?? '',
          payload: jsonEncode(message.data),
        );
      },
      onError: (error) {
        debugPrint('Foreground FCM message error: $error');
      },
    );
  }

  // ============================================================
  // OPENED FROM NOTIFICATION
  // ============================================================

  void _listenForNotificationOpen() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('App opened from notification (background).');
      debugPrint('Data: ${message.data}');
      // TODO: navigate based on message.data
    });
  }

  Future<void> _handleInitialMessage() async {
    final message = await _messaging.getInitialMessage();
    if (message == null) return;

    debugPrint('App opened from terminated state via notification.');
    debugPrint('Data: ${message.data}');
    // TODO: navigate based on message.data
  }

  // ============================================================
  // SHOW LOCAL NOTIFICATION
  // ============================================================

  Future<void> showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      _androidChannelId,
      _androidChannelName,
      channelDescription: 'Notifications from the application.',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
      payload: payload,
    );
  }
}
