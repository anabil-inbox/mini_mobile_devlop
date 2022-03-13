// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/home/box_model.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class BoxOnOrderItem extends StatelessWidget {
  BoxOnOrderItem(
      {Key? key, required this.boxModel})
      : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  GlobalKey<FormState> formFieldKey = GlobalKey<FormState>();

  BoxModel boxModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: padding10!),
      child: InkWell(
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/svgs/Folder_Shared_1.svg'),
                SizedBox(width: sizeW5),
                CustomTextView(
                  txt: boxModel.serial,
                  textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                ),
              ],
            ),
            SizedBox(
              height: sizeH12,
            ),
          ],
        ),
      ),
    );
  }
}
