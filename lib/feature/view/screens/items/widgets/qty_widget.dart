// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class QtyWidget extends StatelessWidget {
  QtyWidget({Key? key, this.isItemQuantity = false, this.boxItem})
      : super(key: key);

  final bool isItemQuantity;
  BoxItem? boxItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeH50,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(padding6!),
          border: Border.all(color: colorBorderContainer)),
      child: Row(
        children: [
          SizedBox(
            width: sizeW15,
          ),
          Text("Quantity"),
          const Spacer(),
          Container(
            width: sizeH100,
            height: sizeH30,
            child: Stack(
              children: [
                PositionedDirectional(
                    bottom: padding4! * -1,
                    start: padding30,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: scaffoldColor,
                      ),
                      height: sizeH40,
                      width: sizeW40,
                      child: GetBuilder<ItemViewModle>(
                        init: ItemViewModle(),
                        initState: (_) {},
                        builder: (logic) {
                          if (isItemQuantity) {
                            return Text(
                              "${boxItem?.itemQuantity ?? 1}",
                              textAlign: TextAlign.center,
                            );
                          } else {
                            return Text(
                              "${logic.itemQuantity}",
                              textAlign: TextAlign.center,
                            );
                          }
                        },
                      ),
                    )),
                PositionedDirectional(
                    bottom: padding10! * -1,
                    end: padding1,
                    child: GetBuilder<ItemViewModle>(
                      init: ItemViewModle(),
                      initState: (_) {},
                      builder: (builder) {
                        return IconButton(
                          icon:
                              SvgPicture.asset("assets/svgs/circle_mines.svg"),
                          onPressed: () {
                            if (isItemQuantity) {
                              int qty = int.parse(boxItem?.itemQuantity ?? "1");
                              if (qty > 1) {
                                qty--;
                              }
                              boxItem?.itemQuantity = qty.toString();
                              builder.update();
                            } else {
                              builder.minesQty();
                            }
                          },
                        );
                      },
                    )),
                PositionedDirectional(
                    bottom: padding10! * -1,
                    end: padding52,
                    child: GetBuilder<ItemViewModle>(
                      init: ItemViewModle(),
                      initState: (_) {},
                      builder: (value) {
                        return IconButton(
                          icon: SvgPicture.asset("assets/svgs/circle_add.svg"),
                          onPressed: () {
                            if (isItemQuantity) {
                              int qty = int.parse(boxItem?.itemQuantity ?? "1");
                              qty++;
                              boxItem?.itemQuantity = qty.toString();
                              value.update();
                            } else {
                              value.increaseQty();
                            }
                          },
                        );
                      },
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
