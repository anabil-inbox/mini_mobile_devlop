import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/recived_order_screen.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanRecivedOrderScreen extends /*StatefulWidget*/StatelessWidget {
  /*const*/ ScanRecivedOrderScreen(
      {Key? key, required this.isBox, required this.isProduct})
      : super(key: key);

  final bool isBox;
  final bool isProduct;
 /* @override
  State<ScanRecivedOrderScreen> createState() => _ScanRecivedOrderScreenState();
}

class _ScanRecivedOrderScreenState extends State<ScanRecivedOrderScreen> {*/
  HomeViewModel? homeViewModel= Get.put(HomeViewModel() , permanent: true);
  StorageViewModel? storageViewModel = Get.put(StorageViewModel() , permanent: true);
  /*@override
  void initState() {
    // homeViewModel = Get.put(HomeViewModel() , permanent: true);
    // storageViewModel = Get.put(StorageViewModel() , permanent: true);
    super.initState();
  }*/

  GlobalKey<FormState> qrKey = GlobalKey<FormState>();

  Future<bool> onWillPop() async {
    Get.off(() => ReciverOrderScreen(homeViewModel!));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          body: QRView(
        key: qrKey,
        onQRViewCreated: (controller) => homeViewModel?.createQrOrderOrder(
            controller: controller,
            storageViewModel: storageViewModel ?? StorageViewModel(),
            isBox: /*widget.*/isBox,
            isProduct: /*widget.*/isProduct),
        overlay: QrScannerOverlayShape(
            borderColor: colorRed,
            borderRadius: padding10!,
            borderLength: padding30!,
            borderWidth: padding10!,
            cutOutSize: homeViewModel?.scanArea),
        onPermissionSet: (ctrl, p) =>
            homeViewModel?.onPermissionSet(context, ctrl, p),
      )),
    );
  }
}
