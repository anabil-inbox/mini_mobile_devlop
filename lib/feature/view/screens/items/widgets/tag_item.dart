import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class TagItem extends StatelessWidget {
  const TagItem({Key? key, required this.text , required this.onTap}) : super(key: key);

  final String text;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(padding6!),
        decoration: BoxDecoration(
          color: colorPrimary.withAlpha(70),
          border: Border.all(color: colorBorderContainer),
          borderRadius: BorderRadius.circular(padding12!),
        ),
        child: Text("$text  X" , style: textStylePrimarySmall(),),
      ),
    );
  }
}
