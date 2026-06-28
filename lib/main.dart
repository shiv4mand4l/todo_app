import 'package:flutter/material.dart';
import 'package:todo_app/helper/local_notification_service.dart';
import 'package:todo_app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Must be first!
  await initLocalNotification();

  runApp(const MyApp());
}
