import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/add_item/widgets/add_item_widget.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button%20copy.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class ChooseAddMethodWidget extends StatelessWidget {
  const ChooseAddMethodWidget({ Key? key , required this.box}) : super(key: key);

  final Box box;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: containerBoxDecoration().copyWith(borderRadius: BorderRadius.vertical(top: Radius.circular(padding30!))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: sizeH20,),
          SpacerdColor(),
          SizedBox(height: sizeH20,),
          SeconderyButtom(
            buttonTextStyle: textSeconderyButtonUnBold(),
            textButton: "Add Item",
            onClicked: () async {
                 Get.bottomSheet(
        AddItemWidget(
          box: box,
        ),
        isScrollControlled: true);
            },
            isExpanded: true,
          ),
          SizedBox(height: sizeH20,),
          SeconderyButtom(
            buttonTextStyle: textSeconderyButtonUnBold(),
            textButton: "Add From Gallery",
            onClicked: () async {
              
              Get.back();
            },
            isExpanded: true,
          ),
          SizedBox(height: sizeH20,),
        ],
      ),
    );
  }
}