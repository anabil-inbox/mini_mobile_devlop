import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/storage/payment.dart';
import 'package:inbox_clients/feature/view/screens/home/home_page_holder.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/recived_order_screen.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/scan_recived_order_screen.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/order_details_screen.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/my_order_view_modle/my_order_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';

class AppFcm {
  AppFcm._();
  static AppFcm fcmInstance = AppFcm._();

  static HomeViewModel homeViewModel = Get.put(
    HomeViewModel(),
  );
  static StorageViewModel storageViewModel = Get.put(
    StorageViewModel(),
  );

  init() {
    configuration();
    registerNotification();
    getTokenFCM();
  }

  ValueNotifier<int> notificationCounterValueNotifer = ValueNotifier(0);
  MethodChannel platform =
      MethodChannel('dexterx.dev/flutter_local_notifications_example');
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  RemoteMessage messages = RemoteMessage();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'com.inbox.clients', // id
    'com.inbox.clients', // title
    //  'IMPORTANCE_HIGH', // description
    importance: Importance.max,
    //showBadge: true,
  );

  void updatePages(RemoteMessage message) async {
    await SharedPref.instance.setCurrentTaskResponse(taskResponse: jsonEncode(message.data));
    // Get.delete<HomeViewModel>();
    // Get.delete<StorageViewModel>();
    // homeViewModel =  Get.put(HomeViewModel());
    // storageViewModel =  Get.put(StorageViewModel());
    homeViewModel.expandableController.expanded = false;
    homeViewModel.expandableController.expanded = true;
    storageViewModel.update();
    homeViewModel.update();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {

    });
  }

  configuration() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('drawable/app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    // final MacOSInitializationSettings initializationSettingsMacOS =
    //     MacOSInitializationSettings(
    //   requestAlertPermission: false,
    //   requestBadgePermission: false,
    //   requestSoundPermission: false,
    // );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    final notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      await selectNotification(notificationAppLaunchDetails?.payload);
    }
  }

  Future selectNotification(String? payload) async {
    try {
      // RemoteMessage message = messages;
      Logger().e(messages);
      goToOrderPage(messages.data, isFromTerminate: false);
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
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: false,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      //todo this for add badge for app
      // var android = message.data;
      Logger().e("MSG_MESSAGE $message");
      Logger().e("MSG_NOT_MESSAGE $messages");
      Logger().e("MSG_NOT ${message.data.toString()}");
      if (Platform.isIOS || Platform.isAndroid) {
        messages = message;
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
                styleInformation: BigTextStyleInformation(''),
                enableLights: true,
                enableVibration: true,
                fullScreenIntent: true,
                autoCancel: true,
                importance: Importance.max,
                priority: Priority.high,
              ),
            ),
            payload: "${message.data}");
      }
    });
  }

  getTokenFCM() async {
    await _firebaseMessaging.getToken().then((token) async {
      Logger().d('token fcm : $token');
      await SharedPref.instance.setFCMToken(token.toString());
    }).catchError((err) {
      Logger().d(err);
    });
  }

  static void goToOrderPage(Map<String, dynamic> map,
      {required bool isFromTerminate}) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      print("MSG_BUG goToOrderPage $map");
      var serial = map;
      Logger().e("MSG_NOT ${map.toString()}");

      if (serial[LocalConstance.id].toString() == LocalConstance.submitId) {
        print("MSG_BUG LocalConstance.submitId $map");
        Get.put(MyOrderViewModle());
        Get.off(() => OrderDetailesScreen(
              orderId: serial[LocalConstance.salesOrder],
              isFromPayment: true,
            ));
        return;
      }
      /*else*/ if (serial[LocalConstance.id].toString() ==
          LocalConstance.scanBoxId) {
        print("MSG_BUG LocalConstance.scanBoxId $map");
        SharedPref.instance
            .setCurrentTaskResponse(taskResponse: jsonEncode(map));
        Logger().e(SharedPref.instance.getCurrentTaskResponse());
        Get.off(ScanRecivedOrderScreen(
          isBox: true,
          isProduct: false,
        ));
      }
      /*else*/ if (serial[LocalConstance.id].toString() ==
          LocalConstance.scanProductId) {
        print("MSG_BUG LocalConstance.scanProductId $map");
        SharedPref.instance.setCurrentTaskResponse(taskResponse: jsonEncode(map));

        storageViewModel.selectedPaymentMethod = PaymentMethod(
          id: SharedPref.instance.getCurrentTaskResponse()?.paymentMethod,
          name: SharedPref.instance.getCurrentTaskResponse()?.paymentMethod,
        );

        storageViewModel.update();
        Get.off(ReciverOrderScreen(homeViewModel));
        return;
      }
      /*else*/ if (serial[LocalConstance.id].toString() ==
          LocalConstance.orderDeleviredId) {
        print("MSG_BUG LocalConstance.orderDeleviredId $map");
        SharedPref.instance
            .setCurrentTaskResponse(taskResponse: jsonEncode(map));
        storageViewModel.selectedPaymentMethod = PaymentMethod(
          id: SharedPref.instance.getCurrentTaskResponse()?.paymentMethod,
          name: SharedPref.instance.getCurrentTaskResponse()?.paymentMethod,
        );
        storageViewModel.update();
        Get.off(ReciverOrderScreen(homeViewModel));
        print("MSG_BUG LocalConstance.endDelvired $map");
        return;
      }
      /*else*/ if (serial[LocalConstance.id].toString() ==
          LocalConstance.orderDoneId) {
        print("MSG_BUG LocalConstance.orderDoneId $map");
        Get.offAll(() => HomePageHolder());
        return;
      }
      if (serial[LocalConstance.id].toString() == LocalConstance.paymentRequiredId) {
        await SharedPref.instance.setCurrentTaskResponse(taskResponse: jsonEncode(map));
        homeViewModel.update();
        Get.off(() => ReciverOrderScreen(
              homeViewModel,
              isNeedToPayment: true,
            ));

        return;
      }
    });
  }
}
