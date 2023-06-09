import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/core/dialog_loading.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/cart/my_cart/cart_screen.dart';
import 'package:inbox_clients/feature/view/screens/home/search_screen.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/box_gv_widget.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/check_in_box_widget.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/filter_widget.dart';
import 'package:inbox_clients/feature/view/screens/items/qr_screen.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/reschedule_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/empty_state/home_empty_statte.dart';
import 'package:inbox_clients/feature/view/widgets/icon_btn.dart';
import 'package:inbox_clients/feature/view_model/cart_view_model/cart_view_model.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../view_model/profile_view_modle/profile_view_modle.dart';
import 'widget/box_lv_widget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, this.isFromScan, this.box}) : super(key: key);

  // ProfileViewModle get profileViewModel =>
  //     Get.put<ProfileViewModle>(ProfileViewModle());

  static HomeViewModel homeViewModle = Get.find<HomeViewModel>();
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  static ProfileViewModle profileViewModle = Get.put(ProfileViewModle());

  bool? isFromScan = false;
  Box? box;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//todo this for search
  Widget get searchWidget =>
      Container(
        height: sizeH50,
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.symmetric(horizontal: sizeW13!),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(sizeRadius10!),
            color: colorTextWhite,
            border: Border.all(color: colorBorderContainer)),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/svgs/search_icon.svg",
            ),
            Expanded(
              child: CustomTextFormFiled(
                maxLine: Constance.maxLineOne,
                textInputAction: TextInputAction.search,
                keyboardType: TextInputType.text,
                onSubmitted: (_) {},
                onChange: (_) {},
                fun: _goToFilterNameView,
                isReadOnly: true,
                isSmallPadding: false,
                isSmallPaddingWidth: true,
                fillColor: colorBackground,
                isFill: true,
                isBorder: true,
              ),
            ),
            // SvgPicture.asset(
            //   "assets/svgs/Filter.svg",
            // ),
          ],
        ),
      );

  Widget get appBar =>
      GetBuilder<StorageViewModel>(builder: (logic) {
        return IntrinsicHeight(
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: sizeW20!, vertical: sizeH20!),
            child: SizedBox(
              // height: sizeH50,
              child: CustomAppBarWidget(
                elevation: 0,
                appBarColor: (HomeScreen.homeViewModle.userBoxess.isEmpty)
                    ? scaffoldColor
                    : colorBackground,
                isCenterTitle: true,
                titleWidget: searchWidget,
                leadingWidget: /*Showcase(
                  disableAnimation: Constance.showCaseDisableAnimation,
                  shapeBorder: RoundedRectangleBorder(),
                  radius: BorderRadius.all(
                      Radius.circular(Constance.showCaseRecBorder)),
                  showArrow: Constance.showCaseShowArrow,
                  overlayPadding: EdgeInsets.all(5),
                  blurValue: Constance.showCaseBluer,
                  description: tr.scan_btn_show_case,
                  key: HomeScreen.homeViewModle.scanShowKey *//*?? GlobalKey()*//*,
                  child: */IconBtn(
                    iconColor: colorTextWhite,
                    width: sizeW48,
                    height: sizeH48,
                    backgroundColor: colorRed,
                    onPressed: () {
                      Get.to(() =>
                          QrScreen(
                            index: 0,
                            storageViewModel: HomeScreen.storageViewModel,
                          ));
                    },
                    borderColor: colorTrans,
                    icon: "assets/svgs/Scan.svg",
                  ),
                /*),*/
                leadingWidth: sizeW48,
                actionsWidgets: [
                  /*Showcase(
                    disableAnimation: Constance.showCaseDisableAnimation,
                    shapeBorder: RoundedRectangleBorder(),
                    radius: BorderRadius.all(
                        Radius.circular(Constance.showCaseRecBorder)),
                    showArrow: Constance.showCaseShowArrow,
                    overlayPadding: EdgeInsets.all(5),
                    blurValue: Constance.showCaseBluer,
                    description: tr.cart_btn_show_case,
                    key: HomeScreen.homeViewModle.cartShowKey *//*?? GlobalKey()*//*,
                    child: */GetBuilder<CartViewModel>(
                      init: CartViewModel(),
                        builder: (logic) {
                          return Badge(
                            toAnimate: false,
                            elevation: 0,
                            shape: BadgeShape.circle,
                            badgeColor:logic.cartList.length == 0 ?colorTrans: colorPrimary,
                            position: BadgePosition(start: -4, bottom: -2),
                            badgeContent:logic.cartList.length == 0 ? const SizedBox.shrink(): Text('${logic.cartList.length}',
                              style: TextStyle(color: colorTextWhite),),
                            borderRadius: BorderRadius.circular(8),
                            child: IconBtn(
                              icon: "assets/svgs/Buy.svg",
                              iconColor: colorRed,
                              width: sizeW48,
                              height: sizeH48,
                              backgroundColor: colorRedTrans,
                              onPressed: () {
                                Get.to(() => CartScreen());
                              },
                              borderColor: colorTrans,
                            ),
                          );
                        }),
                 /* ),*/
                ],
              ),
            ),
          ),
        );
      });

  Widget textHintsWidget(text, color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.circle,
          size: sizeRadius16,
          color: color ?? boxColorGray,
        ),
        SizedBox(
          width: sizeW4,
        ),
        CustomTextView(
          txt: text ?? "${tr.on_the_way}",
          maxLine: Constance.maxLineOne,
          textStyle: textStyleNormal()?.copyWith(fontSize: 8),
          textOverflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          width: sizeW10,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    Get.put(StorageViewModel(), permanent: true);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      HomeScreen.profileViewModle.getProfileData();
      HomeScreen.homeViewModle.homeScrollcontroller.addListener(() {
        HomeScreen.homeViewModle.pagination();
      });
      HomeScreen.homeViewModle.getCases();
      if (widget.isFromScan ?? false) {
        Get.bottomSheet(
            CheckInBoxWidget(
              isUpdate: false,
            ),
            isScrollControlled: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: RefreshIndicator(
        onRefresh: () async {
          HomeScreen.homeViewModle.onInit();
        },
        child: GetBuilder<HomeViewModel>(
          builder: (logic) {
            if (logic.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (logic.userBoxess.isEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  await HomeScreen.homeViewModle.refreshHome();
                },
                child: SingleChildScrollView(
                  physics: customScrollViewIOS(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: SafeArea(
                      child: Stack(
                        children: [
                          EmptyHomeWidget(),
                          appBar,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      await HomeScreen.homeViewModle.refreshHome();
                    },
                    child: SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      child: SingleChildScrollView(
                        controller: logic.homeScrollcontroller,
                        physics: customScrollViewIOS(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: sizeW20!),
                          child: GetBuilder<HomeViewModel>(
                            builder: (_) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: Platform.isIOS ? 160 : 150,
                                  ),
                                  /*Showcase(
                                      disableAnimation: Constance
                                          .showCaseDisableAnimation,
                                      shapeBorder: RoundedRectangleBorder(),
                                      radius: BorderRadius.all(Radius.circular(
                                          Constance.showCaseRecBorder)),
                                      showArrow: Constance.showCaseShowArrow,
                                      overlayPadding: EdgeInsets.all(5),
                                      blurValue: Constance.showCaseBluer,
                                      description: tr.task_btn_show_case,
                                      key: HomeScreen.homeViewModle
                                          .taskShowKey *//*?? GlobalKey()*//*,
                                      child:*/ FilterWidget()/*)*/,
                                  SizedBox(
                                    height: 10,
                                  ),
                                /*  Showcase(
                                    disableAnimation: Constance
                                        .showCaseDisableAnimation,
                                    shapeBorder: RoundedRectangleBorder(),
                                    radius: BorderRadius.all(Radius.circular(
                                        Constance.showCaseRecBorder)),
                                    showArrow: Constance.showCaseShowArrow,
                                    overlayPadding: EdgeInsets.all(5),
                                    blurValue: Constance.showCaseBluer,
                                    description: tr.status_btn_show_case,
                                    key: HomeScreen.homeViewModle
                                        .boxStatusShowKey *//*?? GlobalKey()*//*,
                                    child:*/ FittedBox(
                                      fit: BoxFit.fill,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                              onTap: /*onTheWayClick*/ () {},
                                              child: textHintsWidget(
                                                  "${tr.on_the_way}", null)),
                                          textHintsWidget(
                                              "${tr.at_home}", colorAtHome),
                                          textHintsWidget(
                                              tr.pickup, boxColorOrange),
                                          textHintsWidget("${tr.in_warehouse}",
                                              colorInWarehouse),

                                        ],
                                      ),
                                    ),
                                  /*),*/
                                  if (!logic.isListView!) ...[
                                    logic.isLoading
                                        ? DialogLoading()
                                        : GVWidget(),
                                  ] else
                                    ...[
                                      logic.isLoading
                                          ? DialogLoading()
                                          : LVWidget(),
                                    ],
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      height: Platform.isIOS ? 135 : 130,
                      // padding: EdgeInsets.all(padding10!),
                      decoration: BoxDecoration(
                        color: colorBackground,
                        borderRadius: BorderRadius.circular(sizeRadius5!),
                      ),
                      child: appBar),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void _goToFilterNameView() {
    Get.to(() => SearchScreen());
  }

// void onTheWayClick() async{
//   Get.bottomSheet(
//       NotifayForNewStorage(box: Box(),showQrScanner: true,),
//       isScrollControlled: true
//   );
// }
}
