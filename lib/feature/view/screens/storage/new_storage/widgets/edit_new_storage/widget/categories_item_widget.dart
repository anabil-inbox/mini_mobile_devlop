import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/size_type_item.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:logger/logger.dart';

class CategoriesItemWidget extends StatelessWidget {
  const CategoriesItemWidget({Key? key, this.orderItem,required this.onSelectStorageCategoriesData, }) : super(key: key);

  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  final OrderItem? orderItem;
  final Function(StorageCategoriesData) onSelectStorageCategoriesData;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      color: colorTextWhite,
      child: ListView(
        padding: EdgeInsets.all(padding20!),
        shrinkWrap: true,
        primary: false,
        children: [
          Text(
            "${tr.storage_size_type}",
            style: textStyleIntroBody(),
          ),
          SizedBox(
            height: sizeH5,
          ),
          Text(
            "${tr.choose_from_below}",
            style: smallHintTextStyle(),
          ),
          SizedBox(
            height: sizeH16,
          ),
          GetBuilder<StorageViewModel>(
            init: StorageViewModel(),
            builder: (builder) {
              Logger().w(orderItem!.item.toString());
              return GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: builder.storageCategoriesList.where((element) => element.storageCategoryType == orderItem?.storageType.toString() /*&& element.id.toString().contains(orderItem!.item.toString())*/).length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (builder.storageCategoriesList.length  == 1 ? 1: 2),
                      mainAxisSpacing: sizeW10!,
                      crossAxisSpacing: sizeH10!,
                      childAspectRatio: (sizeH320 / sizeH250!)),
                  itemBuilder: (contxet, index) {
                    return InkWell(
                      onTap: (){
                        onSelectStorageCategoriesData(builder.storageCategoriesList[index]);

                      },
                      child: SizeTypeItem(
                        media: [
                          builder.storageCategoriesList[index].image ?? "",
                          builder.storageCategoriesList[index].video ?? ""
                        ],
                        isFromEditClick: true,
                        storageCategoriesData:
                        builder.storageCategoriesList[index],
                      ),
                    );
                  });
            },
          )
        ],
      ),
    );
  }
}
