import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RegisterCompanyViewModle extends GetxController{
  bool isAccepte = true;
  
  
  Set<String> arraySectors = {};

  void changeAcception(bool newValue){
    isAccepte = newValue;
    update();
  }
  

    

  
}