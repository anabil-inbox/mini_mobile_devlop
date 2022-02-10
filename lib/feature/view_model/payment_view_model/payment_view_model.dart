// ignore_for_file: deprecated_member_use

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentViewModel extends GetxController {
  final Logger logger = Logger();
  final StorageViewModel stroageViewModel = Get.find<StorageViewModel>();

  String paymentId = "";

  WebViewController? payController;

  void readResponse({
    required bool isFromNewStorage,
    Task? task,
    List<Box>? boxes,
    String? beneficiaryId,
  }) async {
    try {
      await payController
          ?.evaluateJavascript("document.documentElement.innerHTML")
          .then((value) async => {
                if (value.contains("success"))
                  {
                    logger.i("Payment Success"),
                    if (isFromNewStorage)
                      {
                        // Get.back();
                        stroageViewModel.addNewStorage(paymentId: paymentId),
                      }
                    else
                      {
                        await stroageViewModel.doTaskBoxRequest(
                            isFromCart: false,
                            paymentId: paymentId,
                            task: task!,
                            boxes: boxes!,
                            beneficiaryId: beneficiaryId!),
                        Get.back(),
                      }
                    //http://inbox.ahdtech.com/response?id=70219f15-6599-4a66-98e7-a5d5b0a481c5&statusId=2&status=Paid
                  }
                else if (value.contains("failed"))
                  {
                    Future.delayed(Duration(seconds: 5), () {
                      snackError("${tr.error_occurred}", "Payment Failed");
                    })
                  }
              });
    } catch (e) {
      Logger().e(e);
    }
  }
}
