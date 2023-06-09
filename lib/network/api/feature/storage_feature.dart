import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/model/storage/store_modle.dart';
import 'package:inbox_clients/network/api/model/app_response.dart';
import 'package:inbox_clients/network/api/model/splash.dart';
import 'package:inbox_clients/network/api/model/storage.dart';
import 'package:inbox_clients/network/firebase/firebase_utils.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:logger/logger.dart';

class StorageFeature {
  StorageFeature._();
  static final StorageFeature getInstance = StorageFeature._();
  var log = Logger();

  Future<List<StorageCategoriesData>> getStorageCategories() async {
    try {
      var response = await SplashApi.getInstance.getAppSettings(
          url: "${ConstanceNetwork.storageCategoriesApi}",
          header: ConstanceNetwork.header(0));
      if (response.status?.success == true) {
        List data = response.data;
        return data.map((e) => StorageCategoriesData.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log.d(e.toString());
      return [];
    }
  }

  Future<List<Task>> getTasks() async {
    try {
      var response = await StorageModel.getInstance.getTasks(
          url: "${ConstanceNetwork.getTaskEndPoint}",
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        List data = response.data["data"];
        return data.map((e) => Task.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log.d(e.toString());
      return [];
    }
  }

  Future<AppResponse> getStorageQuantity({required var item}) async {
    var appResponse = await StorageModel.getInstance.getStorageQuantity(
        item: item,
        url: "${ConstanceNetwork.storageCheckQuantity}?item=$item",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> addNewOrder({required var items}) async {
    var appResponse = await StorageModel.getInstance.addNewOrder(
        item: items,
        url: "${ConstanceNetwork.storageAddOrder}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<List<Store>> getStoreAddress() async {
    var appResponse = await StorageModel.getInstance.getStoresAddress(
        url: "${ConstanceNetwork.storageWareHouse}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      List data = appResponse.data;
      return data.map((e) => Store.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<AppResponse> addNewStorage({var body}) async {
    var appResponse = await StorageModel.getInstance.addNewStorage(
        url: "${ConstanceNetwork.storageAddOrder}",
        body: body,
        header: ConstanceNetwork.header(4));
    Logger().i("${appResponse.toJson()}");
    // FirebaseUtils.instance.addNewStorageFail(appResponse.toJson());
    // FirebaseUtils.instance.addNewStorageFail(body);
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> getOrderDetailes({var body}) async {
    var appResponse = await StorageModel.getInstance.getOrderDetailes(
        url: "${ConstanceNetwork.getOrderDetailes}",
        body: body,
        header: ConstanceNetwork.header(4));
    Logger().i("${appResponse.toJson()}");
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> customerStoragesChangeStatus({var body}) async {
    var appResponse = await StorageModel.getInstance
        .customerStoragesChangeStatus(
            url: "${ConstanceNetwork.customerStoragesChangeStatus}",
            body: body,
            header: ConstanceNetwork.header(2));
    Logger().i("${appResponse.toJson()}");
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> payment({var body}) async {
    var appResponse = await StorageModel.getInstance.paymentMethod(
        url: "${ConstanceNetwork.paymentEndPoint}",
        body: body,
        header: ConstanceNetwork.header(2));
    Logger().i("${appResponse.toJson()}");
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

    Future<AppResponse> checkPromo({var body}) async {
    var appResponse = await StorageModel.getInstance.checkPromo(
        url: "${ConstanceNetwork.checkCouponEndPoints}",
        body: body,
        header: ConstanceNetwork.header(4));
    Logger().i("${appResponse.toJson()}");
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

    Future<AppResponse> applyPayment({var body}) async {
    var appResponse = await StorageModel.getInstance.applyPayment(
        url: "${ConstanceNetwork.applyPaymentEndPoint}",
        body: body,
        header: ConstanceNetwork.header(4));
    Logger().i("${appResponse.toJson()}");
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> applySkipCashPayment({var body}) async {
    var appResponse = await StorageModel.getInstance.applySkipCashPayment(
        url: "${ConstanceNetwork.getSkipCashLinkEndPoint}",
        body: body,
        header: ConstanceNetwork.header(4));
    Logger().i("${appResponse.toJson()}");
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> onTaskReschedule({var body}) async{
    var appResponse = await StorageModel.getInstance.onTaskReschedule(
        url: "${ConstanceNetwork.confirmScheduleApi}",
        body: body,
        header: ConstanceNetwork.header(4));
    Logger().i("${appResponse.toJson()}");
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

}
