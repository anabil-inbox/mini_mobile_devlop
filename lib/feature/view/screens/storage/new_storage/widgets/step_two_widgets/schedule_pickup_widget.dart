import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/utils.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class SchedulePickup extends StatelessWidget {
  const SchedulePickup({Key? key}) : super(key: key);

  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: sizeH7!, vertical: sizeH7!),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(padding6!),
            color: colorTextWhite,
          ),
          child: InkWell(
            onTap: () async {
              storageViewModel.showDatePicker();
            },
            child: GetBuilder<StorageViewModel>(
              init: StorageViewModel(),
              initState: (_) {},
              builder: (_) {
                return Row(
                  children: [
                    Text("Date"),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: sizeH7!, vertical: sizeH7!),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(padding6!),
                        color: scaffoldSecondery,
                      ),
                      child: Row(
                        children: [
                          GetUtils.isNull(storageViewModel.selectedDateTime)
                              ? const SizedBox()
                              : Text(
                                  "${storageViewModel.selectedDateTime?.year}/${storageViewModel.selectedDateTime?.month}/${storageViewModel.selectedDateTime?.day}"),
                          SvgPicture.asset("assets/svgs/down_arrow.svg")
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: sizeH10,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: sizeH7!, vertical: sizeH7!),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(padding6!),
            color: colorTextWhite,
          ),
          child: InkWell(
            onTap: () {},
            child: Row(
              children: [
                Text("Time"),
                const Spacer(),
                InkWell(
                  onTap: () {
                    storageViewModel.chooseTimeBottomSheet();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: sizeH7!, vertical: sizeH7!),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(padding6!),
                      color: scaffoldSecondery,
                    ),
                    child: GetBuilder<StorageViewModel>(
                      init: StorageViewModel(),
                      initState: (_) {},
                      builder: (_) {
                        return Row(
                          children: [
                            GetUtils.isNull(storageViewModel.selectedDay)
                                ? Text("10:00 Am- 06:00 pm")
                                : CustomTextView(
                                    txt:
                                        "${storageViewModel.selectedDay?.from} - ${storageViewModel.selectedDay?.to}",
                                  ),
                            SizedBox(
                              width: sizeW7,
                            ),
                            SvgPicture.asset("assets/svgs/down_arrow.svg")
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
