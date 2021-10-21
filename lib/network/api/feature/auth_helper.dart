import 'package:inbox_clients/network/api/model/auth.dart';

class AuthHelper {

  AuthHelper._();
  static final AuthHelper getInstance = AuthHelper._();

  ///todo here the request we will use it in the controller
  ///todo here we will get response from api and handler to custom model or return type
  Future<dynamic> loginRequest(Map<String, dynamic> map) async {
    var appResponse = await AuthApi.getInstance.loginRequest(map);
    if (appResponse.status!) {
      //todo here we return success data
    } else {
      //todo here we return fail data
    }
  }
}
