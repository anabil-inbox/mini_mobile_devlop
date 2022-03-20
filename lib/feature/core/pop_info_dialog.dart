
import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class PopInfoDialog extends StatelessWidget {
  final String? title, subTitle;

  const PopInfoDialog({
    Key? key,
    this.title,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
   screenUtil(context);
    return PopupMenuButton(
      tooltip: "${formatStringWithCurrency(title, "")}",

      child: Icon(Icons.info_outline , color: colorBlack,),
      offset: Offset(150,-70),
      itemBuilder: (context) {
        return List.generate(1, (index) {
          return PopupMenuItem(
            child: Text('${formatStringWithCurrency(title, "")}'),
          );
        });
      },
    );
  }
}