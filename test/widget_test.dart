// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/core/app_widget.dart';
import 'package:inbox_clients/feature/model/user_modle.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
// ignore_for_file: unused_field

import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/fcm/app_fcm.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/country.dart';
import 'package:inbox_clients/feature/model/customer_modle.dart';
import 'package:inbox_clients/feature/model/user_model.dart';
import 'package:inbox_clients/feature/model/user_modle.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_company/register/register_company.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_company/verfication/company_verfication_code_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_user/register/user_register_view.dart';
import 'package:inbox_clients/feature/view/screens/home/home_page_holder.dart';
import 'package:inbox_clients/feature/view/screens/profile/change_mobile/verfication_change_mobile.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/gloable_bottom_sheet.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/network/api/feature/auth_helper.dart';
import 'package:inbox_clients/network/api/feature/country_helper.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';


void main() {
  // defaultTestWidget();
  // firstTestLogin();
}

firstTestLogin() {
  test("test for login method", () async {
    AuthViewModle authViewModle = Get.put(AuthViewModle());
    var user = User(
      mobile: "595933777",
      countryCode: "+972",
      email: "om107547@gmail.com",
      fullName: "Osama",
      udid: "e232",
      deviceType: "android",
      fcm: "2343",
    );
    authViewModle.signInUser(user: user);
    expect(authViewModle.isLoading, false);
  });
}

defaultTestWidget() {
  //defaultTestWidget
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AppWidget());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

