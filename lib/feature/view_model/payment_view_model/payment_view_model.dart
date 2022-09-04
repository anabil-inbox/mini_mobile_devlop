// ignore_for_file: deprecated_member_use

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/local_database/model/cart_model.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentViewModel extends GetxController {
  final Logger logger = Logger();
  final StorageViewModel stroageViewModel = Get.find<StorageViewModel>();
  final HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  String paymentId = "";
  WebViewController? payController;
  num sendedWattingFeesOrCancellation = -1;
  String sendedWattingFeesOrCancellationReson = "";

  void readResponse({
    required bool isFromNewStorage,
    Task? task,
    List<Box>? boxes,
    String? beneficiaryId,
    required bool isFromCart,
    required bool isOrderProductPayment,
    required List<CartModel> cartModels,
  }) async {
    try {
      await payController?.evaluateJavascript("document.documentElement.innerHTML")
          .then((value) async {
        if (value.contains("success")) {
          logger.i("Payment Success");
          if (isOrderProductPayment) {
            if ((homeViewModel.operationTask.waitingTime ?? 0) > 0) {
              sendedWattingFeesOrCancellation =
                  homeViewModel.operationTask.waitingTime ?? 0;
              sendedWattingFeesOrCancellationReson = "waiting_fees";
            } else if ((homeViewModel.operationTask.cancellationFees ?? 0) >
                0) {
              sendedWattingFeesOrCancellation =
                  homeViewModel.operationTask.cancellationFees ?? 0;
              sendedWattingFeesOrCancellationReson = "cancellation";
            }

            await homeViewModel.applyPayment(
                salesOrder: homeViewModel.operationTask.salesOrder ?? "",
                paymentMethod: LocalConstance.bankCard,
                paymentId: paymentId,
                extraFees: sendedWattingFeesOrCancellation,
                reason: sendedWattingFeesOrCancellationReson);

            Get.back();
          } else if (isFromNewStorage && paymentId.isNotEmpty) {
            stroageViewModel.addNewStorage(paymentId: paymentId);
            return;
          } else if (isFromCart) {
            stroageViewModel.checkOutCart(cartModels: cartModels);
          } else {
            await stroageViewModel.doTaskBoxRequest(
              isFirstPickUp: false,
                isFromCart: false,
                paymentId: paymentId,
                task: task!,
                boxes: boxes!,
                beneficiaryId: beneficiaryId!);
            Get.back();
          }
          //http://inbox.ahdtech.com/response?id=70219f15-6599-4a66-98e7-a5d5b0a481c5&statusId=2&status=Paid
        } else if (value.contains("failed")) {
          Future.delayed(Duration(seconds: 5), () {
            snackError("${tr.error_occurred}", tr.payment_failed);
          });
        }
      });
    } catch (e) {
      Logger().e(e);
    }
  }
}
