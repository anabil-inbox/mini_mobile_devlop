import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/storage/local_bulk_modle.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/bottom_sheet_detailes_widaget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/logout_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/bulk_storage_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/quantity_storage_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/space_storage_bottom_sheet.dart';
import 'package:inbox_clients/network/api/feature/storage_feature.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
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

  // todo this for check deplication between Categories
  /// هي الانواع اللي عنا
  /// Quantity
  /// Item
  /// Space
  /// Dried Space
  /// Cooled Space
  /// Chilled Space
  /// Frozen Space
// اذا كان  Quantity او Item في الlist
// فممنوع اختار معهم اي اشي من الانواع الباقية
// اما ال space باقدر اختارهم مع بعض

  bool isShowAll = true;
  bool isShowQuantityAndItems = false;
  bool isShowSpaces = false;

  checkDaplication() {
    if (userStorageCategoriesData.length == 0) {
      isShowAll = true;
      isShowQuantityAndItems = false;
      isShowSpaces = false;
      update();
      return;
    }
    for (StorageCategoriesData item in userStorageCategoriesData) {
      if (item.storageCategoryType == ConstanceNetwork.quantityCategoryType ||
          item.storageCategoryType == ConstanceNetwork.itemCategoryType) {
        isShowQuantityAndItems = true;
        isShowSpaces = false;
        isShowAll = false;
        update();
        return;
      } else {
        isShowSpaces = true;
        isShowAll = false;
        isShowQuantityAndItems = false;

        update();
        return;
      }
    }
  }

  /// reached to CheckDuplications ::

  //todo this for home page for list or grid view
  bool? isListView = false;

  //todo this for home page for list or grid view

  // for quantity items counter
  int quantity = 1;
  int numberOfDays = 1;
  num balance = 0;

  // Set<StorageFeatures>? selectedStorageFeaturesArray = {};
  Set<StorageItem> selectedStorageItems = {};
  Set<String> lastItems = {};
  Set<String> selectedFeaures = {};
  // Function deepEq = const DeepCollectionEquality().equals;
  StorageItem? lastStorageItem;
  Set<StorageItem> arrayLastStorageItem = {};

  String selectedDuration = ConstanceNetwork.dailyDurationType;
  num customSpace = 0;

// declaration of TextEditing controllers For Custom Space :

  TextEditingController tdX = TextEditingController();
  TextEditingController tdY = TextEditingController();

// bulk item declarations
  bool isNeedingAdviser = false;
  TextEditingController tdSearch = TextEditingController();
  Item? selctedItem;
  Set<Item> allItems = {};

// this for last user chocies :
  num totalBalance = 0;
  List<StorageCategoriesData> userStorageCategoriesData = [];

// to do when user choose new option :
  void doOnChooseNewFeatures(
      {required StorageFeatures storageFeatures,
      required StorageCategoriesData storageCategoriesData}) {
    if (selectedFeaures.contains(storageFeatures.id)) {
      selectedFeaures.remove(storageFeatures.id);
    } else {
      selectedFeaures.add(storageFeatures.id!);
    }
    if (storageCategoriesData.storageCategoryType ==
        ConstanceNetwork.itemCategoryType) {
      addNewBulkOption(storageCategoriesData: storageCategoriesData);
    } else {
      countBalanceQuantity(storageCategoriesData: storageCategoriesData);
      update();
    }
  }

  /// to do when you want to count balance with new choosen options :
  void countBalanceWithOptions(
      {required StorageCategoriesData storageCategoriesData}) {
    if (storageCategoriesData.storageCategoryType ==
        ConstanceNetwork.quantityCategoryType) {
      // storageCategoriesData.storageItem?.forEach((element) {
      //   if (deepEq(element.options, selectedFeaures.toList())) {
      //     lastStorageItem = element;
      //   }
      // });
      storageCategoriesData.storageItem?.forEach((element) {
        //   if (element.options!.every((firstValue) {
        //     print("msg_Outter $firstValue");
        //     print("result ${selectedFeaures.toList().contains(firstValue)}");
        //  //  return selectedFeaures.toList().every((val) => firstValue == val);
        //  return areArraysEquales(element.options!, selectedFeaures.toList());
        //   } ))
        if (areArraysEquales(element.options!, selectedFeaures.toList())) {
          lastStorageItem = element;
        }
      });
    } else if (storageCategoriesData.storageCategoryType ==
            ConstanceNetwork.spaceCategoryType ||
        storageCategoriesData.storageCategoryType ==
            ConstanceNetwork.driedCage) {
      // storageCategoriesData.storageItem?.forEach((element) {
      //   if (deepEq(element.options, selectedFeaures.toList())) {
      //     if (num.parse(element.from ?? "0") <= customSpace &&
      //         num.parse(element.to ?? "0") >= customSpace) {
      //       lastStorageItem = element;
      //     } else {
      //     }
      //   }
      // });
      // storageCategoriesData.storageItem?.forEach((element) {
      //   if (element.options!
      //       .every((value) => selectedFeaures.toList().contains(value))) {
      //     if (num.parse(element.from ?? "0") <= customSpace &&
      //         num.parse(element.to ?? "0") >= customSpace) {
      //       lastStorageItem = element;
      //     }
      //   }
      // });

      storageCategoriesData.storageItem?.forEach((element) {
        if (areArraysEquales(element.options!, selectedFeaures.toList())) {
          if (num.parse(element.from ?? "0") <= customSpace &&
              num.parse(element.to ?? "0") >= customSpace) {
            lastStorageItem?.x = tdX.text;
            lastStorageItem?.y = tdY.text;
            lastStorageItem = element;
          }
        }
      });
    } else if (storageCategoriesData.storageCategoryType ==
        ConstanceNetwork.itemCategoryType) {
      // doOnAddNewBulkItem(storageCategoriesData: storageCategoriesData);
      for (var item in arrayLastStorageItem) {
        //  getBulksBalance(storageItem: item, newDuration: selectedDuration);
      }
    }
    print("msg_get_selcted_item ${lastStorageItem?.toJson()}");
  }

  void increaseQuantity(
      {required StorageCategoriesData storageCategoriesData}) {
    quantity++;
    countBalanceQuantity(storageCategoriesData: storageCategoriesData);
    update();
  }

  void increaseQuantityForBulks(
      {required StorageCategoriesData storageCategoriesData}) {
    quantity++;
    update();
  }

  void minesQuantityForBulks(
      {required StorageCategoriesData storageCategoriesData}) {
    if (quantity != 1) {
      quantity--;
      update();
    }
  }

  void minesQuantity({required StorageCategoriesData storageCategoriesData}) {
    if (quantity != 1) {
      quantity--;
      countBalanceQuantity(storageCategoriesData: storageCategoriesData);
      update();
    }
  }

  void increaseDaysDurations(
      {required StorageCategoriesData storageCategoriesData}) {
    numberOfDays++;
    if (storageCategoriesData.storageCategoryType ==
        ConstanceNetwork.itemCategoryType) {
      getBulksBalance(localBulk: localBulk);
    } else {
      countBalanceQuantity(storageCategoriesData: storageCategoriesData);
    }
    update();
  }

  void minasDaysDurations(
      {required StorageCategoriesData storageCategoriesData}) {
    if (numberOfDays != 1) {
      numberOfDays--;
      if (storageCategoriesData.storageCategoryType ==
          ConstanceNetwork.itemCategoryType) {
        getBulksBalance(localBulk: localBulk);
      } else {
        countBalanceQuantity(storageCategoriesData: storageCategoriesData);
      }
      update();
    }
  }

  void countBalanceQuantity(
      {required StorageCategoriesData storageCategoriesData}) {
    countBalanceWithOptions(storageCategoriesData: storageCategoriesData);
    getBalanceFromDuration(
        newDuration: selectedDuration,
        storageCategoriesData: storageCategoriesData);
    update();
  }

  void getBalanceFromDuration(
      {required String newDuration,
      required StorageCategoriesData storageCategoriesData}) {
    getSmallBalance(newDuration: newDuration, storageItem: lastStorageItem!);
    update();
  }

  void onChangeBulkDuration(
      {required String newDuration,
      required StorageCategoriesData storageCategoriesData}) {
    getBulksBalance(localBulk: localBulk);
  }

  void getSmallBalance(
      {required String newDuration, required StorageItem storageItem}) {
    if (newDuration
        .toLowerCase()
        .contains(ConstanceNetwork.dailyDurationType.toLowerCase())) {
      balance = num.parse(storageItem.price ?? "0");
    } else if (newDuration
        .toLowerCase()
        .contains(ConstanceNetwork.montlyDurationType.toLowerCase())) {
      balance = num.parse(storageItem.monthlyPrice ?? "0");
    } else if (newDuration
        .toLowerCase()
        .contains(ConstanceNetwork.yearlyDurationType.toLowerCase())) {
      balance = num.parse(storageItem.yearlyPrice ?? "0");
    } else if (newDuration
        .toLowerCase()
        .contains(ConstanceNetwork.unLimtedDurationType.toLowerCase())) {
      balance = num.parse(storageItem.price ?? "0");
    } else {
      balance = 0;
    }

    balance *= quantity * numberOfDays;
    update();
  }

  void saveStorageDataToArray(
      {required StorageCategoriesData storageCategoriesData,
      bool isUpdate = false,
      int? updateIndex}) {
    if (storageCategoriesData.storageCategoryType ==
        ConstanceNetwork.itemCategoryType) {
      saveBulksUser(
          storageCategoriesData: storageCategoriesData,
          index: updateIndex ?? 0);
    } else {
      StorageCategoriesData newStorageCategoriesData = storageCategoriesData;
      newStorageCategoriesData.userPrice = balance;
      totalBalance += balance;
      newStorageCategoriesData.storageItem = [lastStorageItem!];
      newStorageCategoriesData.quantity = quantity;
      if (isUpdate) {
        userStorageCategoriesData[updateIndex!] = newStorageCategoriesData;
      } else {
        newStorageCategoriesData.groupId = updateIndex;
        userStorageCategoriesData.add(newStorageCategoriesData);
      }
    }

    getStorageCategories();
    selctedItem = null;
    selectedDuration = "Daily";
    selectedFeaures.clear();
    quantity = 1;
    Get.back();
    update();
  }

  void intialBalance({required StorageCategoriesData storageCategoriesData}) {
    balance = 0;
    countBalanceWithOptions(storageCategoriesData: storageCategoriesData);
    getSmallBalance(
        newDuration: selectedDuration, storageItem: lastStorageItem!);
  }

  void doOnChangeSpace({required StorageCategoriesData storageCategoriesData}) {
    if (tdX.text.length > 0 && tdY.text.length > 0) {
      if (num.parse(tdX.text) * num.parse(tdY.text) > 1) {
        customSpace = num.parse(tdX.text) * num.parse(tdY.text);
      }
    }
    lastStorageItem?.to = customSpace.toString();
    intialBalance(storageCategoriesData: storageCategoriesData);
  }

  String checkCategoreyType({required String storageCategoreyType}) {
    if (storageCategoreyType == ConstanceNetwork.quantityCategoryType) {
      return ConstanceNetwork.quantityCategoryType;
    } else if (storageCategoreyType == ConstanceNetwork.spaceCategoryType ||
        storageCategoreyType.toLowerCase().contains("space")) {
      return ConstanceNetwork.spaceCategoryType;
    } else if (storageCategoreyType == ConstanceNetwork.itemCategoryType) {
      return ConstanceNetwork.itemCategoryType;
    } else {
      return "";
    }
  }

  /// excute when user add New Bulk! -_- :

  void doOnAddNewBulk(
      {required Item newItem,
      required StorageCategoriesData storageCategoriesData}) {
    if (allItems.contains(newItem)) {
      for (var item in allItems) {
        if (item == newItem) {
          newItem.quantity = newItem.quantity! + item.quantity!;
        }
      }
    } else {
      newItem.quantity = quantity;
      allItems.add(newItem);
      for (var item in arrayLastStorageItem) {
        if (item.item == newItem.storageName) {
          item.quantity = quantity;
          print("msg_item ${item.toJson()}");
        }
      }
      quantity = 1;
      update();
    }

    countBalanceWithOptions(storageCategoriesData: storageCategoriesData);
    update();
  }

  /// excute when user add Delete A Bulk! -_- :
  void ondeleteNewBulk(
      {required Item deletedItem,
      required StorageCategoriesData storageCategoriesData}) {
    allItems.remove(deletedItem);
    arrayLastStorageItem
        .removeWhere((element) => element.item == deletedItem.storageName);
    balance = 0;
    countBalanceWithOptions(storageCategoriesData: storageCategoriesData);
    // balance = 0;
    // for (var item in arrayLastStorageItem) {
    //   getBulksBalance(storageItem: item, newDuration: selectedDuration);
    // }
  }

  // void calcuateBulkBalance({required List<Item> bulksItems}) {
  //   for (var bulk in bulksItems) {
  //     // if (bulk.storageType == lastStorageItem!.item) {
  //     //   getBulksBalance(newDuration: selectedDuration, storageItem: lastStorageItem!);
  //     // }
  //    // getBulksBalance(newDuration: selectedDuration, storageItem: lastStorageItem!);
  //   }
  // }
  // this function to calculate bulks balance with options :

  //--------------------------------- Bulk items --------------------------------------------------------:

  //array to save session builk into:
  Set<StorageCategoriesData> bulkArrayItems = {};
  Set<StorageItem> endStorageItem = {};
  StorageItem? finalStorageItem;

  LocalBulk localBulk = LocalBulk();

  // to add new Bulk Item

  // void addNewBulk({required StorageCategoriesData newValue}) {
  //   if (bulkArrayItems.contains(newValue)) {
  //     bulkArrayItems.forEach((element) {
  //       if (element == newValue) {
  //         element.quantity = element.quantity ?? 1 + newValue.quantity!;
  //         print("${element.quantity}");
  //       }
  //     });
  //   } else {
  //     bulkArrayItems.add(newValue);
  //   }
  // //  doOnAddNewBulkItem(storageCategoriesData: newValue);
  //   update();
  //   // printArray(list: bulkArrayItems.toList());
  // }

  // doOnAddNewBulkItem({required StorageCategoriesData storageCategoriesData}) {
  //   for (var i = 0; i < storageCategoriesData.storageItem!.length; i++) {
  //     if (areArraysEquales(storageCategoriesData.storageItem![i].options ?? [],
  //         selectedFeaures.toList())) {
  //       if (storageCategoriesData.storageItem![i].item != null &&
  //           storageCategoriesData.storageItem![i].item ==
  //               selctedItem?.storageName) {
  //         lastStorageItem = storageCategoriesData.storageItem![i];
  //         arrayLastStorageItem.add(lastStorageItem!);
  //       //  break;
  //       } else {
  //         lastStorageItem = storageCategoriesData.storageItem![i];
  //       }
  //        arrayLastStorageItem.add(lastStorageItem!);
  //     }
  //   }
  // }

  void addNewBulk(
      {required StorageCategoriesData storageCategoriesData,
      required Item item}) {
    storageCategoriesData.storageItem?.forEach((element) {
      if (element.item == item.storageName) {
        element.quantity = quantity;
        localBulk.endStorageItem.add(element);
      }
    });
    getBulksBalance(localBulk: localBulk);
  }

  void addNewBulkOption(
      {required StorageCategoriesData storageCategoriesData}) {
    if (selectedFeaures.isEmpty) {
      localBulk.optionStorageItem = null;
    } else {
      storageCategoriesData.storageItem?.forEach((element) {
        if (areArraysEquales(
            element.options!.toList(), selectedFeaures.toList())) {
          localBulk.optionStorageItem = element;
        }
      });
    }

    getBulksBalance(localBulk: localBulk);
  }

  void removeFromBulk(StorageItem storageItem) {
    localBulk.endStorageItem.remove(storageItem);
    getBulksBalance(localBulk: localBulk);
    update();
  }

  void getBulksBalance({required LocalBulk localBulk}) {
    balance = 0;

    for (var item in localBulk.endStorageItem) {
      if (selectedDuration
          .toLowerCase()
          .contains(ConstanceNetwork.dailyDurationType.toLowerCase())) {
        balance += num.parse(item.price ?? "0") * item.quantity! * numberOfDays;
      } else if (selectedDuration
          .toLowerCase()
          .contains(ConstanceNetwork.montlyDurationType.toLowerCase())) {
        balance +=
            num.parse(item.monthlyPrice ?? "0") * item.quantity! * numberOfDays;
      } else if (selectedDuration
          .toLowerCase()
          .contains(ConstanceNetwork.yearlyDurationType.toLowerCase())) {
        balance +=
            num.parse(item.yearlyPrice ?? "0") * item.quantity! * numberOfDays;
      } else {
        balance = 0;
      }
    }

    if (selectedDuration
        .toLowerCase()
        .contains(ConstanceNetwork.dailyDurationType.toLowerCase())) {
      balance += num.parse(localBulk.optionStorageItem?.price ?? "0");
    } else if (selectedDuration
        .toLowerCase()
        .contains(ConstanceNetwork.montlyDurationType.toLowerCase())) {
      balance += num.parse(localBulk.optionStorageItem?.monthlyPrice ?? "0");
    } else if (selectedDuration
        .toLowerCase()
        .contains(ConstanceNetwork.yearlyDurationType.toLowerCase())) {
      balance += num.parse(localBulk.optionStorageItem?.yearlyPrice ?? "0");
    } else {
      balance = 0;
    }

    localBulk.printObject();
    update();
  }

// this for saving Categores Data :

  void saveBulksUser(
      {required StorageCategoriesData storageCategoriesData,
      required int index}) {
    for (var item in localBulk.endStorageItem) {
      userStorageCategoriesData.add(StorageCategoriesData(
        groupId: index,
        name: storageCategoriesData.name,
        storageName: item.item,
        quantity: item.quantity,
        userPrice: balance,
        storageCategoryType: ConstanceNetwork.itemCategoryType,
        storageItem: [
          StorageItem(
            item: item.item,
            options: localBulk.optionStorageItem?.options,
          )
        ],
      ));
    }
    getStorageCategories();
    totalBalance += balance;
    update();
  }

//****************************************************************************************************
// List<LocalBulk> arrLocalBulks = [];

//   void addNewBulk({required StorageCategoriesData newValue}) {

//   }

  void printArray({required List list}) {
    print("--------------------------------------------------");
    print("msg_in_print_array_length:: ${list.length}");
    for (var item in list) {
      print("msg_in_print_array ${item.toJson()}");
    }
    print("--------------------------------------------------");
  }

//---------------------------------- end bulk items -------------------------------------------------:

  void deleteCategoreyDataBottomSheet(
      {required StorageCategoriesData storageCategoriesData}) {
    Get.bottomSheet(GlobalBottomSheet(
      title: "Are You Sure You want to delete This Order ?",
      onOkBtnClick: () {
        userStorageCategoriesData.remove(storageCategoriesData);
        totalBalance -= storageCategoriesData.userPrice ?? 0;

        checkDaplication();
        update();
        Get.back();
      },
      onCancelBtnClick: () {
        Get.back();
      },
    ));
  }

  @override
  void onInit() {
    super.onInit();
    getStorageCategories();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
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
      {required StorageCategoriesData storageCategoriesData,
      bool isUpdate = false,
      int index = 0}) {
    if (ConstanceNetwork.quantityCategoryType ==
        storageCategoriesData.storageCategoryType) {
      selectedStorageItems = storageCategoriesData.storageItem!.toSet();
      Get.bottomSheet(
        QuantityStorageBottomSheet(
          isUpdate: isUpdate,
          index: index,
          storageCategoriesData: storageCategoriesData,
        ),
        isScrollControlled: true,
      );
    } else if (ConstanceNetwork.itemCategoryType ==
        storageCategoriesData.storageCategoryType) {
      Get.bottomSheet(
        ItemStorageBottomSheet(
          index: index,
          isUpdate: isUpdate,
          storageCategoriesData: storageCategoriesData,
        ),
        isScrollControlled: true,
      );
    } else if (ConstanceNetwork.spaceCategoryType ==
        storageCategoriesData.storageCategoryType) {
      Get.bottomSheet(
        SpaceStorageBottomSheet(
          index: index,
          isUpdate: isUpdate,
          storageCategoriesData: storageCategoriesData,
        ),
        isScrollControlled: true,
      );
    } else if (ConstanceNetwork.driedCage ==
        storageCategoriesData.storageCategoryType) {
      Get.bottomSheet(
        SpaceStorageBottomSheet(
          index: index,
          isUpdate: isUpdate,
          storageCategoriesData: storageCategoriesData,
        ),
        isScrollControlled: true,
      );
    }
  }

  void changeTypeViewLVGV() {
    isListView = !isListView!;
    update();
  }
}
