import 'package:firebase_messaging/firebase_messaging.dart';

void setupFirebaseMessaging() {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // طلب الإذن
  messaging.requestPermission();

  // عند استقبال الإشعار والتطبيق مفتوح
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Foreground message: ${message.notification?.title}");
  });

  // عند الضغط على الإشعار
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("User clicked on notification");
  });
}
