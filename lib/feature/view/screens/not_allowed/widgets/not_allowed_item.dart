import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class NotAllowedItem extends StatelessWidget {
  const NotAllowedItem({Key? key, required this.notAllowed}) : super(key: key);

  final NotAllowed? notAllowed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding9!),
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(padding6!)),
      child: imageNetwork(url: notAllowed?.image),
    );
  }
}
