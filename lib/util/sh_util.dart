import 'dart:convert';

import 'package:get/utils.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/customer_modle.dart';
import 'package:inbox_clients/feature/model/language.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPref instance = SharedPref._();
  final String appSettingKey = "settings";
  final String languageKey = "language";
  final String isShowKey = "loading";
  final String isHideKey = "hide";
  final String currentUser = "currentUser";
  final String loginKey = "login";
  final String fcmKey = "fcm";
  final String taskKey = "taskKey";
  final String tokenKey = "token";
  final String customrKey = "customerKey";
  final String userDataKey = "userData";
  final String boxessKey = "boxessKey";
  final String driverToken = "driverToken";
  final String isFirstHomeKey = "isFirstHome";
  final String isFirstStorageKey = "isFirstStorage";
  final String isFirstQtyKey = "isFirstQtyKey";
  final String isFirstAddressAndDate = "isFirstAddressAndDate";
  final String isFirstPayment = "isFirstPayment";
  final String isFirstReceivedOrder = "isFirstReceivedOrder";

  var log = Logger();

  SharedPref._();

  static SharedPreferences? _prefs;

  setDriverToken({required String token}) {
    _prefs?.setString(driverToken, token);
  }

  Future<String> getDriverToken() async {
    return _prefs?.getString(driverToken) ?? "";
  }

  setAppSetting(var json) async {
    String prfApiSettings = jsonEncode(json);
    _prefs?.setString('$appSettingKey', prfApiSettings);
  }

  setCurrentUserData(String profileData) async {
    try {
      print("msg_profile_data_to_save $profileData");

      bool? isSaved =
          await _prefs?.setString("$userDataKey", profileData.toString());
      print(isSaved);
    } catch (e) {
      Logger().e(e);
      return "$e";
    }
  }

  Customer getCurrentUserData() {
    try {
      if (getUserLoginState() == null ||
          getUserLoginState() == ConstanceNetwork.userEnterd) {
        return Customer();
      }
      var string = _prefs?.getString("$userDataKey") ?? "";
      var decode;
      if (GetUtils.isNull(json.decode(string)["data"]["Customer"])) {
        decode = json.decode(string)["data"];
      } else {
        decode = json.decode(string)["data"]["Customer"];
      }
      Customer profileData = Customer.fromJson(decode);
      return profileData;
    } catch (e) {
      Logger().e(e);
      return Customer();
    }
  }

  getAppSetting() {
    try {
      Logger().w(_prefs!.get("$appSettingKey"));
      Object appSetting = _prefs!.get("$appSettingKey")!;
      return appSetting;
    } catch (e) {
      log.d("$e");
    }
  }

  List<CompanySector>? getAppSectors() {
    try {
      Logger().i("sectore_${_prefs!.get("$appSettingKey")}");
      Logger().i(
          "sectore_${ApiSettings.fromJson(json.decode(_prefs!.get("$appSettingKey").toString())).companySectors}");
      return ApiSettings.fromJson(
              json.decode(_prefs!.get("$appSettingKey").toString()))
          .companySectors;
    } catch (e) {
      print("e");
      return null;
    }
  }

  ApiSettings? getAppSettings() {
    try {
      return ApiSettings.fromJson(
          json.decode(_prefs!.get("$appSettingKey").toString()));
    } catch (e) {
      print("e");
      return null;
    }
  }

  List<Language>? getAppLanguage() {
    try {
      return ApiSettings.fromJson(
              json.decode(_prefs!.get("$appSettingKey").toString()))
          .languges;
    } catch (e) {
      print("e");
      return null;
    }
  }

  isShowProgress(bool? isShow) {
    // ignore: unnecessary_statements
    isShow == null ? isShow = false : isShow;
    _prefs?.setBool("$isShowKey", isShow);
  }

  setIsHideSubscriptions(bool? hide) async {
    _prefs?.setBool("$isHideKey", hide!);
  }

  bool getIsHideSubscriptions() {
    return _prefs?.getBool("$isHideKey") ?? false;
  }

  //   setBoxesList({required List<Box> boxes}) {
  //   removeBoxess();
  //   _prefs?.setString(boxessKey, jsonEncode(boxes));
  // }

  // List<Box> getBoxesList() {
  //   try {
  //     String? objectStr = _prefs?.getString(boxessKey);
  //     return List<Box>.from(
  //         json.decode(objectStr!).map((x) => Box.fromJson(x)));
  //   } catch (e) {
  //     return [];
  //   }
  // }

  // removeBoxess() async {
  //   try {
  //     await _prefs?.remove(boxessKey);
  //   } catch (e) {
  //     Logger().e(e);
  //   }
  // }

  getShowProgress() {
    try {
      return _prefs?.getBool("$isShowKey") ?? false;
    } catch (e) {
      print(e);
    }
  }

  setAppLanguage(var local) async {
    _prefs?.setString('$languageKey', local.toString());
    print("exxx:${local.toString()}");
  }

  String getAppLanguageMain() {
    try {
      Object appLanguage = _prefs!.get("$languageKey") ?? "en";
      return appLanguage.toString();
    } catch (e) {
      return "en";
    }
  }

  getUserType() {
    return _prefs!.getString("$customrKey") ?? "";
  }

  setUserType(String customerType) {
    _prefs!.setString("$customrKey", customerType);
  }

  setUserLoginState(String state) async {
    try {
      _prefs!.setString('$loginKey', '$state');
    } catch (e) {
      return "not Logined";
    }
  }

  getUserLoginState() {
    try {
      return _prefs!.getString('$loginKey');
    } catch (e) {
      print(e);
      return "";
    }
  }

  init() async {
    _prefs = await SharedPreferences?.getInstance();
  }

  setFCMToken(String fcmToken) async {
    try {
      _prefs?.setString("$fcmKey", fcmToken);
    } catch (e) {}
  }

  String getFCMToken() {
    return _prefs!.getString("$fcmKey") ?? "";
  }

  setUserToken(String token) async {
    Logger().i("msg_sett_user_token $token");
    try {
      if (!GetUtils.isNull(token)) {
        _prefs?.setString("$tokenKey", token);
      }
    } catch (e) {}
  }

  getUserToken() {
    try {
      return _prefs?.getString('$tokenKey');
    } catch (e) {
      Logger().e("msg_get_user_token_error $e");
      return "";
    }
  }

  // TaskResponse? getCurrentTaskResponse() {
  //   try {
  //     String? objectStr = _prefs?.getString(taskKey);
  //     return TaskResponse.fromJson(jsonDecode(objectStr ?? ""));
  //   } catch (e) {
  //     Logger().e(e.toString());
  //     return null;
  //   }
  // }

  // setCurrentTaskResponse({required String taskResponse}) async{
  //   await _prefs?.remove(taskKey);
  //   await _prefs?.setString(taskKey, taskResponse);
  // }

  setFirstHome(bool value) async {
    await _prefs?.setBool(isFirstHomeKey, value);
  }

  setFirstStorageKey(bool value) async {
    await _prefs?.setBool(isFirstStorageKey, value);
  }

  setFirstQtyKey(bool value) async {
    await _prefs?.setBool(isFirstQtyKey, value);
  }

  setFirstAddressAndDateKey(bool value) async {
    await _prefs?.setBool(isFirstAddressAndDate, value);
  }

  setFirstPaymentKey(bool value) async {
    await _prefs?.setBool(isFirstPayment, value);
  }

  setFirstReceivedOrderKey(bool value) async {
    await _prefs?.setBool(isFirstReceivedOrder, value);
  }

  bool getFirstHome() {
    return /*_prefs?.getBool(isFirstHomeKey) ?? false*/ true;
  }

  bool getFirstStorageKey() {
    return /*_prefs?.getBool(isFirstStorageKey) ?? false*/ true;
  }

  bool getFirstQtyKey() {
    return /*_prefs?.getBool(isFirstQtyKey) ?? false*/ true;
  }

  bool getFirstAddressAndDateKey() {
    return /*_prefs?.getBool(isFirstAddressAndDate) ?? false*/ true;
  }

  bool getFirstPaymentKey() {
    return /*_prefs?.getBool(isFirstPayment) ?? false*/ true;
  }

  bool getFirstReceivedOrderKey() {
    return /*_prefs?.getBool(isFirstReceivedOrder) ?? false*/ true;
  }
}
