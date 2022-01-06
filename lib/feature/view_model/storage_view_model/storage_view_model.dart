import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/my_order/new_sales_order.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart' as OS;
import 'package:inbox_clients/feature/model/storage/local_bulk_modle.dart';
import 'package:inbox_clients/feature/model/storage/order_item.dart';
import 'package:inbox_clients/feature/model/storage/payment.dart';
import 'package:inbox_clients/feature/model/storage/quantity_modle.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/model/storage/store_modle.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/check_in_box_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_two_widgets/selected_hour_item.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/bottom_sheet_detailes_widaget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/logout_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/bulk_storage_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/quantity_storage_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/space_storage_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/network/api/feature/order_helper.dart';
import 'package:inbox_clients/network/api/feature/storage_feature.dart';
import 'package:inbox_clients/network/api/model/app_response.dart';
import 'package:inbox_clients/network/api/model/order_api.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/base_controller.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/string.dart';
import 'package:logger/logger.dart';

class StorageViewModel extends BaseController {
  //todo this for appbar select btn
  bool? isSelectBtnClick = false;
  bool? isSelectAllClick = false;
  List<String> listIndexSelected = <String>[];

  //todo this for bottom sheet accept isAccept
  bool isAccept = true;
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
  bool isShowQuantityAndItems = false;
  bool isShowSpaces = false;

  bool? isChangeStatusLoading = false;


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
          if (num.parse(element.from ?? "0") <= customSpace &&
              num.parse(element.to ?? "0") >= customSpace) {
            lastStorageItem?.x = tdX.text;
            lastStorageItem?.y = tdY.text;
            lastStorageItem = element;
          }
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

  void saveStorageDataToArray({required StorageCategoriesData storageCategoriesData,
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
      storageCategoriesData.storageItem?.forEach((element) {
        if (element.options!.isEmpty &&
            selectedFeaures.isEmpty &&
            element.item == null) {
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

  void saveBulksUser(
      {required StorageCategoriesData storageCategoriesData,
      required int index,
      required bool isUpdate}) {
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

         title: "${/*tr.amount_of_vacant_boxes_not_enough*/""}",
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

  Future<void> addNewStorage() async {
    //still this layer will complete when you complete order // refer to =>
    List<OrderItem> orderIyems = [];

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
          localOrderItem.itemParent = 0;
          localOrderItem.storageType = element.storageCategoryType;
          localOrderItem.needAdviser = element.needAdviser! ? 1 : 0;
          localOrderItem.subscriptionPrice = element.userPrice! /
              element.numberOfDays! /
              innerElement.quantity!;
          Logger().i("${localOrderItem.toJson()}");
          print("${orderIyems.length}");
          orderIyems.add(localOrderItem);
          localOrderItem = OrderItem();
          print("${orderIyems.length}");
        });

        if (!GetUtils.isNull(element.localBulk!.optionStorageItem)) {
          localOrderItem.itemCode = element.localBulk!.optionStorageItem!.name;
          localOrderItem.deliveryDate = selectedDateTime.toString();
          localOrderItem.subscription = element.selectedDuration;
          localOrderItem.qty = 1;
          localOrderItem.subscriptionDuration = element.numberOfDays;
          localOrderItem.groupId = element.groupId;
          localOrderItem.storageType = element.storageCategoryType;
          localOrderItem.needAdviser = element.needAdviser! ? 1 : 0;
          localOrderItem.itemParent = 0;
          orderIyems.add(localOrderItem);
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
        orderIyems.add(localOrderItem);
        localOrderItem = OrderItem();
      }
    });
    isLoading = true;
    update();
    await StorageFeature.getInstance.addNewStorage(body: {
      "shipping_address": "${selectedAddress!.id}",
      "items_list": jsonEncode(orderIyems),
      "order_to": "${selectedDay!.from}",
      "order_from": "${selectedDay!.to}",
      "order_time": "${selectedDay!.from}/${selectedDay!.to}",
    }).then((value) => {
          if (value.status!.success!)
            {
              isLoading = false,
              update(),
              checkDaplication(),
              isShowAll = true,
              snackSuccess("${tr.success}", "${value.status!.message}"),
              userStorageCategoriesData.clear(),
              selectedPaymentMethod = null,
              selectedAddress = null,
              selectedDateTime = null,
              selectedStore = null,
              selectedDay = null,
              Get.close(2)
            }
          else
            {
              isLoading = false,
              update(),
              snackError("${tr.error_occurred}", "${value.status!.message}")
            }
        });
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
  customerStoragesChangeStatus(var serial,{int? index, HomeViewModel? homeViewModel})async{
    if(serial == null ){
      Get.back();
      return;
    }
    isChangeStatusLoading = true;
    update();
    var body = {"${ConstanceNetwork.serial}":"$serial"};
    await StorageFeature.getInstance.customerStoragesChangeStatus(body:body).then((value) {
        if(!GetUtils.isNull(value)){
          if( value.status!.success!){
            isChangeStatusLoading = false;
            homeViewModel?.userBoxess.toList()[index!].storageStatus = "${LocalConstance.boxAtHome}";
            homeViewModel?.update();
            update();
            Get.back();
            Future.delayed(Duration(seconds: 0)).then((value) {
              Get.bottomSheet(
                  CheckInBoxWidget(
                    box: homeViewModel?.userBoxess.toList()[index!],
                    isUpdate: false,
                  ),
                  isScrollControlled: true);
            });

          }else{
           snackError(tr.error_occurred, value.status!.message!);
          }
        }else{
          isChangeStatusLoading = false;
          update();
        }
    }).catchError((onError){
      Logger().d(onError);
      isChangeStatusLoading = false;
      update();
    });
  }

  List<String> selectedStringOption = <String>[];
  addStringOption(var option){
    if(selectedStringOption.contains(option.toString())){
      selectedStringOption.remove(option);
      update();
    }else{
      selectedStringOption.add(option);
      update();
    }
  }
  void changeTypeViewLVGV() {
    isListView = !isListView!;
    update();
  }

  void addNewSealsOrder( Box box, String fullAddress, String type, var date) async{
    var order = Order(
      itemCode: box.id,
      deliveryDate: date,
      groupId: int.tryParse(box.serialNo.toString()),
      itemParent: int.tryParse(box.serialNo.toString()),
      needAdviser: 0,
      qty:0,
      storageType: type,
      subscription: "",
      subscriptionDuration: 0,
      subscriptionPrice: 0,
    );
    var newSalesOrder = NewSalesOrder(salesOrder: [SalesOrderElement(type:type ,address:fullAddress ,order: [order])] );
   Map<String , dynamic> map = {
     "sales_order":jsonEncode([newSalesOrder.toJson()["sales_order"]])
   };
    await OrderHelper.getInstance.newSalesOrder(body:map).then((value) {
      Logger().d(value.toJson());
    });
  }
}
