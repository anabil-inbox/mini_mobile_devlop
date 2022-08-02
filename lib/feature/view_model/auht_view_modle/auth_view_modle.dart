// ignore_for_file: unused_field

import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/fcm/app_fcm.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/country.dart';
import 'package:inbox_clients/feature/model/customer_modle.dart';
import 'package:inbox_clients/feature/model/user_model.dart';
import 'package:inbox_clients/feature/model/user_modle.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_company/register/register_company.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_company/verfication/company_verfication_code_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_user/register/user_register_view.dart';
import 'package:inbox_clients/feature/view/screens/home/home_page_holder.dart';
import 'package:inbox_clients/feature/view/screens/profile/change_mobile/verfication_change_mobile.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/gloable_bottom_sheet.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/network/api/feature/auth_helper.dart';
import 'package:inbox_clients/network/api/feature/country_helper.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';

class AuthViewModle extends GetxController {
  Logger log = Logger();

  //user text Controllers

  TextEditingController tdSearch = TextEditingController();
  TextEditingController tdMobileNumber = TextEditingController();
  TextEditingController tdMobileNumberOperator = TextEditingController();
  TextEditingController tdName = TextEditingController();
  TextEditingController tdEmail = TextEditingController();
  TextEditingController tdPinCode = TextEditingController();

  //Company text Controllers
  TextEditingController tdcrNumber = TextEditingController();
  TextEditingController tdCompanyName = TextEditingController();
  TextEditingController tdCompanyEmail = TextEditingController();
  TextEditingController tdCompanyEmailOperator = TextEditingController();
  TextEditingController tdNameOfApplicant = TextEditingController();
  TextEditingController tdApplicantDepartment = TextEditingController();

  //terms & condistion variable
  bool isAccepte = false;

  //timer For Verfication code
  Timer? timer;
  int startTimerCounter = 60;

  CompanySector? companySector = CompanySector();
  CompanySector? temproreySectorName;
  Set<String> arraySectors = {};
  int selectedIndex = -1;

  String? deviceName;
  String? identifier;

  Set<Country> countres = {};
  String? dropDown;

  // for defoult country
  Country defCountry = Country(name: "Qatar", flag: "", prefix: "+974");
  Country defCountryOperator = Country(name: "Qatar", flag: "", prefix: "+974");
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
    await CountryHelper.getInstance.getCountryApi({
      ConstanceNetwork.page: page,
      ConstanceNetwork.pageSize: pageSize.toString()
    }).then((value) => {
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
              isLoading = false,
              update(),
              Get.to(() => CompanyVerficationCodeScreen(
                  id: value.data[ConstanceNetwork.customerKey]
                      [ConstanceNetwork.idKey],
                  mobileNumber: user.mobile!,
                  countryCode: user.countryCode!,
                  type: "${ConstanceNetwork.userType}")),
            }
          else
            {
              log.e(value.status!.toJson()),
              isLoading = false,
              update(),
              snackError("${tr.error_occurred}", "${value.status!.message}")
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
                  isLoading = false,
                  update(),
                  Get.to(() => CompanyVerficationCodeScreen(
                      id: value.data[ConstanceNetwork.customerKey]
                          [ConstanceNetwork.idKey],
                      countryCode: company.countryCode!,
                      mobileNumber: company.mobile!,
                      type: "${ConstanceNetwork.companyType}")),
                }
              else
                {
                  log.e(value.status!.toJson()),
                  isLoading = false,
                  update(),
                  snackError("${tr.error_occurred}", "${value.status!.message}")
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
              Logger().d(value.data[ConstanceNetwork.customerKey]),
              isLoading = false,
              update(),
              Get.to(() => CompanyVerficationCodeScreen(
                  id: value.data[ConstanceNetwork.customerKey]
                      [ConstanceNetwork.idKey],
                  mobileNumber: user.mobile!,
                  countryCode: user.countryCode!,
                  type: "${ConstanceNetwork.userType}")),
            }
          else
            {
              if(value.status?.code ==417)
              Get.bottomSheet(GlobalBottomSheet(
                title: tr.register_new_user,
                onCancelBtnClick: ()=> Get.back(),
                onOkBtnClick: ()=> Get.off(() => UserRegisterScreen()),
              ),),
              isLoading = false,
              update(),
              snackError("${tr.error_occurred}", "${value.status!.message}")
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
              Logger().d(value.data[ConstanceNetwork.customerKey]),
              isLoading = false,
              update(),
              Get.to(() => CompanyVerficationCodeScreen(
                  id: value.data[ConstanceNetwork.customerKey]
                      [ConstanceNetwork.idKey],
                  mobileNumber: value.data[ConstanceNetwork.customerKey]
                          [ConstanceNetwork.mobileNumberKey] ??
                      "",
                  countryCode: value.data[ConstanceNetwork.customerKey]
                          [ConstanceNetwork.contryCodeKey] ??
                      "",
                  type: "${ConstanceNetwork.companyType}")),
            }
          else
            {
              print("msg_value ${value.toJson()}"),
              isLoading = false,
              update(),
              if(value.status?.code ==417)
              Get.bottomSheet(GlobalBottomSheet(
                title: tr.register_new_user,
                onCancelBtnClick: ()=> Get.back(),
                onOkBtnClick: ()=> Get.off(() => RegisterCompanyScreen()),
              ),),
              snackError("${tr.error_occurred}", "${value.status!.message}")
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
      String? id,
      String? mobileNumber,
      String? countryCode}) async {
    Map<String, dynamic> params = Map<String, dynamic>();

    params[ConstanceNetwork.idKey] = id;
    params[ConstanceNetwork.udidKey] = identifier;
    params[ConstanceNetwork.codeKey] = code;
    if (mobileNumber.toString().isNotEmpty &&
        countryCode.toString().isNotEmpty) {
      params["${ConstanceNetwork.mobileNumberKey}"] = mobileNumber;
      params[ConstanceNetwork.contryCodeKey] = countryCode;
    }

    await AuthHelper.getInstance.checkVerficationCode(params).then((value) => {
          if (value.status!.success!)
            {
              // snackSuccess("${tr.success}", "${value.status!.message}"),
              Get.put(ProfileViewModle()),
              //Get.off(() => ProfileScreen()),
              Get.offAll(() => HomePageHolder()),
            }
          else
            {snackError("${tr.error_occurred}", "${value.status!.message}")}
        });
  }

  reSendVerficationCode({
    String? udid,
    String? id,
    String? target,
    String? mobileNumber,
    String? countryCode,
    bool isFromChange = false,
  }) async {
    isLoading = true;
    update();
    await AuthHelper.getInstance.reSendVerficationCode({
      ConstanceNetwork.idKey: "$id",
      ConstanceNetwork.udidKey: "$udid",
      ConstanceNetwork.targetKey: "$target",
      "${ConstanceNetwork.mobileNumberKey}": "$mobileNumber",
      ConstanceNetwork.contryCodeKey: "$countryCode"
    }).then((value) => {
          if (value.status!.success!)
            {
              isLoading = false,
              startTimerCounter = 60,
              startTimer(),
              update(),
              // snackSuccess("${tr.success}", "${value.status!.message}"),
              isFromChange
                  ? Get.to(() => VerficationChangeMobilScreen(
                        id: id ?? "",
                        mobileNumber: mobileNumber ?? "",
                        countryCode: countryCode ?? "",
                      ))
                  : {},
            }
          else
            {
              isLoading = false,
              update(),
              snackError("${tr.error_occurred}", "${value.status!.message}")
            }
        });
  }

  //this for Touch/face (Id) Bottom Sheet :
  logInWithTouchId() async {
    try {
      isLoading = true;
      update();
      await _checkBiometrics();
      await _getAvailableBiometrics();
      await _authenticate();
      if (isAuth! &&
          SharedPref.instance
              .getCurrentUserData()
              .crNumber
              .toString()
              .isEmpty) {
        await signInUser(
            user: User(
                countryCode:
                    "${SharedPref.instance.getCurrentUserData().countryCode}",
                mobile: "${SharedPref.instance.getCurrentUserData().mobile}",
                udid: "$identifier",
                deviceType: "$deviceType",
                fcm: "${SharedPref.instance.getFCMToken()}"));
      } else if (isAuth! &&
          SharedPref.instance
              .getCurrentUserData()
              .crNumber
              .toString()
              .isNotEmpty) {
        await signInCompany(
          Company(
              crNumber: SharedPref.instance.getCurrentUserData().crNumber,
              deviceType: deviceType,
              udid: identifier,
              fcm: "${SharedPref.instance.getFCMToken()}"),
        );
      }
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
    }
  }

  // void showFingerPrinterDiloag() {
  //   Get.bottomSheet(Container(
  //       padding: EdgeInsets.symmetric(horizontal: 16),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(sizeH16!),
  //         color: colorTextWhite,
  //       ),
  //       height: sizeH200,
  //       child: Column(
  //         children: [
  //           SizedBox(
  //             height: sizeH32,
  //           ),
  //           Text(
  //             "${tr.choose_way_to_sign_in}",
  //             style: textStyleHint()!.copyWith(color: colorBlack),
  //           ),
  //           SizedBox(
  //             height: sizeH16,
  //           ),
  //           GetBuilder<AuthViewModle>(
  //             init: AuthViewModle(),
  //             initState: (_) {},
  //             builder: (_) {
  //               return PrimaryButton(
  //                   isExpanded: true,
  //                   isLoading: isLoading,
  //                   textButton:
  //                       "${tr.touch_id}",
  //                   onClicked: isLoading
  //                       ? () {}
  //                       : () async {
  //                           isLoading = true;
  //                           update();
  //                           await _checkBiometrics();
  //                           await _getAvailableBiometrics();
  //                           await _authenticate();
  //                           if (isAuth!) {
  //                             await signInUser(
  //                                 user: User(
  //                                     countryCode:
  //                                         "${SharedPref.instance.getCurrentUserData().countryCode}",
  //                                     mobile:
  //                                         "${SharedPref.instance.getCurrentUserData().mobile}",
  //                                     udid: "$identifier",
  //                                     deviceType: "$deviceType",
  //                                     fcm:
  //                                         "${SharedPref.instance.getFCMToken()}"));
  //                           }
  //                           isLoading = false;
  //                           update();
  //                         });
  //             },
  //           ),
  //           SizedBox(
  //             height: sizeH16,
  //           ),
  //           GetBuilder<AuthViewModle>(
  //             builder: (_) {
  //               return PrimaryButton(
  //                   isExpanded: true,
  //                   isLoading: isLoading,
  //                   textButton: "${tr.face_id}",
  //                   onClicked: () async {
  //                     isLoading = true;
  //                     // update();
  //                     // await _checkBiometrics();
  //                     // await _getAvailableBiometrics();
  //                     // await _authenticate();
  //                     // if (isAuth!) {
  //                     //   await signInUser(
  //                     //       user: User(
  //                     //           countryCode:
  //                     //               "${SharedPref.instance.getCurrentUserData().countryCode}",
  //                     //           mobile:
  //                     //               "${SharedPref.instance.getCurrentUserData().mobile}",
  //                     //           udid: "$identifier",
  //                     //           deviceType: "$deviceType",
  //                     //           fcm: "${SharedPref.instance.getFCMToken()}"));
  //                     // }
  //                     // isLoading = false;
  //                     // update();
  //                       Get.to(()=> FacePage());
  //                   });
  //             },
  //           )
  //         ],
  //       )));
  // }

  bool? isAuth = false;
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  List<BiometricType>? _availableBiometrics;
  String _authorized = tr.not_authorized;

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
      authenticated = await auth.authenticate(
        localizedReason: tr.scan_to_auth,
        useErrorDialogs: true,
        biometricOnly: true,
        stickyAuth: false,
      );
    } on PlatformException catch (e) {
      print(e);
    }
    _authorized = authenticated ? tr.authorized : tr.not_authorized;
    isAuth = authenticated ? true : false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    //  startTimer();
    clearAllControllers();
    AppFcm.fcmInstance.getTokenFCM();
    getDeviceDetails();
    getPhonePlatform();
    update();
  }
}
