import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({Key? key}) : super(key: key);

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
                    bottom: -5,
                    start: 30,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: scaffoldColor,
                      ),
                      height: sizeH40,
                      width: sizeW40,
                      child: GetBuilder<StorageViewModel>(
                        init: StorageViewModel(),
                        initState: (_) {},
                        builder: (logic) {
                          return Text(
                            "${logic.quantity}",
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    )),
                PositionedDirectional(
                    bottom: -10,
                    end: 1,
                    child: GetBuilder<StorageViewModel>(
                      init: StorageViewModel(),
                      initState: (_) {},
                      builder: (builder) {
                        return IconButton(
                          icon:
                              SvgPicture.asset("assets/svgs/circle_mines.svg"),
                          onPressed: () {
                            builder.minesQuantity();
                          },
                        );
                      },
                    )),
                PositionedDirectional(
                    bottom: -10,
                    end: 50,
                    child: GetBuilder<StorageViewModel>(
                      init: StorageViewModel(),
                      initState: (_) {},
                      builder: (value) {
                        return IconButton(
                          icon: SvgPicture.asset("assets/svgs/circle_add.svg"),
                          onPressed: () {
                            value.increaseQuantity();
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
