import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/sh_util.dart';

class SchedulePickup extends StatelessWidget {
  const SchedulePickup({Key? key}) : super(key: key);

  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: sizeH16!, vertical: sizeH16!),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(padding6!),
            color: colorTextWhite,
          ),
          child: InkWell(
            onTap: () {
              ApiSettings settings = ApiSettings.fromJson(
                  json.decode(SharedPref.instance.getAppSetting()!.toString()));
              print("settings ${settings.workingHours?.toJson()}");
              storageViewModel.chooseDayBottomSheet(
                  workingHours: settings.workingHours!);
            },
            child: Row(
              children: [
                storageViewModel.selectedDay.isEmpty
                    ? Text("Date")
                    : Text("${storageViewModel.selectedDay}"),
                const Spacer(),
                SvgPicture.asset("assets/svgs/down_arrow.svg")
              ],
            ),
          ),
        ),
        SizedBox(
          height: sizeH10,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: sizeH7!, vertical: sizeH7!),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(padding6!),
            color: colorTextWhite,
          ),
          child: Row(
            children: [
              Text("Time"),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: sizeH7!, vertical: sizeH7!),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(padding6!),
                  color: scaffoldSecondery,
                ),
                child: Row(
                  children: [
                    Text("10:00 Am- 06:00 pm"),
                    SizedBox(
                      width: sizeW7,
                    ),
                    SvgPicture.asset("assets/svgs/down_arrow.svg")
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
