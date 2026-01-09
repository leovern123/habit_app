import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer';
import 'notification_service.dart';

class FcmService {
  static Future<void> initFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    log('Izin notifikasi: ${settings.authorizationStatus}');

     String? token = await messaging.getToken();
    log("Token FCM perangkat: $token");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Notifikasi masuk di foreground: ${message.notification?.title}');
      if (message.notification != null) {
        NotificationService.showNotification(
          id: message.hashCode,
          title: message.notification!.title ?? '',
          body: message.notification!.body ?? '',
        );
      }
    });