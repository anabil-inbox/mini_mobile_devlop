import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../../util/app_shaerd_data.dart';

class DepositMoneyToWalletWebView extends StatelessWidget {
  const DepositMoneyToWalletWebView({
    Key? key,
    this.url,
  }) : super(key: key);
  final String? url;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<ProfileViewModle>(
        init: ProfileViewModle(),
        builder: (logic) {
          return WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: url,
              onProgress: (i) {},
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
                    Logger().e(logic.depositStatus);
                    //bool result = url.contains("Paid");
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
