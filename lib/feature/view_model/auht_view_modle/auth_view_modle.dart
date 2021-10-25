import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:inbox_clients/feature/model/country.dart';
import 'package:inbox_clients/feature/model/user_modle.dart';
import 'package:inbox_clients/feature/view/screens/user_auth/verfication_code_user_screen.dart';
import 'package:inbox_clients/network/api/feature/auth_helper.dart';
import 'package:inbox_clients/network/api/feature/country_helper.dart';
import 'package:inbox_clients/network/api/model/app_response.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:logger/logger.dart';

class AuthViewModle extends GetxController{
    Logger log = Logger();
    TextEditingController tdSearch = TextEditingController();
    TextEditingController tdMobileNumber = TextEditingController();
    TextEditingController tdName = TextEditingController();
    TextEditingController tdEmail = TextEditingController();

    String? deviceName;
    String? identifier;

    bool isAccepte = true;
    Set<Country> countres = {};
    String? dropDown;
    int selectedIndex = -1;
    Country defCountry = Country(name: "Qatar", flag: "",prefix: "+974");
    bool isSelectedCountry = false;
    String deviceType = "";

  void changeAcception(bool newValue){
    isAccepte = newValue;
    update();
  }

  void onChangeDropDownList(String newValue){
    dropDown = newValue;
    update();
  }

  Future<Set<Country>> getCountries({int? page})async{
    print("msg_Iam_In_getCountries");
   await CountryHelper.getInstance.getCountryApi({"page": page}).then((value) =>{
      if(!GetUtils.isNull(value)){
      countres = value,
      update(),
    }
   });
  return countres;
  }

  Future<Status> signUpUser({User ?user}) async{
    Status status = Status();
    await AuthHelper.getInstance.registerUser(user!.toJson()).then((value) => {
      if(!GetUtils.isNull(value)){
      status =  value,
      update(),
      hideProgress(),
      Get.to(() => VerficationCodeUserScreen()),
    }
    }).catchError((onError){
     
      snackError("Erorr", "${status.message}");
    });
    
    return status;
  }  



  Future<List<String>> getDeviceDetails() async {

  String? deviceVersion;
  
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      deviceName = build.model;
      deviceVersion = build.version.toString();
      identifier = build.androidId; //UUID for Android
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      deviceName = data.name;
      deviceVersion = data.systemVersion;
      identifier = data.identifierForVendor; //UUID for iOS
    }
    update();
  } on PlatformException {
    print('Failed to get platform version');
  }
   return [deviceName!, deviceVersion!, identifier!];
}

     

  @override
  void onInit() {
    getDeviceDetails();
    if(Platform.isAndroid){
      deviceType = "android";
    }else{
       deviceType = "ios";
    }
    update();
    super.onInit();
  }
}