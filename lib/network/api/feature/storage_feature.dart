import 'package:inbox_clients/feature/model/storage/quantity_modle.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/network/api/model/app_response.dart';
import 'package:inbox_clients/network/api/model/splash.dart';
import 'package:inbox_clients/network/api/model/storage.dart';
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


  Future<List<Quantity>> getStorageQuantity({required var item}) async {
    var appResponse = await StorageModel.getInstance.getStorageQuantity(
        item: item,
        url: "${ConstanceNetwork.storageCheckQuantity}?item=$item",
        header: ConstanceNetwork.header(4));
       // Logger().i("msg_res ${appResponse.data.toString()}");
    if (appResponse.status?.success == true) {
      List data = appResponse.data["items"];
      return data.map((e) => Quantity.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
