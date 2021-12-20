import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/price_bottom_sheet_widget.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class OrderDerailesScreen extends StatelessWidget {
  const OrderDerailesScreen({Key? key})
      : super(key: key);

  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeH16!),
        child: GetBuilder<StorageViewModel>(
          init: StorageViewModel(),
          builder: (_) {
            return Column(
              children: [
                SizedBox(
                  height: sizeH20,
                ),
                PriceBottomSheetWidget(
                  isTotalPalnce: true,
                  totalPalance: storageViewModel.returnedOrderSales?.totalPrice ?? 1,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
