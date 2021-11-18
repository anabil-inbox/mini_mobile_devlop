import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/country.dart';
import 'package:inbox_clients/feature/model/customer_modle.dart';
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

  CompanySector? companySector = CompanySector();
  CompanySector? temproreySectorName;
  Set<String> arraySectors = {};
  int selectedIndex = -1;

  Customer? currentCustomer;

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

  //here for edit user profile controllers:
  TextEditingController tdUserFullNameEdit = TextEditingController();
  TextEditingController tdUserEmailEdit = TextEditingController();
  TextEditingController tdUserMobileNumberEdit = TextEditingController();
  Country defCountry = Country(prefix: SharedPref.instance.getCurrentUserData().countryCode);
  final picker = ImagePicker();
  File? img;

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
                        "${tr.success}",
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
                        "${tr.error_occurred}",
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
                        "${tr.success}",
                        "${value.status!.message}"),
                  }
                else
                  {
                    snackError(
                        "${tr.error_occurred}",
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
                        "${tr.success}",
                        "${value.status!.message}"),
                    getMyAddress(),
                    Get.back()
                  }
                else
                  {
                    snackError(
                        "${tr.error_occurred}",
                        "${value.status!.message}")
                  }
              });
    } catch (e) {}
  }
  //-- for log out

  logOutDiloag() {
    Get.defaultDialog(
        titlePadding: EdgeInsets.all(16),
        titleStyle: textStyleBtn()!.copyWith(color: colorBlack),
        title:
            "${tr.are_you_sure_you_want_to_log_out}",
        content: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 140,
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(colorPrimary)),
                    onPressed: () {
                      logOut();
                    },
                    child: Text(
                      "${tr.log_out}",
                      style: TextStyle(
                          color: colorTextWhite, fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(
                width: sizeW10,
              ),
              Container(
                width: 140,
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(colorUnSelectedWidget)),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "${tr.cancle}",
                      style: textStyleHints()!
                          .copyWith(fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ));
  }

  logOut() async {
    isLoading = true;
    update();
    try {
      await ProfileHelper.getInstance.logOut().then((value) => {
            Logger().i("${value.status!.message}"),
            if (value.status!.success!)
              {
                snackSuccess("${tr.success}",
                    "${value.status!.message}"),
                isLoading = false,
                update(),
                SharedPref.instance
                    .setUserLoginState("${ConstanceNetwork.userEnterd}"),
                Get.offAll(() => UserBothLoginScreen()),
              }
            else
              {
                isLoading = false,
                update(),
                snackError(
                    "${tr.error_occurred}",
                    "${value.status!.message}")
              }
          });
    } catch (e) {}
  }

  //-- for user Edit profile:

  editProfileUser() async {
    isLoading = true;
    update();
    hideFocus(Get.context!);

    try {
      await ProfileHelper.getInstance.editProfile({
        "email": "${tdUserEmailEdit.text}",
        "full_name": "${tdUserFullNameEdit.text}",
        "image": "image",
        "contact_number": [
          {"mobile_number": 855555, "country_code": 970},
          {"mobile_number": 85555555, "country_code": 972}
        ]
      }).then((value) => {
        
       Logger().i("${value.status!.message}"),
            if (value.status!.success!)
              {
                snackSuccess("${tr.success}",
                    "${value.status!.message}"),
                isLoading = false,
                update(),
                Get.back()
              }
            else
              {
                isLoading = false,
                update(),
                snackError(
                    "${tr.error_occurred}",
                    "${value.status!.message}")
              }
        });
    } catch (e) {

    }
  }

  Future getImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      img = File(pickedImage.path);
      update();
    }
  }

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
    // getMyAddress();
    // currentCustomer = SharedPref.instance.getCurrentUserData();
    //  update();
    //  editProfileUser();
  }
}
