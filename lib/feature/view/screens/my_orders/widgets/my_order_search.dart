import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_clients/feature/view_model/my_order_view_modle/my_order_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/constance.dart';

import '../../../../../util/app_shaerd_data.dart';

class MyOrderSearch extends StatelessWidget {
  const MyOrderSearch({ Key? key,required this.viewModel,  }) : super(key: key);
  final MyOrderViewModle viewModel;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      height: sizeH50,
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.symmetric(horizontal: sizeW13!),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(sizeRadius10!),
          color: colorTextWhite,
          border: Border.all(color: colorBorderContainer)),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/svgs/search_icon.svg",
          ),
          Expanded(
            child: CustomTextFormFiled(
              maxLine: Constance.maxLineOne,
              textInputAction: TextInputAction.search,
              keyboardType: TextInputType.text,
              onSubmitted: (_) {
                if(_.isNotEmpty && _.length > 3){
                  viewModel.getOrdres(isFromPagination: false , searchValue: _.toString());
                }else if(_.isEmpty ){
                  viewModel.getOrdres(isFromPagination: false , searchValue: "");
                }
              },
              onChange: (_) {
                if(_.isNotEmpty && _.length > 3){
                  viewModel.getOrdres(isFromPagination: false , searchValue: _.toString());
                }else if(_.isEmpty ){
                  viewModel.getOrdres(isFromPagination: false , searchValue: "");
                }
              },
              fun: () {},
              isReadOnly: /*true*/false,
              isSmallPadding: false,
              isSmallPaddingWidth: true,
              fillColor: colorBackground,
              isFill: true,
              isBorder: true,
            ),
          ),
          // SvgPicture.asset(
          //   "assets/svgs/Filter.svg",
          // ),
        ],
      ),
    );
  }
}