import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:inbox_clients/network/api/dio_manager/dio_manage_class.dart';
import 'package:logger/logger.dart';

import 'app_response.dart';

class CountryApi {
  CountryApi._();
  static final CountryApi getInstance = CountryApi._();
  var log =  Logger();
  Future<AppResponse> getAppCountreis({var url , var header , var queryParameters })async{
    try {
      var response = await DioManagerClass.getInstance.dioGetMethod(url: url, header: header , queryParameters: queryParameters);
      log.d(AppResponse.fromJson(json.decode(response.toString())));
      return AppResponse.fromJson(json.decode(response.toString()));
    }  on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
   
  } 

}