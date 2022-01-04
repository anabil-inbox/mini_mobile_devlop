
import 'dart:io';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';

class AppFcm {
  AppFcm._();
  static AppFcm fcmInstance = AppFcm._();
   init(){
    configuration();
    registerNotification();
    getTokenFCM();
  }
  ValueNotifier<int> notificationCounterValueNotifer =
  ValueNotifier(0);
   MethodChannel platform =
  MethodChannel('dexterx.dev/flutter_local_notifications_example');
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  RemoteMessage messages = RemoteMessage();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
      'com.ahdtech.filterqueen', // id
      'com.ahdtech.filterqueen', // title
      //  'IMPORTANCE_HIGH', // description
    importance: Importance.max,
    //showBadge: true,
  );


  void updatePages(RemoteMessage message) async{
    Future.delayed(Duration(seconds: 3)).then((value) {
      //flutterLocalNotificationsPlugin.cancelAll();
    });
  }

  configuration() async {
    // const AndroidInitializationSettings initializationSettingsAndroid =
    // AndroidInitializationSettings('drawable/icons_app');

    // final IOSInitializationSettings initializationSettingsIOS =
    // IOSInitializationSettings(
    //   requestAlertPermission: false,
    //   requestBadgePermission: false,
    //   requestSoundPermission: false,
    // );

    // final MacOSInitializationSettings initializationSettingsMacOS =
    // MacOSInitializationSettings(
    //   requestAlertPermission: false,
    //   requestBadgePermission: false,
    //   requestSoundPermission: false,
    // );

    // final InitializationSettings initializationSettings = InitializationSettings(
    //     android: initializationSettingsAndroid,
    //     iOS: initializationSettingsIOS,
    //     macOS: null);

    // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      //  onSelectNotification: selectNotification);
    final notificationAppLaunchDetails =
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      await selectNotification(notificationAppLaunchDetails?.payload);
    }
  }

  Future selectNotification(String? payload) async {
    try {
   //   RemoteMessage message = messages;
   //   goToOrderPage(messages.data);
    } catch (e) {
      print(e);
      Logger().d(e);
    }
  }


  void registerNotification() async {
   await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      //todo this for add badge for app
      // var android = message.data;
      if ( Platform.isIOS ||Platform.isAndroid) {
        messages = message;
        //todo this for update ui when recive message
        updatePages(message);
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              iOS: IOSNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
                /* subtitle: message.notification.body,*/
              ),
              android: AndroidNotificationDetails(
                  channel.id, channel.name,
                  // channel.description,
                  enableLights: true,
                  enableVibration: true,
                  fullScreenIntent: true,
                  autoCancel: true,
                  importance: Importance.max,
                  priority:Priority.high ,
                  color: colorPrimaryDark),
            ),
            payload: "${message.data}");
      }
    });
  }

  getTokenFCM() async{
    await _firebaseMessaging.getToken().then((token) async{
      Logger().d('token fcm : $token');
       await SharedPref.instance.setFCMToken(token.toString());
    }).catchError((err) {
      Logger().d(err);
    });
  }

  // static void goToOrderPage(Map<String ,dynamic> map){
  //   var serial = map["data"] ;
  //   var customerNum = map["body"];
  //   Get.to(OrderPage(customreNum: customerNum,serial: serial,));
  // }

}