import 'dart:convert';

import 'package:inbox_clients/network/api/dio_manager/dio_manage_class.dart';
import 'package:inbox_clients/network/api/model/app_response.dart';

class SplashApi {
  SplashApi._();
  static final SplashApi getInstance = SplashApi._();

  Future<AppResponse> getAppSettings({var url , var header})async{
    try {
      var response = await DioManagerClass.getInstance.dioGetMethod(url: url, header: header);
      return AppResponse.fromJson(json.decode(response.toString()));
    } catch (e) {
      return AppResponse.fromJson({});  
    }
   
  } 

}