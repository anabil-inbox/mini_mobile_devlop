import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:inbox_clients/network/api/dio_manager/dio_manage_class.dart';
import 'package:logger/logger.dart';

import 'app_response.dart';

class ItemApi{
  ItemApi._();
  static final ItemApi getInstance = ItemApi._(); 
  

    Future<AppResponse> getBoxBySerial({var url, var header,var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, header: header,body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance.handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message);
    }
  }


      Future<AppResponse> addItem({var url, var header,var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, header: header,body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance.handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message);
    }
  }

Future<AppResponse> deleteItem({var url, var header,var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, header: header,body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance.handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message);
    }
  }


  Future<AppResponse> updateItem({var url, var header,var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, header: header,body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance.handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message);
    }
  }
  
}