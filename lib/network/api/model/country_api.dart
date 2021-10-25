import 'dart:convert';

import 'package:inbox_clients/network/api/dio_manager/dio_manage_class.dart';
import 'package:logger/logger.dart';

import 'app_response.dart';

class CountryApi {
  CountryApi._();
  static final CountryApi getInstance = CountryApi._();
  var log =  Logger();
  Future<AppResponse> getAppCountreis({var url , var header , var body})async{
    try {
      var response = await DioManagerClass.getInstance.dioPostMethod(url: url, header: header , body: body);
      log.d(AppResponse.fromJson(json.decode(response.toString())));
      return AppResponse.fromJson(json.decode(response.toString()));
    } catch (e) {
      return AppResponse.fromJson({});  
    }
   
  } 

}