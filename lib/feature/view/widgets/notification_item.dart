import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/fcm/app_fcm.dart';
import 'package:inbox_clients/feature/model/home/notification_data.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';

import '../../../util/app_shaerd_data.dart';
import '../../../util/date_time_util.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key, this.notification, }) : super(key: key);
  final NotificationData? notification;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return InkWell(
      onTap: _onItemClick,
      child: Container(
       padding: EdgeInsets.symmetric(horizontal: sizeW12! , vertical:  sizeH12!),
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: sizeH20! , vertical: sizeH5!),
        clipBehavior: Clip.hardEdge,
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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextView(
                    txt : notification?.title.toString(),
                    textStyle: textStyleAppbar()!.copyWith(
                      fontSize: 14
                    )
                    ),
                  SizedBox(
                    height: sizeW2,
                  ),
                  Container(
                    child: CustomTextView(
                        txt : notification?.message.toString(),
                        maxLine: Constance.maxLineTwo,
                      textOverflow:TextOverflow.ellipsis ,
                      textStyle: textStyleMeduimBlackText(),
                      
                    ),
                  ),
                  SizedBox(
                    height: sizeW2,
                  ),
                  Text(DateUtility.dateFormatNamed(txtDate: notification?.date.toString()), style: smallHintTextStyle(), )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onItemClick() {
    AppFcm.goToOrderPage(notification!.toJson(), isFromTerminate: false);
  }
}
