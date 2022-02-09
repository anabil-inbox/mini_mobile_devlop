import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/profile/widget/availabe_balance_item.dart';
import 'package:inbox_clients/feature/view/screens/profile/widget/history_item.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/bottom_sheet_my_wallet.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:intl/intl.dart';
import 'Widgets/add_money.dart';

class MyWalletScreen extends StatelessWidget {
  var myFormat = DateFormat('d-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: CustomAppBarWidget(
        titleWidget: Text(
          "${tr.my_wallet}",
          style: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
      ),
      body: GetBuilder<ProfileViewModle>(
          init: ProfileViewModle(),
          builder: (logic) {
            if (logic.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: sizeH20!),
                child: ListView(
                  children: [
                    SizedBox(
                      height: sizeH20!,
                    ),
                    AvailableBalanceItem(
                      points: " ${logic.myWallet.balance}",
                      availableBalance: "${tr.available_balance}",
                    ),
                    SizedBox(
                      height: sizeH10!,
                    ),
                    InkWell(
                        onTap: () {
                          Get.bottomSheet(
                            AddMoneyBottomSheet(),
                            isScrollControlled: true,
                          );
                        },
                        child: AddMoneyItem()),
                    SizedBox(
                      height: sizeH20!,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/svgs/list.svg"),
                        SizedBox(
                          width: sizeW10!,
                        ),
                        Text("${tr.transaction_history}"),
                      ],
                    ),
                    SizedBox(
                      height: sizeH20!,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: logic.transaction.length,
                        itemBuilder: (context, index) => HistoryItem(
                              title: "${logic.transaction[index].type}",
                              date:
                                  '${myFormat.format(logic.transaction[index].date!).toString()}',
                              points: "${logic.transaction[index].amount}",
                            ))
                  ],
                ),
              );
            }
          }),
    );
  }
}
