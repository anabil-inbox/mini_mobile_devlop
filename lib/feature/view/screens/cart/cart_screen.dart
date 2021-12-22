import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_clients/feature/view/screens/add_item/widgets/notifay_for_new_storage.dart';
import 'package:inbox_clients/feature/view/screens/cart/widgets/cart_head.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.bottomSheet(
          //  // NotifayForNewStorage(),
          //   isScrollControlled: true
          // );
        },
      ),
      appBar: CustomAppBarWidget(
        isCenterTitle: true,
        titleWidget: CustomTextView(
          txt: "Cart",
          textStyle: textStyleAppBarTitle(),
          maxLine: Constance.maxLineOne,
        ),
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
}
