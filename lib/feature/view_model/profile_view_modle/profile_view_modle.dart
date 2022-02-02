// ignore_for_file: unnecessary_brace_in_string_interps

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
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/user_both_login/user_both_login_view.dart';
import 'package:inbox_clients/feature/view/screens/profile/address/widgets/area_zone_widget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/logout_bottom_sheet.dart';
import 'package:inbox_clients/network/api/feature/profie_helper.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/base_controller.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileViewModle extends BaseController {
  bool isAccepteDefoltLocation = true;
  bool isLoading = false;
  bool isDeleteting = false;

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
  Country defCountry =
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

  // for address (add , edit ,delete)

  clearControllers() {
    tdTitle.clear();
    tdBuildingNo.clear();
    tdUnitNo.clear();
    tdZone.clear();
    tdStreet.clear();
    tdLocation.clear();
    tdExtraDetailes.clear();
    tdSearchMap.clear();
  }

  Future<Address> addNewAddress(Address newAddress) async {
    print("msg_on_add ${newAddress.isPrimaryAddress}");
    Address address = Address();
    isLoading = true;
    update();
    FocusScope.of(Get.context!).unfocus();
    try {
      await ProfileHelper.getInstance
          .addNewAddress(newAddress.toJson())
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
        "id": "$addressId"
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
      await ProfileHelper.getInstance
          .editAddress(address.toJson())
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
      },
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
                snackSuccess("${tr.success}", "${value.status!.message}"),
                isLoading = false,
                update(),
                SharedPref.instance
                    .setUserLoginState("${ConstanceNetwork.userEnterd}"),
                Get.offAll(() => UserBothLoginScreen()),
              }
            else
              {
                isLoading = false,
                SharedPref.instance
                    .setUserLoginState("${ConstanceNetwork.userEnterd}"),
                Get.offAll(() => UserBothLoginScreen()),
                update(),
               // snackError("${tr.error_occurred}", "${value.status!.message}"),
              }
          });
    } catch (e) {}
  }

  // to od here for bottom sheet Time Zone :
  AreaZone? userAreaZone;

  void showZoneBottmSheet() {
    Set<AreaZone> areaZone =
        ApiSettings.fromJson(jsonDecode(SharedPref.instance.getAppSetting()))
                .areaZones
                ?.toSet() ??
            {};

    Get.bottomSheet(
        areaZone.isEmpty
            ? Container(
                decoration: BoxDecoration(
                    color: colorBackground,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(padding30!))),
                child: Text("Sorrey , No Zone Area Available",
                    style: textStyleTitle()))
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
                      "Select Your Time Zone ",
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
        "email": "${tdUserEmailEdit.text}",
        "full_name": "${tdUserFullNameEdit.text}",
        "image": myImg != null
            ? multiPart.MultipartFile.fromFileSync(myImg!.path)
            : "",
        "contact_number": jsonEncode(contactMap),
        "udid": identidire,
      };
    } else {
      myMap = {
        "email": "${tdCompanyEmailEdit.text}",
        "company_name": "${tdCompanyNameEdit.text}",
        "image": myImg != null
            ? multiPart.MultipartFile.fromFileSync(myImg!.path)
            : "",
        "contact_number": jsonEncode(contactMap),
        "company_sector": companySector!.name,
        "applicant_name": tdCompanyNameOfApplicationEdit.text,
        "applicant_department": tdCompanyApplicantDepartment.text,
        "${ConstanceNetwork.mobileNumberKey}": tdCompanyMobileNumber.text,
        "country_code": defCountry.prefix,
        "udid": identidire,
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
  double latitude = 25.36;
  double longitude = 51.18;
  String addressFromLocation = "";
  AutocompletePrediction? selectAutocompletePrediction;
  GooglePlace googlePlace =
      GooglePlace("AIzaSyAozWyP-XVpiaIfqgKprWwwCce5ou46YZE");
  Marker mark = Marker(markerId: MarkerId(LatLng(25.36, 51.18).toString()));
  List<AutocompletePrediction> predictions = [];
  CameraPosition? kGooglePlex;
  LatLng? currentPostion;
  bool isSearching = false;

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
        CameraPosition(target: LatLng(latitude, longitude), zoom: 10)));
    update();
  }

  Future<void> getCurrentUserLagAndLong({LatLng? latLng}) async {
    var status = await Permission.location.status;
    bool isShown = await Permission.contacts.shouldShowRequestRationale;

    Logger().e(status);
    Logger().e(isShown);

    if (status.isDenied) {
      if (await Permission.speech.isPermanentlyDenied) {
        openAppSettings();
      }
    } else {
      var position = await GeolocatorPlatform.instance.getCurrentPosition(
          /*desiredAccuracy: LocationAccuracy.high*/);
      currentPostion = LatLng(latLng?.latitude ?? position.latitude,
          latLng?.longitude ?? position.longitude);
    }

    final Permission location_permission = Permission.location;
    bool location_status = false;
    bool ispermanetelydenied = await location_permission.isPermanentlyDenied;
    if (ispermanetelydenied) {
      print("denied");
      await openAppSettings();
    } else {
      var location_statu = await location_permission.request();
      location_status = location_statu.isGranted;
      if (location_status) {
        var position = await GeolocatorPlatform.instance.getCurrentPosition(
            /*desiredAccuracy: LocationAccuracy.high*/);
        currentPostion = LatLng(latLng?.latitude ?? position.latitude,
            latLng?.longitude ?? position.longitude);
      }
    }

// You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      Logger().e(await Permission.location.isRestricted);
    }

    if (!GetUtils.isNull(currentPostion)) {
      kGooglePlex = CameraPosition(
        target: LatLng(currentPostion!.latitude, currentPostion!.latitude),
        zoom: 10,
      );
      latitude = currentPostion!.latitude;
      longitude = currentPostion!.longitude;
      await changeCameraPosition(mapController!);
      update();
    } else {
      kGooglePlex = CameraPosition(
        target: LatLng(25.36, 51.18),
        zoom: 10,
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
    kGooglePlex = CameraPosition(target: position);
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
      update();
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
  }
}
