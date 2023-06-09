
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/utils.dart';
import 'package:inbox_clients/fcm/app_fcm.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/network/api/feature/splash_feature_helper.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';

class SplashViewModle extends GetxController{
    var log = Logger();
    ApiSettings? apiSettings;  
    List<CompanySector> arrCompanySector = [];
    List<String> arrSecName = [];
     
  getAppSetting() async {
     await SplashHelper.getInstance.getAppSettings().then((value)async =>{
        if(!GetUtils.isNull(value)){
          apiSettings = value,
          await SharedPref.instance.setUserType(value.customerType!),
          update()
    }
   });
  }


  @override
  void onInit() async{
   await getAppSetting();
    SharedPref.instance.getUserType();
    AppFcm.fcmInstance.getTokenFCM();
    super.onInit();
  }

}