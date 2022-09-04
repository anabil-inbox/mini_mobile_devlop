import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/quantity_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/edit_new_storage/widget/qty_widget.dart';
import 'package:inbox_clients/feature/view_model/my_order_view_modle/my_order_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.index,
    required this.orderItem,
    required this.viewModel,required this.arraySize,
  }) : super(key: key);

  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  final int index;
  final OrderItem orderItem;
  final MyOrderViewModle viewModel;
  final int? arraySize;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset("assets/svgs/folder_icon.svg"),
        SizedBox(
          width: sizeW5,
        ),
        Flexible(
          child: FittedBox(
            child: Text(
              "${orderItem.itemName ?? orderItem.item?.replaceAll("_in", "")}",
              style: textStyleNormalBlack(),
            ),
          ),
        ),

        SizedBox(
          width: sizeW20,
        ),
        Flexible(
          child: QuantityEditWidget(
            value: (orderItem.quantity??0.0).toInt(),
            orderItem:orderItem,
            increasingFunction: () {
               viewModel.increaseQuantity(index);
            },
            mineassingFunction: () {
              viewModel.minesQuantity(index);

            },
            quantityTitle: "" /*${tr.quantity}*/,
          ),
        ),
        if(arraySize! > 1)
        InkWell(
            onTap: () {
              viewModel.deleteItem(index);
            },
            child: SvgPicture.asset("assets/svgs/delete_ornage.svg")/*delete.svg*/),
//         SizedBox(
//           width: sizeW10,
//         ),
//         InkWell(
//             onTap: () {
// //              Get.put(StorageViewModel());
// //               storageViewModel.showMainStorageBottomSheet(
// //                   index: index,
// //                   isUpdate: true,
// //                   storageCategoriesData: storageCategoriesData);
//             },
//             child: SvgPicture.asset("assets/svgs/update_icon.svg")),
      ],
    );
  }
}
