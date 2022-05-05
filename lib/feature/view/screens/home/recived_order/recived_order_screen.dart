import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/balance_widget.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/box_need_scanned_item.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/customer_signature_instant_order.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/fetched_items.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/scan_box_instant_order.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/scan_delivered_box.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/scan_products_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/cases_report_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/signature_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';

import '../home_page_holder.dart';

class ReciverOrderScreen extends StatefulWidget /*StatelessWidget */ {
  const ReciverOrderScreen(this.homeViewModel,
      {Key? key,
      this.isNeedToPayment = false,
      this.isNeedSignature = false,
      this.isNeedFingerprint = false})
      : super(key: key);

  final HomeViewModel homeViewModel;
  final bool isNeedToPayment;
  final bool isNeedSignature;
  final bool isNeedFingerprint;

  @override
  State<ReciverOrderScreen> createState() => _ReciverOrderScreenState();
}

class _ReciverOrderScreenState extends State<ReciverOrderScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      if (widget.isNeedSignature) {
        SignatureBottomSheet.showSignatureBottomSheet();
      } else if (widget.isNeedFingerprint) {
        await widget.homeViewModel.signatureWithTouchId();
      }
      // if(!widget.homeViewModel.operationTask.isRated!){
      //   Get.bottomSheet(RateBottomSheet(taskResponse:widget.homeViewModel.operationTask ,),isScrollControlled: true);
      // }

    });
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
                SvgPicture.asset("assets/svgs/check.svg"),
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
  Widget build(BuildContext context) {
    screenUtil(context);
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.bottomSheet(CasesReportBottomSheet(taskResponse: widget.homeViewModel.operationTask,) ,isScrollControlled: true );
          },
          backgroundColor: colorPrimary,
          focusColor: colorPrimary,
          hoverColor: colorPrimary,
          splashColor: colorPrimary,
          child: SvgPicture.asset("assets/svgs/call_red_fig.svg"),
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
                  const BoxNeedScannedItem(),
                ] else ...[
                  const FetchedItems(),
                ],
                SizedBox(height: sizeH10),
                if (home.operationTask.processType !=
                    LocalConstance.fetchId) ...[
                  ScanBoxInstantOrder(
                    homeViewModel: widget.homeViewModel,
                  ),
                ],
                SizedBox(height: sizeH10),

                if (home.operationTask.processType == LocalConstance.recallId ||
                    (home.operationTask.processType == LocalConstance.terminateId &&
                        (home.operationTask.hasDeliveredScan ?? false))) ...[
                  GetBuilder<HomeViewModel>(builder: (homeViewModel) {
                    return scanDelivedBoxes(homeViewModel: homeViewModel);
                  })
                ],

                SizedBox(height: sizeH10),
                const ScanProducts(),
                SizedBox(height: sizeH10),
                const Balance(),
                SizedBox(height: sizeH10),
                const CustomerSignatureInstantOrder(),
                SizedBox(height: sizeH20),
              ],
            ),
          );
        }),
      ),
    );
  }
}