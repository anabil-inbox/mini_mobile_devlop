import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:inbox_clients/feature/model/country.dart';
import 'package:inbox_clients/network/api/feature/country_helper.dart';

class AuthViewModle extends GetxController{
    bool isAccepte = true;
    List<Country> countres = [];
    String? dropDown;
  
  void changeAcception(bool newValue){
    isAccepte = newValue;
    update();
  }

  void onChangeDropDownList(String newValue){
    dropDown = newValue;
    update();
  }

  getCountries()async{
   await CountryHelper.getInstance.getCountryApi().then((value) =>{
      if(!GetUtils.isNull(value)){
      countres = value,
      update(),
  
    }
   });
  }


  @override
  void onInit() {
    getCountries();
    super.onInit();
  }
}