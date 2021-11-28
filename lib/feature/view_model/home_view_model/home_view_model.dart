import 'package:inbox_clients/util/base_controller.dart';

class HomeViewModel extends BaseController{

  var _currentIndex = 0;
  int get currentIndex => _currentIndex;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void changeTab(int index) {
    _currentIndex = index;
    update();
  }



}