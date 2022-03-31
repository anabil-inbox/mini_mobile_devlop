import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/request_new_storage_header.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_three_widgets/payment_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:logger/logger.dart';

import 'widgets/show_selction_widget/my_list_widget.dart';

class RequestNewStorageStepThree extends StatelessWidget {
  const RequestNewStorageStepThree({Key? key}) : super(key: key);

  static ProfileViewModle profileViewModle = Get.find<ProfileViewModle>();

  Widget get acceptTerms => GetBuilder<StorageViewModel>(
        init: StorageViewModel(),
        builder: (value) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  value.isAccept = !value.isAccept;
                  value.update();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    value.isAccept
                        ? SvgPicture.asset("assets/svgs/true.svg")
                        : SvgPicture.asset(
                            "assets/svgs/uncheck.svg",
                            color: seconderyColor,
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    CustomTextView(
                      txt: "${tr.redeem_points} ",
                      textStyle: textStyle(),
                    )
                  ],
                ),
              ),
              CustomTextView(
                txt: "${profileViewModle.myPoints.totalPoints} ${tr.points}",
                textAlign: TextAlign.start,
                textStyle: textStyleNormal()!
                    .copyWith(color: colorPrimary, fontSize: fontSize14),
              ),
            ],
          );
        },
      );

  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
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
        builder: (logical) {
          return SizedBox(
            height: double.infinity,
            child: Stack(
              children: [
                ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
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
                    MyListWidget(),
                    SizedBox(
                      height: sizeH16,
                    ),
                    PaymentWidget(isRecivedOrderPayment: false),
                    // SizedBox(height: sizeH16),
                    // acceptTerms,
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
                              onClicked: () async {
                                if (logic.isValiedToSaveStorage()) {
                                  if (logic.selectedPaymentMethod?.id ==
                                      Constance.cashId) {
                                    await logic.addNewStorage();
                                    logic.isLoading = false;
                                    logic.update();
                                  } else if ((logic.selectedPaymentMethod?.id ==
                                      Constance.walletId)) {
                                    Logger().e(num.parse(profileViewModle
                                        .myWallet.balance
                                        .toString()));
                                    Logger().e(storageViewModel.totalBalance
                                        .toString());
                                    if (num.parse(profileViewModle
                                            .myWallet.balance
                                            .toString()) >
                                        storageViewModel.totalBalance) {
                                      await logic.addNewStorage();
                                      logic.isLoading = false;
                                      logic.update();
                                    } else {
                                      snackError("", tr.wallet_balance_is_not_enough);
                                    }
                                  } else {
                                    await logic.goToPaymentMethod(
                                        cartModels: [],
                                        isOrderProductPayment: false,
                                        isFromCart: false,
                                        isFromNewStorage: true,
                                        amount: logic.totalBalance);
                                    logic.isLoading = false;
                                    logic.update();
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
