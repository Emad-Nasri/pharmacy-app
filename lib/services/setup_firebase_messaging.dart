import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void setupFirebaseMessaging() async {
  if (!kIsWeb) {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission();

    String? token = await messaging.getToken();
    print('FCM Token: $token');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received: ${message.notification?.title}');
    });
  } else {
    print('Skipping FCM setup for web');
  }
}
