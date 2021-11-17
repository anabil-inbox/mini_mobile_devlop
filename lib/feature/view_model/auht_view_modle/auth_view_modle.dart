import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_auth_invisible/auth_strings.dart';
import 'package:flutter_local_auth_invisible/flutter_local_auth_invisible.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:inbox_clients/feature/model/country.dart';
import 'package:inbox_clients/feature/model/customer_modle.dart';
import 'package:inbox_clients/feature/model/user_model.dart';
import 'package:inbox_clients/feature/model/user_modle.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_company/verfication/company_verfication_code_view.dart';
import 'package:inbox_clients/feature/view/screens/profile/profile_screen.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/network/api/feature/auth_helper.dart';
import 'package:inbox_clients/network/api/feature/country_helper.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
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

  Future<Set<Country>> getCountries(int page, int pageSize) async {
    print("msg_in_get_Country");
    await CountryHelper.getInstance
        .getCountryApi({"page": page, "page_size": pageSize.toString()}).then(
            (value) => {
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
              SharedPref.instance.setCurrentUserDate(
                value.data["Customer"],
              ),
              isLoading = false,
              update(),
              snackSuccess("${AppLocalizations.of(Get.context!)!.success}",
                  "${value.status!.message}"),
              Get.to(() => CompanyVerficationCodeScreen(
                  mobileNumber: user.mobile!,
                  countryCode: user.countryCode!,
                  type: "${ConstanceNetwork.userType}")),
            }
          else
            {
              log.e(value.status!.toJson()),
              isLoading = false,
              update(),
              snackError("${AppLocalizations.of(Get.context!)!.error_occurred}",
                  "${value.status!.message}")
            }
        });

    return customer;
  }

  Future<Customer> signUpCompany({Company? company}) async {
    Customer customer = Customer();
    isLoading = true;
    update();
    FocusScope.of(Get.context!).unfocus();

    await AuthHelper.getInstance
        .registerCompany(company!.toJson())
        .then((value) => {
              if (value.status!.success!)
                {
                  SharedPref.instance.setCurrentUserDate(
                    value.data["Customer"],
                  ),
                  isLoading = false,
                  update(),
                  snackSuccess("${AppLocalizations.of(Get.context!)!.success}",
                      "${value.status!.message}"),
                  Get.to(() =>CompanyVerficationCodeScreen(
                      countryCode: company.countryCode!,
                      mobileNumber: company.mobile!,
                      type: "${ConstanceNetwork.companyType}")),
                }
              else
                {
                  log.e(value.status!.toJson()),
                  isLoading = false,
                  update(),
                  snackError(
                      "${AppLocalizations.of(Get.context!)!.error_occurred}",
                      "${value.status!.message}")
                }
            });

    return customer;
  }

  Future<Customer> signInUser({User? user}) async {
    Customer customer = Customer();
    isLoading = true;
    update();
    FocusScope.of(Get.context!).unfocus();
    await AuthHelper.getInstance.loginUser(user!.toJson()).then((value) => {
          if (value.status!.success!)
            {
              Logger().d(value.data["Customer"]),

              SharedPref.instance.setCurrentUserDate(
                Customer.fromJson(value.data["Customer"])
              ),
              isLoading = false,
              update(),
              snackSuccess("${AppLocalizations.of(Get.context!)!.success}",
                  "${value.status!.message}"),
              // Get.to(() =>CompanyVerficationCodeScreen(
              //     mobileNumber: user.mobile!,
              //     countryCode: user.countryCode!,
              //     type: "${ConstanceNetwork.userType}")),
              Get.offAll(() => ProfileScreen())
            }
          else
            {
              isLoading = false,
              update(),
              snackError("${AppLocalizations.of(Get.context!)!.error_occurred}",
                  "${value.status!.message}")
            }
        });

    return customer;
  }

  Future<Customer> signInCompany(Company company) async {
    
    Customer customer = Customer();
    isLoading = true;
    update();
    FocusScope.of(Get.context!).unfocus();

    AuthHelper.getInstance.loginCompany(company.toJson()).then((value) => {
          if (value.status!.success!)
            {
              Get.put(AuthViewModle()),
              Logger().d(value.data["Customer"]),
              SharedPref.instance.setCurrentUserDate(
                value.data["Customer"],
              ),
             // SharedPref.instance.setUserToken(value.data["access_token"]),
              isLoading = false,
              update(),
              
              snackSuccess("${AppLocalizations.of(Get.context!)!.success}",
                  "${value.status!.message}"),
              // Get.to(() => CompanyVerficationCodeScreen(
              //     mobileNumber: value.data["Customer"]["mobile"] ?? "",
              //     countryCode: value.data["Customer"]["country_code"] ?? "",
              //     type: "${ConstanceNetwork.companyType}")),
                Get.offAll(() => ProfileScreen())

            }
          else
            {
              print("msg_value ${value.toJson()}"),
              isLoading = false,
              update(),
              snackError("${AppLocalizations.of(Get.context!)!.error_occurred}",
                  "${value.status!.message}")
            }
        });

    return customer;
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
    } on PlatformException {}
    return [deviceName!, deviceVersion!, identifier!];
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

  void getPhonePlatform() {
    if (Platform.isAndroid) {
      deviceType = "android";
    } else {
      deviceType = "ios";
    }
  }

  void clearAllControllers() {
    tdSearch.clear();
    tdMobileNumber.clear();
    tdName.clear();
    tdEmail.clear();
    tdcrNumber.clear();
    tdCompanyName.clear();
    tdCompanyEmail.clear();
    tdNameOfApplicant.clear();
    tdApplicantDepartment.clear();
  }

  checkVerficationCode(
      {String? code,
      String? udid,
      String? mobileNumber,
      String? countryCode}) async {
    await AuthHelper.getInstance.checkVerficationCode({
      "id":
          "${SharedPref.instance.getCurrentUserData().id}",
      "udid": "$udid",
      "code": "$code",
      "mobile_number": "$mobileNumber",
      "country_code": "$countryCode"
    }).then((value) => {
          if (value.status!.success!)
            {
              snackSuccess("${AppLocalizations.of(Get.context!)!.success}",
                  "${value.status!.message}"),
              SharedPref.instance
                  .setUserLoginState("${ConstanceNetwork.userLoginedState}"),
              Get.off(() => ProfileScreen()),
            }
          else
            {
              snackError("${AppLocalizations.of(Get.context!)!.error_occurred}",
                  "${value.status!.message}")
            }
        });
  }

  reSendVerficationCode(
      {String? udid,
      String? target,
      String? mobileNumber,
      String? countryCode}) async {
    await AuthHelper.getInstance.checkVerficationCode({
      "id":"${SharedPref.instance.getCurrentUserData().id}",
      "udid": "$udid",
      "target": "$target",
      "mobile_number": "$mobileNumber",
      "country_code": "$countryCode"
    }).then((value) => {
          if (value.status!.success!)
            {
              snackSuccess("${AppLocalizations.of(Get.context!)!.success}",
                  "${value.status!.message}"),
              SharedPref.instance
                  .setUserLoginState("${ConstanceNetwork.userLoginedState}"),
              Get.off(() => ProfileScreen()),
            }
          else
            {
              snackError("${AppLocalizations.of(Get.context!)!.error_occurred}",
                  "${value.status!.message}")
            }
        });
  }

  //this for Touch/face (Id) Bottom Sheet :

  void showFingerPrinterDiloag() {
    Get.bottomSheet(Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(sizeH16!),
          color: colorTextWhite,
        ),
        height: sizeH200,
        child: Column(
          children: [
            SizedBox(
              height: sizeH32,
            ),
            Text(
              "${AppLocalizations.of(Get.context!)!.choose_way_to_sign_in}",
              style: textStyleHint()!.copyWith(color: colorBlack),
            ),
            SizedBox(
              height: sizeH16,
            ),
            GetBuilder<AuthViewModle>(
              init: AuthViewModle(),
              initState: (_) {},
              builder: (_) {
                return PrimaryButton(
                    isExpanded: true,
                    isLoading: isLoading,
                    textButton:
                        "${AppLocalizations.of(Get.context!)!.touch_id}",
                    onClicked: isLoading
                        ? () {}
                        : () async {
                            isLoading = true;
                            update();
                            await _checkBiometrics();
                            await _getAvailableBiometrics();
                            await _authenticate();
                            if (isAuth!) {
                              await signInUser(
                                  user: User(
                                      countryCode: "972",
                                      mobile: "123456789",
                                      udid: "2222222222",
                                      deviceType: "android",
                                      fcm: "112222222546546545"));
                            }
                            isLoading = false;
                            update();
                          });
              },
            ),
            SizedBox(
              height: sizeH16,
            ),
            GetBuilder<AuthViewModle>(
              builder: (_) {
                return PrimaryButton(
                    isExpanded: true,
                    isLoading: isLoading,
                    textButton: "${AppLocalizations.of(Get.context!)!.face_id}",
                    onClicked: () async {
                     isLoading = true;
                            update();
                            await _checkBiometrics();
                            await _getAvailableBiometrics();
                            await _authenticate();
                            if (isAuth!) {
                              await signInUser(
                                  user: User(
                                      countryCode: "972",
                                      mobile: "123456789",
                                      udid: "2222222222",
                                      deviceType: "android",
                                      fcm: "112222222546546545"));
                            }
                            isLoading = false;
                            update();
                    //  Get.to(()=> FacePage());
                    });
              },
            )
          ],
        )));
  }

  bool? isAuth = false;
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    _canCheckBiometrics = canCheckBiometrics;
    update();
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics = <BiometricType>[];
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    _availableBiometrics = availableBiometrics;
    update();
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
        localizedReason: 'Scan your fingerprint to authenticate',
        useErrorDialogs: true,
        stickyAuth: false,
      );
      
    } on PlatformException catch (e) {
      print(e);
    }
    _authorized = authenticated ? 'Authorized' : 'Not Authorized';
    isAuth = authenticated ? true : false;
    update();
  }


  Future<void> _authenticateFaceId() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
        androidAuthStrings:
            AndroidAuthMessages(signInTitle: "Face Id Required"),
        localizedReason: 'Scan your FaceId to authenticate',
        useErrorDialogs: true,
        stickyAuth: false,
      );
      var availableBiometrics = await auth.getAvailableBiometrics();
      var availableBiometric = availableBiometrics[0];
     
    } on PlatformException catch (e) {
      print(e);
    }
    _authorized = authenticated ? 'Authorized' : 'Not Authorized';
    isAuth = authenticated ? true : false;
    update();
  }

  Future<void> _checkBiometricsFaceId() async {
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    _canCheckBiometrics = canCheckBiometrics;
    update();
  }

    Future<void> _getAvailableBiometricsFaceId() async {
    List<BiometricType> availableBiometrics = <BiometricType>[];
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
      print("msg_avv ${availableBiometrics}");
    } on PlatformException catch (e) {
      print(e);
    }

    _availableBiometrics = availableBiometrics;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  //  startTimer();
    clearAllControllers();
    getDeviceDetails();
    getPhonePlatform();
    update();
  }
}
