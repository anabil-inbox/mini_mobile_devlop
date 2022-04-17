import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/inside_box/seal.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/box_bottom_sheet/widgets/seals_item.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';

import '../../../../../util/app_color.dart';
import '../../../../../util/app_dimen.dart';
import '../../../../../util/app_shaerd_data.dart';
import '../../../../core/spacerd_color.dart';

class SealsBottomSheet extends StatelessWidget {
  const SealsBottomSheet({Key? key, required this.seals}) : super(key: key);

  final List<Seal> seals;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizeW15!),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(padding30!)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: sizeH16,
          ),
          SpacerdColor(),
          SizedBox(
            height: sizeH32,
          ),
          ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) => SealsItem(
                    seal: seals[index],
                  ),
              itemCount: seals.length),
          SizedBox(
            height: sizeH12,
          ),
          PrimaryButton(
              textButton: tr.ok,
              isLoading: false,
              onClicked: () {
                Get.back();
              },
              isExpanded: true),
          SizedBox(
            height: sizeH12,
          ),
        ],
      ),
    );
  }
}
