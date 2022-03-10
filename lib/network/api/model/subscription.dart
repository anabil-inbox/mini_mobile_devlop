import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:inbox_clients/network/api/dio_manager/dio_manage_class.dart';
import 'package:inbox_clients/network/api/model/app_response.dart';
import 'package:logger/logger.dart';

class Subscription {
  Subscription._();
  static final Subscription getInstance = Subscription._();

  Future<AppResponse> getSubscriptions({var url , var header, var map})async{
    try {
      var response = await DioManagerClass.getInstance.dioGetMethod(url: url, header: header ,queryParameters: map);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
  }

  Future<AppResponse> terminateSubscriptions({var url, var header, var body}) async{
    try {
      var response = await DioManagerClass.getInstance.dioPostMethod(url: url, header: header,body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
  }

}