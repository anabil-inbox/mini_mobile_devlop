import 'package:get/get.dart';
import 'package:inbox_clients/util/sh_util.dart';

abstract class ConstanceNetwork {
  ///todo here insert base_url
  static String imageUrl = "http://50.17.152.72/".trim();

  // contsanse for Days Constance 
  static var sunday = "sunday";
  static var monday = "monday";
  static var tuesday = "tuesday";
  static var wednesday = "wednesday";
  static var thuersday = "thuersday";
  static var friday = "friday";
  static var saturday = "saturday";

  ///todo here insert key Of Request
  
  ///todo this for login request user
  static var contryCodeKey = "country_code";
  static var mobileKey = "mobile";
  static var udidKey = "udid";
  static var deviceTypeKey = "device_type";
  static var fcmKey = "fcm";
  static var emailKey = "email";


  ///todo this for add new contact key
  static var mobileNumberKey = "mobile_number";
  static var countryCodeKey = "country_code";
  ///todo this for add new contact key


  ///todo here insert end Point
  static String settingeEndPoint = "inbox_app.api.settings.api_settings";

  static String featureEndPoint = "inbox_app.api.settings.features";

  static String countryEndPoint = "inbox_app.api.settings.countries";

  static String registerUser = "inbox_app.api.auth.register";

  static String loginUser = "inbox_app.api.auth.login";

  static String registerCompany = "inbox_app.api.auth.company_register";

  static String loginCompany = "inbox_app.api.auth.company_login";

  static String userLoginedState = "logined";

  static String userStillNotVerifyState = "stillNotVerify";

  static String companyStillNotVerifyState = "CompanystillNotVerify";

  static String userEnterd = "enterd";

  static String verfiyCodeEndPoint = "inbox_app.api.auth.verfiy";

  static String recendVerficationCodeEndPoint = "inbox_app.api.auth.resend_code";

  static String addAddressEndPoint = "inbox_app.api.address.add";

  static String editAddressEndPoint = "inbox_app.api.address.edit";

  static String getMyAddressEndPoint = "inbox_app.api.address.get";

  static String deleteAdressEndPoint = "inbox_app.api.address.address_del"; 

  static String logOutEndPoint = "inbox_app.api.auth.logout";

  static String editProfilEndPoint = "inbox_app.api.auth.edit_profile";

  static String editProfilCompanyEndPoint = "inbox_app.api.auth.company_edit_profile";

  //todo this for storage end point
  static String storageCategoriesApi = "inbox_app.api.storage.categories";
  static String storageCheckQuantity = "inbox_app.api.quantity.quantity";
  static String storageAddOrder = "inbox_app.api.sales_order.sales_order";


  //todo this for constance type of user
  static String userType = "user";
  static String companyType = "company";
  static String bothType = "both";



  ///here keys of storage category type:
  static String spaceCategoryType = "Space";
  static String itemCategoryType = "Item";
  static var quantityCategoryType = "Quantity";
  static var driedCage = "Dried Space";

  ///here keys of duration status;
    static var dailyDurationType = "Daily";
    static var montlyDurationType = "Montly";
    static var yearlyDurationType = "yearly";
    static var unLimtedDurationType = "unlimited";
    
 //here block and enaeld Folder icons;
  static String enableFolder = "assets/svgs/folder_icon.svg";
  static String disableFolder = "assets/svgs/clocked_file.svg";
  
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
      print("msg_get_user_token_on_send_to_header ${SharedPref.instance.getUserToken()}");
      headers = {
        'Authorization': 'Bearer ${SharedPref.instance.getUserToken()}',
        'Content-Type': 'application/json',
        'Language': Get.locale.toString().split("_")[0],
        'Accept': 'application/json',
      };
    }

    return headers;
  }
}
