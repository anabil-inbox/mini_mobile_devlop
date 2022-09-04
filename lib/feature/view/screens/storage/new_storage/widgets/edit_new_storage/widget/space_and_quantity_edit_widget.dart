import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/quantity_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/edit_new_storage/widget/header_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/show_selction_widget/show_header_selection.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/show_selction_widget/show_options_widget.dart';
import 'package:inbox_clients/feature/view_model/my_order_view_modle/my_order_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';


class SpaceAndQuantityEditWidget extends StatelessWidget {
  const SpaceAndQuantityEditWidget(
      {Key? key,
      required this.index,required this.orderItem,required this.viewModel,required this.arraySize,required this.storageViewModel,   })
      : super(key: key);


  final int index;
  final OrderItem? orderItem ;
  final MyOrderViewModle viewModel;
  final int? arraySize;
  final StorageViewModel storageViewModel;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding16!),
      margin: EdgeInsets.only(bottom: padding10!),
      decoration: BoxDecoration(
          color:colorTextWhite, borderRadius: BorderRadius.circular(padding6!)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: sizeH22,
          ),
          HeaderWidget(index: index,orderItem:orderItem! , viewModel:viewModel , arraySize:arraySize),

          // SizedBox(
          //   height: sizeH18,
          // ),
          //
          // QuantityWidget(
          //   value: viewModel.numberOfDays,
          //   increasingFunction: () {
          //     viewModel.increaseDaysDurations(
          //         storageCategoriesData: storageViewModel.storageCategoriesData);
          //   },
          //   mineassingFunction: () {
          //     viewModel.minasDaysDurations(
          //         storageCategoriesData: widget.storageCategoriesData);
          //   },
          //   quantityTitle: "${tr.days}",
          //   storageCategoriesData: widget.storageCategoriesData,
          // ),
          SizedBox(
            height: sizeH18,
          ),

          SizedBox(
            height: sizeH9,
          ),
          Row(
            children: [
              Text(
                tr.total,
                style: textStyleNormalBlack(),
              ),
              const Spacer(),
              Text("${calculateBalance(balance: orderItem!.totalPrice ?? 0)}",
                  style: textStylePrimaryFont()
                      ?.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(
                width: sizeW2,
              ),
              Text("QR",
                  style: textStylePrimaryFont()
                      ?.copyWith(fontWeight: FontWeight.bold))
            ],
          ),
          SizedBox(
            height: sizeH9,
          ),
        ],
      ),
    );
  }
}
