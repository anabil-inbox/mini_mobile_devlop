import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/local_database/cart_helper.dart';
import 'package:inbox_clients/local_database/model/cart_model.dart';
import 'package:logger/logger.dart';

class CartViewModel extends GetxController {
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
  void addToCart(List<Box>? boxes, List<BoxItem>? boxItems, Address? address,
      Task task, Day day, String title) {
    var cartModel = CartModel(
        task: task,
        box: boxes,
        boxItem: boxItems,
        orderTime: day,
        address: address,
        title: "$title");
    cartModel.toJson().remove("id");
    CartHelper.instance.addToCart(cartModel).then((value) {
      if (value > 1) {
        //todo success state
        Logger().d("addToCart_1${cartModel.toJson()}");
      } else {
        //todo fail state
        Logger().d("addToCart_2${cartModel.toJson()}");
      }
    }).catchError((onError) {});

    getMyCart();
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
      if (value > 1) {
        //todo success state
      } else {
        //todo fail state
      }
    });
  }

  void getMyCart() async{
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
