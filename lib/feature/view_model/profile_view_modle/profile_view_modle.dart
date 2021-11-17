import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/user_both_login/user_both_login_view.dart';
import 'package:inbox_clients/network/api/feature/profie_helper.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/base_controller.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileViewModle extends BaseController {
  bool isAccepteDefoltLocation = true;
  bool isLoading = false;

  Address address = Address();
  String? userLat;
  String? userLong;
  List<Address> userAddress = [];

//to do fot address textEditting Controllers ;
  TextEditingController tdTitle = TextEditingController();
  TextEditingController tdBuildingNo = TextEditingController();
  TextEditingController tdUnitNo = TextEditingController();
  TextEditingController tdZone = TextEditingController();
  TextEditingController tdStreet = TextEditingController();
  TextEditingController tdLocation = TextEditingController();
  TextEditingController tdExtraDetailes = TextEditingController();

  // to do here for edit address
  TextEditingController tdTitleEdit = TextEditingController();
  TextEditingController tdBuildingNoEdit = TextEditingController();
  TextEditingController tdUnitNoEdit = TextEditingController();
  TextEditingController tdZoneEdit = TextEditingController();
  TextEditingController tdStreetEdit = TextEditingController();
  TextEditingController tdLocationEdit = TextEditingController();
  TextEditingController tdExtraDetailesEdit = TextEditingController();

  // for address (add , edit ,delete)

  clearControllers() {
    tdTitle.clear();
    tdBuildingNo.clear();
    tdUnitNo.clear();
    tdZone.clear();
    tdStreet.clear();
    tdLocation.clear();
    tdExtraDetailes.clear();
  }

  Future<Address> addNewAddress(Address newAddress) async {
    print("msg_on_add ${newAddress.isPrimaryAddress}");
    Address address = Address();
    isLoading = true;
    update();
    FocusScope.of(Get.context!).unfocus();
    try {
      ProfileHelper.getInstance
          .addNewAddress(newAddress.toJson())
          .then((value) => {
                Logger().i("${value.status!.message}"),
                if (value.status!.success!)
                  {
                    isLoading = false,
                    update(),
                    snackSuccess(
                        "${AppLocalizations.of(Get.context!)!.success}",
                        "${value.status!.message}"),
                    getMyAddress(),
                    clearControllers(),
                    update(),
                    Get.back()
                  }
                else
                  {
                    isLoading = false,
                    update(),
                    snackError(
                        "${AppLocalizations.of(Get.context!)!.error_occurred}",
                        "${value.status!.message}")
                  }
              });
    } catch (e) {}

    return address;
  }

  getMyAddress() async {
    List data = [];
    try {
      await ProfileHelper.getInstance.getMyAddress().then((value) => {
            data = value.data,
            userAddress = data.map((e) => Address.fromJson(e)).toList(),
            update()
          });
    } catch (e) {}
  }

  deleteAddress(String addressId) async {
    update();
    try {
      await ProfileHelper.getInstance
          .deleteAddress(body: {"id": "$addressId"}).then((value) => {
                Logger().i("${value.status!.message}"),
                if (value.status!.success!)
                  {
                    snackSuccess(
                        "${AppLocalizations.of(Get.context!)!.success}",
                        "${value.status!.message}"),
                  }
                else
                  {
                    snackError(
                        "${AppLocalizations.of(Get.context!)!.error_occurred}",
                        "${value.status!.message}")
                  }
              });
    } catch (e) {}
  }

  editAddress(Address address) async {
    try {
      await ProfileHelper.getInstance
          .editAddress(address.toJson())
          .then((value) => {
                Logger().i("${value.status!.message}"),
                if (value.status!.success!)
                  {
                    snackSuccess(
                        "${AppLocalizations.of(Get.context!)!.success}",
                        "${value.status!.message}"),
                    getMyAddress(),
                    Get.back()
                  }
                else
                  {
                    snackError(
                        "${AppLocalizations.of(Get.context!)!.error_occurred}",
                        "${value.status!.message}")
                  }
              });
    } catch (e) {}
  }
  //-- for log out

  logOutDiloag() {
    Get.defaultDialog(
        title: "Are You Sure You want to Log Out ?",
        content: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(colorPrimary)),
                  onPressed: () {
                    //  logOut();
                    // SharedPref.instance
                    //     .setUserLoginState("${ConstanceNetwork.userEnterd}");
                    Get.offAll(() => UserBothLoginScreen());
                  },
                  child: Text(
                    "Log Out",
                    style: TextStyle(color: colorTextWhite),
                  )),
              SizedBox(
                width: sizeW30,
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(colorUnSelectedWidget)),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Cancle",
                    style: textStyleHints(),
                  )),
            ],
          ),
        ));
  }

  // logOut() async {
  //   isLoading = true;
  //   update();
  //   try {
  //     await ProfileHelper.getInstance.logOut().then((value) => {
  //       Logger().i("${value.status!.message}"),
  //               if (value.status!.success!)
  //                 {
  //                   snackSuccess(
  //                       "${AppLocalizations.of(Get.context!)!.success}",
  //                       "${value.status!.message}"),
  //                   isLoading = false,
  //                    update(),
  //                   Get.offAll(() => UserBothLoginScreen())
  //                 }
  //               else
  //                 {
  //                    isLoading = false,
  //                    update(),
  //                   snackError(
  //                       "${AppLocalizations.of(Get.context!)!.error_occurred}",
  //                       "${value.status!.message}")
  //                 }
  //     });
  //   } catch (e) {
  //   }
  // }

  //-- for user Edit profile:

  // editProfileUser() async {
  //   try {
  //     await ProfileHelper.getInstance.editProfile({
  //       "email": "test11@mm.com",
  //       "full_name": "khaled2",
  //       "image": "image",
  //       "contact_number":
  //        [
  //         {"mobile_number": 855555, "country_code": 970},
  //         {"mobile_number": 85555555, "country_code": 972}
  //        ]
  //     }).then((value) => {Logger().e(value.toJson())});
  //   } catch (e) {}
  // }

 // fot timer on change number :
  Timer? timer;
  int startTimerCounter = 60;


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


  @override
  void onInit() {
    super.onInit();
    SharedPref.instance.setUserLoginState("${ConstanceNetwork.userLoginedState}");
    getMyAddress();
    SharedPref.instance.getCurrentUserData();
    
  }
}
