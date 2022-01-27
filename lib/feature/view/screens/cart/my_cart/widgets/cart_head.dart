import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/feature/view_model/cart_view_model/cart_view_model.dart';
import 'package:inbox_clients/local_database/model/cart_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class CartHead extends StatelessWidget {
  const CartHead({Key? key, this.cartModel, this.cartViewModel,  }) : super(key: key);
  final CartModel? cartModel;
  final CartViewModel? cartViewModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(padding6!)),
      child: Column(
        children: [
           SizedBox(height: sizeH16,),
           Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: sizeW10,
              ),
              SvgPicture.asset("assets/svgs/folder_icon.svg"),
              SizedBox(
                width: sizeW10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("${cartModel?.title}"),
                      SizedBox(width: sizeW5),
                      Text("100 QR",style: textStylePrimarySmall(),),
                      
                    ],
                  ),
                  Text(
                    "${cartModel?.address?.title}",
                    style: textStyleHints()!.copyWith(fontSize: fontSize13),
                  ),
                  Text(
                    "${cartModel?.orderTime?.delivery}"/*Mar 13, 2018*/,
                    style: textStyleHints()!.copyWith(fontSize: fontSize13),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: _deleteCartItem ,
                child: ClipOval(
                  child: SvgPicture.asset(
                    "assets/svgs/delete_box_widget.svg",
                    fit: BoxFit.cover,
                    width: sizeW36,
                  ),
                ),
              ),
            ],
          ),
           SizedBox(height: sizeH18,),
        ],
      ),
    );
  }

  void _deleteCartItem() {
  cartViewModel?.deleteItemCart(cartModel!);
  }
}
