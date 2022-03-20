import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inbox_clients/feature/model/respons/task_response.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/application_payment.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/balance_widget.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/box_need_scanned_item.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/contract_signature_widget.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/customer_signature_instant_order.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/scan_box_instant_order.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/scan_delivered_box.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/scan_products_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/signature_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';

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
    if (homeViewModel.operationTask.processType == LocalConstance.newStorageSv ||
        homeViewModel.operationTask.processType == LocalConstance.fetchId) {
      return const SizedBox();
    } else {
      return const ScanDeliveredBox();
    }
  }


  Future<bool> onWillPop() async {
    // Get.off(() => HomePageHolder());
    return false;
  }

  Widget paymentSection({required StorageViewModel storageViewModel}) {
    TaskResponse currentTask = widget.homeViewModel.operationTask;
    if (currentTask.paymentMethod == null) {
      return const SizedBox();
    } else if (currentTask.paymentMethod != LocalConstance.application) {
      // return PaymentWidget();
      return const SizedBox();
    } else if (currentTask.paymentMethod == LocalConstance.application) {
      return ApplicationPayment();
    }

    storageViewModel.update();
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleWidget: CustomTextView(
          txt: tr.instant_order,
          maxLine: Constance.maxLineOne,
          textStyle: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
      ),
      body: GetBuilder<HomeViewModel>(
        builder: (home) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: padding20!),
              child: ListView(
                shrinkWrap: true,
                children: [
                   home.operationTask.isNew == true
                      ? SizedBox(height: sizeH27)
                      : const SizedBox(),
                  home.operationTask.isNew == true
                      ? const ContractSignature()
                      : const SizedBox(),
                  SizedBox(height: sizeH10),
                  home.operationTask.isNew == true
                      ? idVerification
                      : const SizedBox(),
                  SizedBox(height: sizeH10),
                  const BoxNeedScannedItem(),
                  SizedBox(height: sizeH10),
                 home.operationTask.processType == LocalConstance.pickupId
                  ? const SizedBox()
                  : ScanBoxInstantOrder(
                    homeViewModel: widget.homeViewModel,
                  ),
                  SizedBox(height: sizeH10),
                  home.operationTask.processType == LocalConstance.newStorageSv
                  ? const SizedBox()
                  : GetBuilder<HomeViewModel>(builder: (homeViewModel) {
                    return scanDelivedBoxes(homeViewModel: homeViewModel);
                  }),
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
          }        
      ),
    );
  }


}
