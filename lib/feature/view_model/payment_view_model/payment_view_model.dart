import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentViewModel extends GetxController {
  WebViewController? payController;

  void readResponse() async {
    try {
      await payController
          ?.evaluateJavascript("document.documentElement.innerHTML")
          .then((value) => {
                Logger().e(" value $value"),
                Logger().e(
                    "isHave Payment iD ${value.contains("name=\"paymentId\"")}"),
                if (value.contains("name=\"paymentId\"")) {
                  
                }
              });
    } catch (e) {
      Logger().e(e);
    }
  }
}
