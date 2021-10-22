
import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPref {
  static SharedPref instance = SharedPref._();
  final String appSettingKey = "settings";
  var log = Logger();

  SharedPref._();

  static late SharedPreferences? _prefs;

  setAppSetting(var json)
  async{
    SharedPreferences pref = await SharedPreferences.getInstance();
      String prfApiSettings = jsonEncode(json);
      pref.setString('$appSettingKey', prfApiSettings);
      print("${pref.get("$appSettingKey")}");
  }
  getAppSetting(){
    try {
       Object appSetting = _prefs!.get("$appSettingKey")!;
        print("$appSetting");
    } catch (e) {
      log.d("$e");
    }
  }

  init() async {
    _prefs = await SharedPreferences?.getInstance();
  }


}
