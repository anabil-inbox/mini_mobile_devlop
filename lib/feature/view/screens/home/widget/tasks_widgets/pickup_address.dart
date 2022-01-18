import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class SchedulePickupTaskWidget extends StatelessWidget {
  const SchedulePickupTaskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      initState: (_) {},
      builder: (home) {
        return InkWell(
          onTap: () {
            home.showDatePicker();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: padding14!),
            decoration: BoxDecoration(
                border: Border.all(color: colorBorderContainer),
                borderRadius: BorderRadius.circular(padding6!)),
            child: Row(
              children: [
                SizedBox(
                  width: sizeW15!,
                ),
                Text(
                  "Schedule Pickup",
                  style: textStyleHints(),
                ),
                const Spacer(),
                SvgPicture.asset("assets/svgs/down_arrow.svg"),
                SizedBox(
                  width: sizeW5!,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
