import 'package:get/get.dart';

abstract class ConstanceNetwork {
  ///todo here insert base_url
  static String imageUrl ="".trim();
  ///todo here insert key Of Request
  
  ///todo this for login request user
  static var contryCodeKey ="country_code";
  static var mobileKey ="mobile";
  static var udidKey ="udid";
  static var deviceTypeKey ="device_type";
  static var fcmKey ="fcm";
  static var emailKey ="email";

  // "country_code": "",
  //  "mobile": "4407177777",
  //  "udid": "2222222222", 
  //  "device_type": "android",
  //  "fcm": "112222222546546545",
  //  "email":""

  
  ///todo here insert end Point
  static String settingeEndPoint = "inbox_app.api.settings.api_settings";

  static String featureEndPoint = "inbox_app.api.settings.features";

  static String countryEndPoint = "inbox_app.api.settings.countries";

  static String registerUser = "inbox_app.api.auth.register";

  static String loginUser = "inbox_app.api.auth.login";

  static String registerCompany = "inbox_app.api.auth.company_register";
                                  
  static String loginCompany = "inbox_app.api.auth.company_login";

    static String userLoginedState = "logined";
    static String userEnterd = "enterd";


  //todo this for constance type of user
  static String userType = "user";
  static String companyType = "company";
  static String bothType = "both";

  static Map<String, String> header(int typeToken) {
    Map<String, String> headers = {};
    if (typeToken == 0) {
      headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Language': Get.locale.toString().split("_")[0],
      };
    } else if (typeToken == 1) {
      headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };
    } else if (typeToken == 2) {
      headers = {
        //    'Authorization': '${SharedPref.instance.getToken().toString()}',
      };
    } else if (typeToken == 3) {
      headers = {
        //  'Authorization': '${SharedPref.instance.getToken().toString()}',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
    } else if (typeToken == 4) {
      headers = {
        //  'Authorization': '${SharedPref.instance.getToken().toString()}',
        'Content-Type': 'application/json'
      };
    }

    return headers;
  }



}
