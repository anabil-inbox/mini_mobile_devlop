import 'dart:io';

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
import 'package:inbox_clients/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/icon_btn.dart';
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
import 'package:logger/logger.dart';

import '../primary_button.dart';

class BottomSheetPaymentWidget extends StatefulWidget {
  final Task task;
  final Box box;
  final List<Box> boxes;
  final List<BoxItem>? items;
  final String beneficiaryId;
  final bool? isFirstPickUp;

  const BottomSheetPaymentWidget({
    Key? key,
    required this.task,
    required this.box,
    required this.boxes,
    this.items,
    required this.beneficiaryId,
    this.isFirstPickUp = false,
  }) : super(key: key);

  static StorageViewModel storageViewModle = Get.find<StorageViewModel>();
  static ProfileViewModle profileViewModle =
      Get.put(ProfileViewModle(), permanent: true);

  @override
  State<BottomSheetPaymentWidget> createState() =>
      _BottomSheetPaymentWidgetState();
}

class _BottomSheetPaymentWidgetState extends State<BottomSheetPaymentWidget> {
  Widget onDestroy() {
    if (widget.task.id != LocalConstance.destroyId) {
      return const SizedBox();
    }
    return Column(
      children: [
        SizedBox(
          height: sizeH12,
        ),
        Text(tr.choose_destroy_place),
        SizedBox(
          height: sizeH12,
        ),
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
                      txt: handlePrice(logic),
                      textStyle: textStyleAppBarTitle()
                          ?.copyWith(fontSize: fontSize28, color: colorPrimary),
                    ),
                    if ((BottomSheetPaymentWidget.storageViewModle.isAccept &&
                            BottomSheetPaymentWidget.storageViewModle.priceAfterDiscount >= 0) ||
                        /*BottomSheetPaymentWidget.storageViewModle.isUsingPromo*/
                        (BottomSheetPaymentWidget.storageViewModle.checkPromoAppResponse != null &&
                            BottomSheetPaymentWidget.storageViewModle.checkPromoAppResponse!.status != null &&
                            BottomSheetPaymentWidget.storageViewModle.checkPromoAppResponse!.status!.success!) ||
                        (widget.isFirstPickUp! &&
                            widget.task.id == LocalConstance.pickupId)) ...[
                      SizedBox(
                        width: sizeW7,
                      ),
                      CustomTextView(
                          txt: widget.boxes.length == 0
                              ? logic.calculateTaskPriceOnceBox(
                                  task: widget.task)
                              : logic.calculateTaskPriceLotBoxess(
                                  isFromCart: false,
                                  task: widget.task,
                                  boxess: widget.boxes,
                                  isFirstPickUp: widget.isFirstPickUp! &&
                                      widget.task.id ==
                                          LocalConstance
                                              .pickupId) /*logic.calculateTaskPriceLotBoxess(
                              isFromCart: false,
                              task: widget.task,
                              boxess: widget.boxes,
                              isFirstPickUp: widget.isFirstPickUp! &&
                                  widget.task.id == LocalConstance.pickupId)*/
                          ,
                          textAlign: TextAlign.center,
                          textStyle: textStyleAppBarTitle()?.copyWith(
                              fontSize: fontSize14,
                              color: colorPrimary,
                              decoration: TextDecoration.lineThrough))
                    ],
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

  Widget get myPointsText => GetBuilder<StorageViewModel>(
        builder: (value) {
          Logger().e("CONVERCATION FACTOR ${SharedPref.instance.getCurrentUserData().conversionFactor}"
              "pointSpentBoundary: ${SharedPref.instance.getAppSettings()!.pointSpentBoundary}");
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (handlePrice(value).replaceAll("QR", "").trim() == "0.00" && value.isUsingPromo && !value.isAccept) {
                    return;
                  }
                  value.isAccept = !value.isAccept;
                  value.update();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    value.isAccept
                        ? SvgPicture.asset("assets/svgs/true_orange.svg") //true
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
                    "${BottomSheetPaymentWidget.profileViewModle.paidPoints( widget.task.copyWith(price:widget.task.price! * (widget.boxes.isEmpty ? 1 : widget.boxes.length) ))/*myPoints.totalPoints*/} ${tr.points} = ${BottomSheetPaymentWidget.profileViewModle.pointsCalcPrice( widget.task.copyWith(price:widget.task.price! * (widget.boxes.isEmpty ? 1 : widget.boxes.length) ))} QR",
                //${BottomSheetPaymentWidget.profileViewModle.myPoints.totalPoints! * SharedPref.instance.getCurrentUserData().conversionFactor!}
                textAlign: TextAlign.start,
                textStyle: textStyleNormal()!
                    .copyWith(color: colorPrimary, fontSize: fontSize14),
              ),
            ],
          );
        },
      );

  Widget get promoCode => GetBuilder<StorageViewModel>(builder: (builder) {
        if (widget.task.id != LocalConstance.terminateId)
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (builder.isUsingPromo ) {
                        BottomSheetPaymentWidget.storageViewModle.tdCopun
                            .clear();
                        BottomSheetPaymentWidget.storageViewModle
                            .checkPromoAppResponse?.status?.success = false;
                      }
                      builder.isUsingPromo = !builder.isUsingPromo;
                      builder.update();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        builder.isUsingPromo
                            ? SvgPicture.asset(
                                "assets/svgs/true_orange.svg") //true
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
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller:
                            BottomSheetPaymentWidget.storageViewModle.tdCopun,
                        onSubmitted: (value) async {
                          if(BottomSheetPaymentWidget.storageViewModle.tdCopun.text.isNotEmpty) {
                            await BottomSheetPaymentWidget.storageViewModle
                                .checkPromo(promoCode: value);
                          }
                        },
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                            suffixIcon: builder.checkPromoAppResponse != null
                                ? Padding(
                                    padding: EdgeInsets.all(padding12!),
                                    child: builder.checkPromoAppResponse!
                                                    .status !=
                                                null &&
                                            builder.checkPromoAppResponse!
                                                .status!.success!
                                        ? SvgPicture.asset(
                                            "assets/svgs/icon_big_check.svg")
                                        : SvgPicture.asset(
                                            "assets/svgs/cross_big.svg",
                                          ),
                                  )
                                : const SizedBox(),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: colorBorderContainer),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: colorBorderContainer),
                            ),
                            hintText: "${tr.promo_code}"),
                      ),
                    ),
                    SizedBox(
                      width: sizeW10,
                    ),
                    IconBtn(
                      onPressed: () async {
                        await BottomSheetPaymentWidget.storageViewModle
                            .checkPromo(
                                promoCode: BottomSheetPaymentWidget
                                    .storageViewModle.tdCopun.text);
                      },
                      backgroundColor: builder.checkPromoAppResponse != null &&
                              builder.checkPromoAppResponse!.status != null &&
                              builder.checkPromoAppResponse!.status!.success!
                          ? colorGreen
                          : colorPrimary,
                      width: sizeW50,
                      height: sizeH50,
                      borderColor: colorTextWhite,
                      icon: "assets/svgs/check_icons.svg",
                      iconColor: colorTextWhite,
                    )
                  ],
                )
            ],
          );
        else
          return const SizedBox.shrink();
      });

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (BottomSheetPaymentWidget.storageViewModle.imageBankTransfer != null) {
      BottomSheetPaymentWidget.storageViewModle.imageBankTransfer = null;
      BottomSheetPaymentWidget.storageViewModle.update();
    }
    BottomSheetPaymentWidget.storageViewModle.checkPromoAppResponse = null;
    BottomSheetPaymentWidget.storageViewModle.tdCopun.clear();
    BottomSheetPaymentWidget.storageViewModle.isUsingPromo = false;
    BottomSheetPaymentWidget.storageViewModle.isAccept = false;
    BottomSheetPaymentWidget.storageViewModle.update();
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    Logger().w(widget.task.toJson());
    Logger().w(widget.isFirstPickUp);
    Logger()
        .w(!widget.isFirstPickUp! && widget.task.id != LocalConstance.pickupId);
    Logger().w(BottomSheetPaymentWidget.profileViewModle.myPoints.totalPoints);
    Logger().w(((BottomSheetPaymentWidget.storageViewModle.isAccept &&
            BottomSheetPaymentWidget.storageViewModle.priceAfterDiscount > 0) ||
        /*BottomSheetPaymentWidget.storageViewModle.isUsingPromo*/
        (BottomSheetPaymentWidget.storageViewModle.checkPromoAppResponse !=
                null &&
            BottomSheetPaymentWidget
                    .storageViewModle.checkPromoAppResponse!.status !=
                null &&
            BottomSheetPaymentWidget
                .storageViewModle.checkPromoAppResponse!.status!.success!) ||
        (widget.isFirstPickUp! && widget.task.id == LocalConstance.pickupId)));
    return GetBuilder<StorageViewModel>(
        init: StorageViewModel(),
        builder: (logic) {
          // Logger().w("handlePrice_${handlePrice(logic)}");
          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(padding30!)),
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
                    // Container(
                    //   height: sizeH38,
                    //   child: ListView.builder(
                    //     shrinkWrap: true,
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: getPaymentMethod().length,
                    //     itemBuilder: (context, index) {
                    //       PaymentMethod? paymentMethod = getPaymentMethod()[index];
                    //       var calculateTasksCart = widget.boxes.length == 0
                    //           ? logic.calculateTaskPriceOnceBox(task: widget.task)
                    //           : logic.calculateTaskPriceLotBoxess(
                    //               isFromCart: false, task: widget.task, boxess: widget.boxes);
                    //       if (paymentMethod.name == LocalConstance.bankCard &&
                    //           int.tryParse(calculateTasksCart.toString())
                    //                   ?.toInt() ==
                    //               0) {
                    //         return const SizedBox.shrink();
                    //       } else {
                    //         return PaymentItem(
                    //           paymentMethod: paymentMethod,
                    //           isDisable: ((logic.isAccept || logic.isUsingPromo) &&
                    //                   BottomSheetPaymentWidget.storageViewModle.priceAfterDiscount == 0)
                    //               ? true
                    //               : false,
                    //         );
                    //       }
                    //     },
                    //     // children: getPaymentMethod()
                    //     //     .map((e) => PaymentItem(
                    //     //           paymentMethod: e,
                    //     //         ))
                    //     //     .toList(),
                    //   ),
                    // ),
                    Container(
                      // height: sizeH38,
                      child: Wrap(
                        // shrinkWrap: true,
                        // scrollDirection: Axis.horizontal,
                        spacing: 10,
                        runSpacing: 5,
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: getPaymentMethod().map((e) {
                          var calculateTasksCart = widget.boxes.length == 0
                              ? logic.calculateTaskPriceOnceBox(
                                  task: widget.task)
                              : logic.calculateTaskPriceLotBoxess(
                                  isFromCart: false,
                                  task: widget.task,
                                  boxess: widget.boxes,
                                  isFirstPickUp: widget.isFirstPickUp! &&
                                      widget.task.id ==
                                          LocalConstance.pickupId);
                          if (e.name == LocalConstance.bankCard &&
                              int.tryParse(calculateTasksCart.toString())
                                      ?.toInt() ==
                                  0) {
                            return const SizedBox.shrink();
                          } else {
                            return PaymentItem(
                              isFirstPickUp: widget.isFirstPickUp! &&
                                  widget.task.id == LocalConstance.pickupId,
                              paymentMethod: e,
                              isDisable:
                                  ((logic.isAccept || logic.isUsingPromo) &&
                                          BottomSheetPaymentWidget
                                                  .storageViewModle
                                                  .priceAfterDiscount ==
                                              0)
                                      ? true
                                      : false,
                              isApple: false,
                            );
                          }
                          // return PaymentItem(
                          //   isRecivedOrderPayment: isRecivedOrderPayment,
                          //   paymentMethod: e,
                          // );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: sizeH16,
                    ),
                    // if (Platform.isIOS) ...[
                    //   SizedBox(
                    //     width: MediaQuery.of(context).size.width / 1.13,
                    //     child: PaymentItem(
                    //       isFirstPickUp: widget.isFirstPickUp! &&
                    //           widget.task.id == LocalConstance.pickupId,
                    //       doPossess: () {
                    //         if (BottomSheetPaymentWidget.storageViewModle.isAccept ||
                    //             BottomSheetPaymentWidget.storageViewModle.isUsingPromo) {
                    //           if (BottomSheetPaymentWidget.storageViewModle.priceAfterDiscount > 0) {
                    //             if (BottomSheetPaymentWidget.storageViewModle.selectedPaymentMethod?.id != null) {
                    //               if (widget.boxes.length > 0) {
                    //                 BottomSheetPaymentWidget.storageViewModle
                    //                     .doTaskBoxRequest(
                    //                         isFirstPickUp:
                    //                             widget.isFirstPickUp! &&
                    //                                 widget.task.id ==
                    //                                     LocalConstance.pickupId,
                    //                         isFromCart: false,
                    //                         task: widget.task,
                    //                         boxes: widget.boxes,
                    //                         selectedItems: widget.items,
                    //                         beneficiaryId:
                    //                             widget.beneficiaryId);
                    //               } else {
                    //                 BottomSheetPaymentWidget.storageViewModle
                    //                     .doTaskBoxRequest(
                    //                         isFirstPickUp:
                    //                             widget.isFirstPickUp! &&
                    //                                 widget.task.id ==
                    //                                     LocalConstance.pickupId,
                    //                         isFromCart: false,
                    //                         task: widget.task,
                    //                         boxes: [widget.box],
                    //                         selectedItems: widget.items,
                    //                         beneficiaryId:
                    //                             widget.beneficiaryId);
                    //               }
                    //             }
                    //           }
                    //           return;
                    //         }
                    //     if (BottomSheetPaymentWidget.storageViewModle.selectedPaymentMethod?.id != null) {
                    //       if (widget.boxes.length > 0) {
                    //         BottomSheetPaymentWidget.storageViewModle
                    //             .doTaskBoxRequest(
                    //             isFirstPickUp:
                    //             widget.isFirstPickUp! &&
                    //                 widget.task.id ==
                    //                     LocalConstance.pickupId,
                    //             isFromCart: false,
                    //             task: widget.task,
                    //             boxes: widget.boxes,
                    //             selectedItems: widget.items,
                    //             beneficiaryId:
                    //             widget.beneficiaryId);
                    //       } else {
                    //         BottomSheetPaymentWidget.storageViewModle
                    //             .doTaskBoxRequest(
                    //             isFirstPickUp:
                    //             widget.isFirstPickUp! &&
                    //                 widget.task.id ==
                    //                     LocalConstance.pickupId,
                    //             isFromCart: false,
                    //             task: widget.task,
                    //             boxes: [widget.box],
                    //             selectedItems: widget.items,
                    //             beneficiaryId:
                    //             widget.beneficiaryId);
                    //       }
                    //     }
                    //
                    //
                    //       },
                    //       isDoPossess: true,
                    //       isDisable: ((logic.isAccept || logic.isUsingPromo) &&
                    //               BottomSheetPaymentWidget.storageViewModle
                    //                       .priceAfterDiscount ==
                    //                   0)
                    //           ? true
                    //           : false,
                    //       price: widget.boxes.length == 0
                    //           ? logic.calculateTaskPriceOnceBox(
                    //               task: widget.task)
                    //           : logic.calculateTaskPriceLotBoxess(
                    //               isFromCart: false,
                    //               task: widget.task,
                    //               boxess: widget.boxes,
                    //               isFirstPickUp: widget.isFirstPickUp! &&
                    //                   widget.task.id ==
                    //                       LocalConstance.pickupId),
                    //       paymentMethod: PaymentMethod(
                    //           id: LocalConstance.applePay,
                    //           name: LocalConstance.applePay,
                    //           image: Constance.appleImage),
                    //       isApple: true,
                    //     ),
                    //   ),
                    //   SizedBox(
                    //     height: sizeH16,
                    //   ),
                    // ],
                    if (logic.selectedPaymentMethod?.id ==
                        Constance.bankTransferId) ...[
                      SizedBox(
                        height: sizeH16,
                      ),
                      CustomTextFormFiled(
                        isReadOnly: true,
                        fun: () async {
                          logic.onBankImageClick();
                        },
                        label: logic.imageBankTransfer != null
                            ? logic.imageBankTransfer?.path
                                .split("/")
                                .last
                                .toString()
                            : tr.select_image,
                        isFill: false,
                        isBorder: true,
                        enabledBorderColor: colorContainerGray,
                        // fillColor: colorTextWhite,
                      ),
                    ],
                    SizedBox(
                      height: sizeH16,
                    ),
                    if (!widget
                        .isFirstPickUp! /*&& widget.task.id != LocalConstance.pickupId*/) ...[
                      promoCode,
                      SizedBox(
                        height: sizeH16,
                      ),
                    ],
                    // if (handlePrice(logic).replaceAll("QR","").trim() != "0.00" && !BottomSheetPaymentWidget.storageViewModle.isUsingPromo && !widget.isFirstPickUp!/*&& BottomSheetPaymentWidget.profileViewModle.myPoints.totalPoints! > 0*/)
                    BottomSheetPaymentWidget.profileViewModle.myPoints.totalPoints != null &&
                            BottomSheetPaymentWidget.profileViewModle.myPoints.totalPoints! > /*0*/
                                SharedPref.instance.getAppSettings()!.pointSpentBoundary!.toInt()
                        ? myPointsText
                        : const SizedBox(),
                    SizedBox(
                      height: sizeH16,
                    ),
                    PrimaryButton(
                      isExpanded: true,
                      isLoading: logic.isLoading,
                      onClicked: onClickSubmit,
                      textButton: "${tr.submit}",
                    ),
                    SizedBox(
                      height: sizeH16,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  onClickSubmit() {
    if (BottomSheetPaymentWidget.storageViewModle.isAccept ||
        BottomSheetPaymentWidget.storageViewModle.isUsingPromo) {
      if (BottomSheetPaymentWidget.storageViewModle.priceAfterDiscount > 0) {
        if (BottomSheetPaymentWidget
                .storageViewModle.selectedPaymentMethod?.id !=
            null) {
          if (BottomSheetPaymentWidget
                      .storageViewModle.selectedPaymentMethod?.id ==
                  Constance.cashId ||
              /*storageViewModle.selectedPaymentMethod?.id == Constance.bankTransferId ||*/
              BottomSheetPaymentWidget
                      .storageViewModle.selectedPaymentMethod?.id ==
                  Constance.pointOfSaleId) {
            if (widget.boxes.length > 0) {
              BottomSheetPaymentWidget.storageViewModle.doTaskBoxRequest(
                  isFirstPickUp: widget.isFirstPickUp! &&
                      widget.task.id == LocalConstance.pickupId,
                  isFromCart: false,
                  task: widget.task,
                  boxes: widget.boxes,
                  selectedItems: widget.items,
                  beneficiaryId: widget.beneficiaryId);
            } else {
              BottomSheetPaymentWidget.storageViewModle.doTaskBoxRequest(
                  isFirstPickUp: widget.isFirstPickUp! &&
                      widget.task.id == LocalConstance.pickupId,
                  isFromCart: false,
                  task: widget.task,
                  boxes: [widget.box],
                  selectedItems: widget.items,
                  beneficiaryId: widget.beneficiaryId);
            }
          } else if (BottomSheetPaymentWidget
                  .storageViewModle.selectedPaymentMethod?.id ==
              Constance.bankTransferId) {
          } else if (BottomSheetPaymentWidget
                  .storageViewModle.selectedPaymentMethod?.id ==
              Constance.walletId) {
            if (num.tryParse(BottomSheetPaymentWidget
                        .profileViewModle.myWallet.balance
                        .toString() /*??
                    "0"*/
                    )! >=
                BottomSheetPaymentWidget.storageViewModle.priceAfterDiscount) {
              if (widget.boxes.length > 0) {
                BottomSheetPaymentWidget.storageViewModle.doTaskBoxRequest(
                    isFirstPickUp: widget.isFirstPickUp! &&
                        widget.task.id == LocalConstance.pickupId,
                    isFromCart: false,
                    task: widget.task,
                    boxes: widget.boxes,
                    selectedItems: widget.items,
                    beneficiaryId: widget.beneficiaryId);
              } else {
                BottomSheetPaymentWidget.storageViewModle.doTaskBoxRequest(
                    isFirstPickUp: widget.isFirstPickUp! &&
                        widget.task.id == LocalConstance.pickupId,
                    isFromCart: false,
                    task: widget.task,
                    boxes: [widget.box],
                    selectedItems: widget.items,
                    beneficiaryId: widget.beneficiaryId);
              }
            } else {
              snackError(
                  "${tr.error_occurred}", "Wallet balance is not enough");
            }
          } else {
            BottomSheetPaymentWidget.storageViewModle.goToPaymentMethod(
                isOrderProductPayment: false,
                cartModels: [],
                isFromCart: false,
                amount: BottomSheetPaymentWidget
                    .storageViewModle.priceAfterDiscount,
                beneficiaryId: widget.beneficiaryId,
                task: widget.task,
                boxes: widget.boxes,
                isFromNewStorage: false,
                isFromEditOrder: false);
          }
        } else {
          snackError("${tr.error_occurred}",
              "${tr.you_have_to_select_payment_method}");
        }
      } else {
        if (widget.boxes.length > 0) {
          BottomSheetPaymentWidget.storageViewModle.doTaskBoxRequest(
              isFirstPickUp: widget.isFirstPickUp! &&
                  widget.task.id == LocalConstance.pickupId,
              isFromCart: false,
              task: widget.task,
              boxes: widget.boxes,
              selectedItems: widget.items,
              beneficiaryId: widget.beneficiaryId);
        } else {
          BottomSheetPaymentWidget.storageViewModle.doTaskBoxRequest(
              isFirstPickUp: widget.isFirstPickUp! &&
                  widget.task.id == LocalConstance.pickupId,
              isFromCart: false,
              task: widget.task,
              boxes: [widget.box],
              selectedItems: widget.items,
              beneficiaryId: widget.beneficiaryId);
        }
      }
      return;
    }
    if (BottomSheetPaymentWidget.storageViewModle.selectedPaymentMethod?.id != null) {
      if (BottomSheetPaymentWidget.storageViewModle.selectedPaymentMethod?.id == Constance.cashId ||
          BottomSheetPaymentWidget.storageViewModle.selectedPaymentMethod?.id ==
              Constance.bankTransferId ||
          BottomSheetPaymentWidget.storageViewModle.selectedPaymentMethod?.id ==
              Constance.pointOfSaleId) {
        if (widget.boxes.length > 0) {
          BottomSheetPaymentWidget.storageViewModle.doTaskBoxRequest(
              isFirstPickUp: widget.isFirstPickUp! &&
                  widget.task.id == LocalConstance.pickupId,
              isFromCart: false,
              task: widget.task,
              boxes: widget.boxes,
              selectedItems: widget.items,
              beneficiaryId: widget.beneficiaryId);
        } else {
          BottomSheetPaymentWidget.storageViewModle.doTaskBoxRequest(
              isFirstPickUp: widget.isFirstPickUp! &&
                  widget.task.id == LocalConstance.pickupId,
              isFromCart: false,
              task: widget.task,
              boxes: [widget.box],
              selectedItems: widget.items,
              beneficiaryId: widget.beneficiaryId);
        }
      } else if (BottomSheetPaymentWidget
              .storageViewModle.selectedPaymentMethod?.id ==
          Constance.walletId) {
        var amount = widget.boxes.length == 0
            ? BottomSheetPaymentWidget.storageViewModle
                .calculateTaskPriceOnceBox(task: widget.task)
            : BottomSheetPaymentWidget.storageViewModle
                .calculateTaskPriceLotBoxess(
                    isFromCart: false,
                    task: widget.task,
                    boxess: widget.boxes,
                    isFirstPickUp: widget.isFirstPickUp! &&
                        widget.task.id == LocalConstance.pickupId);

        if (num.tryParse(amount.toString().split(" ")[0])! <=
            num.tryParse(BottomSheetPaymentWidget
                .profileViewModle.myWallet.balance
                .toString() /*?? "0"*/)!) {
          if (widget.boxes.length > 0) {
            BottomSheetPaymentWidget.storageViewModle.doTaskBoxRequest(
              isFromCart: false,
              task: widget.task,
              boxes: widget.boxes,
              selectedItems: widget.items,
              beneficiaryId: widget.beneficiaryId,
              isFirstPickUp: widget.isFirstPickUp! &&
                  widget.task.id == LocalConstance.pickupId,
            );
          } else {
            BottomSheetPaymentWidget.storageViewModle.doTaskBoxRequest(
                isFirstPickUp: widget.isFirstPickUp! &&
                    widget.task.id == LocalConstance.pickupId,
                isFromCart: false,
                task: widget.task,
                boxes: [widget.box],
                selectedItems: widget.items,
                beneficiaryId: widget.beneficiaryId);
          }
        } else {
          snackError("${tr.error_occurred}", "Wallet balance is not enough");
        }
      } else {
        var amount = widget.boxes.length == 0
            ? BottomSheetPaymentWidget.storageViewModle
                .calculateTaskPriceOnceBox(task: widget.task)
            : BottomSheetPaymentWidget.storageViewModle
                .calculateTaskPriceLotBoxess(
                    isFromCart: false,
                    task: widget.task,
                    boxess: widget.boxes,
                    isFirstPickUp: widget.isFirstPickUp! &&
                        widget.task.id == LocalConstance.pickupId);
        Logger().e("AMOUNT $amount");
        BottomSheetPaymentWidget.storageViewModle.goToPaymentMethod(
            isOrderProductPayment: false,
            cartModels: [],
            isFromCart: false,
            amount: num.parse(amount.toString().split(" ")[0]),
            beneficiaryId: widget.beneficiaryId,
            task: widget.task,
            boxes: widget.boxes,
            isFromNewStorage: false,
            isFromEditOrder: false);
      }
    } else {
      snackError(
          "${tr.error_occurred}", "${tr.you_have_to_select_payment_method}");
    }
  }

  String handlePrice(StorageViewModel logic) {
    return (BottomSheetPaymentWidget.storageViewModle.isAccept ||
            BottomSheetPaymentWidget.storageViewModle.isUsingPromo ||
            (widget.isFirstPickUp! &&
                widget.task.id == LocalConstance.pickupId))
        ? BottomSheetPaymentWidget.storageViewModle
            .getPriceWithDiscount(
                isFirstPickUp: widget.isFirstPickUp! &&
                    widget.task.id == LocalConstance.pickupId,
                oldPrice: logic
                    .calculateTaskPriceLotBoxess(
                        isFirstPickUp: widget.isFirstPickUp! &&
                            widget.task.id == LocalConstance.pickupId,
                        isFromCart: false,
                        task: widget.task,
                        boxess:
                            widget.boxes.isEmpty ? [widget.box] : widget.boxes)
                    .toString()
                    .split(" ")[0], task: widget.task.copyWith(price:widget.task.price! * (widget.boxes.isEmpty ? 1 : widget.boxes.length) ) , )[0]
            .toString()
        : widget.boxes.length == 0
            ? logic.calculateTaskPriceOnceBox(task: widget.task)
            : logic.calculateTaskPriceLotBoxess(
                isFromCart: false,
                task: widget.task,
                boxess: widget.boxes,
                isFirstPickUp: widget.isFirstPickUp! &&
                    widget.task.id == LocalConstance.pickupId);
  }
}
