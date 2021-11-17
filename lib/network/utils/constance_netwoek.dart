import 'package:get/get.dart';

abstract class ConstanceNetwork {
  ///todo here insert base_url
  static String imageUrl = "".trim();

  ///todo here insert key Of Request

  ///todo this for login request user
  static var contryCodeKey = "country_code";
  static var mobileKey = "mobile";
  static var udidKey = "udid";
  static var deviceTypeKey = "device_type";
  static var fcmKey = "fcm";
  static var emailKey = "email";


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

  static String verfiyCodeEndPoint = "inbox_app.api.auth.verfiy";

  static String recendVerficationCodeEndPoint = "inbox_app.api.auth.resend_code";

  static String addAddressEndPoint = "inbox_app.api.address.add";

  static String editAddressEndPoint = "inbox_app.api.address.edit";

  static String getMyAddressEndPoint = "inbox_app.api.address.get";

  static String deleteAdressEndPoint = "inbox_app.api.address.address_del"; 

  static String logOutEndPoint = "inbox_app.api.auth.logout";

  static String editProfilEndPoint = "inbox_app.api.auth.edit_profile";

  
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
        'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MzcwNzA0MTIuNzUxNjUzNCwibmJmIjoxNjM3MDcwNDEyLjc1MTY1MzQsImV4cCI6MTYzODM2NjQxMi43NTE2NTM0LCJkYXRhIjp7ImZ1bGxfbmFtZSI6ImtoYWxlZDIyMiIsIm5hbWUiOiJ0ZXN0IHVzZXIgMDkifX0.-jE8gOZDDoQh1U_1Uy4QO56A34s9dxHtb3GFnD495vM',
        'Content-Type': 'application/json',
        'Language': Get.locale.toString().split("_")[0],
        'Accept': 'application/json',
      };
    }

    return headers;
  }
}
