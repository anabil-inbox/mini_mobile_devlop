import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/signature_item.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/signature_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';

class CustomerSignatureInstantOrder extends StatelessWidget {
  const CustomerSignatureInstantOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizeW15!, vertical: sizeH13!),
      decoration: BoxDecoration(
        color: colorTextWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpandablePanel(
        theme: const ExpandableThemeData(
          hasIcon: false,
          alignment: Alignment.topLeft,
          tapHeaderToExpand: true,
        ),
        header: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorBtnGray.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(padding4!),
              child: Transform.rotate(
                angle: 180 * math.pi / 180,
                child: Icon(
                  Icons.keyboard_arrow_up,
                  color: colorBlack,
                  size: 20,
                ),
              ),
            ),
            SizedBox(width: sizeW10),
            CustomTextView(
              txt: "CustomerSignature",
              textStyle: textStyleNormal()?.copyWith(color: colorBlack),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                // Get.to(() => const ScanScreen(
                //       isBoxSalesScan: false,
                //       isProductScan: false,
                //     ));
              },
              child: SvgPicture.asset("assets/svgs/Scan.svg",
                  color: colorRed, width: sizeW20, height: sizeH17),
            ),
          ],
        ),
        collapsed: const SizedBox.shrink(),
        expanded: Column(
          children: [
            SizedBox(height: sizeH14),
            card,
            SizedBox(height: sizeH14),
          ],
        ),
      ),
    );
  }

  Widget get card => Column(
        children: [
          SignatureItem(
            title: Constance.onDriverSide,
            onSelected: () {},
          ),
          SizedBox(height: sizeH10),
          SignatureItem(
            title: Constance.onClientSide,
            onSelected: () {
              SignatureBottomSheet.showSignatureBottomSheet();
            },
          ),
          SizedBox(height: sizeH10),
          SignatureItem(
            title: LocalConstance.fingerprint,
            onSelected: () {
              SignatureBottomSheet.homeViewModel.signatureWithTouchId();
            },
          ),
          SizedBox(height: sizeH10),
        ],
      );
}
