import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer';
import 'notification_service.dart';

class FcmService {
  static Future<void> initFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;