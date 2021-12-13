// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class SelectedHourItem extends StatelessWidget {
  SelectedHourItem({Key? key, required this.day}) : super(key: key);

  Day? day;
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SeconderyButtom(
            textButton: "${day?.from} - ${day?.to}",
            onClicked: () {
              storageViewModel.selectedDay = day;
              storageViewModel.update();
              Get.back();
            }),
        SizedBox(
          height: sizeH10,
        )
      ],
    );
  }
}
