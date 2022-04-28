import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

import '../../../../../../../util/app_shaerd_data.dart';

class BulkItemWidget extends StatelessWidget {
  const BulkItemWidget(
      {Key? key,
      required this.title,
      required this.deleteFunction,
      required this.quantity
      })
      : super(key: key);

  final String title;
  final Function deleteFunction;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          children: [
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(padding6!),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(padding6!),
                  color: colorUnSelectedWidget,
                ),
                child: Row(
                  children: [
                    Text("$title"),
                    SizedBox(
                      width: sizeW10,
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: padding10!, vertical: padding3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(padding6!),
                          color: colorTextWhite,
                        ),
                        child: Text("$quantity"))
                  ],
                )),
            SizedBox(
              width: sizeW10,
            )
          ],
        ),
        PositionedDirectional(
            end: padding4,
            top: padding6! * -1,
            child: InkWell(
                onTap: () {
                  deleteFunction();
                },
                child: SvgPicture.asset("assets/svgs/close.svg" , 
                height: sizeH20,
                width: sizeW20,
                )))
      ],
    );
  }
}
