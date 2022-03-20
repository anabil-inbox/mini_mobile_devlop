import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

import '../../../../../../util/app_shaerd_data.dart';

class BoxDetailsWidget extends StatelessWidget {
  const BoxDetailsWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: sizeH16,),
          SpacerdColor(),
          SizedBox(height: sizeH12,),
          Text("Box Name"),
          SizedBox(height: sizeH12,),
          Text("data"),
          

        ],
      ),
    );
  }
}