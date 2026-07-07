import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// step1   instisance of local notification

final FlutterLocalNotificationsPlugin localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// step1.1
Future<void> initLocalNotification() async {
  // step2  init  local notification
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // step 3
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  // step 4
  await localNotificationsPlugin.initialize(settings: initializationSettings);

  // step 5 request notification permission for android 13+ (api 33+)
  await localNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.requestNotificationsPermission();
}

Future<void> showNotification({
  required String title,
  required String body,
}) async {
  const android = AndroidNotificationDetails(
    'local_notification',
    'Local Notification',
    channelDescription: 'This is a Local Notification',
    importance: Importance.max,
    priority: Priority.max,
  );
  // step 2
  const details = NotificationDetails(android: android);
  await localNotificationsPlugin.show(
    id: 0,
    title: title,
    body: body,
    notificationDetails: details,
  );
}
