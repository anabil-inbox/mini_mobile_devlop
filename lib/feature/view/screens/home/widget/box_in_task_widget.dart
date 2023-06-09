import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/date_time_util.dart';

class BoxInTaskWidget extends StatelessWidget {
  const BoxInTaskWidget({Key? key, required this.box, this.isEnabeld = true})
      : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  final Box box;
  final bool isEnabeld;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Column(
      children: [
        Container(
          // height: sizeH70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(padding6!),
              color: scaffoldColor),
          child: InkWell(
            onTap: () {
              homeViewModel.addToBoxessOperations(box: box);
            },
            child: GetBuilder<HomeViewModel>(
              init: HomeViewModel(),
              initState: (_) {},
              builder: (logical) {
                return FittedBox(
                  child: Row(
                    children: [
                      SizedBox(
                        width: sizeW13,
                      ),
                      logical.selctedOperationsBoxess.contains(box)
                          ? SvgPicture.asset(
                              "assets/svgs/true_orange.svg"/*true*/,
                              width: sizeW20,
                              height: sizeH20,
                            )
                          : SvgPicture.asset(
                              "assets/svgs/empty_circle.svg",
                              width: sizeW20,
                              height: sizeH20,
                            ),
                      SizedBox(
                        width: sizeW10,
                      ),
                      returnBoxByStatus(
                          isPickup: box.isPickup ?? true,
                          storageStatus: box.storageStatus!,
                          isEnabeld: isEnabeld),
                      SizedBox(
                        width: sizeW15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: sizeH16,
                          ),
                          Container(
                              width: sizeW240,
                              child: CustomTextView(
                                txt: "${box.storageName}",
                                maxLine: 2,
                              )),
                          SizedBox(
                            height: sizeH2,
                          ),
                          Text(
                            "${DateUtility.getChatTime(box.modified.toString())}",
                            style: textStyleHints(),
                          ),
                          SizedBox(
                            height: sizeH16,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: sizeH10,
        )
      ],
    );
  }
}
