import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/model/storage/payment.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_three_widgets/payment_item.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/icon_btn.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/local_database/model/cart_model.dart';
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

class BottomSheetPaymentCartWidget extends StatelessWidget {
  const BottomSheetPaymentCartWidget({Key? key, required this.cartModels})
      : super(key: key);
  final List<CartModel> cartModels;

  static StorageViewModel storageViewModle = Get.find<StorageViewModel>();
  static ProfileViewModle profileViewModle =
      Get.put(ProfileViewModle(), permanent: true);

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
                      // txt: storageViewModle.calculateTasksCart(
                      //     cartModel: cartModels),

                      txt: storageViewModle
                          .getPriceWithDiscount(
                              oldPrice: logic
                                  .calculateTasksCart(cartModel: cartModels)
                                  .toString()
                                  .split(" ")[0],
                              isFirstPickUp: false, task: Task(price: num.tryParse(logic
                          .calculateTasksCart(cartModel: cartModels)
                          .toString()
                          .split(" ")[0].toString())),  /*getIsFirstPickUp()*/)[0]
                          .toString(),

                      textStyle: textStyleAppBarTitle()
                          ?.copyWith(fontSize: fontSize28, color: colorPrimary),
                    ),
                    if (storageViewModle.isAccept ||
                        storageViewModle.isUsingPromo)
                      SizedBox(
                        width: sizeW7,
                      ),
                    if ((storageViewModle.isAccept ||
                            storageViewModle.isUsingPromo) &&
                        storageViewModle.checkPromoAppResponse != null &&
                        storageViewModle.checkPromoAppResponse!.status !=
                            null &&
                        storageViewModle
                            .checkPromoAppResponse!.status!.success!)
                      CustomTextView(
                          txt: storageViewModle.calculateTasksCart(
                              cartModel: cartModels),
                          // txt:
                          // logic.getPriceWithDiscount(
                          //     oldPrice: storageViewModle
                          //         .calculateTasksCart(cartModel: cartModels)
                          //         .toString()
                          //         .split(" ")[0])[0],
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
                    "${profileViewModle.paidPoints(Task(price: num.tryParse(storageViewModle
                        .calculateTasksCart(cartModel: cartModels)
                        .toString()
                        .split(" ")[0].toString())) )/*myPoints.totalPoints*/} ${tr.points} = ${profileViewModle.pointsCalcPrice(Task(price: num.tryParse(storageViewModle
                        .calculateTasksCart(cartModel: cartModels)
                        .toString()
                        .split(" ")[0].toString())) )/*profileViewModle.myPoints.totalPoints! * SharedPref.instance.getCurrentUserData().conversionFactor!*/} QR",
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
                    if (builder.isUsingPromo) {
                      builder.tdCopun.clear();
                      builder.checkPromoAppResponse?.status?.success = false;
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
                                      builder.checkPromoAppResponse!.status !=
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
                            borderSide: BorderSide(color: colorBorderContainer),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: colorBorderContainer),
                          ),
                          hintText: "${tr.promo_code}"),
                    ),
                  ),
                  SizedBox(
                    width: sizeW10,
                  ),
                  IconBtn(
                    onPressed: () async {
                      if(builder.tdCopun.text.isNotEmpty) {
                        await builder.checkPromo(promoCode: builder.tdCopun.text);
                      }
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
      });

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return WillPopScope(
      onWillPop: () {
        storageViewModle.isAccept = false;
        storageViewModle.update();
        return Future.value(true);
      },
      child: SingleChildScrollView(
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
                Text("${tr.select_payment_method}"),
                SizedBox(
                  height: sizeH16,
                ),
                // Container(
                //   height: sizeH38,
                //   child: ListView.builder(
                //     shrinkWrap: true,
                //     itemCount: getPaymentMethod().length,
                //     scrollDirection: Axis.horizontal,
                //     itemBuilder:  (context, index) {
                //       PaymentMethod? paymentMethod = getPaymentMethod()[index];
                //       var calculateTasksCart = storageViewModle.calculateTasksCart(cartModel: cartModels);
                //       Logger().d("${paymentMethod.name} ${LocalConstance.bankCard}");
                //       if(paymentMethod.name == LocalConstance.bankCard && int.tryParse(calculateTasksCart.toString())?.toInt()  == 0)
                //         {
                //           return const SizedBox.shrink();
                //         }
                //       else{
                //         return PaymentItem(
                //           paymentMethod:paymentMethod,
                //         );
                //       }
                //
                //     },
                //     // children: getPaymentMethod()
                //     //     .map((e) {
                //     //       return PaymentItem(
                //     //           paymentMethod: e,
                //     //         );
                //     //     }).toList(),
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
                      // PaymentMethod? paymentMethod = getPaymentMethod()[index];
                      var calculateTasksCart = storageViewModle
                          .calculateTasksCart(cartModel: cartModels);
                      Logger().d("${e.name} ${LocalConstance.bankCard}");
                      if (e.name == LocalConstance.bankCard &&
                          num.tryParse(calculateTasksCart.toString())
                                  ?.toInt() ==
                              0) {
                        return const SizedBox.shrink();
                      } else {
                        // width: e.id  == LocalConstance.applePay  &&e.image == Constance.appleImage ? MediaQuery.of(context).size.width / 1.9 : MediaQuery.of(context).size.width /4,
                        return PaymentItem(
                          isDisable: storageViewModle
                                      .getPriceWithDiscount(
                                          oldPrice: storageViewModle
                                              .calculateTasksCart(
                                                  cartModel: cartModels)
                                              .toString()
                                              .split(" ")[0],
                                          isFirstPickUp:
                                              false, task: Task(price: num.tryParse(storageViewModle
                              .calculateTasksCart(cartModel: cartModels)
                              .toString()
                              .split(" ")[0].toString())),  /*getIsFirstPickUp()*/)[0]
                                      .toString().replaceAll("QR","").trim()  ==
                                  "0.00"
                              ? true
                              : false,
                          paymentMethod: e,
                          isFirstPickUp: false, isApple: false,
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
                if (Platform.isIOS) ...[
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.14,
                    child: PaymentItem(
                      isDisable: storageViewModle.getPriceWithDiscount(
                          oldPrice: storageViewModle.calculateTasksCart(cartModel: cartModels).toString().split(" ")[0], isFirstPickUp: false,
                          task: Task(price: num.tryParse(storageViewModle
                              .calculateTasksCart(cartModel: cartModels)
                              .toString()
                              .split(" ")[0].toString())),  /*getIsFirstPickUp()*/)[0].toString().replaceAll("QR","").trim() == "0.00" ? true : false,
                      price:storageViewModle.calculateTasksCart(cartModel: cartModels),
                      isDoPossess: true,
                      doPossess: (){
                        if (storageViewModle.isAccept || storageViewModle.isUsingPromo) {
                        if (storageViewModle.priceAfterDiscount > 0) {
                        if (storageViewModle.selectedPaymentMethod != null) {
                          storageViewModle.checkOutCart(cartModels: cartModels);
                        }
                        }
                        return;
                        }
                        if (storageViewModle.selectedPaymentMethod != null) {
                          storageViewModle.checkOutCart(cartModels: cartModels);
                        }
                      },
                      paymentMethod: PaymentMethod(
                          id: LocalConstance.applePay,
                          name: LocalConstance.applePay,
                          image: Constance.appleImage),
                      isFirstPickUp: false, isApple: true,
                    ),
                  ),
                ],
                // promoCode,
                SizedBox(
                  height: sizeH16,
                ),
                profileViewModle.myPoints.totalPoints != null && profileViewModle.myPoints.totalPoints! >  /*0*/
                    SharedPref.instance.getAppSettings()!.pointSpentBoundary!.toInt() && storageViewModle.getPriceWithDiscount(oldPrice: storageViewModle
                    .calculateTasksCart(
                    cartModel: cartModels)
                    .toString()
                    .split(" ")[0],
                    isFirstPickUp: false, task: Task(price: num.tryParse(storageViewModle
                        .calculateTasksCart(cartModel: cartModels)
                        .toString()
                        .split(" ")[0].toString())),  /*getIsFirstPickUp()*/)[0].toString().replaceAll("QR","").trim() != "0.00"
                    ? acceptTerms
                    : const SizedBox(),
                SizedBox(
                  height: sizeH16,
                ),

                // promoCode,
                // SizedBox(
                //   height: sizeH16,
                // ),
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
      ),
    );
  }

  onClickSubmit() {
    if (storageViewModle.isAccept || storageViewModle.isUsingPromo) {
      if (storageViewModle.priceAfterDiscount > 0) {
        if (storageViewModle.selectedPaymentMethod != null) {
          if (storageViewModle.selectedPaymentMethod?.id == Constance.cashId ||
              /*storageViewModle.selectedPaymentMethod?.id == Constance.bankTransferId ||*/
              storageViewModle.selectedPaymentMethod?.id ==
                  Constance.walletId) {
            storageViewModle.checkOutCart(cartModels: cartModels);
          } else if (storageViewModle.selectedPaymentMethod?.id ==
              Constance.bankTransferId) {
          } else {
            storageViewModle.goToPaymentMethod(
                isOrderProductPayment: false,
                cartModels: cartModels,
                isFromCart: true,
                amount: num.parse(storageViewModle
                    .getPriceWithDiscount(
                        oldPrice: storageViewModle
                            .calculateTasksCart(cartModel: cartModels)
                            .toString()
                            .split(" ")[0],
                        isFirstPickUp: false, task: Task(price: num.tryParse(storageViewModle
                    .calculateTasksCart(cartModel: cartModels)
                    .toString()
                    .split(" ")[0].toString())), )[0]
                    .toString()
                    .split(" ")[0]
                    .toString()),
                beneficiaryId: "",
                task: Task(),
                boxes: [],
                isFromNewStorage: false,
                isFromEditOrder: false);
          }
        } else {
          snackError("${tr.error_occurred}",
              "${tr.you_have_to_select_payment_method}");
        }
      } else {
        storageViewModle.checkOutCart(cartModels: cartModels);
      }
      return;
    }
    if (storageViewModle.selectedPaymentMethod != null) {
      if (storageViewModle.selectedPaymentMethod?.id == Constance.cashId ||
          /*storageViewModle.selectedPaymentMethod?.id == Constance.bankTransferId ||*/
          storageViewModle.selectedPaymentMethod?.id == Constance.walletId) {
        storageViewModle.checkOutCart(cartModels: cartModels);
      } else if (storageViewModle.selectedPaymentMethod?.id ==
          Constance.bankTransferId) {
      } else {
        storageViewModle.goToPaymentMethod(
            isOrderProductPayment: false,
            cartModels: cartModels,
            isFromCart: true,
            amount: num.parse(storageViewModle
                .calculateTasksCart(cartModel: cartModels)
                .toString()
                .split(" ")[0]),
            beneficiaryId: "",
            task: Task(),
            boxes: [],
            isFromNewStorage: false,
            isFromEditOrder: false);
      }
    } else {
      snackError(
          "${tr.error_occurred}", "${tr.you_have_to_select_payment_method}");
    }
  }

  bool getIsFirstPickUp() {
    bool isFirstPickUp = false;
    cartModels.forEach((element) {
      isFirstPickUp = element.isFirstPickUp!;
    });
    // cartModels.firstWhere((element) => element.isFirstPickUp!).isFirstPickUp!
    return isFirstPickUp;
  }
}
