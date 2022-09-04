// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/date_time_util.dart';

import '../../../../../../../util/app_shaerd_data.dart';

class SelectedHourItem extends StatelessWidget {
  SelectedHourItem({Key? key, required this.day, this.isFromEdit = false, this.selectedDateTime, }) : super(key: key);

  final  bool? isFromEdit;
  Day? day;
  final DateTime? selectedDateTime;

  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Column(
      children: [
        Stack(
          children: [

            SeconderyButtom(
                isEnable: (day?.check ?? false),
                textButton: "${DateUtility.getLocalhouersFromUtcTR(day: day!)/*DateUtility.getLocalhouersFromUtc(day: day!)*/}",
                onClicked: day?.check ?? false
                    ? () {
                  if(isFromEdit!){
                    storageViewModel.selectedDayEdit = day;
                    storageViewModel.myOrderViewModel.newOrderSales.timeFrom = day?.from ;
                    storageViewModel.myOrderViewModel.newOrderSales.timeTo = day?.to ;
                    storageViewModel.update();
                    Get.back();
                  }else{
                    storageViewModel.selectedDay = day;
                    storageViewModel.update();
                    Get.back();
                  }
                      }
                    : (){}),
            PositionedDirectional(
                start: sizeW10,
                bottom: sizeH10,
                top: sizeH10,
                child:  InkWell(
                    onTap: day?.check ?? false
                        ? () {
                      storageViewModel.selectedDay = day;
                      storageViewModel.update();
                      Get.back();
                    }
                        : (){},
                    child: SvgPicture.asset(storageViewModel.selectedDay == day?"assets/svgs/true_orange.svg"/*true*/:"assets/svgs/uncheck.svg"))),
          ],
        ),
        SizedBox(
          height: sizeH10,
        )
      ],
    );
  }
}
