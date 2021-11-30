import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/request_new_storage_header.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/storage_size_type_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

class RequestNewStorageScreen extends StatelessWidget {
  const RequestNewStorageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: CustomAppBarWidget(
        isCenterTitle: true,
        titleWidget: Text(
          "${tr.request_new_storage}",
          style: textStyleAppBarTitle(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        primary: true,
        children: [
          GetBuilder<StorageViewModel>(
            init: StorageViewModel(),
            initState: (_) {},
            builder: (val) {
              return RequestNewStorageHeader(
                currentLevel: val.currentLevel,
              );
            },
          ),
          GetBuilder<StorageViewModel>(
            init: StorageViewModel(),
            initState: (_) {},
            builder: (builder) {
              return StorageSizeType();
            },
          )
        ],
      ),
    );
  }
}
