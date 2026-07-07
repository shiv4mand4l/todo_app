import 'package:flutter/material.dart';
import 'package:todo_app/helper/local_notification_service.dart';

class LocalFlutterNotificationScreen extends StatefulWidget {
  const LocalFlutterNotificationScreen({super.key});

  @override
  State<LocalFlutterNotificationScreen> createState() =>
      _LocalFlutterNotificationScreenState();
}

class _LocalFlutterNotificationScreenState
    extends State<LocalFlutterNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Local Notification')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              showNotification(
                title: 'This is From local notification ',
                body: 'body',
              );
            },
            child: Text('Notification'),
          ),
        ],
      ),
    );
  }

  // for notifiation

  // Future<void> showNotification() async {
  //   const android = AndroidNotificationDetails(
  //     'local_notification',
  //     'Local Notification',
  //     channelDescription: 'This is a Local Notification',
  //     importance: Importance.max,
  //     priority: Priority.max,
  //   );
  //   // step 2
  //   const details = NotificationDetails(android: android);
  //   await localNotificationsPlugin.show(
  //     id: 1,
  //     title: 'Hello, this is my first notifiation title',
  //     body: 'this is body description',
  //     notificationDetails: details,
  //   );
  // }
}
