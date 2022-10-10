import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/storage/payment.dart';
import 'package:inbox_clients/feature/view/screens/payment/payment_screen.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/network/firebase/firebase_utils.dart';
import 'package:inbox_clients/network/utils/apple_pay_sqeaur.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:logger/logger.dart';
import 'package:mad_pay/mad_pay.dart' as applePay;
// import 'package:pay/pay.dart';

import '../../../../../../../util/app_shaerd_data.dart';
import '../../../../../../view_model/profile_view_modle/profile_view_modle.dart';
// import 'package:pay/pay.dart' as applePay;

class PaymentItem extends StatelessWidget {
  const PaymentItem(
      {Key? key,
      this.isRecivedOrderPayment = false,
      required this.paymentMethod,
      this.isDisable = false,
      this.isFromApplicationPayment = false,required this.isFirstPickUp,required this.isApple, this.price,this.doPossess, this.isDoPossess = false,   })
      : super(key: key);

  final  Function()? doPossess;//doPossess
  final  bool? isDoPossess;
  final bool isApple;
  final PaymentMethod paymentMethod;
  final bool isFromApplicationPayment;
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  static ProfileViewModle profileViewModle =
      Get.put(ProfileViewModle(), permanent: true);
  final bool? isDisable;
  final bool isRecivedOrderPayment;
  final bool? isFirstPickUp;
  final dynamic price;

  // static applePay.Pay _payClient = applePay.Pay.withAssets([
  //   'applepay.json',
  //   // 'default_payment_profile_google_pay.json'
  // ]);

  static bool _isAvailableApplePay = true; //available
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<StorageViewModel>(
      init: StorageViewModel(),
      initState: (_) {
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
          // if(isFirstPickUp!){
          //   _.controller?.selectedPaymentMethod =
          //       PaymentMethod(id: "Cash", image: null, name: "Cash");
          //   _.controller?.update();
          // }
          // await _payClient.userCanPay().then((value) {
          //   _isAvailableApplePay = value;
          //   _.controller?.update();
          // });
          await ApplePaySquare.instance.initSquarePayment();
        });
      },
      builder: (builder) {
        //if unAvailableApplePay && list have method apple pay
        //  if(!_isAvailableApplePay && paymentMethod.id == LocalConstance.applePay){
        //    return const SizedBox.shrink();
        //  }
        //if isAndroid && list have method apple pay
        if (Platform.isAndroid && paymentMethod.id == LocalConstance.applePay) {
          return const SizedBox.shrink();
        }
        //if selected subscriptions != daily && list have method apple pay
        if (builder.selectedDuration != LocalConstance.dailySubscriptions &&
            paymentMethod.id == LocalConstance.applePay) {
          return const SizedBox.shrink();
        }
        if (isDisable! || isFirstPickUp!) {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            builder.selectedPaymentMethod =
                PaymentMethod(id: "Cash", image: null, name: "Cash");
            builder.update();
          });
        }
        // Logger().w(ConstanceNetwork.imageUrl +  paymentMethod.image.toString());
        return InkWell(
          onTap: isDisable! || isFirstPickUp!
              ? () {}
              : () async {
                  builder.selectedPaymentMethod = paymentMethod;
                  builder.update();

                  Logger().d(paymentMethod.toJson());
                  if (isRecivedOrderPayment) {
                    doOnRecivedOrderPayment();
                  } else {
                    _applePayHandler();
                  }
                },
          child:/*isApple ?
          ApplePayButton(
            paymentConfigurationAsset: 'applepay.json',
            paymentItems: [
              applePay.PaymentItem(
                type: applePay.PaymentItemType.total,
                label: 'INBOX LOGISTIC',// Total
                amount: '${price != null  ? price : homeViewModel.operationTask.totalDue != null &&  homeViewModel.operationTask.totalDue! > 0 ? homeViewModel.operationTask.totalDue: storageViewModel.totalBalance}',
                status: applePay.PaymentItemStatus.final_price,
              )
            ],
            style: ApplePayButtonStyle.black,
            type: ApplePayButtonType.buy,

            margin: const EdgeInsets.only(top: 15.0),
            onPaymentResult: onApplePayResult,
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
          )
              : */Container(
             width: /*isApple? MediaQuery.of(context).size.width / 1.14 :*/ MediaQuery.of(context).size.width /4,
            margin: EdgeInsets.symmetric(horizontal: padding4!),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(padding6!),
                border: Border.all(
                    width: 2/*0.5*/,
                    color:builder.selectedPaymentMethod?.id != paymentMethod.id
                        ? colorContainerGrayLight
                        : colorPrimary /*builder.selectedPaymentMethod?.id != paymentMethod.id
                        ? colorBorderContainer
                        : colorTrans*/),
                color: isApple ? colorBlack:colorTextWhite
                /*color: builder.selectedPaymentMethod?.id != paymentMethod.id
                    ? colorTextWhite
                    : colorPrimary*/),
            padding: EdgeInsets.symmetric(
                vertical: 1/*padding9!*/, horizontal: 1/*padding14!*/),
            child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (paymentMethod.image != null &&
                    paymentMethod.image != "") ...[
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(isApple ?50:0),
                      clipBehavior: Clip.hardEdge,
                      child: imageNetwork(
                          isPayment: true,
                          url:paymentMethod.id == LocalConstance.applePay ? Constance.appleImage: ConstanceNetwork.imageUrl + ""+ paymentMethod.image.toString(),
                          width:isApple ? MediaQuery.of(context).size.width / 1.6 : sizeH90,
                          fit: isApple ? BoxFit.fill:BoxFit.contain,
                          height: sizeH60!),
                    ),
                  ),
                ] else ...[
                  imageNetwork(isPayment: true, width: sizeH90, height: sizeH60,fit: BoxFit.contain)
                ],

                // if (paymentMethod.id == LocalConstance.bankCard)
                //   SvgPicture.asset(
                //     "assets/svgs/bank_card_icon.svg",
                //     color: builder.selectedPaymentMethod?.id == paymentMethod.id
                //         ? colorBackground
                //         : colorHint,
                //   ),
                // if (paymentMethod.id == LocalConstance.cash)
                //   SvgPicture.asset(
                //     "assets/svgs/cash_icon.svg",
                //     color: builder.selectedPaymentMethod?.id == paymentMethod.id
                //         ? colorBackground
                //         : colorHint,
                //   ),
                // if (paymentMethod.id == LocalConstance.wallet)
                //   SvgPicture.asset(
                //     "assets/svgs/wallet_icon.svg",
                //     color: builder.selectedPaymentMethod?.id == paymentMethod.id
                //         ? colorBackground
                //         : colorHint,
                //   ),
                if(paymentMethod.id != LocalConstance.applePay)...[
                SizedBox(
                  height: sizeW5,
                ),

                CustomTextView(
                  txt:  (paymentMethod.id == LocalConstance.applePay) ? "":"${paymentMethod.name}",
                  textStyle: /*builder.selectedPaymentMethod?.id ==
                          paymentMethod.id
                      ? textStylebodyWhite()
                      :*/ textStyleHints()!
                          .copyWith(fontSize: fontSize14, color: colorBlack/*colorHint2*/),
                ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  void doOnRecivedOrderPayment() async {
    if (homeViewModel.operationTask.totalDue == 0) {
      snackError("", "There is no due");
      return;
    }
    num sendedWattingFeesOrCancellation = -1;
    String sendedWattingFeesOrCancellationReson = "";

    if ((homeViewModel.operationTask.waitingTime ?? 0) > 0) {
      sendedWattingFeesOrCancellation =
          homeViewModel.operationTask.waitingTime ?? 0;
      sendedWattingFeesOrCancellationReson = "waiting fees";
    } else if ((homeViewModel.operationTask.cancellationFees ?? 0) > 0) {
      sendedWattingFeesOrCancellation =
          homeViewModel.operationTask.cancellationFees ?? 0;
      sendedWattingFeesOrCancellationReson = "cancellation";
    }
    if (paymentMethod.name == LocalConstance.cash ||
        paymentMethod.name == LocalConstance.pointOfSale
    /*paymentMethod.name == LocalConstance.bankTransfer*/) {
    }else if (paymentMethod.name == LocalConstance.bankTransfer){

    } else if (paymentMethod.name == LocalConstance.applePay) {
      //todo this for apple pay actions
      _applePayHandler();
    } else if (paymentMethod.name == LocalConstance.wallet) {
      if ((num.tryParse(profileViewModle.myWallet.balance.toString()) ?? 0) >
          (homeViewModel.operationTask.totalDue ?? 0)) {
        homeViewModel.applyPayment(
            isRecivedOrderPayment:isRecivedOrderPayment,
            salesOrder: homeViewModel.operationTask.salesOrder ?? "",
            paymentMethod: paymentMethod.name ?? "",
            paymentId: "",
            extraFees: 0/*sendedWattingFeesOrCancellation*/,
            reason: sendedWattingFeesOrCancellationReson, isAppPay: false);
      } else {
        snackError("", "Wallet Balance is not enough");
      }
    } else if (paymentMethod.name == LocalConstance.bankCard || paymentMethod.name == LocalConstance.creditCard) {
      if(homeViewModel.operationTask.urlPayment != null && homeViewModel.operationTask.urlPayment!.isNotEmpty){
        Get.to(PaymentScreen(
          operationTask: homeViewModel.operationTask,
          isFromNotifications: true,
          url: homeViewModel.operationTask.urlPayment,
          isFromCart: false,
          isOrderProductPayment: false,
          isFromOrderDetails:isRecivedOrderPayment,
          cartModels: [],
          isFromNewStorage: false,
          doFunctions:()async{
            await homeViewModel.applyPayment(
                isRecivedOrderPayment:isRecivedOrderPayment,
                salesOrder: homeViewModel.operationTask.salesOrder ?? "",
                paymentMethod: paymentMethod.name ?? "",
                paymentId: "",
                extraFees: 0/*sendedWattingFeesOrCancellation*/,
                reason: sendedWattingFeesOrCancellationReson, isAppPay: false);
            // Get.back();
          },
          paymentId: '',
        ));
      }else{
        await storageViewModel.payApplicationFromPaymentGatewaye(
            price: homeViewModel.operationTask.totalDue ?? 0);
      }

    } else if (paymentMethod.name == LocalConstance.pointOfSale) {}
  }

  void _applePayHandler() async {
    if (paymentMethod.name == LocalConstance.applePay) {
      //todo this for apple pay actions
      Logger().d(
          "1${paymentMethod.name} , ${homeViewModel.operationTask.totalDue ?? storageViewModel.totalBalance} , ${storageViewModel.totalBalance}");
    //   var _paymentItems = [
    //     applePay.PaymentItem(
    //       type: applePay.PaymentItemType.total,
    //       label: 'INBOX LOGISTIC',// Total
    //       amount: '${price != null  ? price : homeViewModel.operationTask.totalDue != null &&  homeViewModel.operationTask.totalDue! > 0 ? homeViewModel.operationTask.totalDue: storageViewModel.totalBalance}',
    //       status: applePay.PaymentItemStatus.final_price,
    //     )
    //   ];
    //   bool userCanPay = await _payClient.userCanPay();
    // Logger().w("userCanPay_ $userCanPay");

      num sendedWattingFeesOrCancellation = -1;
      String sendedWattingFeesOrCancellationReson = "";

      if ((homeViewModel.operationTask.waitingTime ?? 0) > 0) {
        sendedWattingFeesOrCancellation =
            homeViewModel.operationTask.waitingTime ?? 0;
        sendedWattingFeesOrCancellationReson = "waiting fees";
      } else if ((homeViewModel.operationTask.cancellationFees ?? 0) > 0) {
        sendedWattingFeesOrCancellation =
            homeViewModel.operationTask.cancellationFees ?? 0;
        sendedWattingFeesOrCancellationReson = "cancellation";
      }
      // if (userCanPay) {
      // _payClient.userCanPay(applePay.PayProvider.apple_pay).then((values) {
      //
      //   _payClient.showPaymentSelector(paymentItems: _paymentItems , provider: applePay.PayProvider.apple_pay).then((value) {
      //     Logger().d("paymentApple: => $value");
      //     FirebaseUtils.instance.addPaymentSuccess(value);
      //     if (value["token"] != null || value["transactionIdentifier"] != null ) {
      //       Logger().d("paymentApple:1 => $value  ${isDoPossess! && doPossess != null}" );
      //       if(isDoPossess! && doPossess != null){
      //         doPossess!();
      //       }else {
      //
      //         homeViewModel.applyPayment(
      //             isRecivedOrderPayment:isRecivedOrderPayment,
      //             salesOrder: homeViewModel.operationTask.salesOrder ?? "",
      //             paymentMethod: LocalConstance.creditCard/*paymentMethod.name ?? ""*/ ,
      //             paymentId: value["transactionId"] != null ? value["transactionId"] : "${DateTime.now().millisecondsSinceEpoch.toString()}",
      //             isAppPay: true,
      //             storageViewModel: storageViewModel,
      //             extraFees: 0/*sendedWattingFeesOrCancellation*/,
      //             reason: sendedWattingFeesOrCancellationReson);
      //       }
      //     } else {
      //       FirebaseUtils.instance.addPaymentFail({
      //         ...value,
      //         "else": "token == null",
      //       });
      //       snackError("", "Credit Balance is not enough");
      //     }
      //   }).catchError((onError) {
      //     Logger().d("paymentApple: => $onError");
      //     FirebaseUtils.instance
      //         .addPaymentFail({"onError": "${onError.toString()}"});
      //   });
      // });

      final applePay.MadPay pay = applePay.MadPay();

      // To find out if payment is available on this device
      await pay.checkPayments();

      // If you need to check if user has at least one active card
      await pay.checkActiveCard(
        paymentNetworks: <applePay.PaymentNetwork>[
          applePay.PaymentNetwork.visa,
          applePay.PaymentNetwork.mastercard,
          applePay.PaymentNetwork.amex,
          applePay.PaymentNetwork.maestro,
          applePay.PaymentNetwork.discover,
          applePay.PaymentNetwork.mada,
          applePay.PaymentNetwork.vpay,
        ],
      );

      // To pay with Apple Pay or Google Pay
      var response = await pay.processingPayment(
          applePay.PaymentRequest(
            google: applePay.GoogleParameters(
              gatewayName: 'Your Gateway',
              gatewayMerchantId: 'Your id',
              merchantId: 'example_id',
            ),
            apple: applePay.AppleParameters(
              merchantIdentifier: 'merchant.inbox.mini',
            ),
            currencyCode: 'QAR',
            countryCode: 'QA',
            paymentItems: <applePay.PaymentItem>[
              applePay.PaymentItem(name: 'Inbox Logistic', price: (price != null  ? price : homeViewModel.operationTask.totalDue != null &&  homeViewModel.operationTask.totalDue! > 0 ? homeViewModel.operationTask.totalDue: storageViewModel.totalBalance).toDouble(),),
              // applePay.PaymentItem(name: 'Trousers', price: 15.24),
            ],
            paymentNetworks: <applePay.PaymentNetwork>[
              applePay.PaymentNetwork.visa,
              applePay.PaymentNetwork.mastercard,
              applePay.PaymentNetwork.amex,
              applePay.PaymentNetwork.maestro,
              applePay.PaymentNetwork.discover,
              applePay.PaymentNetwork.mada,
              applePay.PaymentNetwork.vpay,
            ],
          )
      ).catchError((onError){
        Logger().d("paymentApple: => $onError");
        FirebaseUtils.instance
            .addPaymentFail({"onError": "${onError.toString()}"});
      });

      FirebaseUtils.instance.addPaymentSuccess({"data":response?.rawData});
      if(response?.token != null){
        if(isDoPossess! && doPossess != null){
          doPossess!();
        }else {

          homeViewModel.applyPayment(
              isRecivedOrderPayment:isRecivedOrderPayment,
              salesOrder: homeViewModel.operationTask.salesOrder ?? "",
              paymentMethod: LocalConstance.creditCard/*paymentMethod.name ?? ""*/ ,
              paymentId: /*value["transactionId"] != null ? value["transactionId"] :*/ "${DateTime.now().millisecondsSinceEpoch.toString()}",
              isAppPay: true,
              storageViewModel: storageViewModel,
              extraFees: 0/*sendedWattingFeesOrCancellation*/,
              reason: sendedWattingFeesOrCancellationReson);
        }
      }
      // ApplePaySquare.instance.onStartApplePay(
      //     price != null  ? price : homeViewModel.operationTask.totalDue != null &&  homeViewModel.operationTask.totalDue! > 0 ? homeViewModel.operationTask.totalDue: storageViewModel.totalBalance,
      //         (){
      //             if(isDoPossess! && doPossess != null){
      //               doPossess!();
      //             }else {
      //
      //               homeViewModel.applyPayment(
      //                   isRecivedOrderPayment:isRecivedOrderPayment,
      //                   salesOrder: homeViewModel.operationTask.salesOrder ?? "",
      //                   paymentMethod: LocalConstance.creditCard/*paymentMethod.name ?? ""*/ ,
      //                   paymentId: /*value["transactionId"] != null ? value["transactionId"] :*/ "${DateTime.now().millisecondsSinceEpoch.toString()}",
      //                   isAppPay: true,
      //                   storageViewModel: storageViewModel,
      //                   extraFees: 0/*sendedWattingFeesOrCancellation*/,
      //                   reason: sendedWattingFeesOrCancellationReson);
      //             }
      //
      //         });

      // } else {
      //   Logger().e("paymentApple is: => $userCanPay");
      //   snackError("", "Apple Pay is not available");
      // }
    }
  }

  // void onApplePayResult(Map<String, dynamic> result) {
  //   Logger().w(result);
  // }
}
// watting fees > 0 watting fees::
// canclation fees > 0 canclation::
//
