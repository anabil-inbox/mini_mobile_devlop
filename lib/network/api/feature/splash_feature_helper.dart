import 'package:get/utils.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/storage/payment.dart';
import 'package:inbox_clients/network/api/model/splash.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';

class SplashHelper {
  SplashHelper._();
  static final SplashHelper getInstance = SplashHelper._();
  var log = Logger();

  Future<ApiSettings> getAppSettings() async {
    try {
      var response = await SplashApi.getInstance.getAppSettings(
          url: "${ConstanceNetwork.settingeEndPoint}",
          header: GetUtils.isNull(SharedPref.instance.getUserToken())
              ? ConstanceNetwork.header(0)
              : ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        await SharedPref.instance.setAppSetting(response.data);
        return ApiSettings.fromJson(response.data);
      } else {
        return ApiSettings.fromJson({});
      }
    } catch (e) {
      log.d(e.toString());
      return ApiSettings.fromJson({});
    }
  }
}
