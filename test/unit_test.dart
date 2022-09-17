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
import 'package:inbox_clients/util/math_func.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';

void main() {
  testMathFunction();
  testFormValidator();
}

void testFormValidator() {
  group("test Form Validator", (){

    test("here we need check if user email empty or not || if it valid or not", (){
      ///Arrange
      var userEmail = "";
      ///act
      var actual = Validator.isEmailEmpty(userEmail);
      ///assert
      expect(actual, 'Required');
    });//end test

    test("here we need check if user email empty or not || if it valid or not", (){
      ///Arrange
      var userEmail = "osaosaosa";
      ///act
      var actual = Validator.isEmailEmpty(userEmail);
      ///assert
      expect(actual, 'Enter Valid Email pls');
    });//end test

    test("here we need check happy scenario", (){
      ///Arrange
      var userEmail = "om@gmail.com";
      ///act
      var actual = Validator.isEmailEmpty(userEmail);
      ///assert
      expect(actual, null);
    });//end test

    test("here we need check if user password empty or not || if it valid or not", (){
      ///Arrange
      var userPassword = "";
      ///act
      var actual = Validator.isPasswordEmpty(userPassword);
      ///assert
      expect(actual, 'Required');
    });//end test

    test("here we need check if user password empty or not || if it valid or not", (){
      ///Arrange
      var userPassword = "sd";
      ///act
      var actual = Validator.isPasswordEmpty(userPassword);
      ///assert
      expect(actual, 'Enter Valid Password pls');
    });//end test

    test("here we need check happy scenario", (){
      ///Arrange
      var userPassword = "12341234";
      ///act
      var actual = Validator.isPasswordEmpty(userPassword);
      ///assert
      expect(actual, null);
    });//end test

  });//end group

}

void testMathFunction() {
  group("Math functions -test", (){
    test("we will check if it work good or not for add func", (){
      ///Arrange

      var a = 5;
      var b = 5;
      var matcher = 10;

      ///act

      var actual = addFunc(a, b);

      ///assert

      expect(actual, matcher);

    });

    test("we will check if it work good or not for multi func", (){
      ///Arrange

      var a = 5;
      var b = 5;
      var matcher = 25;

      ///act

      var actual = multiFunc(a, b);

      ///assert

      expect(actual, matcher);

    });

    test("we will check if it work good or not for subsc func", (){
      ///Arrange

      var a = 5;
      var b = 5;
      var matcher = 0;

      ///act

      var actual = subFunc(a, b);

      ///assert

      expect(actual, matcher);

    });
  });

}
