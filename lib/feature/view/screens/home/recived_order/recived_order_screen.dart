import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inbox_clients/feature/model/storage/payment.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/balance_widget.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/box_need_scanned_item.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/customer_signature_instant_order.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/fetched_items.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/scan_box_instant_order.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/scan_delivered_box.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/scan_products_widget.dart';
import 'package:inbox_clients/feature/view/screens/payment/payment_screen.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/cases_report_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/signature_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/three_size_dot.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:showcaseview/showcaseview.dart';

import '../home_page_holder.dart';

class ReciverOrderScreen extends StatefulWidget /*StatelessWidget */ {
  const ReciverOrderScreen(this.homeViewModel,
      {Key? key,
      this.isNeedToPayment = false,
      this.isNeedSignature = false,
      this.isNeedFingerprint = false, this.paymentUrl, })
      : super(key: key);

  final HomeViewModel homeViewModel;
  final bool isNeedToPayment;
  final bool isNeedSignature;
  final bool isNeedFingerprint;
  final String? paymentUrl;

  @override
  State<ReciverOrderScreen> createState() => _ReciverOrderScreenState();
}

class _ReciverOrderScreenState extends State<ReciverOrderScreen> {
  HomeViewModel get homeViewModel => Get.put(HomeViewModel());
  var boxNeedScanShowKey = GlobalKey();
  var scanBoxShowKey = GlobalKey();
  var scanProductShowKey = GlobalKey();
  var priceShowKey = GlobalKey();
  var signatureShowKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (widget.isNeedSignature) {
        SignatureBottomSheet.showSignatureBottomSheet();
      } else if (widget.isNeedToPayment && widget.paymentUrl != null && widget.paymentUrl!.isNotEmpty) {
        // Get.to(PaymentScreen(
        //   operationTask:homeViewModel.operationTask,
        //   isFromNotifications:true,
        //   url: widget.paymentUrl,
        //   isFromCart: false,
        //   isOrderProductPayment: false,
        //   cartModels: [],
        //   isFromNewStorage: false,
        //   paymentId: '',
        // ));
      } else if (widget.isNeedFingerprint) {
        await widget.homeViewModel.signatureWithTouchId();
      }
      // if(!widget.homeViewModel.operationTask.isRated!){
      //   Get.bottomSheet(RateBottomSheet(taskResponse:widget.homeViewModel.operationTask ,),isScrollControlled: true);
      // }
    });
    homeViewModel.showReceivedOrderCase(
      boxNeedScanShowKey,
      scanBoxShowKey,
      scanProductShowKey,
      priceShowKey,
      signatureShowKey,
    );
  }

  Widget get idVerification => Container(
        height: sizeH50,
        padding: EdgeInsets.symmetric(horizontal: sizeW15!, vertical: sizeH13!),
        decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: GetBuilder<HomeViewModel>(
          builder: (_) {
            return Row(
              children: [
                CustomTextView(
                  txt: tr.id_verification,
                  textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                ),
                const Spacer(),
                SvgPicture.asset(
                  "assets/svgs/check.svg",
                  color: colorPrimary,
                ),
              ],
            );
          },
        ),
      );

  Widget scanDelivedBoxes({required HomeViewModel homeViewModel}) {
    if (homeViewModel.operationTask.processType ==
            LocalConstance.newStorageSv ||
        homeViewModel.operationTask.processType == LocalConstance.fetchId) {
      return const SizedBox();
    } else {
      return const ScanDeliveredBox();
    }
  }

  Future<bool> onWillPop() async {
    // if () {
    // }
    // homeViewModel.onClose();
    homeViewModel.addShowKey = GlobalKey();
    homeViewModel.scanShowKey = GlobalKey();
    homeViewModel.cartShowKey = GlobalKey();
    homeViewModel.taskShowKey = GlobalKey();
    homeViewModel.switchViewShowKey = GlobalKey();
    homeViewModel.boxStatusShowKey = GlobalKey();
    Get.off(() => HomePageHolder());
    return false;
  }

  // Widget paymentSection({required StorageViewModel storageViewModel}) {
  //   TaskResponse currentTask = widget.homeViewModel.operationTask;
  //   if (currentTask.paymentMethod == null) {
  //     return const SizedBox();
  //   } else if (currentTask.paymentMethod != LocalConstance.application) {
  //     // return PaymentWidget();
  //     return const SizedBox();
  //   } else if (currentTask.paymentMethod == LocalConstance.application) {
  //     return ApplicationPayment();
  //   }
  //
  //   storageViewModel.update();
  //   return const SizedBox();
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    // homeViewModel.boxNeedScanShowKey.currentState?.dispose();
    // homeViewModel.scanBoxShowKey.currentState?.dispose();
    // homeViewModel.scanProductShowKey.currentState?.dispose();
    // homeViewModel.priceShowKey.currentState?.dispose();
    // homeViewModel.signatureShowKey.currentState?.dispose();
    // homeViewModel.scanShowKey.currentState?.dispose();
    // homeViewModel.cartShowKey.currentState?.dispose();
    // homeViewModel.taskShowKey.currentState?.dispose();
    // homeViewModel.switchViewShowKey.currentState?.dispose();
    // homeViewModel.boxStatusShowKey.currentState?.dispose();
    // homeViewModel.addShowKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return WillPopScope(
      onWillPop: onWillPop,
      child: ShowCaseWidget(
        onFinish: () async {
          await SharedPref.instance.setFirstReceivedOrderKey(true);
        },
        builder: Builder(builder: (context) {
          homeViewModel.setContext(context);
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.bottomSheet(
                    CasesReportBottomSheet(
                      taskResponse: widget.homeViewModel.operationTask,
                    ),
                    isScrollControlled: true);
              },
              backgroundColor: colorPrimary,
              focusColor: colorPrimary,
              hoverColor: colorPrimary,
              splashColor: colorPrimary,
              child: /*Icon(
                Icons.emergency_outlined,
                color: colorTextWhite,
              )*/ SvgPicture.asset("assets/svgs/issue_report.svg" ,width:sizeW28 ,color: colorTextWhite,),
            ),
            appBar: CustomAppBarWidget(
              titleWidget: CustomTextView(
                txt: tr.instant_order,
                maxLine: Constance.maxLineOne,
                textStyle: textStyleAppBarTitle(),
              ),
              onBackBtnClick: () {
                onWillPop();
              },
              isCenterTitle: true,
              actionsWidgets: [
                SizedBox(width: sizeW10!,),
                InkWell(
                  splashColor: colorTrans,
                  hoverColor: colorTrans,
                  highlightColor: colorTrans,
                  onTap: (){

                  },
                  child: Icon(
                    Icons.call,
                    color: colorBlack,
                  ),
                ),
                SizedBox(width: sizeW10!,),
              ],
            ),
            body: GetBuilder<HomeViewModel>(builder: (home) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: padding20!),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    // if ((home.operationTask.isNew ?? false)) ...[
                    //   SizedBox(height: sizeH27),
                    //   const ContractSignature(),
                    //   SizedBox(height: sizeH10),
                    //   idVerification
                    // ],
                    SizedBox(height: sizeH10),
                    if (home.operationTask.processType !=
                        LocalConstance.fetchId) ...[
                      /*Showcase(
                          disableAnimation: Constance.showCaseDisableAnimation,
                          shapeBorder: RoundedRectangleBorder(),
                          radius: BorderRadius.all(
                              Radius.circular(Constance.showCaseRecBorder)),
                          showArrow: Constance.showCaseShowArrow,
                          overlayPadding: EdgeInsets.all(5),
                          blurValue: Constance.showCaseBluer,
                          description: tr.need_scan_btn_show_case,
                           key: *//*homeViewModel.*//* boxNeedScanShowKey,
                          child:*/ const BoxNeedScannedItem()/*)*/,
                    ] else ...[
                      const FetchedItems(),
                    ],
                    SizedBox(height: sizeH10),
                    if (home.operationTask.processType !=
                        LocalConstance.fetchId) ...[
                      /*Showcase(
                        disableAnimation: Constance.showCaseDisableAnimation,
                        shapeBorder: RoundedRectangleBorder(),
                        radius: BorderRadius.all(
                            Radius.circular(Constance.showCaseRecBorder)),
                        showArrow: Constance.showCaseShowArrow,
                        overlayPadding: EdgeInsets.all(5),
                        blurValue: Constance.showCaseBluer,
                        description: tr.scan_box_btn_show_case,
                        key: *//*homeViewModel.*//* scanBoxShowKey,
                        child:*/ ScanBoxInstantOrder(
                          homeViewModel: widget.homeViewModel,
                        ),
                     /* ),*/
                    ],
                    SizedBox(height: sizeH10),

                    if (home.operationTask.processType ==
                            LocalConstance.recallId ||
                        (home.operationTask.processType ==
                                LocalConstance.terminateId &&
                            (home.operationTask.hasDeliveredScan ??
                                false))) ...[
                      GetBuilder<HomeViewModel>(builder: (homeViewModel) {
                        return scanDelivedBoxes(homeViewModel: homeViewModel);
                      })
                    ],

                    SizedBox(height: sizeH10),
                    /*Showcase(
                        disableAnimation: Constance.showCaseDisableAnimation,
                        shapeBorder: RoundedRectangleBorder(),
                        radius: BorderRadius.all(
                            Radius.circular(Constance.showCaseRecBorder)),
                        showArrow: Constance.showCaseShowArrow,
                        overlayPadding: EdgeInsets.all(5),
                        blurValue: Constance.showCaseBluer,
                        description: tr.scan_product_btn_show_case,
                        key: *//*homeViewModel.*//* scanProductShowKey,
                        child: const*/ ScanProducts()/*)*/,
                    SizedBox(height: sizeH10),
                   /* Showcase(
                        disableAnimation: Constance.showCaseDisableAnimation,
                        shapeBorder: RoundedRectangleBorder(),
                        radius: BorderRadius.all(
                            Radius.circular(Constance.showCaseRecBorder)),
                        showArrow: Constance.showCaseShowArrow,
                        overlayPadding: EdgeInsets.all(5),
                        blurValue: Constance.showCaseBluer,
                        description: tr.price_btn_show_case,
                        key: *//*homeViewModel.*//* priceShowKey,
                        child:*/ const Balance()/*)*/,
                    SizedBox(height: sizeH10),
                    /*Showcase(
                        disableAnimation: Constance.showCaseDisableAnimation,
                        shapeBorder: RoundedRectangleBorder(),
                        radius: BorderRadius.all(
                            Radius.circular(Constance.showCaseRecBorder)),
                        showArrow: Constance.showCaseShowArrow,
                        overlayPadding: EdgeInsets.all(5),
                        blurValue: Constance.showCaseBluer,
                        description: tr.signature_show_case,
                        key: *//*homeViewModel.*//* signatureShowKey,
                        child: */const CustomerSignatureInstantOrder()/*)*/,
                    SizedBox(height: sizeH20),
                  ],
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
