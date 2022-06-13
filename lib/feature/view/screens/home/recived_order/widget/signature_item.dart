import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/home/signature_item_model.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class SignatureItem extends StatelessWidget {
  const SignatureItem({Key? key, required this.title, required this.onSelected})
      : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  final String title;
  final Function onSelected;

  Widget photoSignature() {
    // Logger().d("test_title:$title");
    // Logger().d("test_Constanse:${Constance.fingerprint}");
    // Logger().d("test_Selected:${homeViewModel.selectedSignatureItemModel.title}");
    // Logger().d("test_get:${homeViewModel.operationTask.signatureFile}");
    // Logger().d("test_task:${homeViewModel.operationTask.toJson()}");
    // Logger().d("test_type:${homeViewModel.operationTask.signatureType}");
    // Logger().d("test_selected_type:${homeViewModel.selectedSignatureItemModel.toString()}");
    if (title == Constance.fingerprint) {
      return const SizedBox();
    }
    /*if ( title ==
        homeViewModel.selectedSignatureItemModel.title &&
        homeViewModel.operationTask.signatureFile != null)*/
      if ( title == homeViewModel.operationTask.signatureType &&
          homeViewModel.operationTask.signatureType ==
        homeViewModel.selectedSignatureItemModel.title &&
        homeViewModel.operationTask.signatureFile != null) {
      return imageNetwork(
        url: ConstanceNetwork.imageUrl +
            (homeViewModel.operationTask.signatureFile ?? ""),
        width: sizeW30,
        height: sizeH30,
      );
    }else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: colorTextWhite,
          border: Border.all(color: colorBtnGray)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeW10!, vertical: sizeH2!),
        child: GetBuilder<HomeViewModel>(
          builder: (_) {
            return Row(
              children: [
                GetBuilder<HomeViewModel>(
                  builder: (home) {
                    return IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          homeViewModel.selectedSignatureItemModel =
                              SignatureItemModel(title: title);
                          homeViewModel.update();
                          onSelected();
                        },
                        icon:
                            // SharedPref.instance
                            //                 .getCurrentTaskResponse()
                            //                 ?.type ==
                            //             title ||
                            homeViewModel.selectedSignatureItemModel.title ==
                                    title
                                ? SvgPicture.asset("assets/svgs/check.svg",color: colorPrimary,)
                                : SvgPicture.asset("assets/svgs/uncheck.svg"));
                  },
                ),
                SizedBox(width: sizeW5),
                CustomTextView(
                  txt: title,
                  textStyle: textStyleNormal()?.copyWith(fontSize: fontSize13),
                ),
                const Spacer(),
                // if(homeViewModel.operationTask.signatureType ==
                //     homeViewModel.selectedSignatureItemModel.title )
                photoSignature(),
                Transform(
                  transform:
                      Matrix4.translationValues(isArabicLang() ? -5 : 5, 0, 0),
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: colorBlack,
                    size: 20,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
