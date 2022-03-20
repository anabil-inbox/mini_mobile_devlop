import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/profile/log/widgets/log_item.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({Key? key}) : super(key: key);

  static ProfileViewModle profileViewModle = Get.find<ProfileViewModle>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleWidget: Text(
          tr.log,
          style: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding20!),
        child: GetBuilder<ProfileViewModle>(
          init: ProfileViewModle(),
          initState: (_) async {
            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
              await profileViewModle.getUserLog();
            });
          },
          builder: (log) {
            if (log.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (log.userLogs.isEmpty) {
              return const SizedBox();
            } else {
              return ListView(
                  children: log.userLogs.map((e) => LogItem(log: e)).toList());
            }
          },
        ),
      ),
    );
  }
}
