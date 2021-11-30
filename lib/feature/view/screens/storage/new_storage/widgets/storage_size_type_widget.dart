import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/size_type_item.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class StorageSizeType extends StatelessWidget {
  const StorageSizeType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorTextWhite,
      child: ListView(
        padding: EdgeInsets.all(padding20!),
        shrinkWrap: true,
        primary: false,
        children: [
          Text(
            "Storage Size & Type:",
            style: textStyleIntroBody(),
          ),
          SizedBox(
            height: sizeH5,
          ),
          Text(
            "Choose from below",
            style: smallHintTextStyle(),
          ),
          SizedBox(
            height: sizeH16,
          ),
          GetBuilder<StorageViewModel>(
            init: StorageViewModel(),
            initState: (_) {},
            builder: (builder) {
              return GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: builder.storageCategoriesList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: sizeW10!,
                      crossAxisSpacing: sizeH10!,
                      childAspectRatio: (sizeW290! / sizeH200!)),
                  itemBuilder: (contxet, index) {
                    return SizeTypeItem(
                      itemType: builder.storageCategoriesList[index].storageName ?? "",
                    );
                  });
            },
          )
        ],
      ),
    );
  }
}
