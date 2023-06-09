import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

import '../../../../../../../util/app_shaerd_data.dart';

class SpaceWidget extends StatelessWidget {
   SpaceWidget(
      {Key? key,
      required this.textEditingController,
      required this.hint,
      required this.storageCategoriesData})
      : super(key: key);

  final TextEditingController textEditingController;
  final String hint;
  final StorageCategoriesData storageCategoriesData;
  final formKeySpcaeKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<StorageViewModel>(
      builder: (value) {
        return Container(
          width: sizeW50,
          height: sizeH40,
          alignment: Alignment.center,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(padding6!)),
          ),
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(),
            controller: textEditingController,
            textAlign: TextAlign.center,
            onChanged: (e) {
              value.doOnChangeSpace(
                  storageCategoriesData: storageCategoriesData);
            },
            validator: (e) {
              if (e!.isEmpty) {
                return '';
              } else {
                return null;
              }
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
                filled: true,
                fillColor: scaffoldColor,
                contentPadding: EdgeInsets.only(bottom: padding4!),
                hintText: "$hint"),
          ),
        );
      },
    );
  }
}
