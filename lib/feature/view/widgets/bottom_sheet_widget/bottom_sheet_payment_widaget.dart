import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/storage/payment.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_three_widgets/payment_item.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/viedo_player.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:inbox_clients/util/sh_util.dart';

import '../primary_button.dart';

class BottomSheetPaymentWidget extends StatelessWidget {

  const BottomSheetPaymentWidget(
      {Key? key, })
      : super(key: key);



  Widget get priceTotalWidget => Container(
    width: double.infinity,
    decoration: BoxDecoration(
        color: scaffoldColor,
        borderRadius: BorderRadius.circular(padding6!)),
    margin: EdgeInsets.symmetric(horizontal: sizeH10!),
    padding: EdgeInsets.symmetric(horizontal: sizeH20!),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: sizeH22,
        ),
        CustomTextView(
          txt: "${tr.total}",
          textAlign:TextAlign.center ,
          textStyle: textStyleAppBarTitle()?.copyWith(fontSize: fontSize20),
        ),
        SizedBox(
          height: sizeH2,
        ),
        CustomTextView(
          txt: "50.00 QR",
          textAlign:TextAlign.center ,
          textStyle: textStyleAppBarTitle()?.copyWith(fontSize: fontSize28 ,color: colorPrimary),
        ),
        SizedBox(
          height: sizeH2,
        ),
        CustomTextView(
          txt: "${tr.other_services_eparately}",
          textAlign:TextAlign.center ,
          textStyle: textStyleNormal()?.copyWith(fontSize: fontSize14),
        ),
        SizedBox(
          height: sizeH20,
        ),
      ],
    ),
  );

  Widget get acceptTerms=> GetBuilder<StorageViewModel>(
    init: StorageViewModel(),
    builder: (value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              value.isAccept = !value.isAccept;
              value.update();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                value.isAccept
                    ? SvgPicture.asset("assets/svgs/check.svg")
                    : SvgPicture.asset("assets/svgs/uncheck.svg",
                  color: seconderyColor,
                ),
                SizedBox(
                  width: 10,
                ),
                CustomTextView(
                  txt: "${tr.redeem_points} ",
                  textStyle: textStyle(),
                )
              ],
            ),
          ),
          CustomTextView(
            txt: "500 ${tr.points}",
            textAlign: TextAlign.start,
            textStyle: textStyleNormal()!.copyWith(
                color: colorBlack, fontSize: fontSize14),
          ),
        ],
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(padding30!)),
          color: colorTextWhite,
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: sizeW15!),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: sizeH20,
              ),
              SpacerdColor(),
              SizedBox(
                height: sizeH20,
              ),
              CustomTextView(
                txt: "${tr.payment_method}",
                textAlign:TextAlign.center ,
                textStyle: textStyleAppBarTitle(),
              ),
              SizedBox(
                height: sizeH20,
              ),
              priceTotalWidget,
              SizedBox(
                height: sizeH16,
              ),
              Text("${tr.select_payment_method}"),
              SizedBox(
                height: sizeH16,
              ),
              Container(
                height: sizeH38,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: getPaymentMethod().map((e) => PaymentItem(paymentMethod: e,)).toList(),
                ),
              ),
              SizedBox(
                height: sizeH16,
              ),
              acceptTerms,
              SizedBox(
                height: sizeH16,
              ),
              PrimaryButton(
                isExpanded: true,
                isLoading: false,
                onClicked: onClickSubmit,
                textButton: "${tr.submit}",
              ),
              SizedBox(
                height: sizeH16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  onClickSubmit(){}
}
