import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/duration_widget.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class PeriodStorageWidget extends StatelessWidget {
  const PeriodStorageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: colorBorderContainer),
        borderRadius: BorderRadius.circular(padding6!),
        color: colorTextWhite,
      ),
      child: Column(
        children: [
          SizedBox(
            height: sizeH16,
          ),
          Text(
            "Duration of Subscription",
            style: textStyleNormalBlack(),
          ),
          SizedBox(
            height: sizeH5,
          ),
          Text(
            "starting from pickup date",
            style: smallHintTextStyle(),
          ),
          SizedBox(
            height: sizeH16,
          ),
          GetBuilder<StorageViewModel>(
            builder: (builder) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DurationWidget(
                    durationTitle: "Daily",
                    selectedDuration: builder.selectedDuration,
                    thisDuration: 1,
                  ),
                  SizedBox(
                    width: sizeH5,
                  ),
                  DurationWidget(
                    durationTitle: "Monthly",
                    selectedDuration: builder.selectedDuration,
                    thisDuration: 2,
                  ),
                  SizedBox(
                    width: sizeH5,
                  ),
                  DurationWidget(
                    durationTitle: "Yearly",
                    selectedDuration: builder.selectedDuration,
                    thisDuration: 3,
                  ),
                  SizedBox(
                    width: sizeH5,
                  ),
                  DurationWidget(
                    durationTitle: "Unlimited",
                    selectedDuration: builder.selectedDuration,
                    thisDuration: 4,
                  ),
                ],
              );
            },
          ),
          SizedBox(
            height: sizeH16,
          ),
        ],
      ),
    );
  }
}
