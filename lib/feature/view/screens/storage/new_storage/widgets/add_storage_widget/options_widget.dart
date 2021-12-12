import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

import 'option_item.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({Key? key, required this.storageCategoriesData})
      : super(key: key);

  final StorageCategoriesData storageCategoriesData;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding16!),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(padding6!)),
        border: Border.all(color: colorBorderContainer),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: sizeH12,
          ),
          Text("${tr.options}"),
          SizedBox(
            height: sizeH14,
          ),
          ListView.builder(
            padding: EdgeInsets.all(padding0!),
            shrinkWrap: true,
            itemCount: storageCategoriesData.storageFeatures?.length,
            primary: false,
            itemBuilder: 
            (context, index) =>
             OptionItem(
                storageCategoriesData: storageCategoriesData,
                storageFeatures: storageCategoriesData
                .storageFeatures![index],
                ),
          ),
        ],
      ),
    );
  }

}
