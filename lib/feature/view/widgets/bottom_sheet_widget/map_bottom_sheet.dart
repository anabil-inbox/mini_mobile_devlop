import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';

import '../../../../util/app_dimen.dart';
import '../../../../util/app_shaerd_data.dart';
import '../../../view_model/map_view_model/map_view_model.dart';

class MapBottomSheet extends StatelessWidget {
  const MapBottomSheet({Key? key, required this.salesOrder, required this.newOrderSales, }) : super(key: key);

  static MapViewModel get mapViewModel => Get.find<MapViewModel>();

  final String salesOrder;
  final OrderSales newOrderSales;

  Widget get closeBtnWidget => InkWell(
        child: SvgPicture.asset("assets/svgs/Close_orange.svg" , /*close.svg*/),
        onTap: () {
          Get.back();
        },
      );
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<MapViewModel>(
        init: MapViewModel(),
        initState: (_) async {
          mapViewModel.getDirections();
          // mapViewModel.customerLatLng =
          //     LatLng(salesOrder.latituide ?? 0, salesOrder.longitude ?? 0);
          mapViewModel.update();
        },
        builder: (logic) {
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(sizeRadius25!),
                    topLeft: Radius.circular(sizeRadius25!))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: sizeH80,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(sizeRadius25!),
                                  topLeft: Radius.circular(sizeRadius25!)),
                              child: GoogleMap(
                                myLocationButtonEnabled: true,
                                initialCameraPosition:
                                    logic.initialCameraPosition,
                                zoomControlsEnabled: true,
                                mapType: MapType.normal,
                                mapToolbarEnabled: true,
                                myLocationEnabled: true,
                                zoomGesturesEnabled: true,
                                scrollGesturesEnabled: true,
                                rotateGesturesEnabled: false,
                                compassEnabled: false,
                                onTap: (argument) => logic.onMapTaped(argument),
                                markers: logic.markers,
                                polylines: logic.polyLines,
                                gestureRecognizers: logic.gestureRecognizers,
                                onMapCreated:
                                    (GoogleMapController controller) =>
                                        logic.onMapCreated(controller,
                                            salesOrderId: salesOrder ,newOrderSales:newOrderSales),
                              ),
                            ),
                          ),
                        ],
                      ),
                      PositionedDirectional(
                        top: sizeW20,
                        start: sizeH20,
                        height: sizeH30,
                        width: sizeW30,
                        child: closeBtnWidget,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
