import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/request_new_storage_header.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_three_widgets/payment_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';

import 'widgets/show_selction_widget/my_list_widget.dart';

class RequestNewStorageStepThree extends StatelessWidget {
  const RequestNewStorageStepThree({Key? key}) : super(key: key);

  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();
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
      body: GetBuilder<StorageViewModel>(
        init: StorageViewModel(),
        initState: (_) {},
        builder: (_) {
          return SizedBox(
            height: double.infinity,
            child: Stack(
              children: [
                ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  primary: true,
                  shrinkWrap: true,
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
                    MyListWidget(),
                    SizedBox(
                      height: sizeH16,
                    ),
                    PaymentWidget(),
                    SizedBox(
                      height: sizeH100,
                    ),
                  ],
                ),
                PositionedDirectional(
                    bottom: padding32,
                    start: padding20,
                    end: padding20,
                    child: Container(
                        width: sizeW150,
                        child: GetBuilder<StorageViewModel>(
                          builder: (logic) {
                            return PrimaryButton(
                              isExpanded: false,
                              isLoading: logic.isLoading,
                              textButton: "${tr.request_box}",
                              onClicked: () {
                                if (logic.isValiedToSaveStorage()) {
                                  if (logic.selectedPaymentMethod?.id ==
                                      Constance.cashId) {
                                    logic.addNewStorage();
                                  } else {
                                    logic.goToPaymentMethod(
                                      amount: logic.totalBalance
                                    );
                                  }
                                }
                              },
                            );
                          },
                        ))),
                // PositionedDirectional(
                //     bottom: padding32,
                //     end: padding40,
                //     child: Container(
                //         width: sizeW150,
                //         child: SeconderyFormButton(
                //           buttonText: "${tr.add_to_cart}",
                //           onClicked: () {},
                //         ))),
              ],
            ),
          );
        },
      ),
    );
  }
}
