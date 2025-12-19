import 'package:flutter/material.dart';
import 'package:uas_flutter/screen/splash_screen_2.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit App',
      theme: ThemeData(
        useMaterial3: true,

      ),
      home: MySplashScreen2(),
    debugShowCheckedModeBanner: false,
    );
  }
}