import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'request_new_storage_step_three.dart';
import 'widgets/add_storage_widget/request_new_storage_header.dart';
import 'widgets/step_two_widgets/pickup_address_widget.dart';
import 'widgets/step_two_widgets/schedule_pickup_widget.dart';

class RequestNewStoragesStepTwoScreen extends StatefulWidget {
  const RequestNewStoragesStepTwoScreen({Key? key}) : super(key: key);

  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override
  State<RequestNewStoragesStepTwoScreen> createState() =>
      _RequestNewStoragesStepTwoScreenState();
}

class _RequestNewStoragesStepTwoScreenState
    extends State<RequestNewStoragesStepTwoScreen> {
  @override
  void initState() {
    super.initState();
    RequestNewStoragesStepTwoScreen.storageViewModel.currentLevel = 1;
  }

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding20!),
        child: Stack(
          children: [
            ListView(
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
                Text("${tr.schedule_pickup}"),
                SizedBox(
                  height: sizeH10,
                ),
                SchedulePickup(),
                SizedBox(
                  height: sizeH16,
                ),
                PickupAddress(),
              ],
            ),
            PositionedDirectional(
                bottom: padding32,
                start: padding0,
                end: padding0,
                child: Container(
                    width: sizeW150,
                    child: GetBuilder<StorageViewModel>(
                      init: StorageViewModel(),
                      initState: (_) {},
                      builder: (logic) {
                        return PrimaryButton(
                          isExpanded: false,
                          isLoading: false,
                          textButton: "${tr.next}",
                          onClicked: () {
                            if (logic.userStorageCategoriesData.isNotEmpty) if 
                            (logic.isStepTwoValidate(catygoreyType: logic
                                            .userStorageCategoriesData[0]
                                            .storageCategoryType ??
                                        "")) {
                              logic.currentLevel = 2;
                              Get.off(() => RequestNewStorageStepThree());
                            }
                          },
                        );
                      },
                    ))),
            // PositionedDirectional(
            //     bottom: 34,
            //     end: 16,
            //     child: Container(
            //         width: sizeW150,
            //         child: SeconderyFormButton(
            //           buttonText: "${tr.add_to_cart}",
            //           onClicked: () {},
            //         ))),
          ],
        ),
      ),
    );
  }
}
