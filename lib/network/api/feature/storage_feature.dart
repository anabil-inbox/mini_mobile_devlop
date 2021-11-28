
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/network/api/model/splash.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';

class StorageFeature {
  StorageFeature._();
  static final StorageFeature getInstance = StorageFeature._();
  var log = Logger();

  Future<List<StorageCategoriesData>> getStorageCategories() async {
    try {
      var response = await SplashApi.getInstance.getAppSettings(url: "${ConstanceNetwork.storageCategoriesApi}", header: ConstanceNetwork.header(0));
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
}
