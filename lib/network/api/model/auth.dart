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

      var jsonMap = json.decode(response.toString());

      if (jsonMap["status"]["success"] != false) {
       await SharedPref.instance.setCurrentUserData(response.toString());
             
        Logger().e(jsonMap["data"]["access_token"]);
       await SharedPref.instance.setUserToken(jsonMap["data"]["access_token"]);

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
          
      SharedPref.instance.setCurrentUserData(response.toString());
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
  }
}
