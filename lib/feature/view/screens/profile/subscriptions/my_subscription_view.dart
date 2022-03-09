import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/profile/subscriptions/widget/my_subscription_item.dart';
import 'package:inbox_clients/feature/view/widgets/icon_btn.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

class MySubscriptionsView extends StatelessWidget {
  const MySubscriptionsView({Key? key}) : super(key: key);

  PreferredSizeWidget get myAppbar =>  AppBar(
    automaticallyImplyLeading: true,
    elevation: 1,
    title: Text(
      "${tr.my_subscriptions}",
      style: textStyleAppBarTitle(),
    ),
    leading: IconButton(
      onPressed: () {
        Navigator.pop(Get.context!);
      },
      icon: isArabicLang()?SvgPicture.asset("assets/svgs/back_arrow_ar.svg"):SvgPicture.asset("assets/svgs/back_arrow.svg"),
    ),
    centerTitle: true,
    backgroundColor: colorBackground,
    actions: [
      IconBtn(
        onPressed: () {
        },
        icon:  "assets/svgs/list.svg",
        height: sizeH30,
        width: sizeW30,
        backgroundColor: colorTextWhite,
        borderColor: colorTextWhite,
        iconColor: colorBlack,
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: myAppbar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MySubscriptionsItem(),
        ],
      ),
    );
  }
}
