import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/cart/store/store_view.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/cart_view_model/cart_view_model.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';

import 'widgets/cart_head.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  var cartViewModel = Get.put<CartViewModel>(CartViewModel(), permanent: true);

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
          InkWell(
              onTap: _goToStoreView,
              child: SvgPicture.asset("assets/svgs/store.svg")),
          SizedBox(
            width: sizeW10,
          ),
        ],
      ),
      body: GetBuilder<CartViewModel>(
          init: CartViewModel(),
          initState: (state) {
            cartViewModel.getMyCart();
          },
          builder: (logic) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeH20!),
              child: Column(
                children: [
                  SizedBox(
                    height: sizeH20,
                  ),
                   if(!GetUtils.isNull(logic.cartList)  && logic.cartList.length != 0)
                  Expanded(
                    child: ListView.builder(
                      itemCount: logic.cartList.length,
                      shrinkWrap: true,
                      physics: customScrollViewIOS(),
                      itemBuilder: (context, index) => CartHead(cartViewModel:logic,cartModel:logic.cartList[index]),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  void _goToStoreView() {
    Get.to(() => StoreView());
  }
}
