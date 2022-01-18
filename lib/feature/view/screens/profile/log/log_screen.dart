import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/screens/profile/log/widgets/log_item.dart';
import 'package:inbox_clients/feature/view/screens/profile/log/widgets/log_recall_item.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleWidget: Text(tr.log ,  style: textStyleAppBarTitle(),),
        isCenterTitle: true,
      ),

    body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding20!) , 
        child: ListView(
          children: [
            SizedBox(height: sizeH10,),
            LogItem(),
            SizedBox(height: sizeH10,),
            LogRecallItem(),
            SizedBox(height: sizeH10,),
          ],
        ),
        ),
    );
  }
}