import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/beneficiary.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/model/storage/store_modle.dart';
import 'package:inbox_clients/feature/view/screens/home/home_page_holder.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/check_in_box_widget.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/tasks_widgets/task_widget_BS.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/network/api/feature/home_helper.dart';
import 'package:inbox_clients/network/api/feature/item_helper.dart';
import 'package:inbox_clients/network/api/feature/storage_feature.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/base_controller.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:logger/logger.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomeViewModel extends BaseController {
  var _currentIndex = 0;
  int get currentIndex => _currentIndex;
  //to do for Loading var:
  bool isLoading = false;
  bool isLoadingPagination = false;

  // get Custome Boxes Vars And Functtions ::
  Set<Box> userBoxess = {};

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
  final scrollcontroller = ScrollController();
  int page = 1;

  // open Scaner Qr :
  var scanArea = (MediaQuery.of(Get.context!).size.width < 400 ||
          MediaQuery.of(Get.context!).size.height < 400)
      ? 300.0
      : 300.0;

  Barcode? result;
  QRViewController? controller;

  onQRViewCreated(QRViewController controller,
      {bool? isFromAtHome,
      required StorageViewModel storageViewModel,
      int index = 0}) {
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
          if (isFromAtHome ?? false) {
            update();
          } else {}
          userBoxess.toList()[index].storageStatus = LocalConstance.boxAtHome;
          update();
          await fromAtHome(data.code, storageViewModel);
          await getBoxBySerial(serial: data.code ?? "")
              .then((value) async => {
                    Logger().e(value.toJson()),
                    if (value.id == null)
                      {
                        Get.off(() => HomePageHolder()),
                      }
                    else
                      {
                        Get.off(() => HomePageHolder(
                              box: value,
                              isFromScan: true,
                            )),
                        itemViewModle.tdName.text = value.storageName ?? "",


                        if (isFromAtHome ?? false)
                          {
                            await Get.bottomSheet(
                                    CheckInBoxWidget(
                                        box: value, isUpdate: false),
                                    isScrollControlled: true)
                                .then((value) => {}),
                          }
                        else
                          {
                            userBoxess.forEach((element) {
                              if (element.id == value.id) {
                                element.storageStatus =
                                    LocalConstance.boxAtHome;
                              }
                            }),
                            getCustomerBoxes()
                          }
                      }
                  })
              .then((value) => {});
          update();
          // Get.back();
        }
      });
      refreshHome();
      isLoading = false;
      update();
    } catch (e) {
      Logger().e("$e");
    }
    endLoading();
    refresh();
  }

  void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    try {
      if (!p) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('no Permission')),
        );
      }
    } catch (e) {
      Logger().e("$e");
    }
  }

  // this for Pagination :

  void pagination() async {
    try {
      startLoadingPagination();
      if ((scrollcontroller.position.pixels ==
          scrollcontroller.position.maxScrollExtent)) {
        await getCustomerBoxes();
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
      "serial": serial
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
    scrollcontroller.addListener(pagination);
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

  fromAtHome(String? code, StorageViewModel? storageViewModel) async {
    if (code == null) {
      //todo show dialog
    } else {
      await storageViewModel?.customerStoragesChangeStatus(code,
          homeViewModel: this);
      Get.back();
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

  Future<void> getBeneficiary() async {
    HomeHelper.getInstance.getBeneficiary().then((value) => {
          beneficiarys = value,
        });
  }
}
