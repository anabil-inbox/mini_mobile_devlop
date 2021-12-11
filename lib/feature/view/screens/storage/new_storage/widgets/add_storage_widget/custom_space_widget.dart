import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/space_x_widget.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

// ignore: must_be_immutable
class CustomSpaceWidget extends StatelessWidget {
   CustomSpaceWidget({Key? key, required this.storageCategoriesData})
      : super(key: key);

  final StorageCategoriesData storageCategoriesData;
  StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(padding6!)),
        border: Border.all(color: colorBorderContainer),
      ),
      child: Row(
        children: [
          SizedBox(
            width: sizeW10,
            height: sizeH60,
          ),
          Text("${tr.custom_space}"),
          const Spacer(),
          SpaceWidget(
            storageCategoriesData: storageCategoriesData,
            hint: "X",
            textEditingController: storageViewModel.tdX,
          ),
          SizedBox(
            width: sizeW5,
            height: sizeH60,
          ),
          Text("*"),
          SizedBox(
            width: sizeW5,
            height: sizeH60,
          ),
          SpaceWidget(
            storageCategoriesData: storageCategoriesData,
            hint: "Y",
            textEditingController: storageViewModel.tdY,
          ),
          SizedBox(
            width: sizeW18,
          )
        ],
      ),
    );
  }
}
