import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:qud/database.dart';

class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging;

  void setUpFirebase() {
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessaging_Listeners();

  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        var notifiche = await Database.get('notifiche');
        if (notifiche == null) {
          notifiche = [];
        }
        String toStore = json.encode(message);
        notifiche.add(toStore);
        await Database.put('notifiche', notifiche);
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        var notifiche = await Database.get('notifiche');
        if (notifiche == null) {
          notifiche = [];
        }
        String toStore = json.encode(message);
        notifiche.add(toStore);
        await Database.put('notifiche', notifiche);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        var notifiche = await Database.get('notifiche');
        if (notifiche == null) {
          notifiche = [];
        }
        String toStore = json.encode(message);
        notifiche.add(toStore);
        await Database.put('notifiche', notifiche);
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}