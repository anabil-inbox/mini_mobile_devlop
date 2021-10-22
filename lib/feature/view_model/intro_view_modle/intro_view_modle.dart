import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/features_modle.dart';
import 'package:inbox_clients/network/api/feature/feature_helper.dart';
import 'package:logger/logger.dart';

class IntroViewModle extends GetxController{
  var indexdPage = 0;
  var log = Logger();
  List<Feature>? features = [];



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
    getIntroData();
    super.onInit();
  }
  
}