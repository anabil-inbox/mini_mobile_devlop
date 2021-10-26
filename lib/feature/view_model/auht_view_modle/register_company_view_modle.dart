import 'dart:async';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RegisterCompanyViewModle extends GetxController{
  bool isAccepte = true;
  
  Timer? timer;
  int startTimerCounter = 60;
  String? companySector;
  String? temproreySectorName;
  Set<String> arraySectors = {};
  int selectedIndex = -1;
  

  void changeAcception(bool newValue){
    isAccepte = newValue;
    update();
  }

  void startTimer() {
  const oneSec = const Duration(seconds: 1);
  timer = new Timer.periodic(
    oneSec,
    (Timer timer) {
      if (startTimerCounter == 0) {
          timer.cancel();
          update();
        
      } else {
        startTimerCounter--;
        update();
      }
    },
  );
}
  
}