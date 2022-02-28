import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/respons/task_response.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';


class ProductOnOrderItem extends StatelessWidget {
  const ProductOnOrderItem({Key? key, required this.productModel})
      : super(key: key);

  final Item productModel;
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: sizeH10!),
      padding: EdgeInsets.symmetric(horizontal: sizeW20!, vertical: sizeH17!),
      height: sizeH60,
      decoration: BoxDecoration(
        color: colorSearchBox,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: <Widget>[
          // const CircleAvatar(
          //   radius: sizeRadius10,
          //   backgroundImage: AssetImage('assets/png/profile.png'),
          // ),
          imageNetwork(
            // url: productModel.p,
            width: sizeW30,
            height: sizeH30,
          ),
          SizedBox(width: sizeW10),
          CustomTextView(
            txt: productModel.name ?? "",
            textStyle: textStyleNormal()?.copyWith(color: colorBlack),
          ),
          SizedBox(width: sizeW48),
          const Spacer(),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: sizeH10!, vertical: sizeH4!),
            decoration: BoxDecoration(
              color: colorTextWhite,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: CustomTextView(
                txt: "${productModel.qty?.toInt().toString()}",
                textStyle: textStyleNormal()
                    ?.copyWith(color: colorRed, fontSize: fontSize13),
              ),
            ),
          ),
          SizedBox(width: sizeW12),
        ],
      ),
    );
  }
}
