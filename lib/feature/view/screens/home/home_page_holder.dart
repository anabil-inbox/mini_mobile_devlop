import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/home/home_screen.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/check_in_box_widget.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/my_orders_screen.dart';
import 'package:inbox_clients/feature/view/screens/notification/notification_screen.dart';
import 'package:inbox_clients/feature/view/screens/profile/profile_screen.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/request_new_storage.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/feature/view_model/my_order_view_modle/my_order_view_modle.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/feature/view_model/splash_view_modle/splash_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';

// ignore: must_be_immutable
class HomePageHolder extends StatefulWidget {
  HomePageHolder({Key? key, this.box, this.isFromScan}) : super(key: key);

  bool? isFromScan = false;
  Box? box;

  @override
  _HomePageHolderState createState() => _HomePageHolderState();
}

class _HomePageHolderState extends State<HomePageHolder> {
  int index = 1;

  List<Widget> bnbScreens = [
    HomeScreen(),
    const MyOrdersScreen(),
    NotificationScreen(),
    const ProfileScreen(),
  ];

  static StorageViewModel get storageViewModel => Get.put(StorageViewModel());
  static SplashViewModle get splashViewModle => Get.put(SplashViewModle());
  static HomeViewModel get homeViewModle => Get.put(HomeViewModel());
  

  @override
  void initState() {
    super.initState();
   Get.put(ProfileViewModle());

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Get.put(ItemViewModle());
      if (widget.isFromScan ?? false) {
        Get.bottomSheet(
            CheckInBoxWidget(
              box: widget.box,
              isUpdate: false,
            ),
            isScrollControlled: true);
      }
      homeViewModle.getCustomerBoxes();
      storageViewModel.getStorageCategories();
      splashViewModle.getAppSetting();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeViewModel>(
          init: HomeViewModel(),
          builder: (logic) {
            return bnbScreens[logic.currentIndex];
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Logger().d(
              "${SharedPref.instance.getCurrentUserData().toJson().toString()}");
          Logger().d("${SharedPref.instance.getUserToken()}");
        Get.to(() => RequestNewStorageScreen());
       //  Get.put(ItemViewModle());
       //  Get.to(() => ItemScreen(box: Box(storageName: "Test")));
       // Get.to(StorageDetailsView(tags: [],));
        },
        child: Icon(
          Icons.add,
          color: colorTextWhite,
        ),
        elevation: 2.0,
      ),
      bottomNavigationBar: GetBuilder<HomeViewModel>(
        init: HomeViewModel(),
        builder: (logic) {
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(sizeRadius16!),
                    topRight: Radius.circular(sizeRadius16!))),
            child: BottomAppBar(
              color: colorTextWhite,
              shape: CircularNotchedRectangle(),
              notchMargin: 8,
              child: Padding(
                padding: EdgeInsets.all(sizeH6!),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            logic.changeTab(0);
                            print('main');
                          },
                          minWidth: sizeW48,
                          child: logic.currentIndex == 0
                              ? SvgPicture.asset(
                                  "assets/svgs/home_selected.svg")
                              : SvgPicture.asset("assets/svgs/home.svg"),
                        ),
                        SizedBox(width: sizeW20),
                        MaterialButton(
                          onPressed: () {
                            Get.put(MyOrderViewModle());
                            logic.changeTab(1);
                            print('Event');
                          },
                          minWidth: sizeW48,
                          child: logic.currentIndex == 1
                              ? SvgPicture.asset(
                                  "assets/svgs/document_selected.svg")
                              : SvgPicture.asset("assets/svgs/document.svg"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            logic.changeTab(2);
                          },
                          minWidth: sizeW48,
                          child: logic.currentIndex == 2
                              ? SvgPicture.asset(
                                  "assets/svgs/notification_selected.svg")
                              : SvgPicture.asset(
                                  "assets/svgs/notification.svg"),
                        ),
                        SizedBox(width: sizeW20),
                        MaterialButton(
                          onPressed: () {
                            logic.changeTab(3);
                          },
                          minWidth: sizeW48,
                          child: logic.currentIndex == 3
                              ? SvgPicture.asset(
                                  "assets/svgs/profile_selected.svg")
                              : SvgPicture.asset("assets/svgs/profile.svg"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
