import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/feature/view/widgets/notification_item.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: colorTextWhite,
        toolbarHeight: sizeH90,
        elevation: 1,
        title: Expanded(
          child: TextFormField(
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
      ),
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => NotificationItem(),
            ),
          ),
        ],
      )),
    );
  }
}
