import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/box_model.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/model/inside_box/invoices.dart';
import 'package:inbox_clients/feature/model/my_order/api_item.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart' as OS;
import 'package:inbox_clients/feature/model/respons/task_response.dart' as taskResponse;
import 'package:inbox_clients/feature/model/storage/local_bulk_modle.dart';
import 'package:inbox_clients/feature/model/storage/order_item.dart';
import 'package:inbox_clients/feature/model/storage/payment.dart';
import 'package:inbox_clients/feature/model/storage/quantity_modle.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/model/storage/store_modle.dart';
import 'package:inbox_clients/feature/view/screens/home/home_page_holder.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/order_details_screen.dart';
import 'package:inbox_clients/feature/view/screens/payment/payment_screen.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_two_widgets/selected_hour_item.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/bottom_sheet_detailes_widaget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/gloable_bottom_sheet.dart';
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
import 'package:inbox_clients/network/firebase/firebase_utils.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/base_controller.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/date_time_util.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart' as multiPart;
import 'package:showcaseview/showcaseview.dart';

class StorageViewModel extends BaseController {
  //todo this for appbar select btn
  bool? isSelectBtnClick = false;
  bool? isSelectAllClick = false;
  List<BoxItem> listIndexSelected = <BoxItem>[];
  bool isNeedToPayment = false;

  //todo this for bottom sheet accept isAccept
  bool isAccept = false;
  bool isAcceptTermsAndConditions = false;
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
  int numberOfDays = (SharedPref.instance.getAppSettings()?.minDays ?? 1);
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

  late BuildContext showCaseBuildContext;

  /// this for host request storage
  var orderStepShowKey = GlobalKey();
  var storageCategoriesShowKey = GlobalKey();

  ///this for qty bottom sheet
  var qtyShowCaseKey = GlobalKey();
  var subscriptionsShowCaseKey = GlobalKey();
  var durationsShowCaseKey = GlobalKey();
  var featuresShowCaseKey = GlobalKey();

  ///this for new storage step two address and date
  var dateTimeShowCaseKey = GlobalKey();
  var addressShowCaseKey = GlobalKey();

  ///this for payment
  var paymentCaseKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    storageCategoriesList.clear();
    userStorageCategoriesData.clear();
    userStorageCategoriesData = <StorageCategoriesData>[];
    getStorageCategories();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      moveToIntro();
    });
  }

  moveToIntro() {
    if (!SharedPref.instance.getFirstStorageKey()) {
      // ShowCaseWidget.of(showCaseBuildContext).startShowCase([
      //   orderStepShowKey,
      //   storageCategoriesShowKey,
      // ]);
    }
  }

  void showQtyShowCase() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (!SharedPref.instance.getFirstQtyKey()) {
        // ShowCaseWidget.of(showCaseBuildContext).startShowCase([
        //   qtyShowCaseKey,
        //   subscriptionsShowCaseKey,
        //   durationsShowCaseKey,
        //   featuresShowCaseKey,
        // ]);
      }
    });
  }

  void showAddressAndDateShowCase() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (!SharedPref.instance.getFirstAddressAndDateKey()) {
        // ShowCaseWidget.of(showCaseBuildContext)
        //     .startShowCase([dateTimeShowCaseKey, addressShowCaseKey]);
      }
    });
  }

  void showPaymentShowCase() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (!SharedPref.instance.getFirstPaymentKey()) {
        // ShowCaseWidget.of(showCaseBuildContext).startShowCase([paymentCaseKey]);
      }
    });
  }

  void setContext(context) {
    showCaseBuildContext = context;
    // update();
  }

  void calculateBalance() {
    totalBalance = 0;
    userStorageCategoriesData.forEach((element) {
      totalBalance += element.userPrice!;
    });
  }

  ScrollController myListController = ScrollController();

  void animateToIndex() {
    myListController.jumpTo(myListController.position.maxScrollExtent + 200);
    update();
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
    } else if (storageCategoriesData.storageCategoryType ==
            ConstanceNetwork.spaceCategoryType ||
        storageCategoriesData.storageCategoryType ==
            ConstanceNetwork.driedCage) {
      intialBalance(storageCategoriesData: storageCategoriesData);
      // getSmallBalanceForCage(
      //     newDuration: selectedDuration, storageItem: lastStorageItem!);
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
      storageCategoriesData.storageItem?.forEach((element) {
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
      storageCategoriesData.storageItem?.forEach((element) {
        if (areArraysEquales(element.options!, selectedFeaures.toList())) {
          Logger().i("true");
          if (num.parse(element.from ?? "") <= customSpace &&
              num.parse(element.to ?? "") >= customSpace) {
            lastStorageItem = element;
            lastStorageItem?.x = tdX.text.isEmpty ? "1" : tdX.text;
            lastStorageItem?.y = tdY.text.isEmpty ? "1" : tdY.text;
            return;
          }
        } else {
          Logger().i("False");
        }
      });
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
    if (numberOfDays != (SharedPref.instance.getAppSettings()?.minDays ?? 1)) {
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

  void increaseDaysPriceCage(
      {required StorageCategoriesData storageCategoriesData}) {
    numberOfDays++;

    // getBalanceFromDuration(newDuration: newDuration, storageCategoriesData: storageCategoriesData)

    getSmallBalanceForCage(
        newDuration: selectedDuration, storageItem: lastStorageItem!);
    update();
  }

  void minuesDaysPriceCage(
      {required StorageCategoriesData storageCategoriesData}) {
    if (numberOfDays != (SharedPref.instance.getAppSettings()?.minDays ?? 1)) {
      numberOfDays--;
    }
    getSmallBalanceForCage(
        newDuration: selectedDuration, storageItem: lastStorageItem!);
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

  void getSmallBalanceForCage(
      {required String newDuration, required StorageItem storageItem}) {
    if (newDuration
        .toLowerCase()
        .contains(ConstanceNetwork.dailyDurationType.toLowerCase())) {
      balance = num.parse(storageItem.price ?? "0") *
          num.parse(storageItem.x ?? "0") *
          num.parse(storageItem.y ?? "0");
    } else if (newDuration
        .toLowerCase()
        .contains(ConstanceNetwork.montlyDurationType.toLowerCase())) {
      balance = num.parse(storageItem.monthlyPrice ?? "0") *
          num.parse(storageItem.x ?? "0") *
          num.parse(storageItem.y ?? "0");
    } else if (newDuration
        .toLowerCase()
        .contains(ConstanceNetwork.yearlyDurationType.toLowerCase())) {
      balance = num.parse(storageItem.yearlyPrice ?? "0") *
          num.parse(storageItem.x ?? "0") *
          num.parse(storageItem.y ?? "0");
    } else {
      balance = 0;
    }

    balance *= quantity * numberOfDays;

    update();
  }

  void saveStorageDataToArray(
      {required StorageCategoriesData storageCategoriesData,
      bool isUpdate = false,
      int? updateIndex,
      MyOrderViewModle? orderViewModel,
      bool? isFromOrderEdit = false}) async {
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
        if (isFromOrderEdit!) {
          orderViewModel!.addItemToList(newStorageCategoriesData);
        } else {
          await Future.delayed(Duration(seconds: 0)).then((value) {
            if (userStorageCategoriesData.isNotEmpty) {
              for (var element in userStorageCategoriesData.toList()) {
                // Logger().d(
                //     "tr_${element.name == newStorageCategoriesData.name && element.selectedDuration == newStorageCategoriesData.selectedDuration}" /*&&
                //     element.storageFeatures == newStorageCategoriesData.storageFeatures*/
                //     );
                // Logger()
                //     .d("tr_${element.name == newStorageCategoriesData.name}");
                // Logger().d(
                //     "tr_${element.selectedDuration == newStorageCategoriesData.selectedDuration}");
                // Logger().d(element.quantity == newStorageCategoriesData.quantity);

                if (element.name == newStorageCategoriesData.name &&
                        element.selectedDuration ==
                            newStorageCategoriesData.selectedDuration &&
                        element.numberOfDays ==
                            newStorageCategoriesData
                                .numberOfDays /*&&
                    element.quantity == newStorageCategoriesData.quantity*/ /*&&
                    element.storageFeatures == newStorageCategoriesData.storageFeatures*/
                    ) {
                  element.quantity =
                      element.quantity! + newStorageCategoriesData.quantity!;
                  if (element.numberOfDays! !=
                      newStorageCategoriesData.numberOfDays!) {
                    element.numberOfDays = element.numberOfDays! +
                        newStorageCategoriesData.numberOfDays!;
                  }
                  element.userPrice =
                      element.userPrice! + newStorageCategoriesData.userPrice!;
                } else {
                  if (!userStorageCategoriesData
                      .contains(newStorageCategoriesData))
                    userStorageCategoriesData.add(newStorageCategoriesData);
                }
              }
            } else {
              userStorageCategoriesData.add(newStorageCategoriesData);
            }
          });
        }
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
    numberOfDays = (SharedPref.instance.getAppSettings()?.minDays ?? 1);
    isNeedingAdviser = false;
    tdX.clear();
    tdY.clear();
    tdSearch.clear();

    Get.back();
    update();
    // animateToIndex();
  }

  void intialBalance({required StorageCategoriesData storageCategoriesData}) {
    balance = 0;
    countBalanceWithOptions(storageCategoriesData: storageCategoriesData);
    if (storageCategoriesData.storageCategoryType ==
            ConstanceNetwork.spaceCategoryType ||
        storageCategoriesData.storageCategoryType ==
            ConstanceNetwork.driedCage) {
      getSmallBalanceForCage(
          newDuration: selectedDuration, storageItem: lastStorageItem!);
    } else {
      getSmallBalance(
          newDuration: selectedDuration, storageItem: lastStorageItem!);
    }
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
  }

  //--------------------------------- Bulk items --------------------------------------------------------:

  //array to save session builk into:
  Set<StorageCategoriesData> bulkArrayItems = {};
  Set<StorageItem> endStorageItem = {};
  StorageItem? finalStorageItem;

  LocalBulk localBulk = LocalBulk();

  // to add new Bulk Item

  void onAddingAdviser({required StorageCategoriesData storageCategoriesData}) {
    if (isNeedingAdviser) {
      selctedItem = null;
      selectedDuration = "Daily";
      selectedFeaures.clear();
      quantity = 1;
      numberOfDays = (SharedPref.instance.getAppSettings()?.minDays ?? 1);
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
    numberOfDays = (SharedPref.instance.getAppSettings()?.minDays ?? 1);
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
    bool complete = /*false*/ true;
    // await Get.defaultDialog(
    //     titlePadding: EdgeInsets.all(0),
    //     title: "${ /*tr.amount_of_vacant_boxes_not_enough*/ ""}",
    //     middleText: "$message",
    //     actions: [
    //       TextButton(
    //           onPressed: () {
    //             Get.back();
    //             complete = true;
    //           },
    //           child: Text("${tr.ok}")),
    //       TextButton(
    //           onPressed: () {
    //             Get.back();
    //             complete = false;
    //           },
    //           child: Text("${tr.cancle}")),
    //     ]);

    return complete;
  }

  // this for add storage Order :
  ProfileViewModle profileViewModle =
      Get.put(ProfileViewModle(), permanent: true);

  Future<void> addNewStorage(
      {String? paymentId, bool? isFromBankTransfer = false}) async {
    // try {
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

          if (element.selectedDuration == ConstanceNetwork.dailyDurationType) {
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
          localOrderItem.itemCode = element.localBulk!.optionStorageItem!.name;
          localOrderItem.deliveryDate = selectedDateTime.toString();
          localOrderItem.subscription = element.selectedDuration;
          localOrderItem.qty = 1;
          localOrderItem.subscriptionDuration = element.numberOfDays;
          localOrderItem.groupId = element.groupId;
          localOrderItem.storageType = element.storageCategoryType;
          localOrderItem.needAdviser = element.needAdviser! ? 1 : 0;
          localOrderItem.itemParent = 0;
          localOrderItem.from = selectedDay!.from;
          localOrderItem.to = selectedDay!.to;
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
        localOrderItem.subscriptionPrice = element.userPrice! / element.numberOfDays! / element.quantity!;
        localOrderItem.from = selectedDay!.from;
        localOrderItem.to = selectedDay!.to;
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

    Map<String, dynamic> map = {};
    if (isFromBankTransfer!) {
      map = {
        "shipping_address": "${selectedAddress?.id}",
        "items_list": jsonEncode(orderItems),
        "order_to": "${selectedDay?.to /*from*/}",
        "coupon_code": "",
        "points": isAccept ? profileViewModle.myPoints.totalPoints : 0,
        "payment_method": selectedPaymentMethod?.id == LocalConstance.applePay ?LocalConstance.creditCard : "${selectedPaymentMethod?.id}",
        "payment_id": paymentId == null ? "${DateTime.now().millisecondsSinceEpoch}":"$paymentId",
        "order_from": "${selectedDay?.from /*to*/}",
        "order_time": "${selectedDay?.from}/${selectedDay?.to}",
        "type": getNewStorageType(
            storageCategoriesData: userStorageCategoriesData[0]),
        "image": imageBankTransfer != null
            ? multiPart.MultipartFile.fromFileSync(imageBankTransfer!.path)
            : "",
      };
    } else {
      map = {
        "shipping_address": "${selectedAddress?.id}",
        "items_list": jsonEncode(orderItems),
        "order_to": "${selectedDay?.to /*from*/}",
        "coupon_code": "",
        "points": isAccept ? profileViewModle.myPoints.totalPoints : 0,
        "payment_method": selectedPaymentMethod?.id == LocalConstance.applePay ?LocalConstance.creditCard : "${selectedPaymentMethod?.id}",
        "payment_id": paymentId == null ? "${DateTime.now().millisecondsSinceEpoch}":"$paymentId",
        "order_from": "${selectedDay?.from /*to*/}",
        "order_time": "${selectedDay?.from}/${selectedDay?.to}",
        "type": getNewStorageType(
            storageCategoriesData: userStorageCategoriesData[0]),
      };
    }
    Logger().wtf(map);
    await StorageFeature.getInstance
        .addNewStorage(body: map
            /*   map*/
            )
        .then((value) => {
              if (value.status!.success!)
                {
                  // FirebaseUtils.instance.addNewStorageFail(value.toJson()),
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
                  homeViewModel.getCustomerBoxes(),
                  myOrderViewModel.getOrdres(isFromPagination: false),
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
                  // FirebaseUtils.instance.addPaymentFail({"onError":value.status!.message}),
                  snackError("${tr.error_occurred}", "${value.status!.message}")
                }
            })
        .catchError((onError) {
      // FirebaseUtils.instance.addPaymentFail({"onError":onError.toString()});
    });
    // } catch (e) {
    //   FirebaseUtils.instance.addPaymentFail({"error":e.toString()});
    // }
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
    } else if (selectedPaymentMethod?.id == Constance.bankTransferId &&
        imageBankTransfer == null) {
      snackError("${tr.error_occurred}",
          "${tr.you_have_to_add_bank_transfer_image}"); //transfer
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
      if (selectedDateTime != null && selectedDay != null) {
        selectedDateTime = DateTime(
            selectedDateTime!.year,
            selectedDateTime!.month,
            selectedDateTime!.day,
            int.tryParse(DateUtility.getLocalhouersFromUtc(day: selectedDay!)
                    .split("-")[1]
                    .split(":")[0]) ??
                0,
            int.tryParse(DateUtility.getLocalhouersFromUtc(day: selectedDay!)
                    .split("-")[1]
                    .split(":")[1]) ??
                0);

        Logger().e(selectedDateTime);
      }

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
    Logger().d(
        "selectedDateTime_${selectedDateTime?.toUtc()} \t :: DateTimeNowToUtc_${DateTime.now().toUtc()} ");

    Logger().w("_selectedDay ${selectedDay?.toJson()}");
    if (GetUtils.isNull(selectedDateTime)) {
      snackError("${tr.error_occurred}", "${tr.you_have_to_select_date}");
      return false;
    } else if (selctedWorksHours!.isEmpty) {
      snackError("${tr.error_occurred}", "${tr.you_have_to_select_time}");
      return false;
    } else if (GetUtils.isNull(selectedDay)) {
      snackError("${tr.error_occurred}", "${tr.you_have_to_select_time}");
      return false;
    }
    /* else if (DateTime.now().hour > num.parse(selectedDay?.to?.split(":")[0]?? "0")){
      snackError("${tr.error_occurred}", "${tr.you_should_select_correct_time}");
      return false;
    }*/
    else if (DateTime.now().toUtc().isAfter(selectedDateTime!
        .add(Duration(hours: 12))
        .toUtc() /*DateUtility.convertUtcToLocalDateTimeDT(selectedDateTime!)*/)) {
      Logger().w(DateTime.now()
          .toUtc()
          .isAfter(selectedDateTime!.add(Duration(hours: 12))));
      Logger().w(selectedDateTime.toString());
      snackError("${tr.error_occurred}",
          "${tr.you_should_select_correct_time /*tr.invalid_selected_date*/}");
      Logger().d(
          "selectedDateTime_${selectedDateTime?.toUtc()} \t :: DateTimeNowToUtc_${DateTime.now().toUtc()} ");
      return false;
    } else {
      return true;
    }
  }

  List<Day>? selctedWorksHours = [];
  DateTime? selectedDateTime;
  Day? selectedDay;
  Day? selectedDayEdit;
  Store? selectedStore;
  Address? selectedAddress;

  void showDatePicker() async {
    var dt = await dateBiker();
    if (!GetUtils.isNull(dt)) {
      selctedWorksHours = getDayByNumber(selectedDateTime: dt!);
      Logger().i(selctedWorksHours);
      selectedDateTime = DateTime(dt.year, dt.month, dt.day);
      selectedDay = null;
    }
    update();
  }

  clearNewStorageData() {
    selctedWorksHours = null;
    selectedDateTime = null;
    selectedDay = null;
    selectedDayEdit = null;
    selectedStore = null;
    selectedAddress = null;
  }

  void chooseTimeBottomSheet({bool? isFromEdit = false}) {
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
                      "${selectedDateTime == null ? tr.sorry_there_are_no_date : tr.sorry_there_are_no_work_hours}",
                      textAlign: TextAlign.center,
                    ))
                : ListView(
                    shrinkWrap: true,
                    children: selctedWorksHours!
                        .where((element) {
                          // Logger().wtf(element.to);
                          // Logger().wtf("${DateUtility.getToLocalhouersFromUtc(day: element)}");
                          //  var localhouersFromUtcTR = DateUtility.getToLocalhouersFromUtc(day: element);
                          //  var split = element.to?.split(":")[0];
                          // var hour =  num.tryParse(split.toString())!.toInt() > 12 ?num.tryParse(split.toString())!.toInt() -12 :num.tryParse(split.toString())!.toInt();
                          //  Logger().e(hour);
                          //  var dateTo = DateTime(DateTime.now().year ,DateTime.now().month , DateTime.now().day , hour);
                          if (DateTime.now().day == selectedDateTime?.day) {
                            var day = Day(
                                from: element.from,
                                to: "${DateTime.now().hour.toString()}:00",
                                check: element.check ?? false);

                            return DateTime.now().day ==
                                    selectedDateTime?.day &&
                                DateUtility.getToLocalhouersFromUtc(
                                        day: element)
                                    .isAfter(
                                        DateUtility.getToLocalhouersFromUtc(
                                            day: day));
                          } else {
                            return selectedDateTime?.day != null;
                          }
                        })
                        .map((e) =>
                            SelectedHourItem(day: e, isFromEdit: isFromEdit))
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
      title: tr.want_delete,
      isDelete: true,
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
    media.removeWhere((element) => element.isEmpty);
    Logger().w(media);
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
      int index = 0,
      bool? isFromOrderEdit = false}) {
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

      Logger().i(lastStorageItem?.options);

      storageCategoriesData.storageFeatures?.forEach((element) {
        Logger().w(element.storageFeature);
        lastStorageItem?.options?.forEach((inner) {
          Logger().e(inner);
          if (inner.toLowerCase() == element.storageFeature?.toLowerCase()) {
            selectedFeaures.add(element);
          }
        });
      });
      Logger().i(selectedFeaures);
    }

    if (ConstanceNetwork.quantityCategoryType ==
        storageCategoriesData.storageCategoryType) {
      Get.bottomSheet(
        QuantityStorageBottomSheet(
          isUpdate: isUpdate,
          index: index,
          isFromOrderEdit: isFromOrderEdit,
          storageCategoriesData: storageCategoriesData,
        ),
        isScrollControlled: true,
      ).whenComplete(() => {
            clearBottomSheetData(isFromOrderEdit: isFromOrderEdit),
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
            clearBottomSheetData(),
          });
    } else if (ConstanceNetwork.driedCage ==
            storageCategoriesData.storageCategoryType ||
        ConstanceNetwork.spaceCategoryType ==
            storageCategoriesData.storageCategoryType) {
      if (!isUpdate) {
        clearSpaceStorage();
      }
      Get.bottomSheet(
        SpaceStorageBottomSheet(
          index: index,
          isUpdate: isUpdate,
          storageCategoriesData: storageCategoriesData,
        ),
        isScrollControlled: true,
      ).whenComplete(() => {
            clearBottomSheetData(),
          });
    }
  }

  //todo this for customerStoragesChangeStatus api
  //todo i concatenate homeViewModel with storageViewModel
  //todo i get index of list to update it local

  void clearBottomSheetData({bool? isFromOrderEdit = false}) {
    selectedDuration = "Daily";
    quantity = 1;
    numberOfDays = (SharedPref.instance.getAppSettings()?.minDays ?? 1);
    selectedFeaures.clear();
    lastStorageItem = null;
    balance = 0;
    if (!isFromOrderEdit!) animateToIndex();
  }

  bool isChangeStatus = false;

  customerStoragesChangeStatus(var serial,
      {HomeViewModel? homeViewModel, bool isScanDeliverdBox = false}) async {
    print("mes__1");
    if (serial == null) {
      print("mes__2");
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
        isChangeStatus = value.status!.success!;
        if (value.status!.success!) {
          isChangeStatusLoading = false;
          if (isScanDeliverdBox) {
            if (!homeViewModel!.operationTask.customerDelivered!
                .contains(BoxModel.fromJson(value.data))) {
              homeViewModel.operationTask.customerDelivered
                  ?.add(BoxModel.fromJson(value.data));
            }
          } else {
            if (!homeViewModel!.operationTask.customerScanned!
                .contains(BoxModel.fromJson(value.data))) {
              homeViewModel.operationTask.customerScanned
                  ?.add(BoxModel.fromJson(value.data));
            }
          }
          Logger().e(homeViewModel.operationTask.customerScanned?.length);
          Logger().e(homeViewModel.operationTask.customerDelivered?.length);
          homeViewModel.update();

          update();
          Get.back();
          snackSuccess(tr.success, value.status!.message!);
        } else {
          print("mes__9");
          snackError(tr.error_occurred, value.status!.message!);
        }
      } else {
        print("mes__10");
        isChangeStatusLoading = false;
        update();
      }
    }).catchError((onError) {
      print("mes__11");
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

  void clearSpaceStorage() {
    tdX.clear();
    tdY.clear();
    customSpace = 1;
  }

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
    }

    price += task.price!;
    // num shivingPrice = 0;
    // if (selectedAddress != null) {
    //   for (var item in task.areaZones!) {
    //     if (item.id == selectedAddress!.zone) {
    //       shivingPrice = (item.price ?? 0);
    //     }
    //   }
    //   Logger().i("price_$price shivingPrice_$shivingPrice");
    //   price = price + shivingPrice;
    // }
    return getPriceWithFormate(price: price);
  }

  calculateTaskPriceLotBoxess(
      {required Task task,
      required List<Box> boxess,
      required bool isFromCart,
      Address? myAddresss,
      required bool isFirstPickUp/*= false*/
      }) {
    final ApiSettings settings =
        ApiSettings.fromJson(json.decode(SharedPref.instance.getAppSetting()));
    if (isFromCart) {
      selectedAddress = myAddresss;
    }
    num price = 0.00;

    // if(isFirstPickUp!){
    //   task.price = 0;
    // }
    price = task.price! * boxess.length;
    // Logger().i("1_$price");
    if (selectedAddress !=
        null /*&& (!isFirstPickUp && task.id !=LocalConstance.pickupId)*/) {
      if((!isFirstPickUp /*&& task.id !=LocalConstance.pickupId*/)) {
        for (var item in task.areaZones!) {
          if (item.id == selectedAddress?.zone) {
            price += (item.price ?? 0) *
                (boxess.length / settings.deliveryFactor!)
                    .toDouble()
                    .ceilToDouble();
          }
        }
      }
    }

    // Logger().i("2_$price");
    if (isFromCart) {
      for (VAS item in task.selectedVas ?? []) {
        price += (item.price ?? 0) * boxess.length;
        print("options_price ${item.price}");
      }
    } else {
      for (VAS item in selectedStringOption) {
        price += (item.price ?? 0) * boxess.length;
        print("options_price ${item.price}");
      }
    }
    // Logger().i("3_$price");
    // num shivingPrice = 0;
    // if (selectedAddress != null) {
    //   for (var item in task.areaZones!) {
    //     if (item.id == selectedAddress!.zone) {
    //       shivingPrice = (item.price ?? 0);
    //     }
    //   }
    //   Logger().i("price_$price shivingPrice_$shivingPrice");
    //   price = price + shivingPrice;
    // }

    return getPriceWithFormate(price: price);
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

  String placeDestroy = "";

  // THIS REGUSET is For Playing WITH Api Tasks you will Add The Task And Boxess
  //Note :: IF You want to Send Single Box you Will Add The Box Only in The List Like This [myBox()]

  final HomeViewModel homeViewModel = Get.put(HomeViewModel(), permanent: true);
  final MyOrderViewModle myOrderViewModel =
      Get.put(MyOrderViewModle(), permanent: true);

  Future<void> doTaskBoxRequest({
    required Task task,
    required bool isFromCart,
    required List<Box> boxes,
    List<BoxItem>? selectedItems,
    required String beneficiaryId,
    required bool isFirstPickUp,
    String? paymentId,
  }) async {
    startLoading();
    List<Map<String, dynamic>> mapSalesOrder = <Map<String, dynamic>>[];
    Map<String, dynamic> map = {};
    String boxessSeriales = "";
    String invoices = "";
    String itemSeriales = "";
    num shivingPrice = 0;
    if (selectedPaymentMethod?.id == Constance.bankTransferId &&
        imageBankTransfer == null) {
      snackError("${tr.error_occurred}",
          "${tr.you_have_to_add_bank_transfer_image}"); //transfe
      return;
    }

    for (var i = 0; i < boxes.length; i++) {
      boxessSeriales += '${boxes[i].serialNo},';
    }

    selectedItems?.forEach((element) {
      itemSeriales += '${element.id},';
    });

    for (var i = 0; i < boxes.length; i++) {
      for (Invoices invoice in boxes[i].invoices ?? []) {
        invoices += '${invoice.name},';
      }
    }

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

    if (invoices.isNotEmpty) {
      invoices = invoices.substring(0, invoices.length - 1);
    }

    if (itemSeriales.isNotEmpty) {
      itemSeriales = itemSeriales.substring(0, itemSeriales.length - 1);
    }

    if (task.id == LocalConstance.fetchId) {
      data.add(ApiItem.getApiObjectToSend(
          itemCode: task.id ?? "",
          processType: task.id,
          qty: boxes.length,
          subscriptionPrice: task.price ?? 0,
          selectedDateTime: selectedDateTime,
          groupId: 1,
          itemParent: 0,
          invoices: invoices,
          itemsChildIn: itemSeriales,
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
          invoices: invoices,
          selectedDay: selectedDay,
          processType: task.id,
          itemsChildIn: "",
          beneficiaryNameIn: homeViewModel.selctedbeneficiary?.id ?? "",
          boxessSeriales: boxessSeriales));
    } else {
      data.add(ApiItem.getApiObjectToSend(
          itemCode: task.id ?? "",
          qty: boxes.length,
          itemsChildIn: "",
          processType: task.id,
          subscriptionPrice: task.price ?? 0,
          selectedDateTime: selectedDateTime,
          invoices: invoices,
          groupId: 1,
          itemParent: 0,
          selectedDay: selectedDay,
          boxessSeriales: boxessSeriales,
          beneficiaryNameIn: null));
    }
    if (!isFirstPickUp && shivingPrice > 0) {
      data.add(ApiItem.getApiObjectToSend(
          itemCode: "shipping_sv",
          qty: boxes.length,
          processType: task.id,
          subscriptionPrice: shivingPrice,
          selectedDateTime: selectedDateTime,
          invoices: invoices,
          groupId: 1,
          itemParent: 0,
          itemsChildIn: "",
          selectedDay: selectedDay,
          boxessSeriales: boxessSeriales,
          beneficiaryNameIn: null));
    }

    for (var item in selectedStringOption) {
      data.add(ApiItem.getApiObjectToSend(
          itemCode: item.id ?? "",
          processType: task.id,
          qty: boxes.length,
          invoices: invoices,
          subscriptionPrice: item.price ?? 0,
          selectedDateTime: selectedDateTime,
          groupId: 1,
          itemsChildIn: "",
          itemParent: 0,
          selectedDay: selectedDay,
          beneficiaryNameIn: "",
          boxessSeriales: boxessSeriales));
    }

    map["type[0]"] = task.id;
    map["payment_method"] = selectedPaymentMethod?.id == LocalConstance.applePay ? LocalConstance.creditCard: selectedPaymentMethod?.id ?? "";
    map["payment_id"] = paymentId == null ? "${DateTime.now().millisecondsSinceEpoch}":paymentId ;
    map["points"] = isAccept ? userUsesPoints : 0;
    // map["destroy_status"] = LocalConstance.inWarehouse;
    // if (task.id == LocalConstance.destroyId) {
    //   map["destroy_status"] = placeDestroy;
    // }

    map["coupon_code"] = (isUsingPromo &&
            checkPromoAppResponse != null &&
            checkPromoAppResponse!.status!.success!)
        ? tdCopun.text
        : "";
    map["order[0]"] = data;
    map["address[0]"] =
        selectedAddress == null ? boxes[0].address?.id : selectedAddress?.id;
    mapSalesOrder.add(map);

    Map<String, dynamic> newMap = {"sales_order": jsonEncode(mapSalesOrder)};
    // Logger().i(newMap);
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
    clearNewStorageData();
    if (!isFromCart) {
      Get.close(1);
    }
    // if (task.id == LocalConstance.destroyId) {
    //   Get.back();
    // }
    Get.back();
    // if (boxes.isNotEmpty) {
    //   await homeViewModel.getBoxBySerial(serial: boxes[0].serialNo ?? "");
    // }
    // homeViewModel.;

    await homeViewModel.refreshHome();
    endLoading();
    checkPromoAppResponse = AppResponse();
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
    profileViewModle.getMyWallet();
    tdCopun.clear();
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
    required bool isOrderProductPayment,
    StorageViewModel? storageViewModel,
    required bool isFromEditOrder,
    Function()? editOrder,
  }) async {
    startLoading();
    try {
      var paymentUrlOldKey = "payment_url";
      var paymentUrlNewKey = "url";
      var paymentIdKey = "id";
      Map<String, dynamic> map = {
        "amount": amount,
        "task_process": /*isFromNewStorage? "new_storage" :*/ "other",
        // "type":ConstanceNetwork.dailyDurationType.toUpperCase(),
        // "type":ConstanceNetwork.dailyDurationType.toUpperCase(),
      };
      if (isFromNewStorage &&
          storageViewModel != null &&
          storageViewModel.selectedDuration !=
              ConstanceNetwork.dailyDurationType) {
        map = {
          "amount": amount,
          "task_process": "new_storage",
          "type": storageViewModel.selectedDuration ==
                  ConstanceNetwork.montlyDurationType
              ? "MONTHLY"
              : "YEARLY",
          //MONTHLY/YEARLY,
          "price": amount,
          "date": DateFormat("yyyy-MM-dd")
              .format(storageViewModel.selectedDateTime!),
        };
      }
      await StorageFeature.getInstance.payment(body: map).then((value) => {
            if (value.status!.success!)
              {
                Logger().d(value.data[paymentUrlNewKey]),
                if (GetUtils.isURL(value.data[paymentUrlNewKey]) ||
                    value.data[paymentUrlNewKey].toString().contains("http"))
                  {
                    Logger().e(value.data[paymentUrlNewKey]),
                    Logger().e(value.data[paymentIdKey] ?? "null"),
                    Get.put(PaymentViewModel()),
                    Get.to(() => PaymentScreen(
                          isOrderProductPayment: isOrderProductPayment,
                          cartModels: cartModels,
                          isFromCart: isFromCart,
                          beneficiaryId: beneficiaryId,
                          boxes: boxes,
                          task: task,
                          isFromEditOrder: isFromEditOrder,
                          editOrderFunc: editOrder,
                          paymentId: value.data[paymentIdKey] == null
                              ? DateTime.now().millisecondsSinceEpoch.toString()
                              : value.data[paymentIdKey],
                          url: value.data[paymentUrlNewKey],
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
      if(tdCopun.text.isEmpty){
        return;
      }
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

  List<dynamic> getPriceWithDiscount(
      {required String oldPrice, required bool isFirstPickUp  ,required Task? task}) {
    num price = num.parse(oldPrice);
    num usesPoints = 0;
    Logger().w(task?.price);
    if (!GetUtils.isNull(checkPromoAppResponse)) {
      if (checkPromoAppResponse!.status != null &&
          checkPromoAppResponse!.status!.success!) {
        Logger().wtf("getPriceWithDiscount_${checkPromoAppResponse?.toJson()}");
        if (checkPromoAppResponse?.data != null && (checkPromoAppResponse?.data["discount_type"] == null ? null:checkPromoAppResponse?.data["discount_type"]) != null &&
            (checkPromoAppResponse?.data["discount_type"] == null ? null:checkPromoAppResponse?.data["discount_type"]) ==
            LocalConstance.discountPercentag) {
          if ((price - (price * (checkPromoAppResponse?.data["amount"] == null ? 0:checkPromoAppResponse?.data["amount"]) / 100)) >
              0) {
            price =
                price - (price * (checkPromoAppResponse?.data["amount"] == null ? 0:checkPromoAppResponse?.data["amount"]) / 100);
          } else {
            price = 0;
          }
        } else {
          price = price - (checkPromoAppResponse?.data["amount"] == null ? 0:checkPromoAppResponse?.data["amount"]);
        }
      }
    }

    if (isAccept) {
      //
      if (price - profileViewModle.pointsCalcPrice(task!)/*profileViewModle.myPoints.totalPoints! * SharedPref.instance.getCurrentUserData().conversionFactor!*/ > 0) {
        price = price -
            profileViewModle.pointsCalcPrice(task)/*profileViewModle.myPoints.totalPoints! *
                SharedPref.instance.getCurrentUserData().conversionFactor!*/;
        userUsesPoints = profileViewModle.myPoints.totalPoints!;
      } else {
        // price = ((price * profileViewModle.myPoints.totalPoints!) - price) /
        //     SharedPref.instance.getCurrentUserData().conversionFactor!;

        usesPoints = profileViewModle.myPoints.totalPoints! -
            (price /
                SharedPref.instance.getCurrentUserData().conversionFactor!);
        price = 0;
      }
    }
    if (isFirstPickUp) {
      price = 0;
    }
    priceAfterDiscount = price;
    userUsesPoints = profileViewModle.myPoints.totalPoints! - usesPoints;

    // Logger().e("MSG_USER_POINTS = $userUsesPoints");
    // Logger().e("MSG_USER_POINTS = $price");

    if (!isFirstPickUp) profileViewModle.getMyPoints();

    if (price > 0) {
      return [getPriceWithFormate(price: price), usesPoints];
    } else {
      return [getPriceWithFormate(price: 0), usesPoints];
    }
  }

  calculateTasksCart({required List<CartModel> cartModel}) {
    final ApiSettings settings =
        ApiSettings.fromJson(json.decode(SharedPref.instance.getAppSetting()));

    num price = 0.00;
    for (var cartItem in cartModel) {
      selectedAddress = cartItem.address;
      if (cartItem.isFirstPickUp! &&
          cartItem.task?.id == LocalConstance.pickupId) {
        cartItem.task?.price = 0.00;
      }
      if (cartItem.task!.price! == 0.00) {
        price += cartItem.task!.price!;
      } else {
        price += cartItem.task!.price! * cartItem.box!.length;
      }
      if (selectedAddress !=
          null /*&&   (!cartItem.isFirstPickUp! && cartItem.task?.id !=LocalConstance.pickupId)*/) {
        if ((!cartItem.isFirstPickUp! /*&& cartItem.task?.id != LocalConstance.pickupId*/)) {
          for (var item in cartItem.task!.areaZones!) {
            if (item.id == selectedAddress?.zone) {
              Logger().e((cartItem.box!.length / settings.deliveryFactor!).toDouble().ceilToDouble());
              price += (item.price ?? 0) *(cartItem.box!.length / settings.deliveryFactor!).toDouble().ceilToDouble();
            }
          }
        }
      }

      for (var item in cartItem.task!.selectedVas!) {
        price += (item.price ?? 0) * cartItem.box!.length;
        print("options_price ${item.price}");
      }
      // Logger().i(price);
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
        String invoices = "";
        // String pickupIdSerial = ""; //
        // List<CartModel> list = [];
        // Logger().w(cartModels[i].task?.id);
        // if (cartModels[i].task?.id == LocalConstance.pickupId) {
        //   cartModels.forEach((element) {
        //     list.add(element);
        //   });
        //   // list.add(cartModels[i]);
        //
        //   // if()
        //   // if(cartModels[i].orderTime  || cartModels[i].task.)
        // }
        // if (list.length > 1) {
        //   for (int j = 0; j < list.length; j ++) {
        //     list[j].box?.forEach((element) {
        //       Logger().i(element.serialNo);
        //       pickupIdSerial = pickupIdSerial + "${element.serialNo},";
        //     });
        //     // if(list[i].orderTime == list[i + 1].orderTime) {
        //     //   pickupIdSerial = "${list[i].},";
        //     // }
        //   }
        // }
        // if (pickupIdSerial.isNotEmpty) {
        //   pickupIdSerial =
        //       pickupIdSerial.substring(0, pickupIdSerial.length - 1);
        // }
        num shivingPrice = 0;
        Map<String, dynamic> map = {};
        for (var j = 0; j < cartModels[i].box!.length; j++) {
          boxessSeriales += '${cartModels[i].box![j].serialNo},';
        }

        cartModels[i].boxItem?.forEach((element) {
          itemSeriales += '${element.id},';
        });

        cartModels[i].box?.forEach((element) {
          for (Invoices invoice in element.invoices ?? []) {
            invoices += '${invoice.name},';
          }
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

        if (invoices.isNotEmpty) {
          invoices = invoices.substring(0, invoices.length - 1);
        }

        if (itemSeriales.isNotEmpty) {
          itemSeriales = itemSeriales.substring(0, boxessSeriales.length - 2);
        }

        if (cartModels[i].task!.id == LocalConstance.fetchId) {
          data.add(ApiItem.getApiObjectToSend(
              itemCode: cartModels[i].task?.id ?? "",
              qty: cartModels[i].box!.length,
              invoices: invoices,
              processType: cartModels[i].task?.id ?? "",
              subscriptionPrice: cartModels[i].task?.price ?? 0,
              selectedDateTime: selectedDateTime,
              itemsChildIn: itemSeriales,
              groupId: 1,
              itemParent: 0,
              selectedDay: selectedDay,
              beneficiaryNameIn: "",
              boxessSeriales: boxessSeriales));
        } else if (cartModels[i].task?.id == LocalConstance.giveawayId) {
          data.add(ApiItem.getApiObjectToSend(
              itemCode: cartModels[i].task?.id ?? "",
              qty: cartModels[i].box!.length,
              itemsChildIn: "",
              invoices: invoices,
              subscriptionPrice: cartModels[i].task?.price ?? 0,
              selectedDateTime: selectedDateTime,
              groupId: 1,
              itemParent: 0,
              processType: cartModels[i].task?.id ?? "",
              selectedDay: selectedDay,
              beneficiaryNameIn: homeViewModel.selctedbeneficiary?.id ?? "",
              boxessSeriales: boxessSeriales));
        }
        /*else if(cartModels[i].task?.id == LocalConstance.pickupId) {
          data.add(ApiItem.getApiObjectToSend(
              itemCode: cartModels[i].task?.id ?? "",
              qty: cartModels[i].box!.length,
              itemsChildIn: */ /*pickupIdSerial*/ /*"",
              invoices: invoices,
              subscriptionPrice: cartModels[i].task?.price ?? 0,
              selectedDateTime: selectedDateTime,
              groupId: 1,
              itemParent: 0,
              processType: cartModels[i].task?.id ?? "",
              selectedDay: selectedDay,
              beneficiaryNameIn: homeViewModel.selctedbeneficiary?.id ?? "",
              boxessSeriales: pickupIdSerial));
        } */
        else {
          data.add(ApiItem.getApiObjectToSend(
              itemCode: cartModels[i].task?.id ?? "",
              qty: cartModels[i].box!.length,
              invoices: invoices,
              itemsChildIn: "",
              processType: cartModels[i].task?.id ?? "",
              subscriptionPrice: cartModels[i].task?.price ?? 0,
              selectedDateTime: selectedDateTime,
              groupId: 1,
              itemParent: 0,
              selectedDay: selectedDay,
              boxessSeriales: /*cartModels[i].task?.id == LocalConstance.pickupId
                  ? pickupIdSerial
                  :*/
                  boxessSeriales,
              beneficiaryNameIn: null));
        }
        // Logger().wtf(pickupIdSerial);
        if (shivingPrice > 0) {
          data.add(ApiItem.getApiObjectToSend(
              itemCode: "shipping_sv",
              qty: cartModels[i].box!.length,
              subscriptionPrice: shivingPrice,
              invoices: invoices,
              itemsChildIn: "",
              processType: cartModels[i].task?.id ?? "",
              selectedDateTime: selectedDateTime,
              groupId: 1,
              itemParent: 0,
              selectedDay: selectedDay,
              boxessSeriales: boxessSeriales,
              beneficiaryNameIn: null));
        }

        for (var item in selectedStringOption) {
          data.add(ApiItem.getApiObjectToSend(
              itemCode: item.id ?? "",
              qty: cartModels[i].box!.length,
              itemsChildIn: "",
              subscriptionPrice: item.price ?? 0,
              invoices: invoices,
              selectedDateTime: selectedDateTime,
              processType: cartModels[i].task?.id ?? "",
              groupId: 1,
              itemParent: 0,
              selectedDay: selectedDay,
              beneficiaryNameIn: "",
              boxessSeriales: boxessSeriales));
        }

        map["type[$i]"] = cartModels[i].task?.id;
        map["payment_method"] = selectedPaymentMethod?.id == LocalConstance.applePay ? LocalConstance.creditCard: selectedPaymentMethod?.id ?? "";
        map["payment_id"] = paymentId == null ? "${DateTime.now().millisecondsSinceEpoch}":paymentId ;
        map["points"] = isAccept ? userUsesPoints / cartModels.length : 0;
        map["coupon_code"] = (isUsingPromo &&
                checkPromoAppResponse != null &&
                checkPromoAppResponse!.status!.success!)
            ? tdCopun.text
            : "";
        map["order[$i]"] = data;
        // Logger().wtf("data_: ${map["order[$i]"]} index_ $i");
        map["address[$i]"] = selectedAddress == null
            ? cartModels[i].box![0].address?.id
            : selectedAddress?.id;
        mapSalesOrder.add(map);
        // if(mapSalesOrder.isEmpty){
        //
        // }else {
        //   mapSalesOrder.forEach((element) {
        //   if(element["storage_child_in"].toString() == map["order[$i]"]["storage_child_in"]){
        //
        //   }else if(element["storage_child_in"].toString().contains(map["order[$i]"]["storage_child_in"])){
        //     mapSalesOrder.remove(element);
        //   }
        //
        // });
        // }
        // Logger().e("__${mapSalesOrder}");
      }

      Map<String, dynamic> newMap = {"sales_order": jsonEncode(mapSalesOrder)};
      Logger().wtf(newMap);
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

  Future<void> applyPayment(
      {required String salesOrderId, required String paymentMethodId}) async {
    try {
      await StorageFeature.getInstance.applyPayment(body: {
        LocalConstance.id: salesOrderId,
        LocalConstance.paymentMethod: paymentMethodId,
      }).then((value) => {
            if (value.status!.success!)
              {
                Get.offAll(() => HomePageHolder()),
                snackSuccess('', value.status?.message)
              }
            else
              {Get.back(), snackError('', value.status?.message)}
          });
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> payApplicationFromWallet(
      {required num price, required String newSalesOrderId}) async {
    try {
      num walletBalance = num.parse(profileViewModle.myWallet.balance ?? "0");
      if (walletBalance >= price) {
        await applyPayment(
            salesOrderId: newSalesOrderId,
            paymentMethodId: LocalConstance.wallet);
      } else {
        snackError("", "Wallet Balance");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> payApplicationFromPaymentGatewaye({
    required num price,
  }) async {
    try {
      await goToPaymentMethod(
          amount: price,
          isOrderProductPayment: true,
          isFromNewStorage: false,
          isFromCart: false,
          cartModels: [],
          isFromEditOrder: false);
    } catch (e) {
      printError();
    }
  }

  File? imageBankTransfer;

  //this for add image for bank transfer
  void onBankImageClick() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageBankTransfer = File(image.path.toString());
      update();
    }
  }

  Future<void> onTaskReschedule(taskResponse.TaskResponse operationTask, DateTime? selectedDateTime, String localHoursFromUtc) async{
    startLoading();
    var date = "${selectedDateTime?.year}-${selectedDateTime?.month}-${selectedDateTime?.day}";
    var time = localHoursFromUtc;
    var driverId = operationTask.driverId;
    var orderId = operationTask.salesOrder;
    Map<String , dynamic> map = {
      ConstanceNetwork.orderIdKey : orderId,
      ConstanceNetwork.dateKey : date,
      ConstanceNetwork.timeKey : time,
      ConstanceNetwork.driverId : driverId,

    };
    await StorageFeature.getInstance.onTaskReschedule(body:map).then((value){
      if(value.status!.success!){
       snackSuccess("", value.status?.message.toString());
        endLoading();
        Get.back();
      }else{
        snackError("", value.status?.message.toString());
        endLoading();
        // Get.back();
      }
    }).catchError((onError){
      Logger().w(onError);
      endLoading();
    });

  }
}
