import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/my_order/api_item.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/tasks_widgets/task_widget_BS.dart';
import 'package:inbox_clients/feature/view/screens/payment/payment_screen.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/edit_new_storage/edit_new_storage_view.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/gloable_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/order/edit_order_bottom_sheet.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/network/api/feature/order_helper.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/base_controller.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class MyOrderViewModle extends BaseController {
// get user Orders Var And Functions ::
  Set<OrderSales> userOrderSales = <OrderSales>{};
  bool isLoading = false;
  bool isLoadingCancel = false;

  Future<void> getOrdres({required bool isFromPagination}) async {
    if (!isFromPagination) {
      isLoading = true;
      userOrderSales.clear();
    }

    update();
    await OrderHelper.getInstance
        .getCustomerBoxess(pageSize: 50, page: page)
        .then((value) => {
              userOrderSales.addAll(value),
              Logger().i("${userOrderSales.length}"),
            });
    if (!isFromPagination) {
      isLoading = false;
    }
    update();
  }

  // to do here for pagination :
  var scrollcontroller = ScrollController();
  int page = 1;

  void pagination() {
    try {
      if ((scrollcontroller.position.pixels ==
          scrollcontroller.position.maxScrollExtent)) {
        page += 1;
        getOrdres(isFromPagination: true);
      }
    } catch (e) {}

    update();
  }

  OrderSales newOrderSales = OrderSales();

  Future<void> getOrderDetaile({required String orderId}) async {
    isLoading = true;
    update();
    try {
      await OrderHelper.getInstance.getOrderDetaile(body: {
        Constance.orderId: orderId,
      }).then((value) {
        Logger().e("Msg_Current_Order : ${value.toJson()}");
        newOrderSales = value;
        isLoading = false;
        update();
      });
    } catch (e) {
      Logger().e(e);
      Logger().e("Msg_newOrderSales_Order : ${newOrderSales.toJson()}");
      isLoading = false;
      update();
    }
  }

  bool isTask({required String orderItem}) {
    if (orderItem == LocalConstance.destroyId ||
        orderItem == LocalConstance.terminateId ||
        orderItem == LocalConstance.pickupId ||
        orderItem == LocalConstance.giveawayId ||
        orderItem == LocalConstance.fetchId) {
      return true;
    }
    return false;
  }

  bool isAllowToCancel(OrderSales newOrderSales) {
    /// in New Storage case
    /// allow if box not at the home
    /// newNewStorageSpaceSv
    /// newStorageItemSv
    if (newOrderSales.proccessType?.toLowerCase() ==
        LocalConstance.newStorageSv.toLowerCase()) {
      /// [newStorageSv]
      ///if status != completed  && order boxes not contain at home
      if (newOrderSales.status?.toLowerCase() !=
              LocalConstance.completed
                  .toLowerCase() /* &&
          newOrderSales.orderItems!
              .where((element) =>
                  element.itemStatus?.toLowerCase() ==
                  LocalConstance.boxAtHome.toLowerCase())
              .isEmpty &&
          newOrderSales.status?.toLowerCase() !=
              LocalConstance.orderStatusCancelled.toLowerCase()*/
          ) {
        return true;
      } else {
        return false;
      }

      ///# [end] # newStorageSv
    } else if (newOrderSales.proccessType?.toLowerCase() ==
            LocalConstance.newNewStorageSpaceSv.toLowerCase() ||
        newOrderSales.proccessType?.toLowerCase() ==
                LocalConstance.newStorageItemSv.toLowerCase() &&
            newOrderSales.status?.toLowerCase() !=
                LocalConstance.orderStatusCancelled.toLowerCase()) {
      /// [newNewStorageSpaceSv, newStorageItemSv]
      ///if status != completed  && order boxes not contain at home
      if (newOrderSales.status?.toLowerCase() !=
          LocalConstance.completed.toLowerCase()) {
        return true;
      } else {
        return false;
      }

      ///# [end] # [newNewStorageSpaceSv, newStorageItemSv]
    } else if (newOrderSales.proccessType?.toLowerCase() ==
            LocalConstance.pickupId.toLowerCase() &&
        newOrderSales.status?.toLowerCase() !=
            LocalConstance.orderStatusCancelled.toLowerCase()) {
      /// [pickupId]
      ///if status != completed  && order boxes not contain boxOnTheWay || boxes not contain boxinWareHouse
      if (newOrderSales.status?.toLowerCase() !=
              LocalConstance.completed
                  .toLowerCase() /*&&
          newOrderSales.orderItems!
              .where((element) =>
                  element.itemStatus?.toLowerCase() ==
                      LocalConstance.boxOnTheWay.toLowerCase() ||
                  element.itemStatus?.toLowerCase() ==
                      LocalConstance.boxinWareHouse.toLowerCase())
              .isEmpty*/
          ) {
        return true;
      } else {
        return false;
      }

      ///# [end] # pickupId
    } else if (newOrderSales.proccessType?.toLowerCase() ==
            LocalConstance.recallId.toLowerCase() &&
        newOrderSales.status?.toLowerCase() !=
            LocalConstance.orderStatusCancelled.toLowerCase()) {
      /// [recallId]
      ///if status != completed  && order boxes not contain at home
      if (newOrderSales.status?.toLowerCase() !=
              LocalConstance.completed
                  .toLowerCase() /*&&
          newOrderSales.orderItems!
              .where((element) =>
                  element.itemStatus?.toLowerCase() ==
                  LocalConstance.boxAtHome.toLowerCase())
              .isEmpty*/
          ) {
        return true;
      } else {
        return false;
      }

      ///# [end] # recallId
    } else if (newOrderSales.proccessType?.toLowerCase() ==
            LocalConstance.fetchId.toLowerCase() &&
        newOrderSales.status?.toLowerCase() !=
            LocalConstance.orderStatusCancelled.toLowerCase()) {
      /// [fetchId]
      ///if status != completed
      if (newOrderSales.status?.toLowerCase() !=
          LocalConstance.completed.toLowerCase()) {
        return true;
      } else {
        return false;
      }

      ///# [end] # fetchId
    } else if (newOrderSales.proccessType?.toLowerCase() ==
        LocalConstance.giveawayId.toLowerCase()) {
      /// [giveawayId]
      ///if status != completed
      ///depend on time
      if (newOrderSales.status?.toLowerCase() !=
          LocalConstance.completed.toLowerCase()) {
        return true;
      } else {
        return false;
      }

      ///# [end] # giveawayId
    } else {
      return false;
    }
  }

  bool isAllowToEdit(OrderSales newOrderSales) {
    /// in New Storage case
    /// allow if box not at the home
    /// newNewStorageSpaceSv
    /// newStorageItemSv
    if (newOrderSales.proccessType?.toLowerCase() ==
        LocalConstance.newStorageSv.toLowerCase()) {
      /// [newStorageSv]
      ///if status != completed  && order boxes not contain at home || boxOnTheWay
      if (newOrderSales.status?.toLowerCase() !=
              LocalConstance.completed.toLowerCase() &&
          /*newOrderSales.orderItems!
              .where((element) =>
                  element.itemStatus?.toLowerCase() ==
                      LocalConstance.boxAtHome.toLowerCase() ||
                  element.itemStatus?.toLowerCase() ==
                      LocalConstance.boxOnTheWay.toLowerCase())
              .isEmpty*/
          newOrderSales.editable!) {
        return true;
      } else {
        return false;
      }

      ///# [end] # newStorageSv
    }
    // if(newOrderSales.proccessType?.toLowerCase() == LocalConstance.newNewStorageSpaceSv.toLowerCase()
    //     ||newOrderSales.proccessType?.toLowerCase() == LocalConstance.newStorageItemSv.toLowerCase()){
    //   /// [newNewStorageSpaceSv, newStorageItemSv]
    //   ///if status != completed  && order boxes not contain at home
    //   if(newOrderSales.status?.toLowerCase() != LocalConstance.completed.toLowerCase()){
    //     return true;
    //   }else {
    //     return false;
    //   }
    //   ///# [end] # [newNewStorageSpaceSv, newStorageItemSv]
    // }
    else if (newOrderSales.proccessType?.toLowerCase() ==
        LocalConstance.pickupId.toLowerCase()) {
      /// [pickupId]
      ///if status != completed  && order boxes not contain boxOnTheWay || boxes not contain boxAtHome
      if (newOrderSales.status?.toLowerCase() !=
              LocalConstance.completed
                  .toLowerCase() /*&&
          newOrderSales.orderItems!
              .where((element) =>
                  element.itemStatus?.toLowerCase() ==
                      LocalConstance.boxOnTheWay.toLowerCase() ||
                  element.itemStatus?.toLowerCase() ==
                      LocalConstance.boxAtHome.toLowerCase())
              .isEmpty*/
          ) {
        return true;
      } else {
        return false;
      }

      ///# [end] # pickupId
    } else if (newOrderSales.proccessType?.toLowerCase() ==
        LocalConstance.recallId.toLowerCase()) {
      /// [recallId]
      ///if status != completed  && order boxes not contain boxOnTheWay || boxes not contain boxAtHome
      if (newOrderSales.status?.toLowerCase() !=
              LocalConstance.completed
                  .toLowerCase() /*&&
          newOrderSales.orderItems!
              .where((element) =>
                  element.itemStatus?.toLowerCase() ==
                      LocalConstance.boxOnTheWay.toLowerCase() ||
                  element.itemStatus?.toLowerCase() ==
                      LocalConstance.boxAtHome.toLowerCase())
              .isEmpty*/
          ) {
        return true;
      } else {
        return false;
      }

      ///# [end] # recallId
    } else if (newOrderSales.proccessType?.toLowerCase() ==
        LocalConstance.fetchId.toLowerCase()) {
      /// [fetchId]
      ///not allow

      return false;

      ///# [end] # fetchId
    } else if (newOrderSales.proccessType?.toLowerCase() ==
        LocalConstance.giveawayId.toLowerCase()) {
      /// [giveawayId]
      ///not allow
      return false;

      ///# [end] # giveawayId
    } else if (newOrderSales.proccessType?.toLowerCase() ==
        LocalConstance.terminateId.toLowerCase()) {
      /// [terminateId]
      ///not allow
      return false;

      ///# [end] # terminateId
    } else if (newOrderSales.proccessType?.toLowerCase() ==
        LocalConstance.destroyId.toLowerCase()) {
      /// [destroyId]
      ///not allow
      return false;

      ///# [end] # destroyId
    } else {
      return false;
    }
  }

  void cancelOrder(OrderSales newOrderSales, HomeViewModel homeViewModel,
      StorageViewModel storageViewModel) async {
    Map<String, dynamic> map = {
      ConstanceNetwork.orderIdKey: newOrderSales.orderId
    };
    isLoadingCancel = true;
    update();
    await OrderHelper.getInstance.cancelOrder(body: map).then((value) {
      if (value.status != null &&
          value.status!.success! &&
          value.data != null) {
        //todo success with payment url
        /// id , fees , url
        ///
        var orderId = value.data["id"];
        var orderFees = value.data["fees"];
        var orderUrl = value.data["url"];
        if (orderUrl.toString().isEmpty) {
          snackSuccess("", "${value.status!.message.toString()}");
          homeViewModel.getCustomerBoxes();
          getOrdres(isFromPagination: false);
          getOrderDetaile(orderId: newOrderSales.orderId.toString());
          isLoadingCancel = false;
          update();
          return;
        }
        Get.bottomSheet(GlobalBottomSheet(
          title: tr.must_fees,
          isTwoBtn: true,
          onCancelBtnClick: ()=> Get.back(),
          onOkBtnClick: (){
            Get.to(
              PaymentScreen(
                isFromCart: false,
                url: orderUrl,
                cartModels: [],
                isFromNewStorage: false,
                paymentId: '',
                isOrderProductPayment: false,
                isFromCancel: true,
                orderId: orderId,
                myOrderViewModel: this,
              ),
            );
          },
        ) , isScrollControlled: true);

        isLoadingCancel = false;
        update();
      } else if (value.status != null && value.status!.success!) {
        //todo success with out payment url
        /// we need request home page request and wallet and subscriptions
        snackSuccess("", "${value.status!.message.toString()}");
        homeViewModel.getCustomerBoxes();
        getOrdres(isFromPagination: false);
        getOrderDetaile(orderId: newOrderSales.orderId.toString());
        isLoadingCancel = false;
        update();
      } else {
        //todo error handler
        snackError("", "${value.status!.message.toString()}");
        isLoadingCancel = false;
        update();
      }
    });
  }

  HomeViewModel get homeViewModel => Get.find<HomeViewModel>();

  void applyCancel(String? orderId) async {
    //applyCancel
    Map<String, dynamic> map = {ConstanceNetwork.idKey: orderId};

    await OrderHelper.getInstance.applyCancel(body: map).then((value) {
      if (value.status != null && value.status!.success!) {
        snackSuccess("", "${value.status!.message.toString()}");
        homeViewModel.getCustomerBoxes();
        getOrdres(isFromPagination: false);
        getOrderDetaile(orderId: orderId.toString());
        Get.back();
        Get.back();
      } else {
        snackError("", "${value.status!.message.toString()}");
      }
    });
  }

  void editOrder(OrderSales newOrderSales, HomeViewModel homeViewModel,
      StorageViewModel storageViewModel) {
    if (newOrderSales.proccessType?.toLowerCase() ==
            LocalConstance.newStorageSv
                .toLowerCase() /*||
        newOrderSales.proccessType?.toLowerCase() == LocalConstance.newNewStorageSpaceSv.toLowerCase()
        ||newOrderSales.proccessType?.toLowerCase() == LocalConstance.newStorageItemSv.toLowerCase()*/
        ) {
      Get.to(EditNewStorageView(newOrderSales: newOrderSales, viewModel: this));

      ///# [end] # newStorageSv
    } else {
      Get.bottomSheet(
              EditOrderBottomSheet(
                newOrderSales: newOrderSales,
                viewModel: this,
              ),
              isScrollControlled: true)
          .whenComplete(() {
        storageViewModel.selectedDateTime = null;
        storageViewModel.selectedDay = null;
        storageViewModel.selectedStringOption.clear();
      });
    }
  }

  void editOrderRequest(
      StorageViewModel storageViewModel, HomeViewModel homeViewModel,
      {bool? isNewStorage = false}) async {
    isLoading = true;
    update();
    Set<String> items = Set();
    var first = getDayByNumber(
      selectedDateTime: storageViewModel.selectedDateTime!,
    ).first;
    var from = first.from;
    var to = first.to;

    Map<String, dynamic> map = {};
    if (!isNewStorage!) {
      map = {
        ConstanceNetwork.orderIdKey: newOrderSales.orderId,
        ConstanceNetwork.deliveryDateKey:
            DateFormat("yyyy-MM-dd").format(storageViewModel.selectedDateTime!),
        ConstanceNetwork.shippingAddressKey:
            (storageViewModel.selectedAddress != null &&
                    storageViewModel.selectedAddress!.id != null)
                ? storageViewModel.selectedAddress?.id
                : (storageViewModel.selectedAddress!.id != null)
                    ? storageViewModel.selectedAddress?.id
                    : "",
        ConstanceNetwork.orderFromKey: from,
        ConstanceNetwork.orderToKey: to,
      };
    } else {
      List<Map<String, dynamic>> apiItems = [];
      num qty = 0;
      var price = 0;
      var groupId = "0";
      var itemCode = "";
      if (newOrderSales.orderItems != null &&
          newOrderSales.orderItems!.isNotEmpty) {

        newOrderSales.orderItems?.forEach((element) {
          Logger().wtf(element.toJson());
          // items.add(itemCode);
          // itemCode= /*element.itemName == null ? */element.item.toString()/*: (element.itemName.toString().contains("_in") ?element.itemName.toString() :element.itemName.toString()+"_in")*/;
          // groupId= element.groupId.toString();
          // qty= qty + element.quantity!;
          Map<String, dynamic> maps = {
            // "item_code": element.itemName == null ? element.item.toString(): (element.itemName.toString().contains("_in") ?element.itemName.toString() :element.itemName.toString()+"_in"),
            "item_code": (element.item.toString().split("-").length > 2 ?  element.item.toString().split("-")[2]+"_in" : element.item.toString() ),
            "qty": element.quantity!.toInt(),
            "delivery_date": DateFormat("yyyy-MM-dd").format(storageViewModel.selectedDateTime!),
             "subscription": storageViewModel.selectedDuration,
             "subscription_duration": storageViewModel.numberOfDays,
            "subscription_price": storageViewModel.balance,
            "group_id": element.groupId,
            "storage_type": element.storageType,
            "item_parent": 0,
            "need_adviser": 0,
            "order_to": first.from,
            "order_from": first.to,
            "order_time": "${first.to ?? "13:20"} -- ${first.from ?? "14:20"}",
            "space": 0,
            "space_xaxis": 0,
            "space_yaxis": 0,
            "area_zone":storageViewModel.selectedAddress?.zone.toString(),
            "process_type": "New Storage_sv",
            "storage_child_in": "",
            "items_child_in": ""
          };
          apiItems.add(/*apiObjectToSend*/maps);
        });
      }
      // Logger().i(itemCode);
      //
      // Map<String, dynamic> maps = {
      //   // "item_code": element.itemName == null ? element.item.toString(): (element.itemName.toString().contains("_in") ?element.itemName.toString() :element.itemName.toString()+"_in"),
      //   "item_code": (itemCode.split("-").length > 2 ?  itemCode.split("-")[2]+"_in" : itemCode ),
      //   "qty": qty,
      //   "delivery_date": DateFormat("yyyy-MM-dd").format(storageViewModel.selectedDateTime!),
      //   "subscription": storageViewModel.selectedDuration,
      //   "subscription_duration": storageViewModel.numberOfDays,
      //   "subscription_price": storageViewModel.balance,
      //   "group_id": groupId,
      //   "storage_type": element.storageType,
      //   "item_parent": 0,
      //   "need_adviser": 0,
      //   "order_to": first.from,
      //   "order_from": first.to,
      //   "order_time": "${first.to ?? "13:20"} -- ${first.from ?? "14:20"}",
      //   "space": 0,
      //   "space_xaxis": 0,
      //   "space_yaxis": 0,
      //   "area_zone":storageViewModel.selectedAddress?.zone.toString(),
      //   "process_type": "New Storage_sv",
      //   "storage_child_in": "",
      //   "items_child_in": ""
      // };
      // apiItems.add(/*apiObjectToSend*/maps);
      map = {
        ConstanceNetwork.orderIdKey: newOrderSales.orderId,
        ConstanceNetwork.deliveryDateKey:
            DateFormat("yyyy-MM-dd").format(storageViewModel.selectedDateTime!),
        ConstanceNetwork.shippingAddressKey:
            (storageViewModel.selectedAddress != null &&
                    storageViewModel.selectedAddress!.id != null)
                ? storageViewModel.selectedAddress?.id
                : (storageViewModel.selectedAddress!.id != null)
                    ? storageViewModel.selectedAddress?.id
                    : "",
        ConstanceNetwork.orderFromKey: from,
        ConstanceNetwork.orderToKey: to,
        ConstanceNetwork.itemsKey: jsonEncode(apiItems),
      };
    }
    Logger().w(map);
    await OrderHelper.getInstance.editOrder(body: map).then((value) {
      if (value.status != null && value.status!.success!) {
        snackSuccess("", "${value.status!.message.toString()}");
        homeViewModel.getCustomerBoxes();
        getOrdres(isFromPagination: false);
        getOrderDetaile(orderId: newOrderSales.orderId.toString());
        isLoading = false;
        update();
        Get.back();
        Get.back();
      } else {
        snackError("", "${value.status!.message.toString()}");
        isLoading = false;
        update();
      }
    });
  }

  void increaseQuantity(int index) {
    if (newOrderSales.orderItems != null &&
        newOrderSales.orderItems!.isNotEmpty &&
        newOrderSales.orderItems![index].quantity != null) {
      newOrderSales.orderItems![index].quantity =
          newOrderSales.orderItems![index].quantity! + 1;
      var oldPrice = newOrderSales.orderItems![index].oldPrice;
      newOrderSales.orderItems![index].totalPrice =
          newOrderSales.orderItems![index].totalPrice! + oldPrice!;
      update();
    }
  }

  void minesQuantity(int index) {
    if (newOrderSales.orderItems != null &&
        newOrderSales.orderItems!.isNotEmpty &&
        newOrderSales.orderItems![index].quantity != null &&
        newOrderSales.orderItems![index].quantity! > 1) {
      Logger().wtf(newOrderSales.orderItems![index].toJson());
      newOrderSales.orderItems![index].quantity =
          newOrderSales.orderItems![index].quantity! - 1;
      // if(newOrderSales.orderItems![index].quantity!  > 1 &&
      //     newOrderSales.orderItems![index].oldPrice == newOrderSales.orderItems![index].totalPrice!){
      //
      //   var oldPrice = (newOrderSales.orderItems![index].oldPrice! / newOrderSales.orderItems![index].quantity!);
      //   Logger().wtf(oldPrice);
      //   newOrderSales.orderItems![index].totalPrice =
      //       newOrderSales.orderItems![index].totalPrice! - oldPrice;
      // }else{
        var oldPrice = newOrderSales.orderItems![index].oldPrice;
        newOrderSales.orderItems![index].totalPrice =
            newOrderSales.orderItems![index].totalPrice! - oldPrice!;
      // }


      update();
    }
  }

  void deleteItem(int index) {
    if (newOrderSales.orderItems != null &&
        newOrderSales.orderItems!.isNotEmpty) {
      newOrderSales.orderItems!.removeAt(index);
      update();
    }
  }

  void addItemToList(StorageCategoriesData newStorageCategoriesData) {
    OrderItem orderItem = OrderItem(
      itemParent: "0",
      item: newStorageCategoriesData.name,
       price: newStorageCategoriesData.userPrice,
      quantity: newStorageCategoriesData.quantity,
      itemName: newStorageCategoriesData.storageName,
      isParent: false,
      totalPrice: newStorageCategoriesData.userPrice,
      // itemsList: newStorageCategoriesData.i,
      // itemStatus: ,
      groupId: newStorageCategoriesData.groupId.toString(),
      needAdviser: 0,
      oldPrice: newStorageCategoriesData.userPrice !~/ newStorageCategoriesData.quantity!,
      // options: newStorageCategoriesData.,
      // boxes: ,
    );
    newOrderSales.orderItems?.add(orderItem);
    update();
  }
}
