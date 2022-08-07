import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/view/screens/payment/payment_screen.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:logger/logger.dart';

class UserGuidDetails extends StatelessWidget {
  const UserGuidDetails({Key? key, required this.userGuide}) : super(key: key);
  final UserGuide userGuide;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorTextWhite,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 1,
        title: Text(
          "${userGuide.title}",
          style: textStyleAppBarTitle(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(Get.context!);
          },
          icon: isArabicLang()
              ? SvgPicture.asset("assets/svgs/back_arrow_ar.svg")
              : SvgPicture.asset("assets/svgs/back_arrow.svg"),
        ),
        centerTitle: true,
        backgroundColor: colorBackground,
      ),
      body: Padding(
        padding:  EdgeInsets.all(sizeH12!),
        child: Column(
          children: [
            Expanded(
              child: HtmlWidget(
                '${userGuide.text}',
                enableCaching: true,
                baseUrl: Uri.parse("${ConstanceNetwork.imageUrl}"),
                onLoadingBuilder: (context, element, loadingProgress) =>
                    Center(child: CircularProgressIndicator()),
                onTapUrl: (url) {
                  Logger().d(url);
                  //open webView
                  // openBrowser(url);
                  Get.to(PaymentScreen(
                    isOrderProductPayment: false,
                    cartModels: [],
                    paymentId: '',
                    url: url,
                    isFromCart: false,
                    isFromNewStorage: false,
                  ));
                  return true;
                },
                onErrorBuilder: (context, element, error) {
                  return Center(child: CircularProgressIndicator());
                },
                webView: true,
                webViewDebuggingEnabled: true,
                webViewJs: true,
                webViewMediaPlaybackAlwaysAllow: true,
                webViewUserAgent: "${ConstanceNetwork.imageUrl}",
                renderMode: RenderMode.column,
              ),
            ),
            SizedBox(
              height: sizeH10!,
            ),
          ],
        ),
      ),
    );
  }
}
