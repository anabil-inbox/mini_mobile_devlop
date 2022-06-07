import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view_model/payment_view_model/payment_view_model.dart';
import 'package:inbox_clients/local_database/model/cart_model.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../util/app_shaerd_data.dart';

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
      required this.isOrderProductPayment,
      required this.paymentId,
      this.isFromAddCard = false})
      : super(key: key);

  final String url;
  final String paymentId;
  final bool isFromNewStorage;
  final bool? isFromAddCard;
  final Task? task;
  final List<Box>? boxes;
  final String? beneficiaryId;
  final bool isFromCart;
  final List<CartModel> cartModels;
  final bool isOrderProductPayment;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
        appBar: CustomAppBarWidget(
          titleWidget: const SizedBox.shrink(),
        ),
        body: GetBuilder<PaymentViewModel>(
          init: PaymentViewModel(),
          builder: (payment) {
            return WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: url,
              onProgress: (i) {},
              onWebResourceError: (error){
                Logger().e(error);
              },
              onPageFinished: (url)async{
                try {
                  Logger().i("onPageFinished : url $url");
                  // String paymentId = url.split("=")[1].split("&")[0];
                  // Logger().e(paymentId);
                  // payment.paymentId = paymentId;
                  if (isFromAddCard!) {
                    if(url.toString().contains("true")){
                      //todo here we will get all cards and go back
                      Get.back(result: true);
                    }
                  } else {
                    if(url.toString().contains("status") && !url.toString().contains("false") ){
                      payment.paymentId = paymentId;
                      payment.readResponse(
                          isOrderProductPayment: isOrderProductPayment,
                          isFromCart: isFromCart,
                          cartModels: cartModels,
                          isFromNewStorage: isFromNewStorage,
                          task: task,
                          boxes: boxes,
                          beneficiaryId: beneficiaryId);
                    }
                  }
                } catch (e) {
                  Logger().e(e);
                }
              },
              onWebViewCreated: (e) {
                payment.payController = e;
                payment.update();
              },
            );
          },
        ));
  }
}
