import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view_model/payment_view_model/payment_view_model.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class PaymentScreen extends StatelessWidget {
  PaymentScreen({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentViewModel>(
      builder: (payment) {
        return WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: url,
          onProgress: (i) {},
          onPageFinished: (url) {
            Logger().i(url);
            payment.readResponse();
          },
          navigationDelegate: (navigation) {
            payment.readResponse();
            return NavigationDecision.prevent;
          },
          onWebViewCreated: (controller) {
            payment.payController = controller;
            payment.update();
            payment.readResponse();
            controller.runJavascriptReturningResult(
                    "document.documentElement.innerText")
                .then((value) => {Logger().e(value)});
          },
        );
      },
    );
  }
}
