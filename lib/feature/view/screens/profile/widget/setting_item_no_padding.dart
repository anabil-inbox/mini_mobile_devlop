import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

import '../../../../../util/app_shaerd_data.dart';

class SettingItemNoPadding extends StatelessWidget {
  const SettingItemNoPadding({Key? key ,required this.settingTitle, required this.onTap}) : super(key: key);

  final String settingTitle;
  final Function onTap;
  
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: sizeH20!),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: colorTextWhite, borderRadius: BorderRadius.circular(4)),
      child: ListTile(
          onTap: () {
            onTap();
          },
          title: Text("$settingTitle"),
          
          contentPadding: EdgeInsets.symmetric(horizontal: sizeH16!),
          trailing: Icon(Icons.arrow_forward_ios , size: 14,color: colorBlack,)      
    )
    );
  }
}