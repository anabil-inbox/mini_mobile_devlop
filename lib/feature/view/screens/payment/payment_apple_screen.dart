import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/model/respons/task_response.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/feature/view_model/my_order_view_modle/my_order_view_modle.dart';
import 'package:inbox_clients/feature/view_model/payment_view_model/payment_view_model.dart';
import 'package:inbox_clients/local_database/model/cart_model.dart';
import 'package:inbox_clients/network/api/feature/order_helper.dart';
import 'package:inbox_clients/network/firebase/firebase_utils.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../util/app_shaerd_data.dart';

// ignore: must_be_immutable
class PaymentAppleScreen extends StatelessWidget {
  PaymentAppleScreen({
    Key? key,
    required this.url,
    required this.isFromNewStorage,
    this.beneficiaryId,
    this.boxes,
    required this.isFromCart,
    this.task,
    required this.cartModels,
    required this.isOrderProductPayment,
    required this.paymentId,
    this.isFromAddCard = false,
    this.isFromCancel = false,
    this.orderId,
    this.myOrderViewModel,
    this.isFromInvoice = false,
    this.boxIdInvoice,
    this.operationsBox,
    this.isFromEditOrder = false,
    this.editOrderFunc,
    this.isFromNotifications = false,
    this.operationTask,
    this.isFromOrderDetails = false,
    this.doFunctions,
    this.isFromApplePay = false
  }) : super(key: key);

  final String? url, orderId;
  final String paymentId;
  final  bool? isFromApplePay;
  final bool isFromNewStorage, isFromCancel;
  final bool? isFromAddCard;
  final Task? task;
  final List<Box>? boxes;
  final String? beneficiaryId;
  final bool isFromCart;
  final List<CartModel> cartModels;
  final bool isOrderProductPayment;
  final MyOrderViewModle? myOrderViewModel;
  final bool? isFromInvoice;
  final String? boxIdInvoice;
  final Box? operationsBox;
  final bool? isFromEditOrder;
  final Function()? editOrderFunc;
  final bool? isFromNotifications;
  final TaskResponse? operationTask;
  final bool? isFromOrderDetails;
  final Function()? doFunctions;

  ItemViewModle get itemViewModel => Get.put<ItemViewModle>(ItemViewModle());


  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    url?.replaceAll("http:", "https:");

    return WillPopScope(
      onWillPop: () {
        PaymentViewModel payment=Get.put(PaymentViewModel());
        payment.isApplePaid = false;
        payment.update();
        return Future.value(true);
      },
      child: Scaffold(
          appBar: CustomAppBarWidget(
            titleWidget: const SizedBox.shrink(),
          ),
          body: GetBuilder<PaymentViewModel>(
            init: PaymentViewModel(),
            builder: (payment) {
              return WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl:!url!.contains("http") && url!.isNotEmpty ? "https://$url": url,
                onProgress: (i) {},
                onWebResourceError: (error) {
                  Logger().e(error.domain);
                  Logger().e(error.description);
                  Logger().e(error.failingUrl);
                  Logger().e(error.errorCode);
                  Logger().e(error.errorType);
                  FirebaseUtils.instance.addPaymentFail({"onWebResourceError":error.toString()});
                  Get.back();
                },
                onPageFinished: (url) async {
                    Logger().i("onPageFinished : url $url");
                    // String paymentId = url.split("=")[1].split("&")[0];
                    // Logger().e(paymentId);
                    // payment.paymentId = paymentId;
                    // FirebaseUtils.instance.addPaymentSuccess({"onPageFinished":url.toString()});
                    if (url.toString().contains("status") && url.toString().contains("false")) {
                      FirebaseUtils.instance.addPaymentFail({"contain false ":url.toString()});
                      Get.back();
                      return;
                    }
                    // if(isFromApplePay!){
                      if (url.toString().contains("status") &&
                          url.toString().contains("true") && !payment.isApplePaid){
                        // FirebaseUtils.instance.addPaymentSuccess({"if true onPageFinished":url.toString()});
                        doFunctions!();
                        // FirebaseUtils.instance.addPaymentSuccess({"onPageFinished doFunctions":url.toString()});
                        payment.isApplePaid = true;
                        payment.update();
                        return;
                      }
                    // }


                },
                onWebViewCreated: (e) {
                  payment.payController = e;
                  payment.update();
                },
              );
            },
          )),
    );
  }
}
