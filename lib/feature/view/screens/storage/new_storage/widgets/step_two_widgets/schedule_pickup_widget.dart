import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/date_time_util.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:logger/logger.dart';

class SchedulePickup extends StatelessWidget {
  const SchedulePickup({Key? key, this.isFromEdit = false}) : super(key: key);
  final bool? isFromEdit;

 static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   handleTime();
  // }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: sizeH7!, vertical: sizeH7!),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(padding6!),
            color: colorTextWhite,
          ),
          child: InkWell(
            onTap: () async {
              storageViewModel.showDatePicker();
            },
            child: GetBuilder<StorageViewModel>(
              init: StorageViewModel(),
              builder: (_) {
                return Row(
                  children: [
                    Text(
                      "${tr.date}",
                      style: textStyleHints(),
                    ),
                    const Spacer(),
                    !GetUtils.isNull(storageViewModel.selectedDateTime)
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizeH7!, vertical: sizeH7!),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(padding6!),
                              color: scaffoldSecondery,
                            ),
                            child: Row(
                              children: [
                                CustomTextView(
                                  txt:
                                      "${storageViewModel.selectedDateTime?.year}/${storageViewModel.selectedDateTime?.month}/${storageViewModel.selectedDateTime?.day}",
                                  textStyle: textStyleHints()!
                                      .copyWith(fontSize: fontSize13),
                                ),
                                SvgPicture.asset("assets/svgs/down_arrow.svg")
                              ],
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizeH7!, vertical: sizeH7!),
                            child:
                                SvgPicture.asset("assets/svgs/down_arrow.svg")),
                  ],
                );
              },
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
          child: InkWell(
            onTap: () {
              storageViewModel.chooseTimeBottomSheet(isFromEdit:isFromEdit);
            },
            child: GetBuilder<StorageViewModel>(
              init: StorageViewModel(),
              builder: (_) {
                return Row(
                  children: [
                    Text(
                      "${tr.time}",
                      style: textStyleHints(),
                    ),
                    const Spacer(),
                    !GetUtils.isNull(storageViewModel.selectedDay)
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizeH7!, vertical: sizeH7!),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(padding6!),
                              color: scaffoldSecondery,
                            ),
                            child: GetBuilder<StorageViewModel>(
                              init: StorageViewModel(),
                              builder: (_) {
                                return Row(
                                  children: [
                                    CustomTextView(
                                      txt:
                                          "${/*handleTime()*/ isFromEdit!  ? handleTime():DateUtility.getLocalhouersFromUtc(day: storageViewModel.selectedDay!)}",
                                      textStyle: textStyleHints()!
                                          .copyWith(fontSize: fontSize13),
                                    ),
                                    SizedBox(
                                      width: sizeW7,
                                    ),
                                    SvgPicture.asset(
                                        "assets/svgs/down_arrow.svg")
                                  ],
                                );
                              },
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizeH7!, vertical: sizeH7!),
                            child:
                                SvgPicture.asset("assets/svgs/down_arrow.svg"))
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  /*String*/
  String handleTime() {
    try {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            storageViewModel.selectedDayEdit = getDayByNumber(
              selectedDateTime: storageViewModel.myOrderViewModel.newOrderSales
                  .deliveryDate!,
            ).first;
           if (!GetUtils.isNull(storageViewModel.myOrderViewModel) &&
               storageViewModel.myOrderViewModel.newOrderSales.timeTo != null &&
               storageViewModel.myOrderViewModel.newOrderSales.timeTo!.isNotEmpty) {
             storageViewModel.selectedDayEdit?.from = storageViewModel.myOrderViewModel.newOrderSales.timeFrom;
             storageViewModel.selectedDayEdit?.to = storageViewModel.myOrderViewModel.newOrderSales.timeTo;
             // storageViewModel.update();
             // storageViewModel.myOrderViewModel.update();
              Logger().w(storageViewModel.myOrderViewModel.newOrderSales.toJson());
              Logger().w(storageViewModel.selectedDayEdit?.toJson());
              Logger().w(storageViewModel.selectedDay?.toJson());
           }
          });
      var localhouersFromUtc =
              DateUtility.getLocalhouersFromUtc(day: storageViewModel.selectedDayEdit!);
      return localhouersFromUtc;
    } catch (e) {
      print(e);
      return "";
    }
  }
}
