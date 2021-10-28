import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:inbox_clients/feature/model/country.dart';
import 'package:inbox_clients/feature/model/customer_modle.dart';
import 'package:inbox_clients/feature/model/user_model.dart';
import 'package:inbox_clients/feature/model/user_modle.dart';
import 'package:inbox_clients/feature/view/screens/auth_company/company_verfication_code.dart';
import 'package:inbox_clients/network/api/feature/auth_helper.dart';
import 'package:inbox_clients/network/api/feature/country_helper.dart';
import 'package:inbox_clients/network/api/model/app_response.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthViewModle extends GetxController {
  Logger log = Logger();
  //user text Controllers

  TextEditingController tdSearch = TextEditingController();
  TextEditingController tdMobileNumber = TextEditingController();
  TextEditingController tdName = TextEditingController();
  TextEditingController tdEmail = TextEditingController();

  //Company text Controllers
  TextEditingController tdcrNumber = TextEditingController();
  TextEditingController tdCompanyName = TextEditingController();
  TextEditingController tdCompanyEmail = TextEditingController();
  TextEditingController tdNameOfApplicant = TextEditingController();
  TextEditingController tdApplicantDepartment = TextEditingController();

  //terms & condistion variable
  bool isAccepte = false;

  //timer For Verfication code
  Timer? timer;
  int startTimerCounter = 60;
  String? companySector;
  String? temproreySectorName;
  Set<String> arraySectors = {};
  int selectedIndex = -1;

  String? deviceName;
  String? identifier;

  Set<Country> countres = {};
  String? dropDown;
  // for defoult country
  Country defCountry = Country(name: "Qatar", flag: "", prefix: "+974");
  bool isSelectedCountry = false;
  String deviceType = "";
  // for loading var
  bool isLoading = false;

  void changeAcception(bool newValue) {
    isAccepte = newValue;
    update();
  }

  void onChangeDropDownList(String newValue) {
    dropDown = newValue;
    update();
  }

  Future<Set<Country>> getCountries({int? page}) async {
    print("msg_Iam_In_getCountries");
    await CountryHelper.getInstance
        .getCountryApi({"page": page}).then((value) => {
              if (!GetUtils.isNull(value))
                {
                  countres = value,
                  update(),
                }
            });
    return countres;
  }

  Future<Customer> signUpUser({User? user}) async {
    Customer customer = Customer();
    isLoading = true;
    update();
    FocusScope.of(Get.context!).unfocus();
    await AuthHelper.getInstance.registerUser(user!.toJson()).then((value) => {
          if (value.status!.success!)
            {
              log.e(value.status!.toJson()),
              SharedPref.instance.setCurrentUserDate(value.data["Customer"],),
              isLoading = false,
              update(),
              snackSuccess("${AppLocalizations.of(Get.context!)!.success}",
                  "${value.status!.message}"),
              Get.to(CompanyVerficationCodeScreen(type: "user")),
            }
          else
            {
              log.e(value.status!.toJson()),
              isLoading = false,
              update(),
              snackError("${AppLocalizations.of(Get.context!)!.error_occurred}", "${value.status!.message}")
            }
        });

    return customer;
  }

  Future<Status> signUpCompany({Company? company}) async {
    isLoading = true;
    update();
    FocusScope.of(Get.context!).unfocus();
    Status status = Status();

    await AuthHelper.getInstance
        .registerCompany(company!.toJson())
        .then((value) => {print("${value.toString()}"), status = value.data});

    if (status.success!) {
      isLoading = false;
      update();
      snackSuccess(
          "${AppLocalizations.of(Get.context!)!.success}", "${status.message}");
      Get.to(CompanyVerficationCodeScreen(type: "company"));
    } else {
      isLoading = false;
      update();
      snackError("${status.success}", "${status.message}");
    }

    return status;
  }

  Future<Customer> signInUser({User? user}) async {
    Customer customer = Customer();
    isLoading = true;
    update();
    FocusScope.of(Get.context!).unfocus();
    await AuthHelper.getInstance.loginUser(user!.toJson()).then((value) => {

          if (value.status!.success!)
            { 
              SharedPref.instance.setCurrentUserDate(value.data["Customer"],),
              isLoading = false,
              update(),
              snackSuccess("${AppLocalizations.of(Get.context!)!.success}",
                  "${value.status!.message}"),
              Get.to(CompanyVerficationCodeScreen(type: "user")),
            }
          else
            {
              isLoading = false,
              update(),
              snackError("${AppLocalizations.of(Get.context!)!.error_occurred}", "${value.status!.message}")
            }
        });

    return customer;
  }

  Future<Company> signInCompany(Company company) async {
    isLoading = true;
    FocusScope.of(Get.context!).unfocus();
    Company company = Company();
    AuthHelper.getInstance.loginCompany({
      "cr_number": "${company.crNumber}",
      "udid": "${company.udid}",
      "device_type": "${company.deviceType}",
      "fcm": "${company.fcm}"
    }).then((value) => {
          company = value.data,
          SharedPref.instance.setCurrentUserDate(value.data),
          update()
        });

    return company;
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
    if (Platform.isAndroid) {
      deviceType = "android";
    } else {
      deviceType = "ios";
    }
    update();
    super.onInit();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (startTimerCounter == 0) {
          timer.cancel();
          update();
        } else {
          startTimerCounter--;
          update();
        }
      },
    );
  }
}
