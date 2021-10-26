import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class HeaderCodeVerfication extends StatelessWidget {
  const HeaderCodeVerfication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeH174,
      child: Stack(
        children: [
          PositionedDirectional(
            top: padding0,
            bottom: padding0,
            start: padding0,
            end: padding0,
            child: SvgPicture.asset(
              "assets/svgs/header_background.svg",
               fit: BoxFit.cover
            ),
          ),
          PositionedDirectional(
              top: padding40,
              start:padding20,
              child: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/svgs/back_arrow.svg"),
          )),
          
          
        ],
      ),
    );
  }
}
