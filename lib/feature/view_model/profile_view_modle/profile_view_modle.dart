// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as multiPart;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/country.dart';
import 'package:inbox_clients/feature/model/customer_modle.dart';
import 'package:inbox_clients/feature/model/profile/cards_model.dart';
import 'package:inbox_clients/feature/model/profile/get_wallet_model.dart';
import 'package:inbox_clients/feature/model/profile/log_model.dart';
import 'package:inbox_clients/feature/model/profile/my_point_model.dart';
import 'package:inbox_clients/feature/model/subscription_data.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/user_both_login/user_both_login_view.dart';
import 'package:inbox_clients/feature/view/screens/payment/payment_screen.dart';
import 'package:inbox_clients/feature/view/screens/profile/address/widgets/area_zone_nomber_widget.dart';
import 'package:inbox_clients/feature/view/screens/profile/address/widgets/area_zone_widget.dart';
import 'package:inbox_clients/feature/view/screens/profile/my_wallet/Widgets/deposit_money_to_wallet_webView.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/gloable_bottom_sheet.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/network/api/feature/profie_helper.dart';
import 'package:inbox_clients/network/api/feature/storage_feature.dart';
import 'package:inbox_clients/network/api/feature/subscription_feature.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/base_controller.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/location_helper.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:inbox_clients/util/string.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileViewModle extends BaseController {
  bool isAccepteDefoltLocation = true;
  bool isLoading = false;
  bool isDeleteting = false;

  int selectedIndexLanguage = -1;
  String? selectedLang;
  String? temproreySelectedLang;

  Address address = Address();
  String? userLat;
  String? userLong;
  List<Address> userAddress = [];

  CompanySector? companySector = CompanySector();
  CompanySector? temproreySectorName;
  Set<String> arraySectors = {};
  int selectedIndex = -1;

  Customer? currentCustomer;

  String? urlCard;
  CardsData? cardsData;

//to do fot address textEditting Controllers ;
  TextEditingController tdTitle = TextEditingController();
  TextEditingController tdBuildingNo = TextEditingController();
  TextEditingController tdUnitNo = TextEditingController();
  TextEditingController tdZone = TextEditingController();
  TextEditingController tdStreet = TextEditingController();
  TextEditingController tdZoneNumber = TextEditingController();
  TextEditingController tdLocation = TextEditingController();
  TextEditingController tdExtraDetailes = TextEditingController();

  // to do here for edit address
  TextEditingController tdTitleEdit = TextEditingController();
  TextEditingController tdBuildingNoEdit = TextEditingController();
  TextEditingController tdUnitNoEdit = TextEditingController();
  TextEditingController tdZoneEdit = TextEditingController();
  TextEditingController tdStreetEdit = TextEditingController();
  TextEditingController tdZoneNumberEdit = TextEditingController();
  TextEditingController tdLocationEdit = TextEditingController();
  TextEditingController tdExtraDetailesEdit = TextEditingController();

  //here for edit user profile controllers:
  TextEditingController tdUserFullNameEdit = TextEditingController();
  TextEditingController tdUserEmailEdit = TextEditingController();
  TextEditingController tdCompanyEmailOperator = TextEditingController();
  TextEditingController tdUserMobileNumberEdit = TextEditingController();
  TextEditingController tdMobileNumberOperator = TextEditingController();
  Country defCountry =
      Country(prefix: SharedPref.instance.getCurrentUserData().countryCode);
  Country defCountryOperator =
      Country(prefix: SharedPref.instance.getCurrentUserData().countryCode);
  final picker = ImagePicker();
  File? img;

  //here to edit profile company controllers
  TextEditingController tdCompanyNameEdit = TextEditingController();
  TextEditingController tdCompanyEmailEdit = TextEditingController();
  TextEditingController tdCompanyNameOfApplicationEdit =
      TextEditingController();
  TextEditingController tdCompanyApplicantDepartment = TextEditingController();
  TextEditingController tdCompanyMobileNumber = TextEditingController();

  List<Map<String, dynamic>> contactMap = [];
  List<SubscriptionData>? subscriptions = [];

  var bottomPadding = sizeH100!;

  // for address (add , edit ,delete)

  clearControllers() {
    tdTitle.clear();
    tdBuildingNo.clear();
    tdUnitNo.clear();
    tdZone.clear();
    tdZoneNumber.clear();
    tdStreet.clear();
    tdLocation.clear();
    tdExtraDetailes.clear();
    tdSearchMap.clear();
  }

  Future<Address> addNewAddress(Address newAddress) async {
    Logger().d("msg_on_add ${newAddress.isPrimaryAddress}");
    Logger().d("addNewAddress ${newAddress.toJson()}");
    Address address = Address();
    isLoading = true;
    update();
    FocusScope.of(Get.context!).unfocus();
    try {
      var json = newAddress.toJson();
      // if(json["zone_number"] == null || json["zone_number"].toString().isEmpty){
      //   // json.remove("zone_number");
      //   json["zone_number"] = "";
      // }
      Logger().w(json);
      await ProfileHelper.getInstance
          .addNewAddress(json)
          .then((value) => {
                Logger().i("${value.status!.message}"),
                if (value.status!.success!)
                  {
                    isLoading = false,
                    update(),
                    snackSuccess("${tr.success}", "${value.status!.message}"),
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
                        "${tr.error_occurred}", "${value.status!.message}")
                  }
              });
      clearControllers();
    } catch (e) {}

    return address;
  }

  getMyAddress() async {
    isLoading = true;
    update();
    List data = [];
    try {
      await ProfileHelper.getInstance.getMyAddress().then((value) => {
            data = value.data,
            userAddress = data.map((e) => Address.fromJson(e)).toList(),
            isLoading = false,
            update()
          });
    } catch (e) {}
    isLoading = false;
    update();
  }

  deleteAddress(String addressId) async {
    isDeleteting = true;
    update();
    try {
      await ProfileHelper.getInstance.deleteAddress(body: {
        ConstanceNetwork.idKey: "$addressId"
      }).then((value) => {
            Logger().i("${value.status!.message}"),
            if (value.status!.success!)
              {
                isDeleteting = false,
                update(),
                snackSuccess("${tr.success}", "${value.status!.message}"),
              }
            else
              {
                isDeleteting = false,
                update(),
                snackError("${tr.error_occurred}", "${value.status!.message}")
              }
          });
    } catch (e) {}
  }

  editAddress(Address address, bool isDefoltAddressUpdate) async {
    isLoading = true;
    update();
    try {
      var json = address.toJson();
      if(json["zone_number"] == null || json["zone_number"].toString().isEmpty){
         json.remove("zone_number");
        // json["zone_number"] = "";
      }
      await ProfileHelper.getInstance
          .editAddress(json)
          .then((value) => {
                Logger().i("${value.status!.message}"),
                if (value.status!.success!)
                  {
                    Logger().i(value.toJson().toString()),
                    snackSuccess("${tr.success}", "${value.status!.message}"),
                    getMyAddress(),
                    isDefoltAddressUpdate ? {} : Get.back(),
                    isLoading = false,
                    update()
                  }
                else
                  {
                    snackError(
                        "${tr.error_occurred}", "${value.status!.message}"),
                    isLoading = false,
                    update(),
                  }
              });
    } catch (e) {}
  }

  //-- for log out

  logOutDiloag() {
    Get.bottomSheet(GlobalBottomSheet(
      
      title: "${tr.are_you_sure_you_want_to_log_out}",
      onOkBtnClick: () {
        logOut();
      },
      onCancelBtnClick: () {
        Get.back();
      }, isDelete: false,
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
                // snackSuccess("${tr.success}", "${value.status!.message}"),
                isLoading = false,
                update(),
                SharedPref.instance
                    .setUserLoginState("${ConstanceNetwork.userEnterd}"),
                Get.offAll(() => UserBothLoginScreen()),
                Get.find<HomeViewModel>().userBoxess.clear(),
                Get.find<HomeViewModel>().changeTab(0),
              }
            else
              {
                isLoading = false,
                SharedPref.instance
                    .setUserLoginState("${ConstanceNetwork.userEnterd}"),
                Get.offAll(() => UserBothLoginScreen()),
                update(),
                Get.find<HomeViewModel>().userBoxess.clear(),
                Get.find<HomeViewModel>().changeTab(0),
                // snackError("${tr.error_occurred}", "${value.status!.message}"),
              }
          });
    } catch (e) {}
  }

  // to od here for bottom sheet Time Zone :
  AreaZone? userAreaZone;
  String? userAreaZoneNum;

  void showZoneBottmSheet({bool? isEdit = false}) {
    Set<AreaZone> areaZone =
        ApiSettings.fromJson(jsonDecode(SharedPref.instance.getAppSetting()))
                .areaZones
                ?.toSet() ??
            {};

    Get.bottomSheet(
        areaZone.isEmpty
            ? Container(
            padding: EdgeInsets.symmetric(horizontal: padding40!),
                decoration: BoxDecoration(
                    color: colorBackground,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(padding30!))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: sizeH20!,),
                    Center(child: Text(tr.sorry_area_available, style: textStyleTitle())),
                    SizedBox(height: sizeH20!,),
                  ],
                ))
            : Container(
                decoration: BoxDecoration(
                    color: colorBackground,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(padding30!))),
                padding: EdgeInsets.symmetric(horizontal: padding20!),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: sizeH20,
                    ),
                    Text(
                      tr.select_time_zone,
                      style: textStyleTitle()!.copyWith(color: colorPrimary),
                    ),
                    SizedBox(
                      height: sizeH20,
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: areaZone
                          .map((e) => AreaZoneWidget(
                                areaZone: e,
                                isEdit: isEdit!,
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
        isScrollControlled: true);
  }

  void showZoneNumberBottmSheet({bool? isEdit = false}) {
    Set<AreaZone> areaZone =
        ApiSettings.fromJson(jsonDecode(SharedPref.instance.getAppSetting()))
                .areaZones
                ?.where((element) => element.id == userAreaZone?.id)
                .toSet() ??
            {};

    Get.bottomSheet(
        areaZone.isEmpty
            ? Container(
                decoration: BoxDecoration(
                    color: colorBackground,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(padding30!))),
                child: Text(tr.sorry_area_available, style: textStyleTitle()))
            : Container(
                decoration: BoxDecoration(
                    color: colorBackground,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(padding30!))),
                padding: EdgeInsets.symmetric(horizontal: padding20!),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: sizeH20,
                    ),
                    Text(
                      tr.select_time_zone,
                      style: textStyleTitle()!.copyWith(color: colorPrimary),
                    ),
                    SizedBox(
                      height: sizeH20,
                    ),
                    if (areaZone.first.numbers != null &&
                        areaZone.first.numbers!.isNotEmpty)
                      ListView(
                        shrinkWrap: true,
                        children: areaZone.first.numbers!
                            .map((e) => AreaZoneNumberWidget(
                                  areaZone: e,
                            isEdit:isEdit!
                                ))
                            .toList(),
                      ),
                  ],
                ),
              ),
        isScrollControlled: true);
  }

  //-- for user Edit profile:

  editProfileUser({String? identidire}) async {
    isLoading = true;
    update();
    var myImg;
    hideFocus(Get.context!);
    Map<String, dynamic> myMap = Map<String, dynamic>();
    if (img != null) {
      myImg = await compressImage(img!);
    }
    if (SharedPref.instance.getCurrentUserData().crNumber.toString().isEmpty ||
        GetUtils.isNull(SharedPref.instance.getCurrentUserData().crNumber)) {
      myMap = {
        ConstanceNetwork.emailKey: "${tdUserEmailEdit.text}",
        ConstanceNetwork.fullNameKey: "${tdUserFullNameEdit.text}",
        ConstanceNetwork.imageSmallKey: myImg != null
            ? multiPart.MultipartFile.fromFileSync(myImg!.path)
            : "",
        ConstanceNetwork.contactNumberkey: jsonEncode(contactMap),
        ConstanceNetwork.udidKey: identidire,
      };
    } else {
      myMap = {
        ConstanceNetwork.emailKey: "${tdCompanyEmailEdit.text}",
        ConstanceNetwork.companyNameKey: "${tdCompanyNameEdit.text}",
        ConstanceNetwork.imageSmallKey: myImg != null
            ? multiPart.MultipartFile.fromFileSync(myImg!.path)
            : "",
        ConstanceNetwork.contactNumberkey: jsonEncode(contactMap),
        ConstanceNetwork.companySectorKey: companySector!.name,
        ConstanceNetwork.applicantNameKey: tdCompanyNameOfApplicationEdit.text,
        ConstanceNetwork.applicantDepartmentKey: tdCompanyApplicantDepartment.text,
        "${ConstanceNetwork.mobileNumberKey}": tdCompanyMobileNumber.text,
        ConstanceNetwork.contryCodeKey: defCountry.prefix,
        ConstanceNetwork.udidKey: identidire,
        "reporter_mobile": tdMobileNumberOperator.text,
        "reporter_email": tdCompanyEmailOperator.text,
      };
    }
    try {
      Logger().i("msg_request_map ${myMap}");
      await ProfileHelper.getInstance.editProfile(myMap).then((value) => {
            if (value.status!.success!)
              {
                snackSuccess("${tr.success}", "${value.status!.message}"),
                isLoading = false,
                update(),
                Get.back()
              }
            else
              {
                isLoading = false,
                update(),
                snackError("${tr.error_occurred}", "${value.status!.message}")
              }
          });
    } catch (e) {}
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

  // for maps functions && td Controller :
  TextEditingController tdSearchMap = TextEditingController();
  Completer<GoogleMapController> controllerCompleter = Completer();
  GoogleMapController? mapController;
  double latitude = 25.226247442192594;
  double longitude = 51.53212357058872;
  String addressFromLocation = "";
  AutocompletePrediction? selectAutocompletePrediction;
  GooglePlace googlePlace =
      GooglePlace("AIzaSyAozWyP-XVpiaIfqgKprWwwCce5ou46YZE");
  Marker mark = Marker(markerId: MarkerId(LatLng(25.226247442192594, 51.53212357058872).toString()));
  List<AutocompletePrediction> predictions = [];
  CameraPosition? kGooglePlex;
  LatLng? currentPostion;
  bool isSearching = false;
  var mapType = MapType.normal;

  void autoCompleteSearch(String value) async {
    try {
      var result = await googlePlace.queryAutocomplete.get(value);
      update();
      if (result != null && result.predictions != null) {
        predictions = result.predictions!;
        update();
      } else {
        predictions = [];
        update();
      }
    } catch (e) {}
    update();
  }

  onClickMap(LatLng point) {
    try {
      isSearching = false;
      currentPostion =point;
      update();
      mark = Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: 'Marker',
        ),
      );
      update();
    } catch (e) {
      print("msg_error $e");
    }
    update();
  }

  getDetailsPlace(String placeName, String placeId) async {
    print("log_getDetailes with params $placeName , $placeId");
    googlePlace.details.get(placeId).then((value) async {
      print("log_getDetailes googlePlace.details");
      DetailsResponse detailsResponse = value!;
      latitude = detailsResponse.result!.geometry!.location!.lat!;
      longitude = detailsResponse.result!.geometry!.location!.lng!;
      addressFromLocation = placeName;
      update();
    }).then((value) async {
      print("log_OutFrom_logDetailes");
      print("log_msg_controller ${latitude} , ${longitude}");
      await changeCameraPosition(mapController!);
    });
  }

  Future<void> changeCameraPosition(GoogleMapController controller) async {
    print("log_msg_in_change_camera $latitude , $longitude");
    print("log_msg_in_change_camera_con ${GetUtils.isNull(controller)}");
    createCurrentMarker(LatLng(latitude, longitude));
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 16)));
    update();
  }

  Future<void> getCurrentUserLagAndLong({LatLng? latLng}) async {
    var status = await Permission.location.status;
    bool isShown = await Permission.contacts.shouldShowRequestRationale;

    Logger().e(status);
    Logger().e(isShown);
      if(bottomPadding != sizeH100){
        bottomPadding = sizeH100!;
        update();
      }
    // if (status.isDenied) {
    //   if (await Permission.speech.isPermanentlyDenied) {
    //     await openAppSettings();
    //   }
    // } else {
    //   var position = await GeolocatorPlatform.instance.getCurrentPosition(
    //       /*desiredAccuracy: LocationAccuracy.high*/);
    //   currentPostion = LatLng(latLng?.latitude ?? position.latitude,
    //       latLng?.longitude ?? position.longitude);
    // }
    //
    // final Permission location_permission = Permission.location;
    // bool location_status = false;
    // bool ispermanetelydenied = await location_permission.isPermanentlyDenied;
    // if (ispermanetelydenied) {
    //   print("denied");
    //   await openAppSettings().then((value) async{
    //     // if(value){
    //     //   var location_statu = await location_permission.request();
    //     //   location_status = location_statu.isGranted;
    //     //   if (location_status) {
    //     //     var position = await GeolocatorPlatform.instance.getCurrentPosition(
    //     //       /*desiredAccuracy: LocationAccuracy.high*/);
    //     //     currentPostion = LatLng(latLng?.latitude ?? position.latitude,
    //     //         latLng?.longitude ?? position.longitude);
    //     //   }
    //     // }
    //   });
    // } else {
    //   var location_statu = await location_permission.request();
    //   location_status = location_statu.isGranted;
    //   if (location_status) {
        var position = await LocationHelper.instance.getCurrentPosition()/*GeolocatorPlatform.instance.getCurrentPosition(
            *//*desiredAccuracy: LocationAccuracy.high*//*)*/;
        currentPostion = LatLng(latLng?.latitude ?? position.latitude,
            latLng?.longitude ?? position.longitude);
      // }
    // }

// You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      Logger().e(await Permission.location.isRestricted);
    }

    if (!GetUtils.isNull(currentPostion)) {
      kGooglePlex = CameraPosition(
        target: LatLng(currentPostion!.latitude, currentPostion!.latitude),
        zoom: 16,
      );
      latitude = currentPostion!.latitude;
      longitude = currentPostion!.longitude;
      await changeCameraPosition(mapController!);
      update();
    } else {
      kGooglePlex = CameraPosition(
        target: LatLng(25.226247442192594, 51.53212357058872),
        zoom: 16,
      );
      print("msg_position_in_else $currentPostion");
      update();
    }
  }

  void createCurrentMarker(LatLng point) async {
    latitude = point.latitude;
    longitude = point.longitude;
    print("create current marker $point");
    await getAddressFromLatLong(LatLng(latitude, longitude));
    update();
  }

  Future<void> getAddressFromLatLong(LatLng position) async {
    latitude = position.latitude;
    longitude = position.longitude;
    onClickMap(position);
    kGooglePlex = CameraPosition(target: position , zoom: 16);
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      if (placemarks.isEmpty) {
        String address = "${tr.unknown_address}";
        tdLocation.text = address;
        tdLocationEdit.text = address;
        update();
        return;
      }
      // ignore: unnecessary_null_comparison
      if (place == null) {
        String address = "${tr.unknown_address}";
        tdLocation.text = address;
        tdLocationEdit.text = address;
        update();
        return;
      }
      String address = "";
      if (place.street!.isNotEmpty) address += "${place.street}";
      if (place.postalCode!.isNotEmpty) address += ", ${place.postalCode}";
      if (place.locality!.isNotEmpty) address += ", ${place.locality}";
      if (place.administrativeArea!.isNotEmpty)
        address += ", ${place.administrativeArea}";
      tdLocation.text = address;
      tdLocationEdit.text = address;
      try {
        tdZone.text = ApiSettings.fromJson(jsonDecode(SharedPref.instance.getAppSetting()))
                  .areaZones?.firstWhere((element) => element.areaZone!.contains(place.administrativeArea.toString())).areaZone??"";
        tdZoneNumber.text =  ApiSettings.fromJson(jsonDecode(SharedPref.instance.getAppSetting()))
            .areaZones?.firstWhere((element) => element.areaZone!.contains(place.administrativeArea.toString())).numbers?.first??"";
      } catch (e) {
        print(e);
      }
      update();
      // Logger().wtf(address , place.toJson());
    } catch (e) {
      String address = "${tr.unknown_address}";
      tdLocation.text = address;
      tdLocationEdit.text = address;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    userAddress.clear();
    getMyAddress();
    getMyPoints();
    getMyWallet();
  }

  GetWallet myWallet = GetWallet();

  // var transaction = <Transactions>[];
  List<Transactions> transaction = <Transactions>[];

  getMyWallet() async {
    startLoading();
    try {
      await ProfileHelper.getInstance.getMyWallet().then((value) {
        myWallet = value;
        transaction = value.transactions!;
        isLoading = false;
        update();
      }).catchError((onError) {
        isLoading = false;
        update();
        Logger().d(onError);
      });
    } catch (e) {
      isLoading = false;
      update();
      Logger().d("test_3");
    }
  }

  TextEditingController amountController = TextEditingController();
  String url = "";

  void depositMoneyToWallet() async {
    isLoading = true;
    update();
    Map<String, dynamic> map = {
      "${ConstanceNetwork.amountKey}": "${amountController.text.toString()}",
      "task_process": "other",
    };
    try {
      await StorageFeature.getInstance.payment(body: map).then((value) {
        if (!GetUtils.isNull(value.data)) {
          isLoading = false;
          url = value.data["url"].toString();
          Logger().d("url : ${value.data["url"].toString()}");

          update();
          if(value.data["url"] != null && value.data["url"].toString().isNotEmpty) {
            Get.off(DepositMoneyToWalletWebView(url: value.data["url"].toString()) );
          }
          // amountController.clear();
        } else {
          isLoading = false;
          // amountController.clear();
          update();
        }
      }).catchError((onError) {
        Logger().d(onError.toString());
        isLoading = false;
        update();
      });
    } on Exception catch (e) {
      Logger().d(e.toString());
      isLoading = false;
      update();
    }
  }

  String depositStatus = "";
  String paymentId = "";

  void checkDeposit() async {
    isLoading = true;
    if (depositStatus.contains("Paid") || depositStatus.contains("true")) {
      depositStatus = 'success';
    } else {
      depositStatus = 'fail';
    }
    Map<String, dynamic> map = {
      "${ConstanceNetwork.statusKey}": "${depositStatus.toString()}",
      "${ConstanceNetwork.idKey}": "${paymentId.toString()}",
      "${ConstanceNetwork.amountKey}": "${amountController.text.toString()}",
    };
    try {
      await ProfileHelper.getInstance.checkDeposit(map).then((value) {
        if (!GetUtils.isNull(value.data)) {
          isLoading = false;
          Logger().d(
              "deposit Status : ${depositStatus} \n payment Id : ${paymentId}");
          Logger().d(
              "depositStatus : ${value.data["_server_messages"].toString()}");

          amountController.clear();
          getMyWallet();
          snackSuccess("$txtSuccess", "$txtSuccess");
          Get.back();
          update();
        } else {
          isLoading = false;
          amountController.clear();
          snackError("$txtError", "$txtError");
          update();
        }
      }).catchError((onError) {
        Logger().d(onError.toString());
        amountController.clear();
        isLoading = false;
        update();
      });
    } on Exception catch (e) {
      Logger().d(e.toString());
      isLoading = false;
      update();
    }
  }

  // to do for points (Rewords)

  // start Loaging Function ::
  void startLoading() {
    isLoading = true;
    update();
  }

  // end Loaging Function ::
  void endLoading() {
    isLoading = false;
    update();
  }

  MyPoints myPoints = MyPoints();

  Future<void> getMyPoints() async {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // startLoading();
    });
    try {
      await ProfileHelper.getInstance.getMyPoints().then((value) => {
            myPoints = MyPoints.fromJson(value.data),
          });
    } catch (e) {
      printError();
    }
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      endLoading();
    });
  }

  String selectedMapType = LocalConstance.mapType;
  List<Log> userLogs = [];

  Future<void> getUserLog() async {
    startLoading();
    try {
      await ProfileHelper.getInstance
          .getUserLogs()
          .then((value) => {userLogs = value.toList(), update()});
    } catch (e) {
      printError();
    }
    endLoading();
  }

  void filterSubscriptions(var filterType) async {
    if (filterType == LocalConstance.quantityConst) {
      //this for quantity
      getUserSubscription(LocalConstance.quantityConst);
    } else if (filterType == LocalConstance.itemConst) {
      //this for item
      getUserSubscription(LocalConstance.itemConst);
    } else if (filterType == LocalConstance.spaceConst) {
      //this for space
      getUserSubscription(LocalConstance.spaceConst);
    } else {
      getUserSubscription("");
    }
  }

  //this for Subscription
  Future<void> getUserSubscription(String filterType) async {
    // startLoading();
    subscriptions?.clear();
    Map<String, dynamic> map = {ConstanceNetwork.filter: filterType};
    try {
      await SubscriptionFeature.getInstance
          .getSubscriptions(filterType.isEmpty ? {} : map)
          .then((value) {
        subscriptions = value;
        endLoading();
      });
    } catch (e) {
      printError();
      endLoading();
      Logger().e(e);
    }
  }

  void onTerminateSubscriptions(SubscriptionData? subscriptionsData) async {
    Map<String, dynamic> map = {
      ConstanceNetwork.idKey: subscriptionsData?.id.toString()
    };
    startLoading();

    try {
      await SubscriptionFeature.getInstance
          .terminateSubscriptions(map)
          .then((value) {
        if (value.status?.success ?? false) {
          subscriptions?.clear();
          List data = value.data;
          List<SubscriptionData> map =
              data.map((e) => SubscriptionData.fromJson(e)).toList();
          subscriptions = map;
          endLoading();
          Get.back();
          Get.find<HomeViewModel>().getCustomerBoxes();
        } else {
          snackError(
              error?.tr,
              value.status?.code == 403
                  ? tr.no_permission
                  : value.status?.message ?? "");
          endLoading();
        }
      });
    } catch (e) {
      printError();
      endLoading();
      Logger().e(e);
    }
  }

  Future<void> initeProfileScreen() async {
    try {
      await getMyWallet();
      await getMyPoints();
      await getUserSubscription("");
    } catch (e) {
      Logger().e("error : ${e.toString()}");
    }
  }

  void sendNote(TextEditingController emailController,
      TextEditingController noteController) {
    if (emailController.text.isEmpty) {
      return;
    }
    if (noteController.text.isEmpty) {
      return;
    }
    Map<String, dynamic> map = {
      ConstanceNetwork.emailKey: emailController.text.toString(),
      ConstanceNetwork.notesKey: noteController.text.toString(),
    };
    _sendNote(map, emailController, noteController);
  }

  Future<void> _sendNote(
      Map<String, dynamic> map,
      TextEditingController emailController,
      TextEditingController noteController) async {
    startLoading();
    await ProfileHelper.getInstance.sendNote(map).then((value) {
      if (value.status!.success!) {
        emailController.clear();
        noteController.clear();
        snackSuccess("", value.status?.message.toString());
      } else {
        snackError("", value.status?.message.toString());
      }
      endLoading();
    }).catchError((value) {
      endLoading();
      Logger().d(value);
    });
  }

  Future<void> getProfileData() async {
    try {
      await ProfileHelper.getInstance.getUserData();
    } catch (e) {
      Logger().e("getProfileData", e);
    }
  }

  Future<void> addCard() async {
    startLoading();
    await ProfileHelper.getInstance.addCard().then((value) async {
      if (value.status!.success!) {
        Logger().d(value.toJson());
        urlCard = value.data["url"].toString();
        // snackSuccess("", value.status?.message.toString());
        endLoading();
        if (value.data["url"] != null) {
          var result = await Get.to(PaymentScreen(
            isOrderProductPayment: false,
            paymentId: '',
            cartModels: [],
            url: value.data["url"].toString(),
            isFromCart: false,
            isFromAddCard: true,
            isFromNewStorage: false,
          ));
          if (result) {
            getCards();
          }
        }
      } else {
        snackError("", value.status?.message.toString());
      }
      endLoading();
    }).catchError((value) {
      endLoading();
      Logger().d(value);
    });
  }

  Future<void> getCards() async {
    startLoading();
    await ProfileHelper.getInstance.getCards().then((value) {
      if (value.cards != null && value.cards!.isNotEmpty) {
        Logger().d(value.toJson());
        cardsData = value;
        endLoading();
      } else {
        endLoading();
      }
    }).catchError((value) {
      endLoading();
      Logger().d(value);
    });
  }

  changeMapType(){
    if(mapType == MapType.normal) {
      mapType =MapType.satellite;
      update();
    }else{
      mapType =MapType.normal;
      update();
    }
  }
}
