import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/bottom_sheet_detailes_widaget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/quantity_storage_bottom_sheet.dart';
import 'package:inbox_clients/network/api/feature/storage_feature.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/base_controller.dart';
import 'package:logger/logger.dart';

class StorageViewModel extends BaseController {
  //todo this for appbar select btn
  bool? isSelectBtnClick = false;
  bool? isSelectAllClick = false;
  List<String> listIndexSelected = <String>[];

  //todo this for appbar select btn

  //todo this for home page
  ValueNotifier<bool> isStorageCategories = ValueNotifier(false);
  List<StorageCategoriesData> storageCategoriesList = <StorageCategoriesData>[];

  //todo this for home page

  //todo this for home page for list or grid view
  bool? isListView = false;

  //todo this for home page for list or grid view

  // for quantity items counter
  int quantity = 1;

  void increaseQuantity() {
    quantity++;
    update();
  }

  void minesQuantity(){
    if (quantity != 1 ) {
      quantity --;
    }
    update();
  }
  
  //fot duration vars
int selectedDuration = 1;


  @override
  void onInit() {
    super.onInit();
    getStorageCategories();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  //todo this for show selection btn
  updateSelectBtn() {
    isSelectBtnClick = !isSelectBtnClick!;
    update();
  }

  //todo this for select all item
  updateSelectAll(List<String> list) {
    isSelectAllClick = !isSelectAllClick!;
    update();
    insertAllItemToList(list);
  }

  //todo this for add single item to selected List item
  addIndexToList(var index) {
    if (listIndexSelected.contains(index)) {
      listIndexSelected.remove(index);
      update();
    } else {
      listIndexSelected.add(index);
      update();
    }
  }

  //todo this for add all item to selected List item
  void insertAllItemToList(List<String> list) {
    if (isSelectAllClick!) {
      listIndexSelected.clear();
      listIndexSelected.addAll(list);
      update();
    } else {
      listIndexSelected.clear();
      update();
    }
  }

  //todo this for get Home Page Requests Storage Categories
  getStorageCategories() async {
    try {
      isStorageCategories.value = true;
      await StorageFeature.getInstance.getStorageCategories().then((value) {
        if (!GetUtils.isNull(value) && value.length != 0) {
          //todo success here
          storageCategoriesList = value;
          isStorageCategories.value = false;
          update();
        } else {
          //todo fail here
          isStorageCategories.value = false;
          update();
        }
      }).catchError((onError) {
        //todo fail here
        Logger().d(onError);
        isStorageCategories.value = false;
        update();
      });
    } catch (e) {
      //todo fail here
      Logger().d(e);
      isStorageCategories.value = false;
      update();
    }
  }

  //---------- to do for new storage Func ---------------
  int currentLevel = 0;
  // for bottomSheet Details:
  void detaielsBottomSheet(
      {required StorageCategoriesData storageCategoriesData,
      required List<String> media}) {
    Get.bottomSheet(
      BottomSheetDetaielsWidget(
        storageCategoriesData: storageCategoriesData,
        media: media,
      ),
      isScrollControlled: true,
    );
  }

  void showMainStorageBottomSheet(
      {required StorageCategoriesData storageCategoriesData}) {
    if (ConstanceNetwork.quantityCategoryType ==
        storageCategoriesData.storageCategoryType) {
      Get.bottomSheet(
        QuantityStorageBottomSheet(
          storageCategoriesData: storageCategoriesData,
        ),
        isScrollControlled: true,
      );
    } else if (ConstanceNetwork.itemCategoryType ==
        storageCategoriesData.storageCategoryType) {
      /// print("$storageType");
    } else if (ConstanceNetwork.spaceCategoryType ==
        storageCategoriesData.storageCategoryType) {
      /// print("$storageType");
    }
  }

  void changeTypeViewLVGV() {
    isListView = !isListView!;
    update();
  }
}
