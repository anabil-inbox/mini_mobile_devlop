import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class MyOrderBoxItem extends StatelessWidget {
  const MyOrderBoxItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: padding10!),
      decoration: BoxDecoration(
        color: colorBackground,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: sizeW10,
          ),
          SvgPicture.asset("assets/svgs/folder_icon.svg"),
          SizedBox(
            width: sizeW10,
          ),
          Text("Regular Box"),
          
        ],
      ),
    );
  }
}
