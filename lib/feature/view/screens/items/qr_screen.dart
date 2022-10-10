import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:logger/logger.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../util/app_shaerd_data.dart';

// ignore: must_be_immutable
class QrScreen extends StatelessWidget {
  QrScreen(
      {Key? key,
      this.isFromAtHome = false,
      required this.storageViewModel,
      this.index = 0,
      this.code, this.isForSeal = false, })
      : super(key: key);

  final String? code;
  final bool? isFromAtHome;
  final StorageViewModel storageViewModel;
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  GlobalKey<FormState> qrKey = GlobalKey<FormState>();
  final int index;
  final bool? isForSeal;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    Logger().d(code);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBlack,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: colorTextWhite,
            )),
      ),
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: (controller) => homeViewModel.onQRViewCreated(
                controller,
                isFromAtHome: isFromAtHome,
                isForSeal: isForSeal,
                index: index,
                storageViewModel: storageViewModel),
            overlay: QrScannerOverlayShape(
                borderColor: colorRed,
                borderRadius: padding10!,
                borderLength: padding30!,
                borderWidth: padding10!,
                cutOutSize: homeViewModel.scanArea),
            onPermissionSet: (ctrl, p) =>
                homeViewModel.onPermissionSet(context, ctrl, p),
          ),
          if /*(index != 0)*/(code != null && code!.isNotEmpty)
            PositionedDirectional(
              bottom: 0,
              end: 0,
              start: 0,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(sizeRadius16!),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: colorTextWhite,
                    borderRadius: BorderRadius.circular(sizeRadius16!)),
                margin: EdgeInsets.all(sizeRadius16!),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextView(
                      txt: tr.you_can_scan_confirmed_button,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: sizeH20,
                    ),
                    GetBuilder<HomeViewModel>(
                        init: HomeViewModel(),
                        builder: (logic) {
                          return PrimaryButton(
                              textButton: tr.confirmed,
                              isLoading: logic.isLoading,
                              onClicked: () async {
                                if (code != null && code!.isNotEmpty) {
                                  logic.onQRViewConfirmed(
                                      code: code,
                                      isFromAtHome: isFromAtHome,
                                      index: index,
                                      storageViewModel: storageViewModel);
                                }
                              },
                              isExpanded: true);
                        }),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
