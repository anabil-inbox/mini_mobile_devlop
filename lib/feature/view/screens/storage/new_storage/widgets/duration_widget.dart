import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

// ignore: must_be_immutable
class DurationWidget extends StatelessWidget {
  DurationWidget(
      {Key? key,
      required this.selectedDuration,
      required this.thisDuration,
      required this.durationTitle})
      : super(key: key);

  int selectedDuration;
  int thisDuration;
  final String durationTitle;

  StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override 
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        storageViewModel.selectedDuration = thisDuration;
        storageViewModel.update();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(padding6!),
            border: Border.all(
                width: 0.5,
                color: selectedDuration != thisDuration
                    ? colorBorderContainer
                    : colorTrans),
            color:
                selectedDuration != thisDuration ? colorTextWhite : colorPrimary),
        padding:
            EdgeInsets.symmetric(vertical: padding9!, horizontal: padding12!),
        child: Text(
          durationTitle,
          style: selectedDuration == thisDuration
              ? textStylebodyWhite()
              : textStyleHints()!.copyWith(fontSize: fontSize14 , color: colorHint2),
        ),
      ),
    );
  }
}
