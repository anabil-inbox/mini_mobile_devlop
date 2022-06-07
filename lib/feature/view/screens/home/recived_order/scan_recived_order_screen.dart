// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/recived_order_screen.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../../util/app_shaerd_data.dart';

class ScanRecivedOrderScreen extends /*StatefulWidget*/ StatelessWidget {
  /*const*/ ScanRecivedOrderScreen(
      {Key? key,
        this.code,
      required this.isBox,
      required this.isProduct,
      required this.isScanDeliverdBoxes})
      : super(key: key);
  final String? code;
  final bool isBox;
  final bool isProduct;
  final bool isScanDeliverdBoxes;

  /* @override
  State<ScanRecivedOrderScreen> createState() => _ScanRecivedOrderScreenState();
}

class _ScanRecivedOrderScreenState extends State<ScanRecivedOrderScreen> {*/
  HomeViewModel homeViewModel = Get.put(HomeViewModel(), permanent: true);
  StorageViewModel? storageViewModel =
      Get.put(StorageViewModel(), permanent: true);

  /*@override
  void initState() {
    // homeViewModel = Get.put(HomeViewModel() , permanent: true);
    // storageViewModel = Get.put(StorageViewModel() , permanent: true);
    super.initState();
  }*/

  GlobalKey<FormState> qrKey = GlobalKey<FormState>();

  Future<bool> onWillPop() async {
    Get.off(() => ReciverOrderScreen(homeViewModel));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
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
                onQRViewCreated: (controller) => homeViewModel.createQrOrderOrder(
                    homeViewModel: homeViewModel,
                    isScanDeliverdBox: isScanDeliverdBoxes,
                    controller: controller,
                    storageViewModel: storageViewModel ?? StorageViewModel(),
                    isBox: /*widget.*/ isBox,
                    isProduct: /*widget.*/ isProduct),
                overlay: QrScannerOverlayShape(
                    borderColor: colorRed,
                    borderRadius: padding10!,
                    borderLength: padding30!,
                    borderWidth: padding10!,
                    cutOutSize: homeViewModel.scanArea),
                onPermissionSet: (ctrl, p) =>
                    homeViewModel.onPermissionSet(context, ctrl, p),
              ),

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
                                      logic.createQrOrderConfirm(
                                          code: code,
                                          isScanDeliverdBox: isScanDeliverdBoxes,
                                          storageViewModel: storageViewModel ?? StorageViewModel(),
                                          isBox: /*widget.*/ isBox,
                                          isProduct: /*widget.*/ isProduct,
                                          homeViewModel: logic);
                                    }
                                  },
                                  isExpanded: true);
                            }),
                      ],
                    ),
                  ),
                ),
            ],
          )),
    );
  }
}
