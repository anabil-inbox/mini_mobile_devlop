import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeH75,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: sizeH20! , vertical: sizeH5!),
      decoration: BoxDecoration(
          color: colorTextWhite, borderRadius: BorderRadius.circular(sizeH6!)),
      child: Row(
        children: [
          SizedBox(
            width: sizeW15,
          ),
          SvgPicture.asset("assets/svgs/notification_icon.svg"),
          SizedBox(
            width: sizeW10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextView(
                txt : "Lorem ipsum dolor sit ametconsectetur"
                ),
              SizedBox(
                width: sizeW2,
              ),
              Text("Mar 13, 2018", style: smallHintTextStyle(), )
            ],
          )
        ],
      ),
    );
  }
}
