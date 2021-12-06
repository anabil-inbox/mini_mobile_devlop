import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/show_selction_widget/show_options_widget.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'show_header_selection.dart';

class ShowSpaceAndQuantityWidget extends StatelessWidget {
  const ShowSpaceAndQuantityWidget({Key? key , required this.storageItem }) : super(key: key);

  final StorageItem storageItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding16!),
      width: double.infinity,
      decoration: BoxDecoration(
          color: scaffoldColor, borderRadius: BorderRadius.circular(padding6!)),
      child: Column(
        children: [
          SizedBox(
            height: sizeH22,
          ),
          ShowHeaderSelection(
            storageName: storageItem.name ?? "",
            quantityOrSpace: "10",
          ),
          SizedBox(
            height: sizeH18,
          ),
          ShowOptionsWidget(
            storageItemOptions: storageItem.options ?? []
          ),
          SizedBox(
            height: sizeH9,
          ),
          Row(
            children: [
              Text(
                "Total",
                style: textStyleNormalBlack(),
              ),
              const Spacer(),
              Text("100.00",
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
