import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/show_selction_widget/my_list_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/widget/back_btn_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:showcaseview/showcaseview.dart';

import 'request_new_storage_step_two.dart';
import 'widgets/add_storage_widget/request_new_storage_header.dart';
import 'widgets/add_storage_widget/storage_size_type_widget.dart';

class RequestNewStorageScreen extends StatefulWidget {
  const RequestNewStorageScreen({Key? key}) : super(key: key);

  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override
  State<RequestNewStorageScreen> createState() =>
      _RequestNewStorageScreenState();
}

class _RequestNewStorageScreenState extends State<RequestNewStorageScreen> {
  // HomeViewModel get homeViewModel => Get.put(HomeViewModel());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      RequestNewStoragesStepTwoScreen.storageViewModel.currentLevel = 0;
      RequestNewStorageScreen.storageViewModel.getStorageCategories();
      RequestNewStorageScreen.storageViewModel.update();
      RequestNewStorageScreen.storageViewModel.moveToIntro();
    });
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);

    return ShowCaseWidget(
      onFinish: ()async{
        await SharedPref.instance.setFirstStorageKey(true);
      },
      builder: Builder(
        builder: (context) {
          RequestNewStorageScreen.storageViewModel.setContext(context);
          return WillPopScope(
            onWillPop: () {
              RequestNewStorageScreen.storageViewModel.userStorageCategoriesData.clear();
              RequestNewStorageScreen.storageViewModel.update();
              // Get.back();
              return Future.value(true);
            },
            child: Scaffold(
              backgroundColor: scaffoldColor,
              appBar: CustomAppBarWidget(
                leadingWidget: GetBuilder<StorageViewModel>(
                  builder: (logic) {
                    return BackBtnWidget(
                      onTap: () {
                        logic.userStorageCategoriesData.clear();
                        logic.update();
                        Get.back();
                      },
                    );
                  },
                ),
                isCenterTitle: true,
                titleWidget: Text(
                  "${tr.request_new_storage}",
                  style: textStyleAppBarTitle(),
                ),
              ),
              floatingActionButton:  GetBuilder<StorageViewModel>(
                init: StorageViewModel(),
                initState: (_) {},
                builder: (logical) {
                  return Padding(
                    padding: EdgeInsetsDirectional.only(start: sizeW36!),
                    child: PrimaryButton(
                        textButton: "${tr.next}",
                        isLoading: false,
                        colorBtn: logical.userStorageCategoriesData.length > 0
                            ? colorPrimary
                            : colorUnSelectedWidget,
                        onClicked: logical.userStorageCategoriesData.length > 0
                            ? () {
                          RequestNewStorageScreen
                              .storageViewModel.currentLevel = 1;
                          Get.put(ProfileViewModle());
                          Get.to(() => RequestNewStoragesStepTwoScreen());
                        }
                            : () {},
                        isExpanded: true),
                  );
                },
              ),
              body: GetBuilder<StorageViewModel>(
                init: StorageViewModel(),
                initState: (_) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    _.controller?.clearNewStorageData();
                  });
                },
                builder: (build) {
                  return Stack(
                    children: [
                      ListView(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        controller:
                        RequestNewStorageScreen.storageViewModel.myListController,
                        shrinkWrap: true,
                        children: [
                          /*Showcase(
                            disableAnimation: Constance.showCaseDisableAnimation,
                            shapeBorder: RoundedRectangleBorder(),
                            radius: BorderRadius.all(Radius.circular(Constance.showCaseRecBorder)),
                            showArrow: Constance.showCaseShowArrow,
                            overlayPadding: EdgeInsets.all(5),
                            blurValue:Constance.showCaseBluer ,
                            description: tr.step_btn_show_case,
                            key: build.orderStepShowKey,
                            child:*/ GetBuilder<StorageViewModel>(
                              builder: (val) {
                                return RequestNewStorageHeader(
                                  currentLevel: val.currentLevel,
                                );
                              },
                            ),
                          /*),*/
                         /* Showcase(
                            disableAnimation: Constance.showCaseDisableAnimation,
                            shapeBorder: RoundedRectangleBorder(),
                            radius: BorderRadius.all(Radius.circular(Constance.showCaseRecBorder)),
                            showArrow: Constance.showCaseShowArrow,
                            overlayPadding: EdgeInsets.all(5),
                            blurValue:Constance.showCaseBluer ,
                            description: tr.categories_btn_show_case,
                            key: build.storageCategoriesShowKey,
                            child: */GetBuilder<StorageViewModel>(
                              builder: (builder) {
                                return StorageSizeType();
                              },
                            /*),*/
                          ),
                          SizedBox(
                            height: sizeH16,
                          ),
                          MyListWidget(),
                          SizedBox(
                            height: sizeH50,
                          ),
                        ],
                      ),
                      // GetBuilder<StorageViewModel>(
                      //   init: StorageViewModel(),
                      //   initState: (_) {},
                      //   builder: (logical) {
                      //     return Positioned(
                      //       bottom: padding10,
                      //       right: padding20,
                      //       left: padding20,
                      //       child: PrimaryButton(
                      //           textButton: "${tr.next}",
                      //           isLoading: false,
                      //           colorBtn: logical.userStorageCategoriesData.length > 0
                      //               ? colorPrimary
                      //               : colorUnSelectedWidget,
                      //           onClicked: logical.userStorageCategoriesData.length > 0
                      //               ? () {
                      //             RequestNewStorageScreen
                      //                 .storageViewModel.currentLevel = 1;
                      //             Get.put(ProfileViewModle());
                      //             Get.to(() => RequestNewStoragesStepTwoScreen());
                      //           }
                      //               : () {},
                      //           isExpanded: true),
                      //     );
                      //   },
                      // )
                    ],
                  );
                },
              ),
            ),
          );
        }
      ),
    );
  }
}
