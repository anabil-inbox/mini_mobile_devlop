// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/network/firebase/firbase_clinte.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/location_helper.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:location/location.dart';
import 'dart:ui' as ui;

import 'package:logger/logger.dart';

import '../../../network/firebase/sales_order.dart';
import '../../../network/firebase/track_model.dart';
import '../../../network/utils/constance_netwoek.dart';

class MapViewModel extends GetxController {
  Completer<GoogleMapController>? controller = Completer();
  GoogleMapController? mapController;

  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(25.320004788193835, 51.189434716459175),
    zoom: 14.4746,
    tilt: 59.440717697143555,
  );

  Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {}
  
    ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
    ..add(
      Factory<VerticalDragGestureRecognizer>(
          () => VerticalDragGestureRecognizer()),
    )
    ..add(
      Factory<HorizontalDragGestureRecognizer>(
          () => HorizontalDragGestureRecognizer()),
    )
    ..add(
      Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()),
    );

  Set<Marker> markers = {};
  Set<Polyline> polyLines = {};

  LatLng myLatLng = const LatLng(40.689202777778, -74.044219444444);
  LatLng customerLatLng = const LatLng(25.320004788193835, 51.189434716459175);

  @override
  void onClose() {
    super.onClose();
    controller = null;
  }

  // Future<void> goToTheLake() async {
  //   final GoogleMapController controllers = await controller!.future;
  //   controllers.animateCamera(CameraUpdate.newCameraPosition(myLatLng));
  // }

  onMapCreated(GoogleMapController controllerMap,
      {required var salesOrderId, required OrderSales newOrderSales}) async {
    if (!controller!.isCompleted) {
      controller?.complete(controllerMap);
    }
    mapController = controllerMap;
    //todo here we use two method first for me and another for the user
    //todo me = driver
    await getMyCurrentPosition(newOrderSales:newOrderSales);
    getStreamLocation(salesOrderId);
    // getUserMarkers(salesOrder: salesOrder);
    Future.delayed(const Duration(seconds: 0)).then((value) async {
      await foucCameraOnUsers(
          /*controllerMap*/
          mapController!,
          myLatLng,
          customerLatLng);
    });
  }

  onMapTaped(LatLng argument) {}

  Future<BitmapDescriptor> _getMarkerImageFromUrl(String url,
      {int? targetWidth, Color? color}) async {
    final File markerImageFile = await DefaultCacheManager().getSingleFile(url);
    if (targetWidth != null) {
      return _convertImageFileToBitmapDescriptor(markerImageFile,
          size: targetWidth, titleColor: color!);
    } else {
      Uint8List markerImageBytes = await markerImageFile.readAsBytes();
      return BitmapDescriptor.fromBytes(markerImageBytes);
    }
  }

  Future<BitmapDescriptor> _convertImageFileToBitmapDescriptor(
    File imageFile, {
    int size = 100,
    // bool addBorder = false,
    // Color borderColor = Colors.white,
    // double borderSize = 10,
    Color titleColor = Colors.transparent,
    // Color titleBackgroundColor = Colors.transparent
  }) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    // final Paint paint = Paint()..color;
    // final TextPainter textPainter = TextPainter(
    //   textDirection: TextDirection.ltr,
    // );
    //  final double radius = size / 2;

    //make canvas clip path to prevent image drawing over the circle
    final Path clipPath = Path();
    clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
        const Radius.circular(100)));
    clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(size / 2.toDouble(), size + 20.toDouble(), 10, 10),
        const Radius.circular(100)));
    clipPath.quadraticBezierTo(50, 200, 100, 0);
    canvas.clipPath(clipPath);
    canvas.drawColor(titleColor, BlendMode.dstOver);
    // canvas.drawPaint(paint);

    //paintImage
    final Uint8List imageUint8List = await imageFile.readAsBytes();
    final ui.Codec codec = await ui.instantiateImageCodec(imageUint8List);
    final ui.FrameInfo imageFI = await codec.getNextFrame();
    paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
        image: imageFI.image);

    //convert canvas as PNG bytes
    final _image = await pictureRecorder
        .endRecording()
        .toImage(size, (size * 1.1).toInt());
    final data = await _image.toByteData(format: ui.ImageByteFormat.png);

    //convert PNG bytes as BitmapDescriptor
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  getMyCurrentMarkers() async {
    // markers.clear();
    Logger().d(SharedPref.instance.getCurrentUserData().image);
    final Marker marker = Marker(
      markerId: MarkerId("${SharedPref.instance.getCurrentUserData().id}"),
      icon: await _getMarkerImageFromUrl(
          SharedPref.instance.getCurrentUserData().image == null
      ? Constance.defoultImageMarker
          : SharedPref.instance.getCurrentUserData().image.toString().length >10  ?(SharedPref.instance.getCurrentUserData().image.toString().contains("http") ?SharedPref.instance.getCurrentUserData().image.toString() :ConstanceNetwork.imageUrl + (SharedPref.instance.getCurrentUserData().image ?? "")):Constance.defoultImageMarker,
          targetWidth: 180,
          color: colorTrans),
      position: myLatLng,
      infoWindow: InfoWindow(
        title: SharedPref.instance.getCurrentUserData().customerName ?? "",
        /*anchor:const  Offset(1.0, 0.7),*/ onTap: () {
          Logger().d("");
        },
      ),
      // onTap: () {
      //
      // },
    );
    markers.add(marker);
    update();
  }

  getUserMarkers(
    {required SalesOrder salesOrder}
    ) async {
    // markers.clear();
    if(markers.isNotEmpty){
        markers.removeWhere((element) => element.markerId.value == salesOrder.customerId);
        update();
    }
    final Marker marker = Marker(
      markerId: MarkerId("${salesOrder.customerId}"),
      icon: await _getMarkerImageFromUrl(
          salesOrder.customerImage == null
              ? Constance.defoultImageMarker
              : (salesOrder.customerImage.toString().isNotEmpty && salesOrder.customerImage.toString().contains("http")?salesOrder.customerImage.toString(): ConstanceNetwork.imageUrl + (salesOrder.customerImage ?? "")),
          targetWidth: 180,
          color: colorTrans),
      position: customerLatLng,
      infoWindow: InfoWindow(
        title: salesOrder.customerId,
        onTap: () {
          Logger().d("");
        },
      ),
      // onTap: () {
      // },
    );
    markers.add(marker);
    update();
  }

  foucCameraOnUsers(GoogleMapController mapController, LatLng pickUp,
      LatLng destination) async {
    //todo this for make map camera fouc on the to marker in the map
    await addLinesToMap(pickUp, destination);
    LatLngBounds bounds;
    if (pickUp.latitude > destination.latitude &&
        pickUp.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitude, destination.longitude),
          northeast: LatLng(pickUp.latitude, pickUp.longitude));
    } else if (pickUp.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(pickUp.latitude, destination.longitude),
          northeast: LatLng(destination.latitude, pickUp.longitude));
    } else if (pickUp.latitude > destination.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitude, pickUp.longitude),
          northeast: LatLng(pickUp.latitude, destination.longitude));
    } else {
      bounds = LatLngBounds(
          southwest: LatLng(pickUp.latitude, pickUp.longitude),
          northeast: LatLng(destination.latitude, destination.longitude));
    }
    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 70));
    update();
  }

  addLinesToMap(LatLng pickUp, LatLng destination) async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> listPoints = <LatLng>[];

    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Constance.googleMapKey.toString(),
        PointLatLng(pickUp.latitude, pickUp.longitude),
        PointLatLng(destination.latitude, pickUp.longitude),
        travelMode: TravelMode.driving,
      );

      var status = result.status;
      var errorMessage = result.errorMessage;
      Logger().d("$status $errorMessage");
      if (result.status?.toLowerCase() == "ok") {
        if (result.points.isNotEmpty) {
          for (var point in result.points) {
            Logger().d("listPoints_${point.latitude}");
            listPoints.add(LatLng(point.latitude, point.longitude));
          }
        }
      }
    } catch (e) {
      Logger().d(e);
    }

    Polyline polyline = Polyline(
        polylineId: const PolylineId("poly"),
        points: listPoints,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        width: 4,
        geodesic: true,
        jointType: JointType.round);
    polyLines.add(polyline);
    update();
  }

  getMyCurrentPosition({required OrderSales newOrderSales}) async {
    if(newOrderSales.orderShippingAddressLatLang != null &&
        newOrderSales.orderShippingAddressLatLang?.latitude != null &&
        newOrderSales.orderShippingAddressLatLang?.longitude != null )
      {
        double latitude = newOrderSales.orderShippingAddressLatLang!.latitude!;
        double longitude = newOrderSales.orderShippingAddressLatLang!.longitude!;
        myLatLng = LatLng(latitude , longitude);
        await getMyCurrentMarkers();
        update();
      }else{
      ///todo stop get my current locations
      // await LocationHelper.instance
      //     .getCurrentPosition()
      //     .then((Position value) async {
      //   myLatLng = LatLng(value.latitude, value.longitude);
      //   //if we need we can make animate for camera
      //   await getMyCurrentMarkers();
      //   update();
      // });
    }

  }

  // to do for stream Location

  getStreamLocation(var salesOrderId) async {
    FirebaseClint.instance.getTrackLocation(SharedPref.instance.getCurrentUserData().id,
        salesOrderId , this).listen((event) { });
  }

  updateDriverLocations(TrackModel trackModel){
    // Logger().d(trackModel.toJson());
    if( trackModel.serialOrderDriverLocation != null)
      customerLatLng = trackModel.serialOrderDriverLocation!;
    if(trackModel.serialOrderData != null)
      getUserMarkers(salesOrder: trackModel.serialOrderData!);
    update();
  }

  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyDma7ThRPGokuU_cJ2Q_qFvowIpK35RAPs";

  // Set<Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LatLng startLocation = const LatLng(27.6683619, 85.3101895);
  LatLng endLocation = const LatLng(27.6875436, 85.2751138);

  double distance = 0.0;

  getDirections() async {
    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      printError();
    }

    //polulineCoordinates is the List of longitute and latidtude.
    double totalDistance = 0;
    for (var i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += calculateDistance(
          lat1: polylineCoordinates[i].latitude,
          lon1: polylineCoordinates[i].longitude,
          lat2: polylineCoordinates[i + 1].latitude,
          lon2: polylineCoordinates[i + 1].longitude);
    }
    Logger().e(totalDistance);
    distance = totalDistance;

    //add to the list of poly line coordinates
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
  }

  // to do this function we need to get the distance between two points

  double calculateDistance(
      {required double lat1,
      required double lon1,
      required double lat2,
      required double lon2}) {
    // num p = 0.017453292519943295;
    // num a = 0.5 -
    //     cos((lat2 - lat1) * p) / 2 +
    //     cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    // Logger().e("msg_Map : From $lat1 , $lon1 to $lat2 , $lon2");
    // Logger().e("msg_Map : The distance is : ${12742 * asin(sqrt(a))}");
    // Logger().e(
    //     "msg_Map : The distance From GeoLoacator : ${Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000}");
    // //  Geolocator.getPositionStream();
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000;
  }

  // to do here check if is Allowed to Deliver or not
  bool isAllowToDeliver(
      {required double lat1,
      required double lon1,
      required double lat2,
      required double lon2}) {
    ApiSettings settings =
        ApiSettings.fromJson(json.decode(SharedPref.instance.getAppSetting()));
    try {
      if (settings.deliveryFactor! >
          calculateDistance(lat1: lat1, lon1: lon1, lat2: lat2, lon2: lon2)) {
        // Logger().e("msg_Map : isAllow to Dilivery true");
        return true;
      } else {
        // Logger().e("msg_Map : isAllow to Dilivery false");
        return false;
      }
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  // to do here Refresh the Map Position
  LocationData? currentLocation;

  refreshMapPosition() async {
    Position currentPosition = await Geolocator.getCurrentPosition();
    if (currentLocation != null) {
      myLatLng = LatLng(currentPosition.latitude, currentPosition.longitude);
    }
  }

  // Stream<void> getDriverLocation(
  //     {required String driverId, required String salesOrder}) async* {
  //   try {
  //     yield FirebaseClint.instance
  //         .getTrackLocation(driverId, salesOrder)
  //         .takeWhile((element) {
  //           Logger().e("msg_Map : getDriverLocation $element");
  //       return true;
  //     });
  //   } catch (e) {
  //     debugPrint("msg_Map : getDriverLocationError : $e");
  //   }
  // }
}
