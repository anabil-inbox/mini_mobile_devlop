// ignore_for_file: unused_field, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_two_widgets/schedule_pickup_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';


class RescheduleSheet extends StatelessWidget {
  const RescheduleSheet({
    Key? key,
  }) : super(key: key);

  Widget  actionBtn(StorageViewModel logic) =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: sizeW10!),
        child: PrimaryButton(
            isExpanded: true,
            isLoading: false,
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
                  child: CustomTextView(txt: "Note",textStyle: textStyleTitleBold(),),
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
                  child: CustomTextView(txt: "Note",textStyle: textStyleNormal(),),
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
    Get.back();
  }//end
}
