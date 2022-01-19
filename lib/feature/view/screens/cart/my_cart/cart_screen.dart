import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/cart/store/store_view.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';

import 'widgets/cart_head.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Get.bottomSheet(
      //     //  // NotifayForNewStorage(),
      //     //   isScrollControlled: true
      //     // );
      //   },
      // ),
      appBar: CustomAppBarWidget(
        isCenterTitle: true,
        titleWidget: CustomTextView(
          txt: "${tr.cart}",
          textStyle: textStyleAppBarTitle(),
          maxLine: Constance.maxLineOne,
        ),
        actionsWidgets: [
          InkWell(onTap: _goToStoreView,child: SvgPicture.asset("assets/svgs/store.svg")),
          SizedBox(width: sizeW10,),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeH20!),
        child: Column(
          children: [
            SizedBox(
              height: sizeH20,
            ),
            CartHead(),
          ],
        ),
      ),
    );
  }

  void _goToStoreView() {
      Get.to(()=> StoreView());
  }
}
