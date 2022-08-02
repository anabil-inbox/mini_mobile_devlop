import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:inbox_clients/network/api/dio_manager/dio_manage_class.dart';
import 'package:logger/logger.dart';

import 'app_response.dart';

class FeatureApi {
  FeatureApi._();
  static final FeatureApi getInstance = FeatureApi._();

  Future<AppResponse> getAppFeature({var url , var header})async{
    try {
      var response = await DioManagerClass.getInstance.dioGetMethod(url: url, header: header);
      return AppResponse.fromJson(json.decode(response.toString()));
    }  on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance.handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message);
    }
   
  } 

}