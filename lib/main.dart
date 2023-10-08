import 'package:flutter/material.dart';

import 'layout/home_screen.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

void main()async {
  runApp(MyApp());
 await AndroidAlarmManager.initialize();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

