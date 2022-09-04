import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';

import '../../../../../util/app_shaerd_data.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({Key? key , this.status, this.child,required this.statusOriginal, }) : super(key: key);

  final String? status;
  final Widget? child;
  final  String? statusOriginal;//statusOriginal

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
     // margin: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(padding6!)),
      child: Column(
        children: [
          SizedBox(
            height: sizeH14,
          ),
          Row(
            children: [
              SizedBox(
                width: sizeW15,
              ),
              Text(tr.status),
              const Spacer(),
              if(GetUtils.isNull(child))...[

                TextButton(
                    style:  statusOriginal == LocalConstance.orderDraft || statusOriginal == LocalConstance.processing
                        ? buttonStyleBackgroundClicable
                        : statusOriginal == LocalConstance.cancelled ? buttonStyleBackgroundGreen.copyWith(backgroundColor:MaterialStateProperty.all(errorColor.withOpacity(0.1))) : buttonStyleBackgroundGreen,
                    onPressed: () {},
                    child: Text("$status" ,style: statusOriginal == LocalConstance.orderDraft || statusOriginal == LocalConstance.processing
                        ? textStyleSmall()?.copyWith(color: colorPrimary)
                        : statusOriginal == LocalConstance.cancelled ? textStyleSmall()?.copyWith(color: errorColor): textStyleSmall()?.copyWith(color: colorGreen),))
              ]else ...[
               child!,
              ],
              SizedBox(
                width: sizeW24,
              ),
            ],
          ),
          SizedBox(
            height: sizeH14,
          ),
        ],
      ),
    );
  }
}
