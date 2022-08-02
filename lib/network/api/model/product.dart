import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:inbox_clients/network/api/dio_manager/dio_manage_class.dart';
import 'package:logger/logger.dart';

import 'app_response.dart';

class ProductApi {
  ProductApi._();

  static final ProductApi getInstance = ProductApi._();

  Future<AppResponse> getMyProducts({var url, var header, var body, var queryParameters}) async {
    try {
      var response = await DioManagerClass.getInstance.dioGetMethod(
          url: url, header: header, queryParameters: queryParameters);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance.handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message);
    }
  }

  Future<AppResponse> getProductDetails({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance.dioGetMethod(
          url: url, header: header, queryParameters: body);
      return AppResponse.fromJson(json.decode(response.toString())??{});
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance.handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message??{});
    }
  }

}