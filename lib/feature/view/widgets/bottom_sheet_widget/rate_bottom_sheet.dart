// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

import '../custome_text_view.dart';
import '../primary_button.dart';

class RateBottomSheet extends StatelessWidget {
  RateBottomSheet({Key? key, required this.orderSales}) : super(key: key);

  //final TaskResponse? taskResponse;
  static final TextEditingController _noteController = TextEditingController();
  final OrderSales orderSales;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<HomeViewModel>(builder: (logic) {
      return SingleChildScrollView(
        primary: true,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(padding30!)),
            color: colorTextWhite,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: sizeH20),
              SvgPicture.asset('assets/svgs/Indicator.svg'),
              SizedBox(height: sizeH20),
              CustomTextView(
                txt: tr.add_review,
                textStyle: textStyleNormal()
                    ?.copyWith(fontSize: fontSize18, color: colorBlack),
              ),
              SizedBox(height: sizeH14),
              RatingBar.builder(
                initialRating: logic.ratingService,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: colorPrimary,
                ),
                onRatingUpdate: (rating) => logic.onRatingUpdate(rating),
              ),
              SizedBox(height: sizeH14),
              CustomTextFormFiled(
                controller: _noteController,
                label: tr.note_review,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                isSmallPadding: true,
                isSmallPaddingWidth: true,
                isBorder: true,
                fillColor: colorBtnGray.withOpacity(0.3),
                isFill: true,
                minLine: 5,
                maxLine: 1000,
              ),
              SizedBox(height: sizeH20),
              PrimaryButton(
                  textButton: tr.add,
                  isLoading: logic.isLoading,
                  colorBtn: colorPrimary,
                  onClicked: () {
                    logic.addReview(orderSales, _noteController);
                  },
                  isExpanded: true),
              SizedBox(height: sizeH40),
            ],
          ),
        ),
      );
    });
  }
}
