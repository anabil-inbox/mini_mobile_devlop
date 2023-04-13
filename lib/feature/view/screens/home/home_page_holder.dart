import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/fcm/app_fcm.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/home/home_screen.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/check_in_box_widget.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/my_orders_screen.dart';
import 'package:inbox_clients/feature/view/screens/notification/notification_screen.dart';
import 'package:inbox_clients/feature/view/screens/profile/profile_screen.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/request_new_storage.dart';
import 'package:inbox_clients/feature/view_model/cart_view_model/cart_view_model.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/feature/view_model/my_order_view_modle/my_order_view_modle.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/feature/view_model/splash_view_modle/splash_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/local_database/sql_helper.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../network/firebase/firebase_utils.dart';
import '../../../../util/app_shaerd_data.dart';

// ignore: must_be_immutable
class HomePageHolder extends StatefulWidget {
  HomePageHolder({Key? key, this.box, this.isFromScan  = false}) : super(key: key);

  final bool? isFromScan ;
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

  static StorageViewModel get storageViewModel =>
      Get.put(StorageViewModel(), permanent: true);
  static SplashViewModle get splashViewModle => Get.put(SplashViewModle());
  static CartViewModel get cartViewModel => Get.put(CartViewModel());
  static HomeViewModel get homeViewModle => Get.put(HomeViewModel() , permanent: true);

  bool isBlockedApp = false;
  @override
  void initState() {
    super.initState();

    Get.put(StorageViewModel(), permanent: true);
    Get.put(HomeViewModel(), permanent: true);
    Get.put(ItemViewModle(), permanent: true);
    Get.put(ProfileViewModle() , permanent: true);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // Get.put(ItemViewModle());
      // if(Platform.isAndroid) {
      handleFirebaseOperations();
      if (!GetUtils.isNull(SharedPref.instance.getCurrentUserData()) &&
          !GetUtils.isNull(SharedPref.instance.getCurrentUserData().id))
        await SqlHelper.instance.initDataBase();
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
      cartViewModel.getMyCart();
    });
  }

  Future<void> handleFirebaseOperations() async {
      // if(Platform.isAndroid) {
    await FirebaseAuth.instance.signInAnonymously();
    isBlockedApp = await FirebaseUtils.instance.isBlockedApp();
    setState(() {});
    // }
    var bool = await FirebaseUtils.instance.isHideWallet();
    var hideDelete = await FirebaseUtils.instance.isHideDelete();

    await SharedPref.instance.setIsHideSubscriptions(bool);
    await SharedPref.instance.setIsHideDeleteAccount(hideDelete);
  }




  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return ShowCaseWidget(
      enableAutoScroll: true,
      // autoPlay: true,
      onFinish: ()async{
        await SharedPref.instance.setFirstHome(true);
      },
      builder: Builder(
        builder: (context) {
          homeViewModle.setContext(context);
          return isBlockedApp ? Scaffold(): Scaffold(
            extendBody: true,
            body: GetBuilder<HomeViewModel>(
                init: HomeViewModel(),
                builder: (logic) {
                  return bnbScreens[logic.currentIndex];
                }),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: /*Showcase*//*.withWidget*//*(
              disableAnimation: Constance.showCaseDisableAnimation,
              shapeBorder: CircleBorder(),
              radius: BorderRadius.all(Radius.circular(40)),
              showArrow: Constance.showCaseShowArrow,
              overlayPadding: EdgeInsets.all(5),
              blurValue:Constance.showCaseBluer ,
              description: tr.add_btn_show_case,
              key: homeViewModle.addShowKey *//*?? GlobalKey()*//*,
              child:*/ FloatingActionButton(
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
            /*),*/
            bottomNavigationBar: GetBuilder<HomeViewModel>(
              init: HomeViewModel(),
              builder: (logic) {
                return Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
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
                                  "assets/svgs/home_selected.svg" , color: colorPrimary,)
                                    : SvgPicture.asset("assets/svgs/home.svg"),
                              ),
                              SizedBox(width: sizeW20),
                              MaterialButton(
                                onPressed: () {
                                  Get.put(MyOrderViewModle() , permanent: true);
                                  logic.changeTab(1);
                                  print('Event');
                                },
                                minWidth: sizeW48,
                                child: logic.currentIndex == 1
                                    ? SvgPicture.asset(
                                  "assets/svgs/document_selected.svg", color: colorPrimary,)
                                    : SvgPicture.asset("assets/svgs/document.svg"),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ValueListenableBuilder(
                                valueListenable:AppFcm.fcmInstance.notificationCounterValueNotifier ,builder: (context, value, child) {
                                  return Badge(
                                    toAnimate: false,
                                    elevation: 0,
                                    shape: BadgeShape.circle,
                                    badgeColor:value == 0 ?colorTrans: colorPrimary,
                                    position: BadgePosition(end: 2, bottom: 17),
                                    badgeContent:value == 0 ? const SizedBox.shrink(): Text('${value}',
                                      style: TextStyle(color: colorTextWhite),),
                                    child: MaterialButton(
                                      onPressed: () {
                                        logic.changeTab(2);
                                        AppFcm.fcmInstance.notificationCounterValueNotifier.value = 0;
                                      },
                                      minWidth: sizeW48,
                                      child: logic.currentIndex == 2
                                          ? SvgPicture.asset(
                                        "assets/svgs/notification_selected.svg", color: colorPrimary,)
                                          : SvgPicture.asset(
                                          "assets/svgs/notification.svg"),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(width: sizeW20),
                              MaterialButton(
                                onPressed: () {
                                  logic.changeTab(3);
                                },
                                minWidth: sizeW48,
                                child: logic.currentIndex == 3
                                    ? SvgPicture.asset(
                                  "assets/svgs/profile_selected.svg", color: colorPrimary,)
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
      ),
    );
  }
}
