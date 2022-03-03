import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view_model/payment_view_model/payment_view_model.dart';
import 'package:inbox_clients/local_database/model/cart_model.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class PaymentScreen extends StatelessWidget {
  PaymentScreen(
      {Key? key,
      required this.url,
      required this.isFromNewStorage,
      this.beneficiaryId,
      this.boxes,
      required this.isFromCart,
      this.task,
      required this.cartModels,
      required this.isOrderProductPayment})
      : super(key: key);

  final String url;
  final bool isFromNewStorage;
  final Task? task;
  final List<Box>? boxes;
  final String? beneficiaryId;
  final bool isFromCart;
  final List<CartModel> cartModels;
  final bool isOrderProductPayment;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentViewModel>(
      builder: (payment) {
        return WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: url,
          onProgress: (i) {},
          onPageFinished: (url) {
            try {
              Logger().i("onPageFinished : url $url");
              String paymentId = url.split("=")[1].split("&")[0];
              Logger().e(paymentId);
              payment.paymentId = paymentId;
              payment.readResponse(
                  isOrderProductPayment: isOrderProductPayment,
                  isFromCart: isFromCart,
                  cartModels: cartModels,
                  isFromNewStorage: isFromNewStorage,
                  task: task,
                  boxes: boxes,
                  beneficiaryId: beneficiaryId);
            } catch (e) {
              print(e);
            }
          },
          navigationDelegate: (navigation) {
            payment.readResponse(
                isOrderProductPayment: isOrderProductPayment,
                isFromCart: isFromCart,
                cartModels: cartModels,
                isFromNewStorage: isFromNewStorage,
                task: task,
                boxes: boxes,
                beneficiaryId: beneficiaryId);
            return NavigationDecision.navigate;
          },
          onWebViewCreated: (controller) {
            payment.payController = controller;
            payment.update();
            payment.readResponse(
                isOrderProductPayment: isOrderProductPayment,
                isFromCart: isFromCart,
                cartModels: cartModels,
                isFromNewStorage: isFromNewStorage,
                task: task,
                boxes: boxes,
                beneficiaryId: beneficiaryId);
            controller
                .runJavascriptReturningResult(
                    "document.documentElement.innerText")
                .then((value) => {});
          },
        );
      },
    );
  }
}
