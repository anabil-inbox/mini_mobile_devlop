import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({Key? key , this.status}) : super(key: key);

  final String? status;
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
              TextButton(
                  style: buttonStyleBackgroundClicable,
                  onPressed: () {},
                  child: Text("$status")),
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
