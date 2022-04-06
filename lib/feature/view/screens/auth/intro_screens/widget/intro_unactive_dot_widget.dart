import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';

import '../../../../../../util/app_shaerd_data.dart';

class IntroUnActiveDot extends StatelessWidget {
  const IntroUnActiveDot({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colorUnSelectedWidget,
      ),
      child: SizedBox(
        width: 11,
        height: 3,
      ),
    );
  }
}
