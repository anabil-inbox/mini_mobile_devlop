import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:inbox_clients/network/api/dio_manager/dio_manage_class.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';

import 'app_response.dart';

class ProfileApi {
  ProfileApi._();
  static final ProfileApi getInstance = ProfileApi._();

  Future<AppResponse> addNewAddress({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostMethod(url: url, header: header, body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
  }

  Future<AppResponse> getMyAddress({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioGetMethod(url: url, header: header);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
  }

  Future<AppResponse> uppdateAddress({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostMethod(url: url, header: header, body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
  }

  Future<AppResponse> deleteAddress({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostMethod(url: url, header: header, body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
  }

  Future<AppResponse> logOut({var url, var header}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioGetMethod(url: url, header: header);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
  }

  Future<AppResponse> editProfile({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, header: header, body: body);
      var jsonMap = json.decode(response.toString());
      if (jsonMap["status"]["success"] != false) {
        await SharedPref.instance.setCurrentUserData(response.toString());
      }
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
  }

  Future<AppResponse> getMyWallet({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioGetMethod(url: url, header: header);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
  }
}
