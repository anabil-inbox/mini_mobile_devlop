import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button%20copy.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class BottomSheetBeneficairy extends StatelessWidget {
  const BottomSheetBeneficairy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: padding20!, vertical: padding20!),
      color: colorBackground,
      child: GetBuilder<HomeViewModel>(
        init: HomeViewModel(),
        initState: (_) {},
        builder: (logic) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: sizeH4,
            ),
            shrinkWrap: true,
            itemCount: logic.beneficiarys.length,
            itemBuilder: (context, index) => SeconderyButtom(
                textButton: logic.beneficiarys[index].name ?? "",
                onClicked: () {
                  logic.selctedbeneficiary = logic.beneficiarys[index];
                  Get.back();
                  logic.update();
                }),
          );
        },
      ),
    );
  }
}
