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
