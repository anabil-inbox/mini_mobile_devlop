import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/storage/payment.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';

import '../../../../../../../util/app_shaerd_data.dart';
import '../../../../../../view_model/profile_view_modle/profile_view_modle.dart';

class PaymentItem extends StatelessWidget {
  const PaymentItem(
      {Key? key,
      this.isRecivedOrderPayment = false,
      required this.paymentMethod,
      this.isFromApplicationPayment = false})
      : super(key: key);

  final PaymentMethod paymentMethod;
  final bool isFromApplicationPayment;
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  static ProfileViewModle profileViewModle =
      Get.put(ProfileViewModle(), permanent: true);

  final bool isRecivedOrderPayment;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<StorageViewModel>(
      init: StorageViewModel(),
      initState: (_) {},
      builder: (builder) {
        return InkWell(
          onTap: () {
            builder.selectedPaymentMethod = paymentMethod;
            builder.update();
            if (isRecivedOrderPayment) {
              doOnRecivedOrderPayment();
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: padding4!),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(padding6!),
                border: Border.all(
                    width: 0.5,
                    color: builder.selectedPaymentMethod?.id != paymentMethod.id
                        ? colorBorderContainer
                        : colorTrans),
                color: builder.selectedPaymentMethod?.id != paymentMethod.id
                    ? colorTextWhite
                    : colorPrimary),
            padding: EdgeInsets.symmetric(
                vertical: padding9!, horizontal: padding14!),
            child: Row(
              children: [
                if (paymentMethod.image != null &&
                    paymentMethod.image != "") ...[
                  imageNetwork(
                      isPayment: true,
                      url: paymentMethod.image,
                      width: sizeW20,
                      height: sizeH20),
                ] else ...[
                  imageNetwork(isPayment: true, width: sizeW20, height: sizeH20)
                ],

                // if (paymentMethod.id == LocalConstance.bankCard)
                //   SvgPicture.asset(
                //     "assets/svgs/bank_card_icon.svg",
                //     color: builder.selectedPaymentMethod?.id == paymentMethod.id
                //         ? colorBackground
                //         : colorHint,
                //   ),
                // if (paymentMethod.id == LocalConstance.cash)
                //   SvgPicture.asset(
                //     "assets/svgs/cash_icon.svg",
                //     color: builder.selectedPaymentMethod?.id == paymentMethod.id
                //         ? colorBackground
                //         : colorHint,
                //   ),
                // if (paymentMethod.id == LocalConstance.wallet)
                //   SvgPicture.asset(
                //     "assets/svgs/wallet_icon.svg",
                //     color: builder.selectedPaymentMethod?.id == paymentMethod.id
                //         ? colorBackground
                //         : colorHint,
                //   ),

                SizedBox(
                  width: sizeW5,
                ),
                CustomTextView(
                  txt: "${paymentMethod.name}",
                  textStyle: builder.selectedPaymentMethod?.id ==
                          paymentMethod.id
                      ? textStylebodyWhite()
                      : textStyleHints()!
                          .copyWith(fontSize: fontSize14, color: colorHint2),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void doOnRecivedOrderPayment() async {
    if (homeViewModel.operationTask.totalDue == 0) {
      snackError("", "There is no due");
      return;
    }
    num sendedWattingFeesOrCancellation = -1;
    String sendedWattingFeesOrCancellationReson = "";

    if ((homeViewModel.operationTask.waitingTime ?? 0) > 0) {
      sendedWattingFeesOrCancellation =
          homeViewModel.operationTask.waitingTime ?? 0;
      sendedWattingFeesOrCancellationReson = "waiting fees";
    } else if ((homeViewModel.operationTask.cancellationFees ?? 0) > 0) {
      sendedWattingFeesOrCancellation =
          homeViewModel.operationTask.cancellationFees ?? 0;
      sendedWattingFeesOrCancellationReson = "cancellation";
    }
    if (paymentMethod.name == LocalConstance.cash) {
      // homeViewModel.applyPayment(
      //     salesOrder: homeViewModel.operationTask.salesOrder ?? "",
      //     paymentMethod: paymentMethod.name ?? "",
      //     paymentId: "",
      //     extraFees: sendedWattingFeesOrCancellation,
      //     reason: sendedWattingFeesOrCancellationReson);
    } else if (paymentMethod.name == LocalConstance.wallet) {
      if ((num.tryParse(profileViewModle.myWallet.balance.toString()) ?? 0) >
          (homeViewModel.operationTask.totalDue ?? 0)) {
        homeViewModel.applyPayment(
            salesOrder: homeViewModel.operationTask.salesOrder ?? "",
            paymentMethod: paymentMethod.name ?? "",
            paymentId: "",
            extraFees: sendedWattingFeesOrCancellation,
            reason: sendedWattingFeesOrCancellationReson);
      } else {
        snackError("", "Wallet Balance is not enough");
      }
    } else if (paymentMethod.name == LocalConstance.bankCard) {
      // await storageViewModel.payApplicationFromPaymentGatewaye(
      //     price: homeViewModel.operationTask.totalDue ?? 0);
    } else if (paymentMethod.name == LocalConstance.creditCard) {
      await storageViewModel.payApplicationFromPaymentGatewaye(
          price: homeViewModel.operationTask.totalDue ?? 0);
    }
  }
}
// watting fees > 0 watting fees::
// canclation fees > 0 canclation::
//