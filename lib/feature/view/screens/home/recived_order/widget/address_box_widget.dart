import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../../../../network/firebase/sales_order.dart';
import '../../../../../../util/app_color.dart';
import '../../../../../../util/app_dimen.dart';
import '../../../../../../util/app_shaerd_data.dart';
import '../../../../../../util/app_style.dart';
import '../../../../../../util/constance.dart';
import '../../../../../view_model/map_view_model/map_view_model.dart';
import '../../../../widgets/bottom_sheet_widget/map_bottom_sheet.dart';
import '../../../../widgets/custome_text_view.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({Key? key, required this.salesOrder}) : super(key: key);

  final SalesOrder salesOrder;

  Widget textAddressWidget() {
    String fullAddress =
        (salesOrder.orderShippingAddress) ?? (salesOrder.orderWarehouseAddress);
    fullAddress +=
        " , ${salesOrder.street} , ${salesOrder.unitNo} , ${salesOrder.buildingNo}";
    
    fullAddress += "\n ${salesOrder.fromTime?.split(":")[0] }:${salesOrder.fromTime?.split(":")[1]} - ${salesOrder.toTime?.split(":")[0] }:${salesOrder.toTime?.split(":")[1]}";
    return InkWell(
      onTap: () => _goToMap(salesOrder: salesOrder),
      child: CustomTextView(
        txt: fullAddress,
        maxLine: Constance.maxLineThree,
        textStyle: textStyleNormal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(padding16!)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: sizeH13,
                ),
                CustomTextView(
                  txt: "Delivery Address",
                  maxLine: Constance.maxLineOne,
                  textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                ),
                SizedBox(
                  height: sizeH1,
                ),
                textAddressWidget(),
                SizedBox(
                  height: sizeH13,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => _goToMap(salesOrder: salesOrder),
            child: Image.asset(
              "assets/png/Location.png",
              height: sizeH32,
              width: sizeW30,
            ),
          ),
        ],
      ),
    );
  }

  void _goToMap({required SalesOrder salesOrder}) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Get.put(MapViewModel());
      Get.bottomSheet(
          MapBottomSheet(
            salesOrder: salesOrder,
          ),
          enableDrag: true,
          isScrollControlled: true,
          clipBehavior: Clip.hardEdge);
    });
  }
}
