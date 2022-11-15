import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../../util/app_shaerd_data.dart';

class DepositMoneyToWalletWebView extends StatelessWidget {
  const DepositMoneyToWalletWebView({
    Key? key,
    this.url, this.isFromInvoice = false, this.isFromSub = false,
  }) : super(key: key);
  final String? url;
  final bool? isFromInvoice;
  final bool? isFromSub;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<ProfileViewModle>(
        init: ProfileViewModle(),
        builder: (logic) {
          return WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: url,
              onWebResourceError: (error) {
                Logger().e(error.toString());
                Logger().e(error.errorType);
                Logger().e(error.description);
                Logger().e(error.errorCode);
                Logger().e(error.failingUrl);
                 Get.back();
              },
              onProgress: (i) {
              },
              onPageFinished: (url) {
                try {
                  if (url.contains("status")) {
                    var uri = Uri.parse(url);
                    var queryParameters = uri.queryParameters;
                    Logger().i("onPageFinished : url $url");
                    //String paymentId = url.split("=")[1].split("&")[0];
                    // String paymentId = queryParameters["id"].toString();
                    String paymentId = queryParameters["tap_id"].toString();
                    logic.paymentId = paymentId;
                    Logger().e(paymentId);
                    //logic.depositStatus = url.split("status=")[1];
                    logic.depositStatus = queryParameters["status"].toString();
                    if(logic.depositStatus == "false"){
                      Get.back();
                    }
                    Logger().e(logic.depositStatus);
                    //bool result = url.contains("Paid");
                    if(isFromInvoice! && queryParameters["status"].toString().contains("true")){
                       logic.applyInvoicesPayment();
                       if(isFromSub!){
                         Get.back();
                       }
                    }
                    //todo add action
                    if (queryParameters["status"].toString().contains("true"))
                      logic.checkDeposit();
                  }
                } on Exception catch (e) {
                  print(e);
                }
              });
        });
  }
}
