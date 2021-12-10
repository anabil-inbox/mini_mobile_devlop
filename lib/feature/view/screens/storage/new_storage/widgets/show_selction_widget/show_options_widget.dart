import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'show_option_item.dart';

class ShowOptionsWidget extends StatelessWidget {
  const ShowOptionsWidget({Key? key, required this.storageItem})
      : super(key: key);

  final StorageItem storageItem;
  
  @override
  Widget build(BuildContext context) {
    return (!GetUtils.isNull(storageItem.options) && storageItem.options!.length > 0) 
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Options",
                textAlign: TextAlign.start,
                style: textStyleNormalBlack(),
              ),
              SizedBox(
                height: sizeH7,
              ),
              ListView(
                shrinkWrap: true,
                primary: false,
                children: storageItem.options
                    !.map((e) => ShowOptionItem(
                          optionTitle: e,
                        ))
                    .toList(),
              ),
            ],
          )
        : const SizedBox();
  }
}
