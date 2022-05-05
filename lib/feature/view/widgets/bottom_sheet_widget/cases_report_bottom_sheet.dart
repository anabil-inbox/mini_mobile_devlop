// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/cases_data.dart';
import 'package:inbox_clients/feature/model/respons/task_response.dart';
import 'package:inbox_clients/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';


import '../custome_text_view.dart';
import '../primary_button.dart';

class CasesReportBottomSheet extends StatelessWidget {
  CasesReportBottomSheet({
    Key? key,
    required this.taskResponse,
  }) : super(key: key);

  final TaskResponse? taskResponse;
  static final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    screenUtil(context);
    return GetBuilder<HomeViewModel>(builder: (logic) {
      return SingleChildScrollView(
        primary: true,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(padding30!)),
            color: colorTextWhite,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: sizeH20),
              SvgPicture.asset('assets/svgs/Indicator.svg'),
              SizedBox(height: sizeH20),
              CustomTextView(
                txt: tr.report_an_emergency,
                textStyle: textStyleNormal()
                    ?.copyWith(fontSize: fontSize18, color: colorBlack),
              ),
              SizedBox(height: sizeH14),
              if (logic.casesDataList.isNotEmpty)
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: logic.casesDataList.length,
                    shrinkWrap: true,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemBuilder: (context, index) {
                      return casesItemWidget(logic, logic.casesDataList[index]);
                    }),
              SizedBox(height: sizeH14),
              CustomTextFormFiled(
                controller: _noteController,
                label: tr.note_review,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                isSmallPadding: true,
                isSmallPaddingWidth: true,
                isBorder: true,
                fillColor: colorBtnGray.withOpacity(0.3),
                isFill: true,
                minLine: 5,
                maxLine: 1000,
              ),
              SizedBox(height: sizeH20),
              PrimaryButton(
                  textButton: tr.add,
                  isLoading: logic.isLoading,
                  colorBtn: colorPrimary,
                  onClicked: () {
                    logic.casesReport(taskResponse, _noteController);
                  },
                  isExpanded: true),
              SizedBox(height: sizeH40),
            ],
          ),
        ),
      );
    });
  }


  Widget casesItemWidget(HomeViewModel logic, CasesData casesData) {
    return InkWell(
      onTap: (){
        logic.addCasesItem(casesData);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: colorTextWhite,
            boxShadow: [boxShadowLight()!],
            borderRadius: BorderRadius.circular(padding6!)),
        padding: EdgeInsets.symmetric(horizontal: sizeW20! , vertical: sizeH20!),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Text("${casesData.name}")),
            if(logic.casesSelectedDataList.contains(casesData))...[
              SvgPicture.asset("assets/svgs/check.svg"),
            ]else...[
              SvgPicture.asset("assets/svgs/uncheck.svg"),
            ]
          ],
        ),
      ),
    );
  }
}
