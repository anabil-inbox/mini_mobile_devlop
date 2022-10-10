// ignore_for_file: unused_field, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/respons/task_response.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_two_widgets/schedule_pickup_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/date_time_util.dart';
import 'package:logger/logger.dart';


class RescheduleSheet extends StatelessWidget {
  const RescheduleSheet({
    Key? key, required this.operationTask,
  }) : super(key: key);

  final TaskResponse operationTask;


  Widget  actionBtn(StorageViewModel logic) =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: sizeW10!),
        child: PrimaryButton(
            isExpanded: true,
            isLoading: logic.isLoading,
            onClicked: ()=> onClick(logic),
            textButton: "${tr.ok}"),
      );

  @override
  Widget build(BuildContext context) {
    screenUtil(context);

    return Container(
      margin: EdgeInsets.only(top: sizeH50!),
      padding: EdgeInsets.symmetric(horizontal: sizeW15!),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(padding30!)),
      ),
      child: GetBuilder<StorageViewModel>(
       init: StorageViewModel(),
        builder: (logic) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: sizeH30,
                ),
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.close)),
                    Expanded(
                        child: Center(
                            child: Align(
                                alignment: Alignment.center,
                                child: SpacerdColor()))),
                  ],
                ),
                SizedBox(
                  height: sizeH30,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal:sizeW12! ),
                  child: CustomTextView(txt: tr.schedule_required,textStyle: textStyleTitleBold(),),
                ),
                SizedBox(
                  height: sizeH16,
                ),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        left: sizeW10!, right: sizeW10!, top: sizeH20!),
                    margin: EdgeInsets.symmetric(horizontal: sizeW10!),
                    decoration: BoxDecoration(
                        boxShadow: [boxShadowLight()!],
                        color: colorTextWhite,
                        borderRadius: BorderRadius.circular(sizeRadius10!)),
                    child: Column(
                      children: [
                        Align(
                          alignment: isArabicLang()
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Text(
                            "${tr.schedule_pickup}",
                            style: textStyleHints(),
                          ),
                        ),
                        SizedBox(
                          height: sizeH6,
                        ),
                        SchedulePickup(),
                      ],
                    )),
                SizedBox(
                  height: sizeH16,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal:sizeW12! ),
                  child: CustomTextView(txt: tr.your_order_have_to_be_rescheduled.toString().replaceAll("\$service_name", "${operationTask.processType}"),textStyle: textStyleNormal(),),
                ),
                SizedBox(
                  height: sizeH16,
                ),
                actionBtn(logic),
                SizedBox(
                  height: padding32,
                ),
              ],
            ),
          );
        },
      ),
    );
  }



  onClick(StorageViewModel logic) {

    if(GetUtils.isNull(logic.selectedDateTime)){
      return;
    }
    if(GetUtils.isNull(logic.selectedDay)){
      return;
    }
    if(GetUtils.isNull(operationTask.driverId)){
      return;
    }
    if(GetUtils.isNull(operationTask.salesOrder)){
      return;
    }
    logic.onTaskReschedule(operationTask , logic.selectedDateTime , DateUtility.getLocalhouersFromUtc(day: logic.selectedDay!) );
    // Get.back();
  }//end

///Users/osama/flutter_sdk/flutter_ten/.pub-cache/hosted/pub.dartlang.org/pay_ios-1.0.7/ios/Classes/PaymentHandler.swift

}
