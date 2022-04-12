import 'dart:io';
import 'dart:typed_data';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as multipart;
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/beneficiary.dart';
import 'package:inbox_clients/feature/model/home/signature_item_model.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/feature/model/respons/task_response.dart';
import 'package:inbox_clients/feature/model/storage/store_modle.dart';
import 'package:inbox_clients/feature/view/screens/home/home_page_holder.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/recived_order_screen.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/check_in_box_widget.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/tasks_widgets/task_widget_BS.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/network/api/feature/home_helper.dart';
import 'package:inbox_clients/network/api/feature/item_helper.dart';
import 'package:inbox_clients/network/api/feature/order_helper.dart';
import 'package:inbox_clients/network/api/feature/storage_feature.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/base_controller.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../model/cases_data.dart';
import '../../model/home/notification_data.dart';

class HomeViewModel extends BaseController {
  var _currentIndex = 0;

  //collapse
  // bool isCollapse = false;
  ExpandableController expandableController = ExpandableController();

  SignatureItemModel selectedSignatureItemModel = SignatureItemModel();

  var signatureOutput;

  int get currentIndex => _currentIndex;

  //to do for Loading var:
  bool isLoading = false;
  bool isLoadingPagination = false;

  // get Custome Boxes Vars And Functtions ::
  Set<Box> userBoxess = {};

  double ratingService = 3.0;
  List<CasesData> casesDataList = [];
  List<CasesData> casesSelectedDataList = [];


  Future<void> getCustomerBoxes() async {
    if (!isLoadingPagination) {
      startLoading();
    }
    await HomeHelper.getInstance
        .getCustomerBoxess(pageSize: 30, page: page)
        .then((value) => {
              userBoxess.addAll(value),
              update(),
            });
    endLoading();
  }

  Future<void> refreshHome() async {
    try {
      page = 1;
      userBoxess.clear();
      onInit();
      await Future.delayed(Duration(seconds: 1));
    } catch (e) {
      printError();
    }
  }

  // search Func And Vars ::
  TextEditingController tdSearch = TextEditingController();
  Set<Box> searchedBoxess = {};

  Future<void> searchForBox({required String searchText}) async {
    await HomeHelper.getInstance
        .getBoxessWithSearch(serchText: "$searchText")
        .then((value) => {
              searchedBoxess = value.toSet(),
              update(),
            });
  }

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

  // start Loaging Function ::
  void startLoadingPagination() {
    isLoadingPagination = true;
    update();
  }

  // end Loaging Function ::
  void endLoadingPagination() {
    isLoadingPagination = false;
    update();
  }

  //paginations Vars And Func ::
  final homeScrollcontroller = ScrollController();
  int page = 1;

  // open Scaner Qr :
  var scanArea = (MediaQuery.of(Get.context!).size.width < 400 ||
          MediaQuery.of(Get.context!).size.height < 400)
      ? 150.0
      : 150.0;

  Barcode? result;
  QRViewController? controller;

  onQRViewCreated(QRViewController controller,
      {bool? isFromAtHome = false,
      required StorageViewModel storageViewModel,
      int index = 0}) {
    Box newBox = Box();
    try {
      int i = 0;
      startLoading();
      refresh();
      ItemViewModle itemViewModle = Get.find<ItemViewModle>();
      itemViewModle.usesBoxItemsTags.clear();
      itemViewModle.tdTag.clear();
      itemViewModle.update();
      this.controller = controller;
      controller.scannedDataStream.listen((scanData) {
        result = scanData;
      }).onData((data) async {
        i = i + 1;
        if (i == 1) {
          Logger().d(
              "${userBoxess.toList()[index].serialNo} || ${data.code.toString().replaceAll("http://", "")}");
          if (userBoxess.toList()[index].serialNo !=
                  data.code.toString().replaceAll("http://", "") &&
              isFromAtHome!) {
            snackError(tr.error_occurred, tr.box_serial_invalid);
            endLoading();
            Get.back();
          } else {
            await getBoxBySerial(
                    serial: data.code.toString().replaceAll("http://", ""))
                .then((value) async => {
                      Logger().e(value.toJson()),
                      newBox.id = value.id,
                      if (value.id == null)
                        {
                          Get.off(() => HomePageHolder()),
                        }
                      else
                        {
                          // userBoxess.toList()[index].storageStatus =
                          //     LocalConstance.boxAtHome,
                          for (var item in userBoxess)
                            {
                              if (item.serialNo == data.code)
                                {
                                  // item..storageStatus = LocalConstance.boxAtHome,
                                  // item.modified = DateTime.now()
                                }
                            },
                          update(),
                          await fromAtHome(data.code, storageViewModel,
                              homeViewModel: this),
                          Get.off(() => HomePageHolder(
                                box: value,
                                isFromScan: true,
                              )),
                          itemViewModle.tdName.text = value.storageName ?? "",
                          if (isFromAtHome ?? false)
                            {
                              await Get.bottomSheet(
                                  CheckInBoxWidget(box: value, isUpdate: false),
                                  isScrollControlled: true),
                            }
                          else
                            {
                              userBoxess.forEach((element) {
                                if (element.id == value.id) {
                                  // element.storageStatus = LocalConstance.boxAtHome;
                                }
                              }),
                              getCustomerBoxes(),
                            },
                        },
                      endLoading(),
                    });
            update();
          }
        }
      });
      // if (newBox.id != null) {
      //   refreshHome();
      // }

      isLoading = false;
      update();
    } catch (e) {
      Logger().e("$e");
      endLoading();
    }

    // refresh();
  }

  // to do here for

  void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    try {
      if (!p) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(tr.no_permission)),
        );
      }
    } catch (e) {
      Logger().e("$e");
    }
  }

  // StorageViewModel storageViewModel =
  //     Get.put(StorageViewModel(), permanent: true);
  // Set<Box> scaanedBoxes = {};

  createQrOrderOrder(
      {required QRViewController controller,
      required StorageViewModel storageViewModel,
      required bool isBox,
      required HomeViewModel homeViewModel,
      required bool isScanDeliverdBox,
      required bool isProduct}) {
    print("mess_1");
    startLoading();
    print("mess_2");
    try {
      int i = 0;
      print("mess_3");
      controller.scannedDataStream.listen((scanData) {
        result = scanData;
        print("mess_4");
      }).onData((data) async {
        i = i + 1;
        print("mess_5");
        if (i == 1) {
          print("mess_6");
          await fromAtHome(data.code, storageViewModel,
              isScanDeliverd: isScanDeliverdBox, homeViewModel: homeViewModel);
          //Get.delete<HomeViewModel>();
          endLoading();
          Get.to(() => ReciverOrderScreen(this));
        }
      });
    } catch (e) {
      Logger().e("$e");
      print("mess_7_$e");
      endLoading();
    }
    // endLoading();
  }

  // this for Pagination :

  void pagination() async {
    try {
      startLoadingPagination();
      if (homeScrollcontroller.hasClients &&
          homeScrollcontroller.positions.length != 1) {
        if ((homeScrollcontroller.position.pixels ==
            homeScrollcontroller.positions.last.pixels)) {
          await getCustomerBoxes();
        }
      }
      endLoadingPagination();
      update();
    } catch (e) {
      Logger().e("$e");
    }
  }

  // to get box by his serial ::

  Future<Box> getBoxBySerial({required String serial}) async {
    Box box = Box();
    await ItemHelper.getInstance.getBoxBySerial(body: {
     ConstanceNetwork.serial: serial
    }).then((value) => {
          if (value.status!.success!)
            {
              box = Box.fromJson(value.data),
            }
          else
            {
              snackError("${tr.error_occurred}", "${value.status!.message}"),
            }
        });
    update();
    return box;
  }

  //
  @override
  void onInit() async {
    super.onInit();
    await getCustomerBoxes();
    await getTasks();
    getBeneficiary();

    // homeScrollcontroller.addListener(() {
    //   pagination();
    // });
  }

  // to start work with user And Store Address ::
  Address? selectedAddres;

  Set<Store> storeAddress = {};
  bool isLoadingGetAddress = false;

  // to get Store Address ::

  getStoreAddress() async {
    isLoadingGetAddress = true;
    update();
  }

  //
  @override
  InternalFinalCallback<void> get onDelete;

  @override
  void dispose() {
    controller?.dispose();
    homeScrollcontroller.dispose();
    super.dispose();
  }

  // to do here get Tasks :
  Set<Task> tasks = {};

  getTasks() async {
    await StorageFeature.getInstance.getTasks().then((value) => {
          for (var item in value)
            {
              if (/* item.id != LocalConstance.fetchId && */
              item.id != LocalConstance.newStorageSv)
                {tasks.add(item)}
            },
        });
    update();
  }

  // to do for Show Bottom Sheet For Task :

  Future<void> showTaskBottomSheet({required Task task}) async {
    selctedOperationsBoxess.clear();
    Get.bottomSheet(
        TaskWidgetBS(
          task: task,
        ),
        isScrollControlled: true);
  }

  Task searchTaskById({required String taskId}) {
    Task task = Task();
    for (var item in tasks) {
      if (item.id == taskId) {
        task = item;
      }
    }

    return task;
  }

  // to change From Grid to List >_<
  bool? isListView = false;

  void changeTypeViewLVGV() {
    isListView = !isListView!;
    update();
  }

  // to do here for home Boxess Operations (Recall , Pickup , Give Away ... etc ):
  Set<Box> selctedOperationsBoxess = {};

  // to add New Box To selcted Boxess ::
  addToBoxessOperations({required Box box}) {
    if (selctedOperationsBoxess.contains(box)) {
      selctedOperationsBoxess.remove(box);
    } else {
      selctedOperationsBoxess.add(box);
    }
    update();
  }

  // to start work with user And Store Address ::
  // Address? selectedAddres;

  // Set<Store> storeAddress = {};
  // bool isLoadingGetAddress = false;
  // // to get Store Address ::

  // getStoreAddress() async {
  //   isLoadingGetAddress = true;
  //   update();
  //   await StorageFeature.getInstance.getStoreAddress().then((value) => {
  //         storeAddress = value.toSet(),
  //       });
  //   isLoadingGetAddress = false;
  //   update();
  // }

  List<Day>? selctedWorksHours = [];
  DateTime? selectedDateTime;

  void showDatePicker() async {
    var dt = await dateBiker();
    if (!GetUtils.isNull(dt)) {
      selctedWorksHours = getDayByNumber(selectedDateTime: dt!);
      selectedDateTime = DateTime(dt.year, dt.month, dt.day);
    }
    update();
  }

  // to do here VAS :
  Set<VAS> selectedVAS = {};

  addVASToArray({required VAS vas}) {
    if (selectedVAS.contains(vas)) {
      selectedVAS.remove(vas);
    } else {
      selectedVAS.add(vas);
    }
  }

  fromAtHome(String? code, StorageViewModel? storageViewModel,
      {bool isScanDeliverd = false,
      required HomeViewModel homeViewModel}) async {
    if (code == null) {
      //todo show dialog
      print("mes__-1");
    } else {
      print("mes__-2");
      await storageViewModel?.customerStoragesChangeStatus(
        code,
        homeViewModel: homeViewModel,
        isScanDeliverdBox: isScanDeliverd,
      );
      print("mes__-3");
      Get.back();
      print("mes__-4");
    }
  }

  void calculateTaskBalance({required Task task, required Box box}) {}

  void changeTab(int index) {
    _currentIndex = index;
    update();
  }

  //here for get Charity Names For GiveAway :
  List<Beneficiary> beneficiarys = [];
  Beneficiary? selctedbeneficiary;
  TaskResponse operationTask = TaskResponse();

  Future<void> getBeneficiary() async {
    HomeHelper.getInstance.getBeneficiary().then((value) => {
          beneficiarys = value,
        });
  }

  Future<void> uploadCustomerSignature({required bool isFingerPrint}) async {
    Map<String, dynamic> body = {};
    if (isFingerPrint) {
      body = {
        Constance.salesOrderUnderScoure: operationTask.salesOrder ?? "",
        Constance.driverToken: operationTask.driverToken ?? ""
      };
    } else {
      Uint8List imageInUnit8List = signatureOutput;
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/image.png').create();
      file.writeAsBytesSync(imageInUnit8List);

      body = {
        Constance.salesOrderUnderScoure: operationTask.salesOrder ?? "",
        Constance.image: multipart.MultipartFile.fromFileSync(file.path),
        Constance.driverToken: operationTask.driverToken ?? ""
      };
    }

    try {
      await HomeHelper.getInstance
          .uploadCustomerSignature(body: body)
          .then((value) => {
                if (value.status!.success!)
                  {
                    snackSuccess("", "${value.status!.message}"),
                    Logger().e(value.data),
                    operationTask = TaskResponse.fromJson(value.data,
                        isFromNotification: false)
                  }
                else
                  {
                    snackError("", "${value.status!.message}"),
                  }
              });
    } catch (e) {
      Logger().e(e);
    }
  }

  //this for Touch/face (Id) Bottom Sheet :
  signatureWithTouchId() async {
    try {
      await _authenticate();
      if (isAuth ?? false) {
        await uploadCustomerSignature(isFingerPrint: true);
      }
    } catch (e) {
      printError();
    }
  }

  bool? isAuth = false;
  final LocalAuthentication auth = LocalAuthentication();

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
    isAuth = authenticated ? true : false;
    update();
  }

  Future<void> getTaskResponse({required String salersOrder}) async {
    startLoading();
    // try {
    await HomeHelper.getInstance.getTaskResponse(body: {
      LocalConstance.orderId: salersOrder
    }).then((value) => {
          if (value.status!.success!)
            {
              Logger().i(value.data),
              operationTask =
                  TaskResponse.fromJson(value.data, isFromNotification: false),
            }
          else
            {snackError("", value.status?.message)}
        });
    // } catch (e) {
    //   Logger().e(e);
    // }
    endLoading();
  }

  Future<void> applyPayment({
    required String salesOrder,
    required String paymentMethod,
    required String paymentId,
    required num extraFees,
    required String reason,
  }) async {
    Map<String, dynamic> map = {
      ConstanceNetwork.idKey: salesOrder,
      ConstanceNetwork.paymentMethodKey: paymentMethod,
      ConstanceNetwork.paymentIdKey: paymentId,
      ConstanceNetwork.extraFeesKey: extraFees,
      ConstanceNetwork.reasonKey: reason,
      Constance.driverToken: operationTask.driverToken ?? ""
    };
    startLoading();
    await OrderHelper.getInstance.applyPayment(body: map).then((value) {
      endLoading();
    });
  }

  List<NotificationData> listNotifications = [];
  Future<void> getNotifications()async{
    isLoading = true;
    update();
    await HomeHelper.getInstance.getNotifications().then((value) {
        if(value.isNotEmpty){
          listNotifications.clear();
          listNotifications = value;
          isLoading = false;
          update();
        }else{
          isLoading = false;
          update();
        }
    }).catchError((onError){
      Logger().d(onError.toString());
      isLoading = false;
      update();
    });
  }

  onRatingUpdate(double rating) {
    ratingService = rating;
    update();
  }

  //this for add user review
  void addReview(OrderSales orderSales , TextEditingController noteController) async{

    Map<String , dynamic> map  = {
      ConstanceNetwork.rateKey:"$ratingService",
      ConstanceNetwork.noteKey:"${noteController.text.toString()}",
      ConstanceNetwork.driverIdKey:"${orderSales.driverId}" ,
      ConstanceNetwork.salesOrderKey:"${orderSales.orderId}" ,
    };

    if(orderSales.driverId == null || (orderSales.driverId != null && "${orderSales.driverId.toString()}".isEmpty)){
      map.remove(ConstanceNetwork.driverIdKey);
    }

    isLoading = true;
    update();
    await OrderHelper.getInstance.addOrderReview(body: map).then((value) {
      if(value.status != null && value.status!.success!){
        isLoading = false;
          update();
          Get.back();
          snackSuccess("", value.status?.message??"");
      }else{
        isLoading = false;
          update();
      }
    }).catchError((onError) {
      Logger().d(onError.toString());
      isLoading = false;
      update();

    });

  }

  getCases()async{
    casesDataList.clear();
    await HomeHelper.getInstance.getCases().then((value) {
      casesDataList = value;
      update();
    });
  }

  void casesReport(TaskResponse? taskResponse, TextEditingController noteController) async{
    if(noteController.text.isEmpty && casesSelectedDataList.isEmpty){
      return;
    }

    Map<String , dynamic> map = {
      ConstanceNetwork.emergencyCaseKey:casesSelectedDataList.first.name,
      ConstanceNetwork.notesKey:"${noteController.text.toString()}",
      ConstanceNetwork.salesOrderKey:"${taskResponse?.salesOrder}" ,
    };

    isLoading = true;
    update();
    await OrderHelper.getInstance.addEmergencyCasesReport(body: map).then((value) {
     if(value.status != null && value.status!.success!){
        isLoading = false;
          update();
          Get.back();
          snackSuccess("", value.status?.message??"");
          casesSelectedDataList.clear();
        noteController.clear();
      }else{
        isLoading = false;
          update();
      }
    }).catchError((onError) {
      Logger().d(onError.toString());
      isLoading = false;
      update();

    });

  }

  void addCasesItem(CasesData casesData) {
    if(casesSelectedDataList.contains(casesData)){
      casesSelectedDataList.remove(casesData);
      update();
    }else{
      casesSelectedDataList.add(casesData);
      update();
    }
  }

}