import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        loading(),
      ],
    );
  }

  Widget loading() {
    return Center(
      
      child: SvgPicture.asset(
        'assets/svgs/qatar_flag.svg',
        width: sizeW40,
        height: sizeH40,
      ),
    );
  }
}
