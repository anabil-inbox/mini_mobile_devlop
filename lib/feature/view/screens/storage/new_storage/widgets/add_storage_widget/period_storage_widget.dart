import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'duration_widget.dart';

class PeriodStorageWidget extends StatelessWidget {
  const PeriodStorageWidget({Key? key, required this.storageCategoriesData})
      : super(key: key);

  final StorageCategoriesData storageCategoriesData;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
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
            "${tr.duration_of_subscription}",
            style: textStyleNormalBlack(),
          ),
          SizedBox(
            height: sizeH5,
          ),
          Text(
            "${tr.starting_from_pickup_date}",
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
                  SizedBox(
                    width: sizeH5,
                  ),
                  DurationWidget(
                    storageCategoriesData: storageCategoriesData,
                    durationTitle: ConstanceNetwork.dailyDurationType,
                  ),
                  SizedBox(
                    width: sizeH5,
                  ),
                  DurationWidget(
                    storageCategoriesData: storageCategoriesData,
                    durationTitle: ConstanceNetwork.montlyDurationType,
                  ),
                  SizedBox(
                    width: sizeH5,
                  ),
                  DurationWidget(
                    storageCategoriesData: storageCategoriesData,
                    durationTitle: ConstanceNetwork.yearlyDurationType,
                  ),
                  SizedBox(
                    width: sizeH5,
                  ),
                  // DurationWidget(
                  //   storageCategoriesData: storageCategoriesData,
                  //   durationTitle: ConstanceNetwork.unLimtedDurationType,
                  // ),
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
