import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/inside_box/invoices.dart';
import 'package:inbox_clients/feature/model/profile/invoices_model.dart';
import 'package:inbox_clients/feature/view/widgets/three_size_dot.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/font_dimne.dart';

import '../../../../widgets/bottom_sheet_widget/box_bottom_sheet/widgets/invoices_bottom_sheet_details.dart';

// ignore: must_be_immutable
class MyInvoicesItem extends StatelessWidget {
  /*const*/ MyInvoicesItem({
    Key? key,
    required this.invoices,
    this.isPadInv = false,
  }) : super(key: key);

  final InvoicesData invoices;
  final bool? isPadInv;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModle>(builder: (logic) {
      return logic.isLoading &&
              logic.invoicesSelectedId.contains(invoices.paymentEntryId)
          ? Center(
              child: ThreeSizeDot(
                color_1: colorPrimary,
                color_2: colorPrimary,
                color_3: colorPrimary,
              ),
            )
          : InkWell(
              onTap: () => isPadInv! ? () {} : _showInvDetails(logic, invoices),
              child: Container(
                // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                color: colorTextWhite,
                padding: EdgeInsets.all(sizeRadius10!),
                child: Row(
                  children: [
                    Text(invoices.name ?? ""),
                    Spacer(),
                    Text(
                      getPriceWithFormate(price: invoices.total ?? 0),
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: colorPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize16),
                    ),
                    SizedBox(
                      width: sizeW10,
                    ),
                    // InkWell(onTap: () {}, child: Icon(Icons.payment)),
                    SizedBox(
                      width: sizeW10,
                    ),
                    if (!isPadInv!) ...[
                      if (logic.invoicesSelectedId
                          .contains(invoices.paymentEntryId)) ...[
                        InkWell(
                          onTap: () => _onItemClick(logic),
                          child: Icon(
                            Icons.check_box,
                            color: colorPrimary,
                          ),
                        ),
                      ] else ...[
                        InkWell(
                          onTap: () => _onItemClick(logic),
                          child: Icon(
                            Icons.check_box_outline_blank,
                            color: colorHint3,
                          ),
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            );
    });
  }

  void _onItemClick(ProfileViewModle logic) {
    ///todo here we need remove item from list
    if (logic.invoicesSelectedId.isNotEmpty &&
        logic.invoicesSelectedId.contains(invoices.paymentEntryId)) {
      logic.invoicesSelectedId.remove(invoices.paymentEntryId);
      logic.update();
    } else {
      ///todo here we need add item to list
      logic.invoicesSelectedId.add(invoices.paymentEntryId!);
      logic.update();
    }
  }

  //todo here we need to show invoice details
  _showInvDetails(ProfileViewModle logic, InvoicesData invoices) {
    Get.bottomSheet(InvoicesDetailsBottomSheet(invoices: invoices),
        isScrollControlled: true);
  }
}
