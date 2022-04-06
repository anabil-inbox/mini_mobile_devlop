import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

import '../../../storage/new_storage/widgets/step_three_widgets/payment_widget.dart';

class Balance extends StatelessWidget {
  const Balance({Key? key}) : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<HomeViewModel>(
      builder: (_) {
        return Container(
          padding:
              EdgeInsets.symmetric(horizontal: sizeW15!, vertical: sizeH13!),
          decoration: BoxDecoration(
            color: colorTextWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              CustomTextView(
                txt: tr.boxes,
                textStyle: textStyleNormal()?.copyWith(color: colorBlack),
              ),
              SizedBox(height: sizeH13),
              Row(
                children: [
                  CustomTextView(
                    txt: tr.total,
                    textStyle: textStyleNormal(),
                  ),
                  const Spacer(),
                  CustomTextView(
                    txt: getPriceWithFormate(
                        price: homeViewModel.operationTask.total ?? 0),
                    textStyle: textStyleMeduimPrimaryBold(),
                  ),
                ],
              ),
              SizedBox(height: sizeH14),
              Row(
                children: [
                  CustomTextView(
                    txt: tr.paid,
                    textStyle: textStyleNormal(),
                  ),
                  const Spacer(),
                  CustomTextView(
                    txt: getPriceWithFormate(
                        price: homeViewModel.operationTask.totalPaid ?? 0),
                    textStyle: textStyleMeduimPrimaryBold(),
                  ),
                ],
              ),
              SizedBox(height: sizeH14),
              Row(
                children: [
                  CustomTextView(
                    txt: tr.amount_due,
                    textStyle: textStyleNormal(),
                  ),
                  const Spacer(),
                  CustomTextView(
                    txt: getPriceWithFormate(
                        price: homeViewModel.operationTask.totalDue ?? 0),
                    textStyle: textStyleMeduimPrimaryBold(),
                  ),
                ],
              ),
              SizedBox(height: sizeH22),
              const PaymentWidget(
                isRecivedOrderPayment: true,
              ),
            ],
          ),
        );
      },
    );
  }
}
