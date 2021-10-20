import 'dart:convert';

import 'package:inbox_clients/network/api/dio_manager/dio_manage_class.dart';
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

  Future<AppResponse> signUpRequest(Map<String, dynamic> map) async {
    try {
      var response = await DioManagerClass.getInstance.dioPostMethod(url: "", body: map, header: {});
      return AppResponse.fromJson(json.decode(response.toString()));
    } catch (e) {
      Logger().d(e);
      return AppResponse.fromJson({});
    }
  }

}
