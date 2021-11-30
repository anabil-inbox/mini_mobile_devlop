import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class BottomSheetDetaielsWidget extends StatelessWidget {
  const BottomSheetDetaielsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(padding30!)),
        color: colorTextWhite,
      ),
      child: Column(
        children: [
          SizedBox(height: sizeH20,),
          Container(
            height: sizeH5,
           
            decoration: BoxDecoration(
              color: colorTextHint1,

            ),
          ),
          Text("Regular Box"),
        ],
      ),
    );
  }
}
