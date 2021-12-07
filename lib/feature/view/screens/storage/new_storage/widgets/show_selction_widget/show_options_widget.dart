import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'show_option_item.dart';

class ShowOptionsWidget extends StatelessWidget {
  const ShowOptionsWidget({Key? key, required this.storageItemOptions})
      : super(key: key);

  final List<String> storageItemOptions;

  @override
  Widget build(BuildContext context) {
    return storageItemOptions.isNotEmpty
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
                children: storageItemOptions
                    .map((e) => ShowOptionItem(
                          optionTitle: e,
                        ))
                    .toList(),
              ),
            ],
          )
        : const SizedBox();
  }
}
