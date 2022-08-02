import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:inbox_clients/util/string.dart';

import '../../../../util/app_shaerd_data.dart';

class AddMoneyBottomSheet extends StatelessWidget {
  const AddMoneyBottomSheet({Key? key, this.isLoading = false, }) : super(key: key);
  final bool? isLoading;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return SingleChildScrollView(
        primary: true,
        child: GetBuilder<ProfileViewModle>(
            init: ProfileViewModle(),
            builder: (logic) {
              return Container(
                height: 250,
                padding: EdgeInsets.symmetric(horizontal: 20),
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
                      txt: txtAddAmount,
                      textStyle: textStyleNormal()
                          ?.copyWith(fontSize: fontSize18, color: colorBlack),
                    ),
                    SizedBox(height: sizeH14),
                    CustomTextFormFiled(
                      controller: logic.amountController,
                      isBorder: false,
                      isSmallPaddingWidth: false,
                      isSmallPadding: false,
                      textInputAction: TextInputAction.done,
                      fillColor: colorBtnGray.withOpacity(0.4),
                      isFill: true,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: sizeH20),
                    PrimaryButton(
                        textButton: txtADD!,
                        isLoading: logic.isLoading,
                        onClicked: () {
                          logic.depositMoneyToWallet();
                        },
                        isExpanded: true)
                  ],
                ),
              );
            }));
  }
}
