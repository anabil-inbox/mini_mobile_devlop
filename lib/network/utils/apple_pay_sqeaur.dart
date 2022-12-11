import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:inbox_clients/network/firebase/firebase_utils.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:logger/logger.dart';
 import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';
// import 'package:square_in_app_payments/models.dart';

class ApplePaySquare {
  var _merchantId = "merchant.inbox.mini";

  String squareApplicationId = "sq0idp-9esPmnBvgSNBprcwZU-V7Q";
  String squareLocationId = "LERZA5VCCB36X";
  String applePayMerchantId = "merchant.inbox.mini";

  ApplePaySquare._();

  static final ApplePaySquare instance = ApplePaySquare._();

  factory ApplePaySquare() => instance;

  Future<void> initSquarePayment() async {
    var canUseApplePay = false;
    await InAppPayments.setSquareApplicationId(squareApplicationId);

    if (Platform.isIOS) {
      // initialize the apple pay with apple pay merchant id
      await InAppPayments.initializeApplePay(_merchantId);
      // always check if apple pay supported on that device
      // before enable apple pay
      canUseApplePay = await InAppPayments.canUseApplePay;
    }

    // _applePayEnabled = canUseApplePay;
  } //end

  /// An event listener to start apple pay flow
  void onStartApplePay(num price, Function() onAppleComplete) async {
    try {
      await InAppPayments.requestApplePayNonce(
        price: '$price',
        summaryLabel: 'INBOX LOGISTIC',
        countryCode: 'QA',
        currencyCode: 'QAR',
        paymentType: ApplePayPaymentType.finalPayment,
        onApplePayNonceRequestSuccess: _onApplePayNonceRequestSuccess,
        onApplePayNonceRequestFailure: _onApplePayNonceRequestFailure,
        onApplePayComplete: () => _onApplePayEntryComplete(onAppleComplete),
      ).catchError((onError) {
        FirebaseUtils.instance.addPaymentFail({"onError": onError});
      });
    } on PlatformException catch (ex) {
      // handle the failure of starting apple pay
      snackError("", ex.toString());
      FirebaseUtils.instance.addPaymentFail({"PlatformException": ex});
    }
  } //end

  /// Callback when successfully get the card nonce details for processig
  /// apple pay sheet is still open and waiting for processing card nonce details
  void _onApplePayNonceRequestSuccess(CardDetails result) async {
    try {
      // take payment with the card nonce details
      // you can take a charge
      // await chargeCard(result);

      FirebaseUtils.instance.addPaymentSuccess({
        "card": result.card.toString(), /*"nonce":result.nonce*/
      });
      _setCardNonce(result.nonce );
      print(
          "_onApplePayNonceRequestSuccess ${result.card.toString()} {result.nonce}");
      // you must call completeApplePayAuthorization to close apple pay sheet
      await InAppPayments.completeApplePayAuthorization(isSuccess: true);
    } on Exception catch (ex) {
      // handle card nonce processing failure
      FirebaseUtils.instance.addPaymentFail({
        "message": ex,
      });
      // you must call completeApplePayAuthorization to close apple pay sheet
      await InAppPayments.completeApplePayAuthorization(
          isSuccess: false, errorMessage: "${ex}");
    }
  }

  /// Callback when failed to get the card nonce
  /// apple pay sheet is still open and waiting for processing error information
  void _onApplePayNonceRequestFailure(ErrorInfo errorInfo) async {
    // handle this error before close the apple pay sheet

    // you must call completeApplePayAuthorization to close apple pay sheet
    print("_onApplePayNonceRequestFailure ${errorInfo.message}");
    print("_onApplePayNonceRequestFailure ${errorInfo.toString}");
    await InAppPayments.completeApplePayAuthorization(
        isSuccess: false, errorMessage: errorInfo.message);

    FirebaseUtils.instance.addPaymentFail({
      "_onApplePayNonceRequestFailure": errorInfo.toString(),
      "message": errorInfo.message,
    });
  }

  void _onApplePayEntryComplete(Function() onAppleComplete) async {
    print("_onApplePayEntryComplete");
    var response = await chargeForCookie(nonce);
    Logger().e(response.toString());
    if (response.statusCode != null && response.statusCode! < 400)
      onAppleComplete();
  }

  Future<Response> chargeForCookie(var nonce) async {
    var baseUrl = "https://inbox-mini-qa.herokuapp.com/chargeForCookie";
    var header = {
      'Square-Version': '2022-09-21',
      'Authorization': 'Bearer EAAAET_VhMHbPr-G5i4r4w-9D_gEnVUvdfU6-YCHela8Y3yCFxRX8GY1von4ONst',
      'Content-Type': 'application/json'
    };
    Logger().wtf("nonce:$nonce header:${header} $baseUrl");
    try {
    var response = await Dio().post(baseUrl,
        data: {
          'nonce': nonce,
        },

        options: Options(headers: header));
    return response;
     } on DioError catch (ex) {
      return ex.response!;
    }
    //curl -X POST 'https://inboxmini.herokuapp.com/chargeForCookie' \
    //   -H 'Content-Type: application/json' \
    //   -d '{ "nonce": ":cnon:CBESEHCnjCSXuknAI4qMatRS6NM " }'
  }

  String _nonce = "";

  void _setCardNonce(String s) {
    this._nonce = s;
  }

  String get nonce => _nonce;
}
