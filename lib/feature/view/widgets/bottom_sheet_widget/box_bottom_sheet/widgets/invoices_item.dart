import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/inside_box/invoices.dart';
import 'package:inbox_clients/feature/view/widgets/three_size_dot.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/font_dimne.dart';

// ignore: must_be_immutable
class InvoicesItem extends StatelessWidget {
  /*const*/ InvoicesItem(
      {Key? key, required this.invoices, this.viewModel, this.operationsBox})
      : super(key: key);

  final Invoices invoices;
  final ItemViewModle? viewModel;
  final Box? operationsBox;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemViewModle>(
        init: ItemViewModle(),
        builder: (logic) {
          return logic.isLoadingInvoice
              ? Center(
                  child: ThreeSizeDot(
                    color_1: colorPrimary,
                    color_2: colorPrimary,
                    color_3: colorPrimary,
                  ),
                )
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      Text(invoices.name ?? ""),
                      Spacer(),
                      Text(
                        getPriceWithFormate(price: invoices.price ?? 0),
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: colorPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize16),
                      ),
                      if (operationsBox?.saleOrder != null &&
                          operationsBox!.saleOrder!.isNotEmpty) ...[
                        SizedBox(
                          width: sizeW10,
                        ),
                        InkWell(
                            onTap: () {
                              viewModel?.getInvoiceUrl(invoices.paymentEntryId,
                                  operationsBox: operationsBox);
                            },
                            child: Icon(Icons.payment)),
                      ],
                    ],
                  ),
                );
        });
  }
}
