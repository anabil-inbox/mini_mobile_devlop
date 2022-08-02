import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'size_type_item.dart';

class StorageSizeType extends StatelessWidget {
  const StorageSizeType({Key? key}) : super(key: key);

  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

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
              return GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: builder.storageCategoriesList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (builder.storageCategoriesList.length  == 1 ? 1: 2),
                      mainAxisSpacing: sizeW10!,
                      crossAxisSpacing: sizeH10!,
                      childAspectRatio: (sizeH320 / sizeH200!)),
                  itemBuilder: (contxet, index) {
                    return SizeTypeItem(
                      media: [
                        builder.storageCategoriesList[index].image ?? "",
                        builder.storageCategoriesList[index].video ?? ""
                      ],
                      storageCategoriesData:
                          builder.storageCategoriesList[index],
                    );
                  });
            },
          )
        ],
      ),
    );
  }
}
