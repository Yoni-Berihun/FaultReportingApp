import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const int _kFixerNewReportsNotificationId = 90001;

class LocalNotificationService {
  LocalNotificationService._();
  static final LocalNotificationService instance = LocalNotificationService._();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _ready = false;

  Future<void> init() async {
    if (_ready) {
      return;
    }
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _plugin.initialize(settings);
    // Android 13+ runtime permission
    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidImpl = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      await androidImpl?.requestNotificationsPermission();
    }
    _ready = true;
  }

  Future<void> showNewOfflineReports(int count) async {
    if (count <= 0) {
      return;
    }
    await _plugin.show(
      _kFixerNewReportsNotificationId,
      'New fault reports',
      count == 1
          ? '1 new report arrived while you were offline.'
          : '$count new reports arrived while you were offline.',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'fixer_sync',
          'Fixer sync',
          channelDescription: 'New reports when reconnecting from offline',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
      ),
    );
  }
}
