import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_style.dart';

import '../../../../../util/app_shaerd_data.dart';

class ResivingNewStorageWidget extends StatelessWidget {
  const ResivingNewStorageWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      decoration: containerBoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            Text("data")
        ],
      ),
    );
  }
}