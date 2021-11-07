import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/features_modle.dart';
import 'package:inbox_clients/network/api/feature/feature_helper.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';

class IntroViewModle extends GetxController{
  var indexdPage = 0;
  var log = Logger();
  List<Feature>? features = [];
  int selectedIndex = -1;
  String? selectedLang;
  String? temproreySelectedLang;
  


  getIntroData()async{
   await FeatureHelper.getInstance.getFeatureApi().then((value) =>{
      if(!GetUtils.isNull(value)){
      features = value,
      update(),
  
    }
   });
  }
    
  @override
  void onInit() {
    SharedPref.instance.setUserLoginState("${ConstanceNetwork.userEnterd}");
    getIntroData();
    super.onInit();
  }
  
}