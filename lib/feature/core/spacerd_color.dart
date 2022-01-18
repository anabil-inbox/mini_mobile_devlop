import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class SpacerdColor extends StatelessWidget {
  const SpacerdColor({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeH5,
      width: sizeW50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(padding6!),
        color: scaffoldColor,
      ),
      child: const SizedBox(),
    );
  }
}