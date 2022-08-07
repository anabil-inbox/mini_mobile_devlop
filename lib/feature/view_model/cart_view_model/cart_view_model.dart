import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/local_database/cart_helper.dart';
import 'package:inbox_clients/local_database/model/cart_model.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';

class CartViewModel extends GetxController {
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  bool isLoading = false;

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

  Future<void> doOnCheckOut() async {
    startLoading();
    try {
      for (var i = 0; i < cartList.length; i++) {
        storageViewModel.selectedPaymentMethod?.id = LocalConstance.cash;
        storageViewModel.selectedAddress = cartList[i].address;
        await storageViewModel.doTaskBoxRequest(
          isFromCart: true,
          task: cartList[i].task!,
          boxes: cartList[i].box!,
          beneficiaryId: "",
          selectedItems: cartList[i].boxItem,
        );
        deleteItemCart(cartList[i]);
      }
      snackSuccess("", tr.checkout_successfully );
      Get.back();

      // List<Map<String, dynamic>> mapSalesOrder = <Map<String, dynamic>>[];
      // Map<String, dynamic> map = {};
      // List data = [];
      // for (var i = 0; i < cartList.length; i++) {
      //   for (var i = 0; i < cartList[i].boxItem!.length; i++) {
      //   }
      //   map["type[$i]"] = cartList[i].task?.id;
      //   map["address[$i]"] = cartList[i].address?.id;
      //   mapSalesOrder.add(map);
      // }
    } catch (e) {
      printError();
    }

    endLoading();
  }

  List<CartModel> cartList = <CartModel>[];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  //todo this for add to cart [local data]
  Future<void> addToCart(List<Box>? boxes, List<BoxItem>? boxItems, Address? address,
      Task task, Day day, String title) async {
    task.selectedVas = storageViewModel.selectedStringOption;
    var cartModel = CartModel(
        userId: SharedPref.instance.getCurrentUserData().id.toString(),
        task: task,
        box: boxes,
        boxItem: boxItems,
        orderTime: day,
        address: address,
        title: "$title");
    cartModel.toJson().remove("id");
   await CartHelper.instance.addToCart(cartModel).then((value) {
      if (value >= 1) {
        //todo success state
        Logger().d("addToCart_1${cartModel.toJson()}");
        Get.back();
        snackSuccess(tr.success, tr.success_add_to_cart);
      } else {
        //todo fail state
        Logger().d("addToCart_2${cartModel.toJson()}");
        snackError(tr.error_occurred, tr.field_add_to_cart);
      }
    }).catchError((onError) {
      Logger().d("addToCart_3${onError.toString()}");
    });
    cartModel = CartModel(
      task: null,
      userId: null,
      box: [],
      boxItem: null,
      title: null,
      address: null,
      orderTime: null,
    );
   // getMyCart();
  }

  //todo this for delete item from cart [local data]
  void deleteItemCart(CartModel cartModel) {
    CartHelper.instance.deleteItemCart(cartModel).then((value) {
      if (value > 1) {
        //todo success state
        cartList.remove(cartModel);
        getMyCart();
        update();
      } else {
        //todo fail state
      }
    });
  }

  //todo this for update item from cart [local data]
  void updateItemCart(CartModel cartModel) {
    CartHelper.instance.updateItemCart(cartModel).then((value) {
      Logger().d("updateCart$value");
      if (value >= 1) {
        //todo success state
        Logger().d("updateCart_1${cartModel.toJson()}");
        snackSuccess(tr.success, tr.success_update_cart);
        getMyCart();
        update();
      } else {
        //todo fail state
        Logger().d("updateCart_2${cartModel.toJson()}");
        snackError(tr.error_occurred, tr.field_update_cart);
      }
    }).catchError((onError) {
      Logger().d("updateCart_3${onError.toString()}");
    });
  }

  void getMyCart() async {
    await CartHelper.instance.getMyCart().then((List<CartModel> value) {
      //todo success state
      cartList = value;
      // for (var item in value) {
      //   cartList.add(item);
      //   Logger().d(item.toJson());
      // }
      update();
    }).catchError((onError) {
      //todo fail state
      Logger().e(onError);
    });
  }
}
