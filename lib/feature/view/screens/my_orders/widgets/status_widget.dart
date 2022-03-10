import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({Key? key , this.status, this.child, }) : super(key: key);

  final String? status;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
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
              Text("Status"),
              const Spacer(),
              if(GetUtils.isNull(child))...[
                TextButton(
                    style: buttonStyleBackgroundClicable,
                    onPressed: () {},
                    child: Text("$status"))
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
