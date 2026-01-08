import 'package:flutter/material.dart';
import 'package:uas_flutter/features/splash/presentation/splash_screen_1.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main()  async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

   await Supabase.initialize(
    url: 'https://ufdvmqxgferjhenuikcd.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVmZHZtcXhnZmVyamhlbnVpa2NkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njc3MzIwOTcsImV4cCI6MjA4MzMwODA5N30.EPu_NreyHGzmY1hjX4VTT3yBYssJiK42Q5fjd9_Zrvw',
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit App',
      theme: ThemeData(useMaterial3: true),
      home: SplashScreen1(),
      debugShowCheckedModeBanner: false,
    );
  }
}
