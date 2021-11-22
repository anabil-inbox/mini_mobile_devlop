import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:inbox_clients/network/api/dio_manager/dio_manage_class.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';

import 'app_response.dart';

class AuthApi {
  AuthApi._();
  static final AuthApi getInstance = AuthApi._();
  //todo this is for login request
  Future<AppResponse> loginRequest({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostMethod(url: url, body: body, header: header);
      await SharedPref.instance.setCurrentUserData(response.toString());
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);

      return AppResponse.fromJson(message);
    }
  }

  Future<AppResponse> signUpRequest({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostMethod(url: url, body: body, header: header);
      await SharedPref.instance.setCurrentUserData(response.toString());
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
  }

  Future<AppResponse> checkVerficationCodeRequset(
      {var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostMethod(url: url, body: body, header: header);
      Logger().e(response);
      if (response.toString().contains("Wrong code")) {
      } else {
        SharedPref.instance.setCurrentUserData(response.toString());
        SharedPref.instance.setUserToken(
            json.decode(response.toString())["data"]["access_token"] ??
                "${SharedPref.instance.getUserToken()}");
        SharedPref.instance
            .setUserLoginState("${ConstanceNetwork.userLoginedState}");
      }
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
  }

  Future<AppResponse> reSendVerficationCodeRequset(
      {var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostMethod(url: url, body: body, header: header);
      // SharedPref.instance.setCurrentUserDate(response.toString());
      // Logger().i(" 1 ${response.toString()}");
      // Logger().i(" 2 ${json.decode(response.toString())}");
      // Logger().i(" 3 ${json.decode(response.toString())["data"]["access_token"]}");
      // SharedPref.instance.setUserToken(json.decode(response.toString())["data"]["access_token"]);
      // SharedPref.instance.setUserLoginState("${ConstanceNetwork.userLoginedState}");
      SharedPref.instance.setCurrentUserData(response.toString());
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
  }
}
