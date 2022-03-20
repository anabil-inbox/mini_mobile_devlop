import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

import '../../../../../util/app_shaerd_data.dart';

class SettingItem extends StatelessWidget {
  const SettingItem(
      {Key? key,
      required this.iconPath,
      required this.settingTitle,
      required this.trailingTitle,
      required this.onTap})
      : super(key: key);

  final String settingTitle;
  final String trailingTitle;
  final String iconPath;
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
          leading: iconPath.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeH4!),
                  child: CircleAvatar(
                    child: SvgPicture.asset("$iconPath"),
                  ),
                )
              : const SizedBox(),
          contentPadding: EdgeInsets.all(0),
          trailing: Container(
           // color: colorBlack,
            width: sizeW100,
            height: sizeH100,
            child: Row(
              children: [
                 const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                SizedBox(width: sizeW10,)
              ],
            ),
          )),
    );
  }
}
