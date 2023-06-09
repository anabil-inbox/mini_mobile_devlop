import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/cart/store/store_view.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/bottom_sheet_payment_cart_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/cart_view_model/cart_view_model.dart';
import 'package:inbox_clients/feature/view_model/product_view_model/product_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
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
    screenUtil(context);
    return Scaffold(
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
              child: SvgPicture.asset("assets/svgs/store.svg", color: colorPrimary,)),
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
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeH20!),
                  child: Column(
                    children: [
                      SizedBox(
                        height: sizeH20,
                      ),
                      if (!GetUtils.isNull(logic.cartList) &&
                          logic.cartList.length != 0)
                        Expanded(
                          child: ListView.builder(
                            itemCount: logic.cartList.length,
                            shrinkWrap: true,
                            clipBehavior: Clip.hardEdge,
                            physics: customScrollViewIOS(),
                            itemBuilder: (context, index) => CartHead(
                                cartViewModel: logic,
                                cartModel: logic.cartList[index]),
                          ),
                        ),
                      SizedBox(
                        height: sizeH20,
                      ),
                    ],
                  ),
                ),
                if (!GetUtils.isNull(logic.cartList) &&
                    logic.cartList.length != 0)
                Positioned(
                  bottom: padding20,
                  right: padding20,
                  left: padding20,
                  child: PrimaryButton(
                      textButton: "${tr.checkout}",
                      isLoading: cartViewModel.isLoading,
                      onClicked: cartViewModel.cartList.isNotEmpty
                          ? () async {
                              setupPaymentCart();
                            }
                          : () {},
                      isExpanded: true),
                )
              ],
            );
          }),
    );
  }

  void _goToStoreView() {
    Get.put(ProductViewModel());
    Get.to(() => StoreView());
  }

  void setupPaymentCart() {
    Get.bottomSheet(
        BottomSheetPaymentCartWidget(
          cartModels: cartViewModel.cartList,
        ),
        isScrollControlled: true);
  }
}
