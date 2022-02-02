import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/storage/payment.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class PaymentItem extends StatelessWidget {
  const PaymentItem({Key? key, required this.paymentMethod}) : super(key: key);

  final PaymentMethod paymentMethod;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StorageViewModel>(
      init: StorageViewModel(),
      initState: (_) {},
      builder: (builder) {
        return InkWell(
          onTap: () {
            builder.selectedPaymentMethod = paymentMethod;
            builder.update();
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
            child: CustomTextView(txt: "${paymentMethod.name}" , 
            textStyle:  builder.selectedPaymentMethod?.id == paymentMethod.id
                    ? textStylebodyWhite()
                    : textStyleHints()!
                        .copyWith(fontSize: fontSize14, color: colorHint2),),
          ),
        );
      },
    );
  }
}
