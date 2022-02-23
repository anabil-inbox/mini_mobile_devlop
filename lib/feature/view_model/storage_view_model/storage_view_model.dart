import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/model/my_order/api_item.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart' as OS;
import 'package:inbox_clients/feature/model/storage/local_bulk_modle.dart';
import 'package:inbox_clients/feature/model/storage/order_item.dart';
import 'package:inbox_clients/feature/model/storage/payment.dart';
import 'package:inbox_clients/feature/model/storage/quantity_modle.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/model/storage/store_modle.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/order_details_screen.dart';
import 'package:inbox_clients/feature/view/screens/payment/payment_screen.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_two_widgets/selected_hour_item.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/bottom_sheet_detailes_widaget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/logout_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/bulk_storage_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/quantity_storage_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/space_storage_bottom_sheet.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/my_order_view_modle/my_order_view_modle.dart';
import 'package:inbox_clients/feature/view_model/payment_view_model/payment_view_model.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/local_database/cart_helper.dart';
import 'package:inbox_clients/local_database/model/cart_model.dart';
import 'package:inbox_clients/network/api/feature/order_helper.dart';
import 'package:inbox_clients/network/api/feature/storage_feature.dart';
import 'package:inbox_clients/network/api/model/app_response.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/base_controller.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';

class StorageViewModel extends BaseController {
  //todo this for appbar select btn
  bool? isSelectBtnClick = false;
  bool? isSelectAllClick = false;
  List<BoxItem> listIndexSelected = <BoxItem>[];

  //todo this for bottom sheet accept isAccept
  bool isAccept = false;
  bool isUsingPromo = false;

  // to do for X And Y Form Keys ::

  //todo this for bottom sheet accept

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
  bool isShowQuantity = false;
  bool isShowItem = false;
  bool isShowSpaces = false;

  bool? isChangeStatusLoading = false;

  checkDaplication() {
    if (userStorageCategoriesData.length == 0) {
      isShowAll = true;
      isShowQuantity = false;
      isShowItem = false;
      isShowSpaces = false;
      update();
      return;
    }
    for (StorageCategoriesData item in userStorageCategoriesData) {
      if (item.storageCategoryType == ConstanceNetwork.quantityCategoryType) {
        isShowQuantity = true;
        isShowAll = false;
        isShowItem = false;
        isShowSpaces = false;
        update();
        return;
      } else if (item.storageCategoryType ==
          ConstanceNetwork.itemCategoryType) {
        isShowItem = true;
        isShowQuantity = false;
        isShowAll = false;
        isShowSpaces = false;
        update();
        return;
      } else {
        isShowSpaces = true;
        isShowItem = false;
        isShowQuantity = false;
        isShowAll = false;
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

  //Set<String> lastItems = {};
  Set<StorageFeatures> selectedFeaures = {};

  // Function deepEq = const DeepCollectionEquality().equals;
  StorageItem? lastStorageItem;
  Set<StorageItem> arrayLastStorageItem = {};

  String selectedDuration = ConstanceNetwork.dailyDurationType;
  num customSpace = 1;

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
  List<StorageCategoriesData> userStorageCategoriesData =
      <StorageCategoriesData>[];

  /// this for account total balance for user choisess :

  void calculateBalance() {
    totalBalance = 0;
    userStorageCategoriesData.forEach((element) {
      totalBalance += element.userPrice!;
    });
  }

// to do when user choose new option :

  void doOnChooseNewFeatures(
      {required StorageFeatures storageFeatures,
      required StorageCategoriesData storageCategoriesData}) {
    if (selectedFeaures.contains(storageFeatures)) {
      selectedFeaures.remove(storageFeatures);
    } else {
      selectedFeaures.add(storageFeatures);
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
            ConstanceNetwork.driedCage ||
        storageCategoriesData.storageCategoryType!
            .toLowerCase()
            .contains("space")) {
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
          Logger().i("true");
          if (num.parse(element.from ?? "") <= customSpace &&
              num.parse(element.to ?? "") >= customSpace) {
            lastStorageItem?.x = tdX.text;
            lastStorageItem?.y = tdY.text;
            lastStorageItem = element;
            return;
          }
        } else {
          Logger().i("False");
        }
      });
    }
    // else if (storageCategoriesData.storageCategoryType ==
    //     ConstanceNetwork.itemCategoryType) {
    //   // doOnAddNewBulkItem(storageCategoriesData: storageCategoriesData);
    //   for (var item in arrayLastStorageItem) {
    //     //  getBulksBalance(storageItem: item, newDuration: selectedDuration);
    //   }
    // }
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
      int? updateIndex}) async {
    if (storageCategoriesData.storageCategoryType ==
        ConstanceNetwork.itemCategoryType) {
      saveBulksUser(
          isUpdate: isUpdate,
          storageCategoriesData: storageCategoriesData,
          index: updateIndex ?? 0);
    } else {
      if (storageCategoriesData.storageCategoryType ==
          ConstanceNetwork.quantityCategoryType) {
        var resQuantity = await checkQuantity(
            boxCheckedId: "${lastStorageItem?.name}", quntity: quantity);
        if (resQuantity.data["item"] != null) {
          Quantity q = Quantity.fromJson(resQuantity.data["item"]);
          if (q.quantityStatus == 0) {
            bool isComplete = await checkSpaceDiloag(
                quantity: Quantity.fromJson(resQuantity.data),
                message: resQuantity.status!.message!);
            if (!isComplete) {
              return;
            }
          }
        } else {
          isLoading = false;
          update();
          return;
        }
      }

      StorageCategoriesData newStorageCategoriesData = storageCategoriesData;
      newStorageCategoriesData.userPrice = balance;
      newStorageCategoriesData.needAdviser = isNeedingAdviser;
      totalBalance += balance;
      newStorageCategoriesData.x = int.tryParse(tdX.text);
      newStorageCategoriesData.y = int.tryParse(tdY.text);
      newStorageCategoriesData.selectedItem = lastStorageItem;
      newStorageCategoriesData.quantity = quantity;
      newStorageCategoriesData.selectedDuration = selectedDuration;
      newStorageCategoriesData.numberOfDays = numberOfDays;
      if (isUpdate) {
        userStorageCategoriesData[updateIndex!] = newStorageCategoriesData;
      } else {
        newStorageCategoriesData.groupId = updateIndex;
        await Future.delayed(Duration(seconds: 0)).then((value) =>
            {userStorageCategoriesData.add(newStorageCategoriesData)});
      }
    }
    Logger().i(storageCategoriesList.length);
    print("msg_lrngth ${userStorageCategoriesData.length}");
    calculateBalance();
    getStorageCategories();
    checkDaplication();
    selctedItem = null;
    selectedDuration = "Daily";
    selectedFeaures.clear();
    quantity = 1;
    numberOfDays = 1;
    isNeedingAdviser = false;
    tdX.clear();
    tdY.clear();
    tdSearch.clear();

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
    if ((tdX.text.length > 0) && (tdY.text.length > 0)) {
      if ((num.parse(tdX.text) * num.parse(tdY.text)) > 1) {
        customSpace = num.parse(tdX.text) * num.parse(tdY.text);
      }
    }
    //lastStorageItem?.to = customSpace.toString();
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
  void onAddingAdviser({required StorageCategoriesData storageCategoriesData}) {
    if (isNeedingAdviser) {
      selctedItem = null;
      selectedDuration = "Daily";
      selectedFeaures.clear();
      quantity = 1;
      numberOfDays = 1;
      balance = 0;
      tdX.clear();
      tdY.clear();
      tdSearch.clear();
      localBulk = LocalBulk();
      localBulk.endStorageItem = {};
      localBulk.optionStorageItem = null;

      update();
      // storageCategoriesData.storageItem?.forEach((element) {
      //   if (element.options!.isEmpty &&
      //       selectedFeaures.isEmpty &&
      //       element.item == null) {
      //     localBulk.optionStorageItem = element;
      //   }
      // });

      storageCategoriesData.storageItem?.forEach((element) {
        if (element.options!.isEmpty && element.item == null) {
          localBulk.optionStorageItem = element;
        }
      });

      localBulk.printObject();
    }
  }

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
          lastStorageItem?.quantity = quantity;
          storageCategoriesData.quantity = quantity;
          lastStorageItem = element;
        }
      });
    }
    localBulk.printObject();
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

    localBulk.bulkprice = balance;
    localBulk.printObject();
    update();
  }

// this for saving Categores Data :

  void saveBulksUser({
    required StorageCategoriesData storageCategoriesData,
    required int index,
    required bool isUpdate,
  }) {
    if (localBulk.endStorageItem.isEmpty && !isNeedingAdviser) {
      snackError("${tr.error_occurred}", "${tr.you_have_to_add_item}");
      return;
    }

    StorageCategoriesData newstorageCategoriesData = storageCategoriesData;
    newstorageCategoriesData.groupId = index;
    newstorageCategoriesData.name = storageCategoriesData.name;
    newstorageCategoriesData.selectedItem = lastStorageItem;
    newstorageCategoriesData.userPrice = balance;
    newstorageCategoriesData.needAdviser = isNeedingAdviser;

    newstorageCategoriesData.storageCategoryType =
        ConstanceNetwork.itemCategoryType;
    newstorageCategoriesData.selectedDuration = selectedDuration;
    newstorageCategoriesData.numberOfDays = numberOfDays;
    LocalBulk lb = LocalBulk();
    // newstorageCategoriesData.localBulk = localBulk;
    lb.endStorageItem = localBulk.endStorageItem;
    lb.optionStorageItem = localBulk.optionStorageItem;
    newstorageCategoriesData.localBulk = lb;
    if (isUpdate) {
      userStorageCategoriesData[index] = newstorageCategoriesData;
    } else {
      userStorageCategoriesData.add(newstorageCategoriesData);
    }
    localBulk.printObject();
    getStorageCategories();
    totalBalance += balance;
    calculateBalance();
    getStorageCategories();
    selctedItem = null;
    selectedDuration = "Daily";
    selectedFeaures.clear();
    quantity = 1;
    numberOfDays = 1;
    balance = 0;
    tdX.clear();
    tdY.clear();
    tdSearch.clear();
    localBulk = LocalBulk();
    localBulk.endStorageItem = {};
    localBulk.optionStorageItem = null;
    update();
  }

//****************************************************************************************************
// List<LocalBulk> arrLocalBulks = [];

//   void addNewBulk({required StorageCategoriesData newValue}) {

//   }

//---------------------------------- end bulk items -------------------------------------------------:

// this for check Quantity Befor Add:
  bool isLoading = false;

  Future<AppResponse> checkQuantity(
      {required String boxCheckedId, required int quntity}) async {
    isLoading = true;
    AppResponse res = AppResponse();

    await StorageFeature.getInstance
        .getStorageQuantity(
            item: jsonEncode([
          {"item": "$boxCheckedId", "qty": quantity}
        ]))
        .then((value) => {
              if (value.status!.success!)
                {
                  isLoading = false,
                  update(),
                }
              else
                {
                  isLoading = false,
                },
              res = value,
            });

    return res;
  }

  // here for quantity status == 0 (No Space):

  Future<bool> checkSpaceDiloag(
      {required Quantity quantity, required String message}) async {
    bool complete = false;
    await Get.defaultDialog(
        titlePadding: EdgeInsets.all(0),
        title: "${/*tr.amount_of_vacant_boxes_not_enough*/ ""}",
        middleText: "$message",
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                complete = true;
              },
              child: Text("${tr.ok}")),
          TextButton(
              onPressed: () {
                Get.back();
                complete = false;
              },
              child: Text("${tr.cancle}")),
        ]);

    return complete;
  }

  // this for add storage Order :
  ProfileViewModle profileViewModle =
      Get.put(ProfileViewModle(), permanent: true);

  Future<void> addNewStorage({String? paymentId}) async {
    try {
      //still this layer will complete when you complete order // refer to =>
      Get.put(MyOrderViewModle());
      List<OrderItem> orderItems = [];
      userStorageCategoriesData.forEach((element) {
        OrderItem localOrderItem = OrderItem();
        if (element.storageCategoryType == ConstanceNetwork.itemCategoryType) {
          element.localBulk?.endStorageItem.forEach((innerElement) {
            localOrderItem.itemCode = innerElement.name;
            localOrderItem.deliveryDate = selectedDateTime.toString();
            localOrderItem.subscription = element.selectedDuration;
            localOrderItem.qty = innerElement.quantity;
            localOrderItem.subscriptionDuration = element.numberOfDays;
            localOrderItem.groupId = element.groupId;
            // localOrderItem.itemParent = 0;
            localOrderItem.storageType = element.storageCategoryType;
            localOrderItem.needAdviser = element.needAdviser! ? 1 : 0;

            if (element.selectedDuration ==
                ConstanceNetwork.dailyDurationType) {
              localOrderItem.subscriptionPrice =
                  num.parse(innerElement.price ?? "0");
            } else if (element.selectedDuration ==
                ConstanceNetwork.montlyDurationType) {
              localOrderItem.subscriptionPrice =
                  num.parse(innerElement.monthlyPrice ?? "0");
            } else {
              localOrderItem.subscriptionPrice =
                  num.parse(innerElement.yearlyPrice ?? "0");
            }

            // localOrderItem.subscriptionPrice = element.pricePerDay;

            // localOrderItem.subscriptionPrice = element.userPrice! /
            //     element.numberOfDays! /
            //     innerElement.quantity!;
            Logger().i("${localOrderItem.toJson()}");
            print("${orderItems.length}");
            // localOrderItem.from = selectedDay!.from;
            // localOrderItem.to = selectedDay!.to;
            // localOrderItem.spacex = tdX.text;
            // localOrderItem.spacey = tdY.text;
            orderItems.add(localOrderItem);
            localOrderItem = OrderItem();
            print("${orderItems.length}");
          });
          if (!GetUtils.isNull(element.localBulk!.optionStorageItem)) {
            localOrderItem.itemCode =
                element.localBulk!.optionStorageItem!.name;
            localOrderItem.deliveryDate = selectedDateTime.toString();
            localOrderItem.subscription = element.selectedDuration;
            localOrderItem.qty = 1;
            localOrderItem.subscriptionDuration = element.numberOfDays;
            localOrderItem.groupId = element.groupId;
            localOrderItem.storageType = element.storageCategoryType;
            localOrderItem.needAdviser = element.needAdviser! ? 1 : 0;
            localOrderItem.itemParent = 0;
            orderItems.add(localOrderItem);
            localOrderItem = OrderItem();
          }
        } else {
          localOrderItem.itemCode = element.selectedItem!.name;
          localOrderItem.qty = element.quantity;
          localOrderItem.deliveryDate = selectedDateTime.toString();
          localOrderItem.subscription = element.selectedDuration;
          localOrderItem.subscriptionDuration = element.numberOfDays;
          localOrderItem.groupId = element.groupId;
          localOrderItem.storageType = element.storageCategoryType;
          localOrderItem.needAdviser = element.needAdviser! ? 1 : 0;
          localOrderItem.itemParent = 0;
          localOrderItem.subscriptionPrice =
              element.userPrice! / element.numberOfDays! / element.quantity!;
          // localOrderItem.from = selectedDay!.from;
          // localOrderItem.to = selectedDay!.to;
          // localOrderItem.spacex = tdX.text;
          // localOrderItem.spacey = tdY.text;
          orderItems.add(localOrderItem);
          localOrderItem = OrderItem();
        }
      });
      isLoading = true;
      update();
      // Map<String, dynamic> map = {};
      // map["order[0]"] = jsonEncode(orderItems);
      // map["type[0]"] = "New Storage_sv";
      // map["address[0]"] = selectedAddress!.id;

      await StorageFeature.getInstance.addNewStorage(body: {
        "shipping_address": "${selectedAddress?.id}",
        "items_list": jsonEncode(orderItems),
        "order_to": "${selectedDay?.from}",
        "coupon_code": "",
        "points": isAccept ? profileViewModle.myPoints.totalPoints : 0,
        "payment_method": "${selectedPaymentMethod?.id}",
        "payment_id": "$paymentId",
        "order_from": "${selectedDay?.to}",
        "order_time": "${selectedDay?.from}/${selectedDay?.to}",
        "type": getNewStorageType(
            storageCategoriesData: userStorageCategoriesData[0])
      }
          /*   map*/
          ).then((value) => {
            if (value.status!.success!)
              {
                isLoading = false,
                update(),
                checkDaplication(),
                isShowAll = true,
                snackSuccess("${tr.success}", "${value.status!.message}"),
                selectedPaymentMethod = null,
                selectedAddress = null,
                selectedDateTime = null,
                selectedStore = null,
                selectedDay = null,
                profileViewModle.getMyPoints(),
                // Get.close(1),
                userStorageCategoriesData.clear(),
                Get.offAll(() => OrderDetailesScreen(
                      orderId: value.data["order_name"],
                      isFromPayment: true,
                    )),
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

  void newBoxOperation() {
    try {} catch (e) {}
  }

  String getNewStorageType(
      {required StorageCategoriesData storageCategoriesData}) {
    if (storageCategoriesData.storageCategoryType ==
            ConstanceNetwork.spaceCategoryType ||
        storageCategoriesData.storageCategoryType!
            .toLowerCase()
            .contains("space")) {
      return LocalConstance.newNewStorageSpaceSv;
    } else if (storageCategoriesData.storageCategoryType ==
        ConstanceNetwork.itemCategoryType) {
      return LocalConstance.newStorageItemSv;
    } else if (storageCategoriesData.storageCategoryType ==
        ConstanceNetwork.quantityCategoryType) {
      // return LocalConstance.;
      return LocalConstance.newStorageSv;
    } else {
      return LocalConstance.newStorageSv;
    }
  }

  // here to getOrderDetailes With Id;
  //  Dangeras Dont Play ::

  OS.OrderSales? returnedOrderSales;

  Future<OS.OrderSales> getOrderDetailes({required String orderId}) async {
    OS.OrderSales orderSales = OS.OrderSales();
    await StorageFeature.getInstance
        .getOrderDetailes(body: {"order_id": "$orderId"}).then((value) => {
              Logger().i("$value"),
              orderSales = OS.OrderSales.fromJson(value.data["order"]),
              returnedOrderSales = orderSales
            });
    update();
    return orderSales;
  }

  /// validate Adding New Storage:

  bool isValiedToSaveStorage() {
    if (userStorageCategoriesData.isEmpty) {
      snackError("${tr.error_occurred}", "${tr.empty_order}");
      return false;
    } else if (GetUtils.isNull(selectedPaymentMethod)) {
      snackError(
          "${tr.error_occurred}", "${tr.you_have_to_select_payment_method}");
      return false;
    } else {
      return true;
    }
  }

  // getting Address For Stores
  Set<Store> storeAddress = {};
  Set<Address> userAddress = {};

  getStoreAddress() async {
    isLoading = true;
    update();
    await StorageFeature.getInstance.getStoreAddress().then((value) => {
          storeAddress = value.toSet(),
        });

    isLoading = false;
    update();
  }

  // this is for validate step two if All inputs true :
  bool isStepTwoValidate({required String catygoreyType}) {
    if (catygoreyType == ConstanceNetwork.itemCategoryType ||
        catygoreyType == ConstanceNetwork.quantityCategoryType) {
      if (GetUtils.isNull(selectedAddress)) {
        snackError("${tr.error_occurred}", "${tr.you_have_to_add_address}");
        return false;
      }
    } else if (GetUtils.isNull(storeAddress)) {
      snackError("${tr.error_occurred}", "${tr.you_have_to_add_address}");
      return false;
    } else if (GetUtils.isNull(selectedAddress)) {
      snackError("${tr.error_occurred}", "${tr.you_have_to_add_address}");
      return false;
    }

    if (GetUtils.isNull(selectedDateTime)) {
      snackError("${tr.error_occurred}", "${tr.you_have_to_select_date}");
      return false;
    } else if (selctedWorksHours!.isEmpty) {
      snackError("${tr.error_occurred}", "${tr.you_have_to_select_time}");
      return false;
    } else if (GetUtils.isNull(selectedDay)) {
      snackError("${tr.error_occurred}", "${tr.you_have_to_select_time}");
      return false;
    } else {
      return true;
    }
  }

  // Future<bool> checkTimeSlot() async {
  //   startLoading();
  //   bool isValidate = false;
  //   try {
  //     await HomeHelper.getInstance.checkTimeSlot(body: {
  //       "date": selectedDateTime,
  //       "from": selectedDay?.from,
  //       "to": selectedDay?.to
  //     }).then((value) => {
  //           if (value.status!.success!)
  //             {
  //               isValidate = true,
  //             }
  //           else
  //             {
  //               snackError('', value.status!.message!),
  //               isValidate = false,
  //             }
  //         });
  //   } catch (e) {
  //     printError();
  //     return false;
  //   }
  //   endLoading();
  //   return isValidate;
  // }

  // working hours bottom sheet

  List<Day>? selctedWorksHours = [];
  DateTime? selectedDateTime;
  Day? selectedDay;
  Store? selectedStore;
  Address? selectedAddress;

  void showDatePicker() async {
    var dt = await dateBiker();
    if (!GetUtils.isNull(dt)) {
      selctedWorksHours = getDayByNumber(selectedDateTime: dt!);
      Logger().i(selctedWorksHours);
      selectedDateTime = DateTime(dt.year, dt.month, dt.day);
    }
    update();
  }

  void chooseTimeBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: padding16!),
        decoration: BoxDecoration(
            color: colorTextWhite,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(padding30!))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: sizeH50,
            ),
            selctedWorksHours!.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(bottom: padding20!),
                    child: Text(
                      "${tr.sorry_there_are_no_work_hours}",
                      textAlign: TextAlign.center,
                    ))
                : ListView(
                    shrinkWrap: true,
                    children: selctedWorksHours!
                        .map((e) => SelectedHourItem(day: e))
                        .toList(),
                  ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  // this for payment Selcted::

  PaymentMethod? selectedPaymentMethod;

  void deleteCategoreyDataBottomSheet(
      {required StorageCategoriesData storageCategoriesData}) {
    Get.bottomSheet(GlobalBottomSheet(
      title: "Are You Sure You want to delete This Order ?",
      onOkBtnClick: () {
        userStorageCategoriesData.remove(storageCategoriesData);
        totalBalance -= storageCategoriesData.userPrice ?? 0;
        checkDaplication();
        calculateBalance();
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
    storageCategoriesList.clear();
    userStorageCategoriesData.clear();
    userStorageCategoriesData = <StorageCategoriesData>[];
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
  updateSelectAll(List<BoxItem> list) {
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
  void insertAllItemToList(List<BoxItem> list) {
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
      checkDaplication();
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
    if (isUpdate) {
      if (storageCategoriesData.storageCategoryType ==
          ConstanceNetwork.itemCategoryType) {
        lastStorageItem = storageCategoriesData.localBulk!.optionStorageItem;
        localBulk = storageCategoriesData.localBulk!;
      } else {
        lastStorageItem = storageCategoriesData.selectedItem!;
      }
      numberOfDays = storageCategoriesData.numberOfDays ?? 1;
      tdX.text = storageCategoriesData.x.toString();
      tdY.text = storageCategoriesData.y.toString();
      selectedDuration = storageCategoriesData.selectedDuration!;
      quantity = storageCategoriesData.quantity ?? 1;
      storageCategoriesData.storageFeatures?.forEach((element) {
        lastStorageItem?.options?.forEach((inner) {
          if (inner == element.storageFeature) {
            selectedFeaures.add(element);
          }
        });
      });
    }

    if (ConstanceNetwork.quantityCategoryType ==
        storageCategoriesData.storageCategoryType) {
      // selectedStorageItems = storageCategoriesData.storageItem!.toSet();

      Get.bottomSheet(
        QuantityStorageBottomSheet(
          isUpdate: isUpdate,
          index: index,
          storageCategoriesData: storageCategoriesData,
        ),
        isScrollControlled: true,
      ).whenComplete(() => {
            selectedFeaures.clear(),
            selectedDuration = "Daily",
            quantity = 1,
            numberOfDays = 1,
            lastStorageItem = null,
            balance = 0,
          });
    } else if (ConstanceNetwork.itemCategoryType ==
        storageCategoriesData.storageCategoryType) {
      Get.bottomSheet(
        ItemStorageBottomSheet(
          index: index,
          isUpdate: isUpdate,
          storageCategoriesData: storageCategoriesData,
        ),
        isScrollControlled: true,
      ).whenComplete(() => {
            selectedFeaures.clear(),
            // localBulk = LocalBulk(),
            selectedDuration = "Daily",
            quantity = 1,
            numberOfDays = 1,
            lastStorageItem = null,
            balance = 0,
          });
    } else if (ConstanceNetwork.spaceCategoryType ==
            storageCategoriesData.storageCategoryType ||
        storageCategoriesData.storageCategoryType!
            .toLowerCase()
            .contains("space")) {
      Get.bottomSheet(
        SpaceStorageBottomSheet(
          index: index,
          isUpdate: isUpdate,
          storageCategoriesData: storageCategoriesData,
        ),
        isScrollControlled: true,
      ).whenComplete(() => {
            selectedDuration = "Daily",
            quantity = 1,
            numberOfDays = 1,
            selectedFeaures.clear(),
            lastStorageItem = null,
            balance = 0,
          });
    } else if (ConstanceNetwork.driedCage ==
            storageCategoriesData.storageCategoryType ||
        ConstanceNetwork.spaceCategoryType ==
            storageCategoriesData.storageCategoryType) {
      Get.bottomSheet(
        SpaceStorageBottomSheet(
          index: index,
          isUpdate: isUpdate,
          storageCategoriesData: storageCategoriesData,
        ),
        isScrollControlled: true,
      ).whenComplete(() => {
            selectedDuration = "Daily",
            quantity = 1,
            numberOfDays = 1,
            selectedFeaures.clear(),
            lastStorageItem = null,
            balance = 0,
          });
    }
  }

  @override
  InternalFinalCallback<void> get onDelete;

  //todo this for customerStoragesChangeStatus api
  //todo i concatenate homeViewModel with storageViewModel
  //todo i get index of list to update it local
  customerStoragesChangeStatus(var serial,
      {HomeViewModel? homeViewModel}) async {
    if (serial == null) {
      Get.back();
      return;
    }
    isChangeStatusLoading = true;
    update();
    var body = {"${ConstanceNetwork.serial}": "$serial"};
    await StorageFeature.getInstance
        .customerStoragesChangeStatus(body: body)
        .then((value) {
      if (!GetUtils.isNull(value)) {
        if (value.status!.success!) {
          isChangeStatusLoading = false;
          // homeViewModel?.userBoxess.toList()[index].storageStatus =
          //     "${LocalConstance.boxAtHome}";
          homeViewModel?.update();
          update();
          Get.back();
          // Future.delayed(Duration(seconds: 0)).then((value) {
          //   Get.bottomSheet(
          //       CheckInBoxWidget(
          //         box: homeViewModel?.userBoxess.toList()[index],
          //         isUpdate: false,
          //       ),
          //       isScrollControlled: true);
          //   snackSuccess(tr.success, value.status!.message!);
          // });
          // snackSuccess(tr.success, value.status!.message!);
        } else {
          snackError(tr.error_occurred, value.status!.message!);
        }
      } else {
        isChangeStatusLoading = false;
        update();
      }
    }).catchError((onError) {
      Logger().d(onError);
      isChangeStatusLoading = false;
      update();
    });
  }

  List<VAS> selectedStringOption = <VAS>[];

  addStringOption({required VAS vas}) {
    if (selectedStringOption.contains(vas)) {
      selectedStringOption.remove(vas);
      update();
    } else {
      selectedStringOption.add(vas);
      update();
    }
  }

  bool searchOperationById({required String vasId}) {
    for (var item in selectedStringOption) {
      if (item.id == vasId) {
        return true;
      }
    }
    return false;
  }

  void changeTypeViewLVGV() {
    isListView = !isListView!;
    update();
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

  // void addNewSealsOrder(Box box, String fullAddress, String type, var date,
  //     {String? itemCode}) async {
  //   List<Map<String, dynamic>> mapSalesOrder = <Map<String, dynamic>>[];
  //   Logger().d("item_code = $type , serialNo = ${box.serialNo} , saleOrder = ${box.saleOrder}, \n  ${box.toString()}");

  //   //todo item_code == recall id
  //   //todo storage_type ==  we not need in recall
  //   //todo storage_child_in ==  list of box

  //   Map<String, dynamic> orderItem = {
  //     "order[0]": [
  //       {
  //         "item_code": "${box.storageName} $itemCode",
  //         "qty": 1,
  //         "delivery_date": "$date",
  //         "subscription": "Daily",
  //         "subscription_duration": 10,
  //         "subscription_price": 0,
  //         "group_id": 1,
  //         "storage_type": "$type",
  //         "item_parent": 0,
  //         "need_adviser": 0,
  //         "storage_child_in": [
  //           {"storage": "${box.serialNo}"}
  //         ]
  //       }
  //     ],
  //     "type[0]": "$itemCode", //New Storage
  //     "address[0]": "$fullAddress"
  //   };
  //   mapSalesOrder.add(orderItem);
  //   Map<String, dynamic> map = {"sales_order": jsonEncode(mapSalesOrder)};
  //   await OrderHelper.getInstance.newSalesOrder(body: map).then((value) {
  //     Logger().d(value.toJson());
  //   });
  // }

  calculateTaskPriceOnceBox({required Task task}) {
    num price = 0;
    if (selectedAddress != null) {
      for (var item in task.areaZones!) {
        if (item.id == selectedAddress!.zone) {
          price += item.price ?? 0;
          print("area_zone_price ${item.price}");
        }
      }
    }

    for (var item in selectedStringOption) {
      price += item.price ?? 0;
      print("options_price ${item.price}");
    }

    price += task.price!;
    print("task_price ${task.price!}");
    print("total_price $price");
    return getPriceWithFormate(price: price);
  }

  calculateTaskPriceLotBoxess(
      {required Task task,
      required List<Box> boxess,
      required bool isFromCart,
      Address? myAddresss}) {
    print("calculate Task Price Lot Boxess !");
    final ApiSettings settings =
        ApiSettings.fromJson(json.decode(SharedPref.instance.getAppSetting()));
    if (isFromCart) {
      selectedAddress = myAddresss;
    }
    num price = 0.00;

    price = task.price! * boxess.length;

    if (selectedAddress != null) {
      for (var item in task.areaZones!) {
        if (item.id == selectedAddress?.zone) {
          Logger().e((boxess.length / settings.deliveryFactor!)
              .toDouble()
              .ceilToDouble());
          price += (item.price ?? 0) *
              (boxess.length / settings.deliveryFactor!)
                  .toDouble()
                  .ceilToDouble();
        }
      }
    }

    Logger().i(price);
    if (isFromCart) {
      for (var item in task.selectedVas ?? []) {
        price += (item.price ?? 0) * boxess.length;
        print("options_price ${item.price}");
      }
    } else {
      for (var item in selectedStringOption) {
        price += (item.price ?? 0) * boxess.length;
        print("options_price ${item.price}");
      }
    }
    return getPriceWithFormate(price: price);
  }

  getDiscount() {
    if (isAccept) {}
  }

  bool isValidateTask({required Task task, required List<Box> boxess}) {
    if (!((task.id == LocalConstance.destroyId ||
            task.id == LocalConstance.terminateId ||
            task.id == LocalConstance.giveawayId) &&
        !(doseBoxInHome(boxess: boxess)))) {
      if (selectedAddress == null) {
        snackError("${tr.error_occurred}", "${tr.you_have_to_add_address}");
        return false;
      }
    }

    if (GetUtils.isNull(selectedDateTime)) {
      snackError("${tr.error_occurred}", "${tr.you_have_to_select_date}");
      return false;
    } else if (selctedWorksHours!.isEmpty) {
      snackError("${tr.error_occurred}", "${tr.you_have_to_select_time}");
      return false;
    } else if (GetUtils.isNull(selectedDay)) {
      snackError("${tr.error_occurred}", "${tr.you_have_to_select_time}");
      return false;
    } else {
      return true;
    }
  }

  // THIS REGUSET is For Playing WITH Api Tasks you will Add The Task And Boxess
  //Note :: IF You want to Send Single Box you Will Add The Box Only in The List Like This [myBox()]

  final HomeViewModel homeViewModel = Get.put(HomeViewModel(), permanent: true);

  Future<void> doTaskBoxRequest({
    required Task task,
    required bool isFromCart,
    required List<Box> boxes,
    List<BoxItem>? selectedItems,
    required String beneficiaryId,
    String? paymentId,
  }) async {
    startLoading();
    List<Map<String, dynamic>> mapSalesOrder = <Map<String, dynamic>>[];
    Map<String, dynamic> map = {};
    String boxessSeriales = "";
    String itemSeriales = "";
    num shivingPrice = 0;

    for (var i = 0; i < boxes.length; i++) {
      boxessSeriales += '${boxes[i].serialNo},';
    }

    selectedItems?.forEach((element) {
      itemSeriales += '${element.id},';
    });

    if (selectedAddress != null) {
      for (var item in task.areaZones!) {
        if (item.id == selectedAddress!.zone) {
          shivingPrice = (item.price ?? 0);
        }
      }
    }

    List data = [];

    if (boxessSeriales.isNotEmpty) {
      boxessSeriales = boxessSeriales.substring(0, boxessSeriales.length - 1);
    }

    if (itemSeriales.isNotEmpty) {
      itemSeriales = itemSeriales.substring(0, boxessSeriales.length - 2);
    }

    // if (task.id == LocalConstance.fetchId) {
    //   if (selectedAddress != null) {
    //     data.add({
    //       "item_code": task.id,
    //       "qty": 1,
    //       "delivery_date": "$selectedDateTime",
    //       "item_parent": "0",
    //       "subscription_price": task.price,
    //       "storage_type": "Process",
    //       "subscription": "Daily",
    //       "subscription_duration": 1,
    //       "group_id": "1",
    //       "order_to": "${selectedDay?.to}",
    //       "order_from": "${selectedDay?.from}",
    //       "order_time": "${selectedDay?.to} -- ${selectedDay?.from}",
    //       "storage_child_in": "$itemSeriales"
    //     });
    //     data.add({
    //       "item_code": "shipping_sv",
    //       "qty": selectedItems?.length,
    //       "area_zone": "${selectedAddress?.zone}",
    //       "delivery_date": "${DateTime.now()}",
    //       "subscription": "Daily",
    //       "subscription_duration": 1,
    //       "subscription_price": shivingPrice,
    //       "group_id": 1,
    //       "storage_type": "Process",
    //       "item_parent": 1,
    //       "need_adviser": 0,
    //       "order_to": "13:20",
    //       "order_from": "14:20",
    //       "order_time": "13:20 -- 14:20",
    //       "space": 0,
    //       "space_xaxis": 0,
    //       "space_yaxis": 0,
    //       "process_type": "shipping_sv",
    //       "storage_child_in": itemSeriales,
    //       "items_child_in": []
    //     });
    //     map["address[0]"] = selectedAddress?.id;
    //   } else {
    //     data.add({
    //       "item_code": task.id,
    //       "qty": boxes.length,
    //       "storage_type": "Process",
    //       "item_parent": "0",
    //       "subscription_price": task.price,
    //       "subscription": "Daily",
    //       "subscription_duration": 1,
    //       "group_id": "1",
    //       "delivery_date": DateTime.now().toString(),
    //       "storage_child_in": "$boxessSeriales"
    //     });
    //     map["address[0]"] = boxes[0].address?.id;
    //   }
    // } else if (task.id == LocalConstance.giveawayId) {
    //   if (selectedAddress != null) {
    //     data.add({
    //       "item_code": task.id,
    //       "qty": boxes.length,
    //       "delivery_date": "$selectedDateTime",
    //       "item_parent": "0",
    //       "group_id": "1",
    //       "subscription_price": task.price,
    //       "storage_type": "Process",
    //       "subscription": "Daily",
    //       "subscription_duration": 1,
    //       "area_zone": "${selectedAddress?.zone}",
    //       "beneficiary_name_in": homeViewModel.selctedbeneficiary?.id ?? "",
    //       "order_to": "${selectedDay?.to}",
    //       "order_from": "${selectedDay?.from}",
    //       "order_time": "${selectedDay?.to} -- ${selectedDay?.from}",
    //       "storage_child_in": "$boxessSeriales"
    //     });
    //     map["address[0]"] = selectedAddress?.id;
    //     data.add({
    //       "item_code": "shipping_sv",
    //       "qty": boxes.length,
    //       "area_zone": "${selectedAddress?.zone}",
    //       "delivery_date": "${DateTime.now()}",
    //       "subscription": "Daily",
    //       "subscription_duration": 1,
    //       "subscription_price": shivingPrice,
    //       "group_id": 1,
    //       "storage_type": "Process",
    //       "item_parent": 0,
    //       "need_adviser": 0,
    //       "order_to": "13:20",
    //       "order_from": "14:20",
    //       "order_time": "13:20 -- 14:20",
    //       "space": 0,
    //       "space_xaxis": 0,
    //       "space_yaxis": 0,
    //       "process_type": "shipping_sv",
    //       "storage_child_in": boxessSeriales,
    //       "items_child_in": []
    //     });
    //   } else {
    // data.add({
    //   "item_code": task.id,
    //   "qty": boxes.length,
    //   "storage_type": "Process",
    //   "beneficiary_name_in": beneficiaryId,
    //   "delivery_date": DateTime.now().toString(),
    //   "item_parent": "0",
    //   "subscription_price": task.price,
    //   "subscription": "Daily",
    //   "subscription_duration": 1,
    //   "group_id": "1",
    //   "storage_child_in": "$boxessSeriales"
    // });
    //     data.add({
    //       "item_code": "shipping_sv",
    //       "qty": boxes.length,
    //       "delivery_date": "${DateTime.now()}",
    //       "subscription": "Daily",
    //       "subscription_duration": 1,
    //       "subscription_price": shivingPrice,
    //       "group_id": 1,
    //       "storage_type": "Process",
    //       "item_parent": 0,
    //       "need_adviser": 0,
    //       "order_to": "13:20",
    //       "order_from": "14:20",
    //       "order_time": "13:20 -- 14:20",
    //       "space": 0,
    //       "space_xaxis": 0,
    //       "space_yaxis": 0,
    //       "process_type": "shipping_sv",
    //       "storage_child_in": boxessSeriales,
    //       "items_child_in": []
    //     });
    //     map["address[0]"] = boxes[0].address?.id;
    //   }
    // } else {
    //   if (!GetUtils.isNull(selectedItems)) {
    //     for (var item in selectedItems!) {
    //       data.add({
    //         "item_code": item.id,
    //         "qty": "${item.itemQuantity}",
    //         "storage_type": "Process",
    //         "delivery_date": selectedDateTime == null
    //             ? DateTime.now().toString()
    //             : selectedDateTime.toString(),
    //         "item_parent": "0",
    //         "order_to": "${selectedDay?.to ?? "13:20"}",
    //         "order_from": "${selectedDay?.from ?? "14:20"}",
    //         "order_time":
    //             "${selectedDay?.to ?? "13:20"} -- ${selectedDay?.from ?? "14:20"}",
    //         "group_id": "0",
    //       });
    //       map["address[0]"] = selectedAddress!.id;
    //     }
    //   }
    //   data.add({
    //     "item_code": task.id,
    //     "qty": boxes.length,
    //     "delivery_date": selectedDateTime == null
    //         ? DateTime.now().toString()
    //         : selectedDateTime.toString(),
    //     "item_parent": "0",
    //     "subscription_price": task.price,
    //     "storage_type": "Process",
    //     "subscription": "Daily",
    //     "subscription_duration": 1,
    //     "group_id": "1",
    //     "beneficiary_name_in": beneficiaryId,
    //     "order_to": "${selectedDay?.to ?? "13:20"}",
    //     "order_from": "${selectedDay?.from ?? "14:20"}",
    //     "order_time":
    //         "${selectedDay?.to ?? "13:20"} -- ${selectedDay?.from ?? "14:20"}",
    //     "storage_child_in": "$boxessSeriales"
    //   });
    //   data.add({
    //     "item_code": "shipping_sv",
    //     "qty": boxes.length,
    //     "delivery_date": "${DateTime.now()}",
    //     "subscription": "Daily",
    //     "subscription_duration": 1,
    //     "subscription_price": shivingPrice,
    //     "group_id": 1,
    //     "storage_type": "Process",
    //     "item_parent": 0,
    //     "need_adviser": 0,
    //     "order_to": "${selectedDay?.to ?? "13:20"}",
    //     "order_from": "${selectedDay?.from ?? "14:20"}",
    //     "order_time":
    //         "${selectedDay?.to ?? "13:20"} -- ${selectedDay?.from ?? "14:20"}",
    //     "space": 0,
    //     "space_xaxis": 0,
    //     "space_yaxis": 0,
    //     "process_type": "shipping_sv",
    //     "storage_child_in": boxessSeriales,
    //     "items_child_in": []
    //   });
    // }

    if (task.id == LocalConstance.fetchId) {
      data.add(ApiItem.getApiObjectToSend(
          itemCode: task.id ?? "",
          qty: boxes.length,
          subscriptionPrice: task.price ?? 0,
          selectedDateTime: selectedDateTime,
          groupId: 1,
          itemParent: 0,
          selectedDay: selectedDay,
          beneficiaryNameIn: "",
          boxessSeriales: boxessSeriales));
    } else if (task.id == LocalConstance.giveawayId) {
      data.add(ApiItem.getApiObjectToSend(
          itemCode: task.id ?? "",
          qty: boxes.length,
          subscriptionPrice: task.price ?? 0,
          selectedDateTime: selectedDateTime,
          groupId: 1,
          itemParent: 0,
          selectedDay: selectedDay,
          beneficiaryNameIn: homeViewModel.selctedbeneficiary?.id ?? "",
          boxessSeriales: boxessSeriales));
    } else {
      data.add(ApiItem.getApiObjectToSend(
          itemCode: task.id ?? "",
          qty: boxes.length,
          subscriptionPrice: task.price ?? 0,
          selectedDateTime: selectedDateTime,
          groupId: 1,
          itemParent: 0,
          selectedDay: selectedDay,
          boxessSeriales: boxessSeriales,
          beneficiaryNameIn: null));
    }
    data.add(ApiItem.getApiObjectToSend(
        itemCode: "shipping_sv",
        qty: boxes.length,
        subscriptionPrice: shivingPrice,
        selectedDateTime: selectedDateTime,
        groupId: 1,
        itemParent: 0,
        selectedDay: selectedDay,
        boxessSeriales: boxessSeriales,
        beneficiaryNameIn: null));

    for (var item in selectedStringOption) {
      data.add(ApiItem.getApiObjectToSend(
          itemCode: item.id ?? "",
          qty: boxes.length,
          subscriptionPrice: item.price ?? 0,
          selectedDateTime: selectedDateTime,
          groupId: 1,
          itemParent: 0,
          selectedDay: selectedDay,
          beneficiaryNameIn: "",
          boxessSeriales: boxessSeriales));
      // data.add({
      //   "item_code": item.id,
      //   "qty": boxes.length,
      //   "delivery_date": "${DateTime.now()}",
      //   "subscription": "Daily",
      //   "subscription_duration": 1,
      //   "subscription_price": item.price,
      //   "group_id": 1,
      //   "storage_type": "Process",
      //   "item_parent": 0,
      //   "need_adviser": 0,
      //   "order_to": "13:20",
      //   "order_from": "14:20",
      //   "order_time": "13:20 -- 14:20",
      //   "space": 0,
      //   "space_xaxis": 0,
      //   "space_yaxis": 0,
      //   "process_type": item.id,
      //   "storage_child_in": boxessSeriales,
      //   "items_child_in": []
      // });
    }

    map["type[0]"] = task.id;
    map["payment_method"] = selectedPaymentMethod?.id ?? "";
    map["payment_id"] = paymentId ?? "";
    map["points"] = isAccept ? userUsesPoints : 0;
    map["coupon_code"] = isUsingPromo ? tdCopun.text : "";
    map["order[0]"] = data;
    map["address[0]"] =
        selectedAddress == null ? boxes[0].address?.id : selectedAddress?.id;
    // for (var i = 0; i < boxes.length; i++) {
    //   // if (task.id == LocalConstance.pickupId) {
    //   //   map["type[$i]"] = LocalConstance.pickupId;
    //   // } else if (task.id == LocalConstance.recallId) {
    //   //   map["type[$i]"] = LocalConstance.recallId;
    //   // }
    //   // this Request Will Changed Here !:
    //   map["type[$i]"] = task.id;
    //   map["order[$i]"] = [
    //     {
    //       "item_code": task.id,
    //       "qty": 1,
    //       "delivery_date": "$selectedDateTime",
    //       "order_to": "${selectedDay?.to}",
    //       "order_from": "${selectedDay?.from}",
    //       "order_time": "${selectedDay?.to} -- ${selectedDay?.from}",
    //       "storage_child_in": "$boxessSeriales"
    //     }
    //   ];
    //   map["address[$i]"] = selectedAddress!.id;
    // }

    mapSalesOrder.add(map);

    Map<String, dynamic> newMap = {"sales_order": jsonEncode(mapSalesOrder)};
    await OrderHelper.getInstance.newSalesOrder(body: newMap).then((value) {
      Logger().d(value.toJson());
      if (value.status!.success!) {
        if (!isFromCart) {
          snackSuccess("${tr.success}", value.status!.message!);
          Get.back();
          update();
        }
      } else {
        snackError("${tr.error_occurred}", value.status!.message!);
      }
    });

    cleanAfterSucces();
    if (!isFromCart) {
      Get.close(1);
    }

    await homeViewModel.refreshHome();
    endLoading();
  }

  // Future<void> giveawayBoxRequest({required Task task , required Box box}) async{
  // }

  // Future<void> recallBoxRequest({required Task task, required Box box}) async {}

  cleanAfterSucces() {
    isAccept = false;
    selectedPaymentMethod = null;
    selectedStringOption.clear();
    selectedStore = null;
    selectedAddress = null;
    selectedDay = null;
    isAccept = false;
    isUsingPromo = false;
    selectedDateTime = null;
    profileViewModle.getMyPoints();
  }

  // Fun to Test If Ihave Any Box At home ::
  bool doseBoxInHome({required List<Box> boxess}) {
    for (var box in boxess) {
      if (box.storageStatus == LocalConstance.boxAtHome) {
        return true;
      }
    }
    return false;
  }

  // to do this for payment :
  Future<void> goToPaymentMethod({
    required num amount,
    required bool isFromNewStorage,
    Task? task,
    List<Box>? boxes,
    String? beneficiaryId,
    required bool isFromCart,
    required List<CartModel> cartModels,
  }) async {
    startLoading();
    try {
      await StorageFeature.getInstance
          .payment(body: {"amount": amount}).then((value) => {
                if (value.status!.success!)
                  {
                    // snackSuccess("${tr.success}", value.status!.message!),
                    if (GetUtils.isURL(value.data["payment_url"]))
                      {
                        Logger().e(value.data["payment_url"]),
                        Get.put(PaymentViewModel()),
                        Get.to(() => PaymentScreen(
                              cartModels: cartModels,
                              isFromCart: isFromCart,
                              beneficiaryId: beneficiaryId,
                              boxes: boxes,
                              task: task,
                              url: value.data["payment_url"],
                              isFromNewStorage: isFromNewStorage,
                            )),
                        endLoading()
                      }
                  }
                else
                  {snackError("${tr.error_occurred}", value.status!.message!)}
              });
    } catch (e) {
      printError();
    }

    endLoading();
  }

  AppResponse? checkPromoAppResponse;

  Future<void> checkPromo({required String promoCode}) async {
    try {
      await StorageFeature.getInstance
          .checkPromo(body: {LocalConstance.coupon: promoCode}).then(
        (value) {
          checkPromoAppResponse = value;
          update();
        },
      );
    } catch (e) {
      printError();
    }
  }

  num priceAfterDiscount = 0;
  num userUsesPoints = 0;
  final tdCopun = TextEditingController();

  List<dynamic> getPriceWithDiscount({required String oldPrice}) {
    num price = num.parse(oldPrice);
    num usesPoints = 0;
    if (!GetUtils.isNull(checkPromoAppResponse)) {
      if (checkPromoAppResponse!.status!.success!) {
        if (checkPromoAppResponse?.data["discount_type"] ==
            LocalConstance.discountPercentag) {
          if ((price - (price * checkPromoAppResponse?.data["amount"] / 100)) >
              0) {
            price =
                price - (price * checkPromoAppResponse?.data["amount"] / 100);
          } else {
            price = 0;
          }
        } else {
          price = price - checkPromoAppResponse?.data["amount"];
        }
      }
    }

    if (isAccept) {
      if (price -
              profileViewModle.myPoints.totalPoints! /
                  SharedPref.instance.getCurrentUserData().conversionFactor! >
          0) {
        price = price -
            profileViewModle.myPoints.totalPoints! /
                SharedPref.instance.getCurrentUserData().conversionFactor!;
        userUsesPoints = profileViewModle.myPoints.totalPoints!;
      } else {
        // price = ((price * profileViewModle.myPoints.totalPoints!) - price) /
        //     SharedPref.instance.getCurrentUserData().conversionFactor!;

        usesPoints = profileViewModle.myPoints.totalPoints! -
            (price *
                SharedPref.instance.getCurrentUserData().conversionFactor!);
        price = 0;
      }
    }
    priceAfterDiscount = price;
    userUsesPoints = profileViewModle.myPoints.totalPoints! - usesPoints;
    // if (!GetUtils.isNull(checkPromoAppResponse)) {
    //   if (checkPromoAppResponse!.status!.success!) {
    //     if ((price - (price * checkPromoAppResponse?.data["amount"] / 100)) >
    //         0) {
    //       price = price - (price * checkPromoAppResponse?.data["amount"] / 100);
    //     } else {
    //       price = 0;
    //     }
    //   }
    // }
    Logger().e("MSG_USER_POINTS = $userUsesPoints");
    Logger().e("MSG_USER_POINTS = $price");
    profileViewModle.getMyPoints();
    return [getPriceWithFormate(price: price), usesPoints];
  }

  calculateTasksCart({required List<CartModel> cartModel}) {
    final ApiSettings settings =
        ApiSettings.fromJson(json.decode(SharedPref.instance.getAppSetting()));

    num price = 0.00;
    for (var cartItem in cartModel) {
      selectedAddress = cartItem.address;

      price += cartItem.task!.price! * cartItem.box!.length;

      if (selectedAddress != null) {
        for (var item in cartItem.task!.areaZones!) {
          if (item.id == selectedAddress?.zone) {
            Logger().e((cartItem.box!.length / settings.deliveryFactor!)
                .toDouble()
                .ceilToDouble());
            price += (item.price ?? 0) *
                (cartItem.box!.length / settings.deliveryFactor!)
                    .toDouble()
                    .ceilToDouble();
          }
        }
      }

      for (var item in cartItem.task!.selectedVas!) {
        price += (item.price ?? 0) * cartItem.box!.length;
        print("options_price ${item.price}");
      }
      Logger().i(price);
    }

    return getPriceWithFormate(price: price);
  }

  Future<void> checkOutCart({
    required List<CartModel> cartModels,
    String? paymentId,
  }) async {
    try {
      startLoading();
      List<Map<String, dynamic>> mapSalesOrder = <Map<String, dynamic>>[];

      for (var i = 0; i < cartModels.length; i++) {
        selectedAddress = cartModels[i].address;
        selectedStringOption = cartModels[i].task?.selectedVas ?? [];
        String boxessSeriales = "";
        String itemSeriales = "";
        num shivingPrice = 0;
        Map<String, dynamic> map = {};
        for (var j = 0; j < cartModels[i].box!.length; j++) {
          boxessSeriales += '${cartModels[i].box![j].serialNo},';
        }

        cartModels[i].boxItem?.forEach((element) {
          itemSeriales += '${element.id},';
        });

        if (selectedAddress != null) {
          for (var item in cartModels[i].task!.areaZones!) {
            if (item.id == selectedAddress!.zone) {
              shivingPrice = (item.price ?? 0);
            }
          }
        }

        List data = [];

        if (boxessSeriales.isNotEmpty) {
          boxessSeriales =
              boxessSeriales.substring(0, boxessSeriales.length - 1);
        }

        if (itemSeriales.isNotEmpty) {
          itemSeriales = itemSeriales.substring(0, boxessSeriales.length - 2);
        }

        if (cartModels[i].task!.id == LocalConstance.fetchId) {
          data.add(ApiItem.getApiObjectToSend(
              itemCode: cartModels[i].task?.id ?? "",
              qty: cartModels[i].box!.length,
              subscriptionPrice: cartModels[i].task?.price ?? 0,
              selectedDateTime: selectedDateTime,
              groupId: 1,
              itemParent: 0,
              selectedDay: selectedDay,
              beneficiaryNameIn: "",
              boxessSeriales: boxessSeriales));
        } else if (cartModels[i].task?.id == LocalConstance.giveawayId) {
          data.add(ApiItem.getApiObjectToSend(
              itemCode: cartModels[i].task?.id ?? "",
              qty: cartModels[i].box!.length,
              subscriptionPrice: cartModels[i].task?.price ?? 0,
              selectedDateTime: selectedDateTime,
              groupId: 1,
              itemParent: 0,
              selectedDay: selectedDay,
              beneficiaryNameIn: homeViewModel.selctedbeneficiary?.id ?? "",
              boxessSeriales: boxessSeriales));
        } else {
          data.add(ApiItem.getApiObjectToSend(
              itemCode: cartModels[i].task?.id ?? "",
              qty: cartModels[i].box!.length,
              subscriptionPrice: cartModels[i].task?.price ?? 0,
              selectedDateTime: selectedDateTime,
              groupId: 1,
              itemParent: 0,
              selectedDay: selectedDay,
              boxessSeriales: boxessSeriales,
              beneficiaryNameIn: null));
        }
        data.add(ApiItem.getApiObjectToSend(
            itemCode: "shipping_sv",
            qty: cartModels[i].box!.length,
            subscriptionPrice: shivingPrice,
            selectedDateTime: selectedDateTime,
            groupId: 1,
            itemParent: 0,
            selectedDay: selectedDay,
            boxessSeriales: boxessSeriales,
            beneficiaryNameIn: null));

        for (var item in selectedStringOption) {
          data.add(ApiItem.getApiObjectToSend(
              itemCode: item.id ?? "",
              qty: cartModels[i].box!.length,
              subscriptionPrice: item.price ?? 0,
              selectedDateTime: selectedDateTime,
              groupId: 1,
              itemParent: 0,
              selectedDay: selectedDay,
              beneficiaryNameIn: "",
              boxessSeriales: boxessSeriales));
        }

        map["type[$i]"] = cartModels[i].task?.id;
        map["payment_method"] = selectedPaymentMethod?.id ?? "";
        map["payment_id"] = paymentId ?? "";
        map["points"] = isAccept ? userUsesPoints / cartModels.length : 0;
        map["coupon_code"] = isUsingPromo ? tdCopun.text : "";
        map["order[$i]"] = data;
        map["address[$i]"] = selectedAddress == null
            ? cartModels[i].box![0].address?.id
            : selectedAddress?.id;
        mapSalesOrder.add(map);
      }

      Map<String, dynamic> newMap = {"sales_order": jsonEncode(mapSalesOrder)};
      await OrderHelper.getInstance
          .newSalesOrder(body: newMap)
          .then((value) async {
        Logger().d(value.toJson());
        if (value.status!.success!) {
          if (selectedPaymentMethod?.id == LocalConstance.bankCard) {
            Get.close(3);
          } else {
            Get.close(2);
          }

          snackSuccess("${tr.success}", value.status!.message!);
          await CartHelper.instance.deleteDataBase();
        } else {
          snackError("${tr.error_occurred}", value.status!.message!);
        }
      });

      cleanAfterSucces();
      await homeViewModel.refreshHome();
      endLoading();
    } catch (e) {}
  }
}
