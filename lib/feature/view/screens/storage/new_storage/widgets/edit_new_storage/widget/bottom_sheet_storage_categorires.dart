import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/storage_size_type_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/edit_new_storage/widget/categories_item_widget.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';

import 'package:inbox_clients/util/app_shaerd_data.dart';

class StorageCategoriesBottomSheet extends StatelessWidget {
  const StorageCategoriesBottomSheet({
    Key? key,
    this.isLoading = false,
    required this.orderItem,
    required this.onSelectStorageCategoriesData,
  }) : super(key: key);
  final bool? isLoading;
  final OrderItem? orderItem;
  final Function(StorageCategoriesData) onSelectStorageCategoriesData;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return SingleChildScrollView(
        primary: true,
        child: GetBuilder<StorageViewModel>(
          init: StorageViewModel(),
          builder: (builder) {
            return CategoriesItemWidget(
              orderItem: orderItem,
              onSelectStorageCategoriesData:
                  (StorageCategoriesData storageCategoriesData) {

                onSelectStorageCategoriesData(storageCategoriesData);

              },
            );
          },
        ));
  }
}
