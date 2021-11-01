import 'dart:convert';

import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/language.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPref instance = SharedPref._();
  final String appSettingKey = "settings";
  final String languageKey = "language";
  final String isShowKey = "loading";
  final String currentUser = "currentUser";

  var log = Logger();

  SharedPref._();

  static late SharedPreferences? _prefs;

  setAppSetting(var json) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String prfApiSettings = jsonEncode(json);
    pref.setString('$appSettingKey', prfApiSettings);
  }

  setCurrentUserDate(var currentUser) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String prfCurrentUser = currentUser.toString();
    pref.setString('$currentUser', prfCurrentUser);
  }

  getCurrentUser() {
    try {
      Object currentUserObject = _prefs!.getString('$currentUser')!;
      return currentUserObject;
    } catch (e) {
      print('$e');
    }
  }

  getAppSetting() {
    try {
      Object appSetting = _prefs!.get("$appSettingKey")!;
      return appSetting;
    } catch (e) {
      log.d("$e");
    }
  }

  List<CompanySector>? getAppSectors() {
    try {
      return ApiSettings.fromJson(
              json.decode(_prefs!.get("$appSettingKey").toString()))
          .companySectors;
    } catch (e) {
      print("e");
    }
  }

  List<Language>? getAppLanguage() {
    try {
      return ApiSettings.fromJson(
              json.decode(_prefs!.get("$appSettingKey").toString()))
          .languges;
    } catch (e) {
      print("e");
    }
  }

  isShowProgress(bool? isShow) {
    // ignore: unnecessary_statements
    isShow == null ? isShow = false : isShow;
    _prefs?.setBool("$isShowKey", isShow);
  }

  getShowProgress() {
    try {
      return _prefs?.getBool("$isShowKey") ?? false;
    } catch (e) {
      print(e);
    }
  }

  setAppLanguage(var local) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('$languageKey', local.toString());
  }

  String getAppLanguageMain() {
    try {
      Object appLanguage = _prefs!.get("$languageKey")!;
      return appLanguage.toString();
    } catch (e) {
      return "en";
    }
  }

  getUserType() {
    return ApiSettings.fromJson(
            json.decode(_prefs!.get("$appSettingKey").toString()))
        .customerType
        .toString();
    // return "company";
    // return "both";
    //return "user";
  }

  init() async {
    _prefs = await SharedPreferences?.getInstance();
  }
}
