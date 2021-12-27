import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// ignore: must_be_immutable
class QrScreen extends StatelessWidget {
   QrScreen({ Key? key }) : super(key: key);
  
 static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  GlobalKey<FormState> qrKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
      key: qrKey,
      onQRViewCreated: homeViewModel.onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: colorRed,
          borderRadius: padding10!,
          borderLength: padding30!,
          borderWidth: padding10!,
          cutOutSize: homeViewModel.scanArea
          ),
      onPermissionSet: (ctrl, p) => homeViewModel.onPermissionSet(context, ctrl, p),
    ),
    );
  }
  
}