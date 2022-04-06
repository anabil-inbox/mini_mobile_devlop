import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/widgets/notification_item.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    screenUtil(context);
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: colorTextWhite,
        toolbarHeight: sizeH90,
        elevation: 1,
        title: TextFormField(
          decoration: InputDecoration(
              border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(padding6!)),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(18),
                child: SvgPicture.asset("assets/svgs/search_icon.svg"),
              ),
              filled: true,
              fillColor: scaffoldColor),
        ),
      ),
      body: GetBuilder<HomeViewModel>(
          initState:(state){
            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
              state.controller?.getNotifications();
            });
          },
          init:HomeViewModel(),
          builder: (logic) {
        return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(logic.isLoading)...[
                  Expanded(child: Center(child: CircularProgressIndicator(color: colorPrimary,),)),
                ]else ...[
                Expanded(
                  child: ListView.builder(
                    itemCount: logic.listNotifications.length,
                    itemBuilder: (context, index) => NotificationItem(notification:logic.listNotifications[index]),
                  ),
                ),
            ]
              ],
            ));
      }),
    );
  }
}
