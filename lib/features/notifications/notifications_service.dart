import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsService{
  static FirebaseMessaging messaging = FirebaseMessaging.instance ;
  init() async {
   await messaging.requestPermission();
   String? token = await messaging.getToken();
   log("Notifications token : $token");
   FirebaseMessaging.onBackgroundMessage(onBackgroundMessage) ;
  }

 Future onBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();

    log(message.notification?.title.toString()?? "Null");
  }
}