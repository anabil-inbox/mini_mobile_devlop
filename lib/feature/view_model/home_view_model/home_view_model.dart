import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/network/api/feature/home_helper.dart';
import 'package:inbox_clients/util/base_controller.dart';

class HomeViewModel extends BaseController {
  var _currentIndex = 0;
  int get currentIndex => _currentIndex;
  //to do for Loading var:
  bool isLoading = false;

  // get Custome Boxes Vars And Functtions ::
  Set<Box> userBoxess = {};
  Future<void> getCustomerBoxes() async {
    startLoading();
    await HomeHelper.getInstance
        .getCustomerBoxess(pageSize: 10, page: page)
        .then((value) => {
              userBoxess = value.toSet(),
              update(),
            });
    endLoading();
  }

  // search Func And Vars ::
  TextEditingController tdSearch = TextEditingController();
  Set<Box> searchedBoxess = {};
  Future<void> searchForBox({required String searchText}) async {
    await HomeHelper.getInstance.getBoxessWithSearch(serchText: "$searchText").then((value) => {
      searchedBoxess = value.toSet(),
      update(),
    });
  }

  // start Loaging Function ::
  void startLoading() {
    isLoading = true;
    update();
  }

  // end Loaging Function ::
  void endLoading() {
    isLoading = false;
    update();
  }

  //paginations Vars And Func ::
  var scrollcontroller = ScrollController();
  int page = 1;

  // this for Pagination :

  void pagination() {
    if ((scrollcontroller.position.pixels ==
        scrollcontroller.position.maxScrollExtent)) {
      page += 1;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getCustomerBoxes();
    scrollcontroller.addListener(pagination);
  }

  void changeTab(int index) {
    _currentIndex = index;
    update();
  }
}
