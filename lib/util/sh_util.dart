
import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPref {
  static SharedPref instance = SharedPref._();
  final String appSettingKey = "settings";
  final String languageKey = "language";

  var log = Logger();

  SharedPref._();

  static late SharedPreferences? _prefs;

  setAppSetting(var json)
  async{
    SharedPreferences pref = await SharedPreferences.getInstance();
      String prfApiSettings = jsonEncode(json);
      pref.setString('$appSettingKey', prfApiSettings);
      
  }
  getAppSetting(){
    try {
       Object appSetting = _prefs!.get("$appSettingKey")!;
        print("$appSetting");
    } catch (e) {
      log.d("$e");
    }
  }



  setAppLanguage(var local)
  async{
    SharedPreferences pref = await SharedPreferences.getInstance();
     pref.setString('$languageKey', local.toString());

  }


  String getAppLanguage(){
    try {
        Object appLanguage = _prefs!.get("$languageKey")!;
        print("msg_On_get $appLanguage");
        return appLanguage.toString();
    } catch (e) {
     print("msg_error in get $e");
      return "";
    }
  }

  init() async {
    _prefs = await SharedPreferences?.getInstance();
  }


}
