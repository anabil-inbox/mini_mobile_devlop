import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import '../../../util/app_shaerd_data.dart';

class PrimaryBorderButton extends StatelessWidget {
  const PrimaryBorderButton({Key? key , required this.buttonText , required this.function}) : super(key: key);

  final String buttonText;
  final Function function;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      width: double.infinity,
      height: sizeH40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(padding6!),
        border: Border.all(color: colorPrimary)
      ),
      child: TextButton(
       style: borderPrimaryButtonStyle,
        onPressed: () {
          function();
        }, 
        child: Text("$buttonText" , style: textStyleBorderButton(),)),
    );
  }
}
