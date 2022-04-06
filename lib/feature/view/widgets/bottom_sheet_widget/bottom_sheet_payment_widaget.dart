import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/model/storage/payment.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_three_widgets/payment_item.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:inbox_clients/util/sh_util.dart';

import '../primary_button.dart';

class BottomSheetPaymentWidget extends StatelessWidget {
  final Task task;
  final Box box;
  final List<Box> boxes;
  final List<BoxItem>? items;
  final String beneficiaryId;

  const BottomSheetPaymentWidget(
      {Key? key,
      required this.task,
      required this.box,
      required this.boxes,
      this.items,
      required this.beneficiaryId})
      : super(key: key);

  static StorageViewModel storageViewModle = Get.find<StorageViewModel>();
  static ProfileViewModle profileViewModle =
      Get.put(ProfileViewModle(), permanent: true);

  Widget onDestroy() {
    if (task.id != LocalConstance.destroyId) {
      return const SizedBox();
    }
    return Column(
      children: [
        SizedBox(height: sizeH12,),
        Text(tr.choose_destroy_place),
        SizedBox(height: sizeH12,),
        ],
    );
  }

  Widget get priceTotalWidget => Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: scaffoldColor,
            borderRadius: BorderRadius.circular(padding6!)),
        margin: EdgeInsets.symmetric(horizontal: sizeH10!),
        padding: EdgeInsets.symmetric(horizontal: sizeH20!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: sizeH22,
            ),
            CustomTextView(
              txt: "${tr.total}",
              textAlign: TextAlign.center,
              textStyle: textStyleAppBarTitle()?.copyWith(fontSize: fontSize20),
            ),
            SizedBox(
              height: sizeH2,
            ),
            GetBuilder<StorageViewModel>(
              builder: (logic) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextView(
                      txt: storageViewModle.isAccept ||
                              storageViewModle.isUsingPromo
                          ? storageViewModle
                              .getPriceWithDiscount(
                                  oldPrice: logic
                                      .calculateTaskPriceLotBoxess(
                                          isFromCart: false,
                                          task: task,
                                          boxess: boxes)
                                      .toString()
                                      .split(" ")[0])[0]
                              .toString()
                              
                          : boxes.length == 0
                              ? logic.calculateTaskPriceOnceBox(task: task)
                              : logic.calculateTaskPriceLotBoxess(isFromCart: false, task: task, boxess: boxes),
                      textStyle: textStyleAppBarTitle()
                          ?.copyWith(fontSize: fontSize28, color: colorPrimary),
                    ),
                    if (storageViewModle.isAccept ||
                        storageViewModle.isUsingPromo)
                      SizedBox(
                        width: sizeW7,
                      ),
                    if (storageViewModle.isAccept ||
                        storageViewModle.isUsingPromo)
                      CustomTextView(
                          txt: logic.calculateTaskPriceLotBoxess(
                              isFromCart: false, task: task, boxess: boxes),
                          textAlign: TextAlign.center,
                          textStyle: textStyleAppBarTitle()?.copyWith(
                              fontSize: fontSize14,
                              color: colorPrimary,
                              decoration: TextDecoration.lineThrough)),
                  ],
                );
              },
            ),
            SizedBox(
              height: sizeH2,
            ),
            CustomTextView(
              txt: "${tr.other_services_eparately}",
              textAlign: TextAlign.center,
              textStyle: textStyleNormal()?.copyWith(fontSize: fontSize14),
            ),
            SizedBox(
              height: sizeH20,
            ),
          ],
        ),
      );

  Widget get acceptTerms => GetBuilder<StorageViewModel>(
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
                txt:
                    "${profileViewModle.myPoints.totalPoints} ${tr.points} = ${profileViewModle.myPoints.totalPoints! * SharedPref.instance.getCurrentUserData().conversionFactor!} QR",
                textAlign: TextAlign.start,
                textStyle: textStyleNormal()!
                    .copyWith(color: colorPrimary, fontSize: fontSize14),
              ),
            ],
          );
        },
      );

  Widget get promoCode => GetBuilder<StorageViewModel>(builder: (builder) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    builder.isUsingPromo = !builder.isUsingPromo;
                    builder.update();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      builder.isUsingPromo
                          ? SvgPicture.asset("assets/svgs/true.svg")
                          : SvgPicture.asset(
                              "assets/svgs/uncheck.svg",
                              color: seconderyColor,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomTextView(
                        txt: "${tr.use_promo_code} ",
                        textStyle: textStyle(),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: sizeH12,
            ),
            if (builder.isUsingPromo)
              TextField(
                controller: storageViewModle.tdCopun,
                onSubmitted: (value) async {
                  await storageViewModle.checkPromo(promoCode: value);
                },
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(
                    suffixIcon: builder.checkPromoAppResponse != null
                        ? Padding(
                            padding: EdgeInsets.all(padding12!),
                            child:
                                builder.checkPromoAppResponse!.status!.success!
                                    ? SvgPicture.asset(
                                        "assets/svgs/icon_big_check.svg")
                                    : SvgPicture.asset(
                                        "assets/svgs/cross_big.svg",
                                      ),
                          )
                        : const SizedBox(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorBorderContainer),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorBorderContainer),
                    ),
                    hintText: "${tr.promo_code}"),
              )
          ],
        );
      });

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(padding30!)),
          color: colorTextWhite,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sizeW15!),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: sizeH20,
              ),
              SpacerdColor(),
              SizedBox(
                height: sizeH20,
              ),
              CustomTextView(
                txt: "${tr.payment_method}",
                textAlign: TextAlign.center,
                textStyle: textStyleAppBarTitle(),
              ),
              SizedBox(
                height: sizeH20,
              ),
              priceTotalWidget,
              SizedBox(
                height: sizeH16,
              ),
              // onDestroy(),
              Text("${tr.select_payment_method}"),
              SizedBox(
                height: sizeH16,
              ),
              GetBuilder<StorageViewModel>(builder: (logic) {
                return Container(
                  height: sizeH38,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: getPaymentMethod().length,
                    itemBuilder: (context, index) {
                      PaymentMethod? paymentMethod = getPaymentMethod()[index];
                      var calculateTasksCart = boxes.length == 0
                          ? logic.calculateTaskPriceOnceBox(task: task)
                          : logic.calculateTaskPriceLotBoxess(
                              isFromCart: false, task: task, boxess: boxes);
                      if (paymentMethod.name == LocalConstance.bankCard &&
                          int.tryParse(calculateTasksCart.toString())
                                  ?.toInt() ==
                              0) {
                        return const SizedBox.shrink();
                      } else {
                        return PaymentItem(
                          paymentMethod: paymentMethod,
                        );
                      }
                    },
                    // children: getPaymentMethod()
                    //     .map((e) => PaymentItem(
                    //           paymentMethod: e,
                    //         ))
                    //     .toList(),
                  ),
                );
              }),
              SizedBox(
                height: sizeH16,
              ),
              promoCode,
              SizedBox(
                height: sizeH16,
              ),
              profileViewModle.myPoints.totalPoints! > 0
                  ? acceptTerms
                  : const SizedBox(),
              SizedBox(
                height: sizeH16,
              ),
              GetBuilder<StorageViewModel>(
                builder: (logic) {
                  return PrimaryButton(
                    isExpanded: true,
                    isLoading: logic.isLoading,
                    onClicked: onClickSubmit,
                    textButton: "${tr.submit}",
                  );
                },
              ),
              SizedBox(
                height: sizeH16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  onClickSubmit() {
    if (storageViewModle.isAccept || storageViewModle.isUsingPromo) {
      if (storageViewModle.priceAfterDiscount > 0) {
        if (storageViewModle.selectedPaymentMethod != null) {
          if (storageViewModle.selectedPaymentMethod?.id == Constance.cashId ||
              storageViewModle.selectedPaymentMethod?.id ==
                  Constance.walletId) {
            if (boxes.length > 0) {
              storageViewModle.doTaskBoxRequest(
                  isFromCart: false,
                  task: task,
                  boxes: boxes,
                  selectedItems: items,
                  beneficiaryId: beneficiaryId);
            } else {
              storageViewModle.doTaskBoxRequest(
                  isFromCart: false,
                  task: task,
                  boxes: [box],
                  selectedItems: items,
                  beneficiaryId: beneficiaryId);
            }
          } else {
            storageViewModle.goToPaymentMethod(
                isOrderProductPayment: false,
                cartModels: [],
                isFromCart: false,
                amount: storageViewModle.priceAfterDiscount,
                beneficiaryId: beneficiaryId,
                task: task,
                boxes: boxes,
                isFromNewStorage: false);
          }
        } else {
          snackError("${tr.error_occurred}",
              "${tr.you_have_to_select_payment_method}");
        }
      } else {
        if (boxes.length > 0) {
          storageViewModle.doTaskBoxRequest(
              isFromCart: false,
              task: task,
              boxes: boxes,
              selectedItems: items,
              beneficiaryId: beneficiaryId);
        } else {
          storageViewModle.doTaskBoxRequest(
              isFromCart: false,
              task: task,
              boxes: [box],
              selectedItems: items,
              beneficiaryId: beneficiaryId);
        }
      }
      return;
    }
    if (storageViewModle.selectedPaymentMethod != null) {
      if (storageViewModle.selectedPaymentMethod?.id == Constance.cashId ||
          storageViewModle.selectedPaymentMethod?.id == Constance.walletId) {
        if (boxes.length > 0) {
          storageViewModle.doTaskBoxRequest(
              isFromCart: false,
              task: task,
              boxes: boxes,
              selectedItems: items,
              beneficiaryId: beneficiaryId);
        } else {
          storageViewModle.doTaskBoxRequest(
              isFromCart: false,
              task: task,
              boxes: [box],
              selectedItems: items,
              beneficiaryId: beneficiaryId);
        }
      } else {
        storageViewModle.goToPaymentMethod(
            isOrderProductPayment: false,
            cartModels: [],
            isFromCart: false,
            amount: num.parse(storageViewModle
                .calculateTaskPriceLotBoxess(
                  isFromCart: false,
                  task: task,
                  boxess: boxes,
                )
                .toString()
                .split(" ")[0]),
            beneficiaryId: beneficiaryId,
            task: task,
            boxes: boxes,
            isFromNewStorage: false);
      }
    } else {
      snackError(
          "${tr.error_occurred}", "${tr.you_have_to_select_payment_method}");
    }
  }
}
