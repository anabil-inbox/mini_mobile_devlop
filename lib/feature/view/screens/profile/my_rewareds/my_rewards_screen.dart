import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/profile/widget/availabe_balance_item.dart';
import 'package:inbox_clients/feature/view/screens/profile/widget/history_item.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

class MyRewardsScreen extends StatelessWidget {
  const MyRewardsScreen({Key? key}) : super(key: key);

  static ProfileViewModle profileViewModle = Get.find<ProfileViewModle>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: CustomAppBarWidget(
        titleWidget: Text(
          "${tr.my_rewards}",
          style: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
      ),
      body: GetBuilder<ProfileViewModle>(
        initState: (_) async {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
            await profileViewModle.getMyPoints();
          });
        },
        builder: (profile) {
          if (profile.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (GetUtils.isNull(profile.myPoints.totalPoints)) {
            return const SizedBox();
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeH20!),
              child: ListView(
                children: [
                  SizedBox(
                    height: sizeH20!,
                  ),
                  AvailableBalanceItem(
                    points: "${profile.myPoints.totalPoints} ${tr.point}",
                    availableBalance: "${tr.available_balance}",
                  ),
                  SizedBox(
                    height: sizeH10!,
                  ),
                  // TransferPointsItem(),
                  // SizedBox(height: sizeH20!,),
                  Row(
                    children: [
                      SvgPicture.asset("assets/svgs/list_icon.svg"),
                      SizedBox(
                        width: sizeW10!,
                      ),
                      Text("${tr.transaction_history}"),
                    ],
                  ),
                  SizedBox(
                    height: sizeH20!,
                  ),
                  ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: profile.myPoints.transactions!
                        .map((e) => HistoryItem(
                              title: e.salesOrder ?? "",
                              date: "${e.date.toString().split(" ")[0]}",
                              points: "${e.loyaltyPoints} points",
                            ))
                        .toList(),
                  ),
                  // ListView.builder(
                  // shrinkWrap: true,
                  // primary: false,
                  //     itemCount: profile.myPoints.transactions?.length,
                  //     itemBuilder: (context, index) => HistoryItem(
                  //           title: "INBOX",
                  //           date: "February 6th, 2021",
                  //           points: "- 13 points",
                  //         ))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
