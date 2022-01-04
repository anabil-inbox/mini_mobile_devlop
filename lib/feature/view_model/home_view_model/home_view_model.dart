import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/model/storage/store_modle.dart';
import 'package:inbox_clients/feature/view/screens/home/home_page_holder.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/tasks_widgets/task_widget_BS.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/network/api/feature/home_helper.dart';
import 'package:inbox_clients/network/api/feature/item_helper.dart';
import 'package:inbox_clients/network/api/feature/storage_feature.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/base_controller.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:logger/logger.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomeViewModel extends BaseController {
  var _currentIndex = 0;
  int get currentIndex => _currentIndex;
  //to do for Loading var:
  bool isLoading = false;

  // get Custome Boxes Vars And Functtions ::
  Set<Box> userBoxess = {};

  Future<void> getCustomerBoxes() async {
    startLoading();
    await HomeHelper.getInstance
        .getCustomerBoxess(pageSize: 10, page: page)
        .then((value) => {
              userBoxess.addAll(value),
              update(),
            });
    endLoading();
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

  //paginations Vars And Func ::
  var scrollcontroller = ScrollController();
  int page = 1;

  // open Scaner Qr :
  var scanArea = (MediaQuery.of(Get.context!).size.width < 400 ||
          MediaQuery.of(Get.context!).size.height < 400)
      ? 150.0
      : 300.0;

  Barcode? result;
  QRViewController? controller;

  onQRViewCreated(QRViewController controller, {bool? isFromAtHome, int? index, StorageViewModel? storageViewModel}) {
    try {
      this.controller = controller;

      controller.scannedDataStream.listen((scanData) {
        result = scanData;
      }).onData((data) async {
        Logger().i(data.code);
        Logger().i("Serial ${data.code}");
        if(isFromAtHome!)
        {
          controller.dispose();
          await fromAtHome(data.code , index , storageViewModel);
        }
        else
         {
           await getBoxBySerial(serial: data.code ?? "").then((value) => {
             if (value.id == null)
               {Get.off(() => HomePageHolder())}
             else
               {
                 Get.off(() => HomePageHolder(
                   box: value,
                   isFromScan: true,
                 ))
               }
           });
         }
      });
    } catch (e) {
      Logger().e("$e");
    }
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

  void pagination() {
    if ((scrollcontroller.position.pixels ==
        scrollcontroller.position.maxScrollExtent)) {
      page += 1;
    }
    update();
  }

  // to get box by his serial ::

  Future<Box> getBoxBySerial({required String serial}) async {
    Box box = Box();
    await ItemHelper.getInstance.getBoxBySerial(body: {
      "serial": serial
    }).then((value) => {
          if (value.status!.success!)
            {
              box = Box.fromJson(value.data["Storages"]),
            }
          else
            {
              snackError("${tr.error_occurred}", "${value.status!.message}"),
            }
        });
    return box;
  }

  @override
  void onInit() {
    super.onInit();
    getCustomerBoxes();
    getTasks();
    scrollcontroller.addListener(pagination);
  }

  void changeTab(int index) {
    _currentIndex = index;
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
          Logger().i("${value.toList().length}"),
          for (var item in value)
            {
              if (item.id != LocalConstance.fetchId && item.id != LocalConstance.newStorageSv) {tasks.add(item)}
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
  Address? selectedAddres;

  Set<Store> storeAddress = {};
  bool isLoadingGetAddress = false;
  // to get Store Address ::

  getStoreAddress() async {
    isLoadingGetAddress = true;
    update();
    await StorageFeature.getInstance.getStoreAddress().then((value) => {
          storeAddress = value.toSet(),
        });
    isLoadingGetAddress = false;
    update();
  }

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

   fromAtHome(String? code, int? index, StorageViewModel? storageViewModel) async{
    if (code == null)
    {
      //todo show dialog
    }
    else
    {
      await storageViewModel?.customerStoragesChangeStatus(code ,index:index , homeViewModel:this);
      Get.back();

    }
  }
}
