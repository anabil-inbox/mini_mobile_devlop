import 'package:inbox_clients/network/api/model/app_response.dart';
import 'package:inbox_clients/network/api/model/auth.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:logger/logger.dart';

class AuthHelper {

  AuthHelper._();
  static final AuthHelper getInstance = AuthHelper._();
   Logger log = Logger();

  Future<dynamic> loginRequest(Map<String, dynamic> map) async {
    var appResponse = await AuthApi.getInstance.loginRequest(map);
    if (appResponse.status?.success == true) {

    } else {
    
    }
  }


  Future<Status> registerUser(Map<String , dynamic> body) async{ 
    var appResponse = await AuthApi.getInstance.signUpRequest(body: body,url: "${ConstanceNetwork.registerUser}" , header: ConstanceNetwork.header(0));
    if(appResponse.status?.success == true){
        return appResponse.status!;
    }else{
      hideProgress();
      snackError("Error","${appResponse.status!.message!}");
      return appResponse.status!;
    }
  
  }

}

