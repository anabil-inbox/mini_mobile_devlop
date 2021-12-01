import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';

class SizeTypeItem extends StatelessWidget {
  const SizeTypeItem({Key? key, required this.itemType}) : super(key: key);
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  final String itemType;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding10!),
      decoration: BoxDecoration(
        border: Border.all(color: colorBorderContainer),
        color: colorBackground,
        borderRadius: BorderRadius.circular(sizeRadius5!),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            end: 0,
            top: -10,
            child: SizedBox(
              width: sizeW40,
              child: TextButton(
                onPressed: () {
                  print("object");
                  storageViewModel.detailsBottomSheet();
                },
                child: SvgPicture.asset("assets/svgs/InfoCircle.svg"),
              ),
            ),
          ),
          PositionedDirectional(
            top: 0,
            bottom: 0,
            start: 0,
            end: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svgs/folder_icon.svg",
                  width: sizeW50,
                  height: sizeH40,
                ),
                SizedBox(
                  height: sizeH10,
                ),
                CustomTextView(
                  txt: itemType,
                  maxLine: Constance.maxLineTwo,
                  textStyle: textStyleNormalBlack(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
