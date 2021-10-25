import 'dart:convert';

import 'package:inbox_clients/network/api/dio_manager/dio_manage_class.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:logger/logger.dart';

import 'app_response.dart';

class AuthApi {
  AuthApi._();
 static final AuthApi getInstance = AuthApi._();
  //todo this is for login request
  Future<AppResponse> loginRequest(Map<String, dynamic> map) async {
    try {
      var response = await DioManagerClass.getInstance.dioPostMethod(url: "", body: map, header: {});
      return AppResponse.fromJson(json.decode(response.toString()));
    } catch (e) {
      Logger().d(e);
      return AppResponse.fromJson({});
    }
  }

  Future<AppResponse> signUpRequest({var url , var header , var body}) async {
    try {
      showProgress();
      var response = await DioManagerClass.getInstance.dioPostMethod(url: url, body: body, header: {});
      return AppResponse.fromJson(json.decode(response.toString()));
    } catch (e) {
      hideProgress();
      Logger().d(e);
      return AppResponse.fromJson({});
    }
  }

}
