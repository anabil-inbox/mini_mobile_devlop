import 'dart:convert';

import 'package:inbox_clients/network/api/dio_manager/dio_manage_class.dart';

import 'app_response.dart';

class FeatureApi {
  FeatureApi._();
  static final FeatureApi getInstance = FeatureApi._();

  Future<AppResponse> getAppFeature({var url , var header})async{
    try {
      var response = await DioManagerClass.getInstance.dioGetMethod(url: url, header: header);
      return AppResponse.fromJson(json.decode(response.toString()));
    } catch (e) {
      return AppResponse.fromJson({});  
    }
   
  } 

}