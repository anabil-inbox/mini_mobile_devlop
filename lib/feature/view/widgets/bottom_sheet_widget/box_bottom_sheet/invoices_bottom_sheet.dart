import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/inside_box/invoices.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/box_bottom_sheet/widgets/invoices_item.dart';

import '../../../../../util/app_color.dart';
import '../../../../../util/app_dimen.dart';
import '../../../../../util/app_shaerd_data.dart';
import '../../primary_button.dart';

class InvoicesBottomSheet extends StatelessWidget {
  const InvoicesBottomSheet({Key? key, required this.invoices})
      : super(key: key);

  final List<Invoices> invoices;

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
              itemBuilder: (context, index) => InvoicesItem(
                    invoices: invoices[index],
                  ),
              itemCount: invoices.length),
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
