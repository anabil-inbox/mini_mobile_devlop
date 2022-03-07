import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inbox_clients/feature/model/respons/task_response.dart';
import 'package:inbox_clients/feature/view/screens/home/home_page_holder.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/application_payment.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/balance_widget.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/contract_signature_widget.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/scan_box_instant_order.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/scan_products_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
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
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';

class ReciverOrderScreen extends /*StatefulWidget*/ StatelessWidget {
  const ReciverOrderScreen(this.homeViewModel,
      {Key? key, this.isNeedToPayment = false})
      : super(key: key);

  final HomeViewModel homeViewModel;
  final bool isNeedToPayment;

/*  @override 
  State<ReciverOrderScreen> createState() => _ReciverOrderScreenState();
}

class _ReciverOrderScreenState extends State<ReciverOrderScreen> {
  @override
  void initState() {
    super.initState();
    // Get.put(HomeViewModel(), permanent: true);
  }*/

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

  Future<bool> onWillPop() async {
    // Get.off(() => HomePageHolder());
    return false;
  }

  Widget paymentSection({required StorageViewModel storageViewModel}) {
    TaskResponse currentTask =
        SharedPref.instance.getCurrentTaskResponse() ?? TaskResponse();
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
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: CustomAppBarWidget(
          titleWidget: CustomTextView(
            txt: tr.instant_order,
            maxLine: Constance.maxLineOne,
            textStyle: textStyleAppBarTitle(),
          ),
          isCenterTitle: true,
          onBackBtnClick: () {
            Get.off(HomePageHolder());
          },
        ),
        body: Stack(
          children: [
            GetBuilder<HomeViewModel>(builder: (home) {
              Logger()
                  .e(SharedPref.instance.getCurrentTaskResponse()?.processType);
              if (SharedPref.instance.getCurrentTaskResponse()?.processType ==
                      LocalConstance.newStorageSv ||
                  SharedPref.instance
                          .getCurrentTaskResponse()
                          ?.notificationId ==
                      LocalConstance.paymentRequiredId) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding20!),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(height: sizeH27),
                      const ContractSignature(),
                      SizedBox(height: sizeH10),
                      idVerification,
                      SizedBox(height: sizeH10),
                      ScanBoxInstantOrder(
                        homeViewModel: /*widget.*/ homeViewModel,
                      ),
                      SizedBox(height: sizeH10),
                      const ScanProducts(),
                      SizedBox(height: sizeH10),
                      GetBuilder<StorageViewModel>(
                        builder: (_) {
                          return Balance();
                        },
                      ),
                      SizedBox(height: sizeH10),
                      GetBuilder<StorageViewModel>(builder: (storageViewModel) {
                        return paymentSection(
                            storageViewModel: storageViewModel);
                      }),
                      SizedBox(height: sizeH10),
                    ],
                  ),
                );
              }
              return const SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}
