import 'dart:convert';
import 'dart:io';


import 'package:get/get.dart';
import 'package:intl/locale.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SharedPref {

  static SharedPref instance = SharedPref._();

  SharedPref._();

  static late SharedPreferences? _prefs;

  static Future<SharedPreferences> get _instances async =>
      _prefs = await SharedPreferences.getInstance();

  init() async {
    _prefs = await SharedPreferences?.getInstance();
    _prefs = await _instances;
  }


}
