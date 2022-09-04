// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view_model/cart_view_model/cart_view_model.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/local_database/model/cart_model.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:logger/logger.dart';

import '../../../../../../util/app_shaerd_data.dart';

class BoxInSalesOrder extends StatelessWidget {
  BoxInSalesOrder({
    Key? key,
    required this.box,
    required this.boxess,
    this.isFromCart,
    this.cartViewModel, this.cartModel,
  }) : super(key: key);

  final Box box;
  final List<Box> boxess;
  final bool? isFromCart;
  final CartViewModel? cartViewModel;
  final CartModel? cartModel;
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  // static CartViewModel cartViewModel = Get.find<CartViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      initState: (_) {},
      builder: (_) {
        return InkWell(
          onTap: () {
            if (isFromCart! && !GetUtils.isNull(cartViewModel) && cartModel != null ) {
              if((cartViewModel?.cartList.where((element) => element.id == cartModel?.id).first.box?.length)! > 1){
                cartViewModel?.cartList.where((element) => element.id == cartModel?.id).first.box?.remove(box);
                cartViewModel?.update();
              }else{
                snackError("", tr.cant_remove);
              }
            }else {
              homeViewModel.selctedOperationsBoxess.remove(box);
              // cartViewModel.cartList
              boxess.remove(box);
              if (homeViewModel.selctedOperationsBoxess.length == 0 && !isFromCart!) {
                Get.back();
              }
              homeViewModel.update();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: sizeH22,
                ),
                Stack(
                  children: [
                    SvgPicture.asset("assets/svgs/folder_icon.svg"),
                    PositionedDirectional(
                        top: padding4,
                        end: padding4,
                        start: padding4,
                        bottom: padding4,
                        child: SvgPicture.asset("assets/svgs/delete_cross.svg"))
                  ],
                ),
                SizedBox(
                  height: sizeH6,
                ),
                Text("${box.storageName}"),
                SizedBox(
                  height: sizeH2,
                ),
                SizedBox(
                  height: sizeH16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
