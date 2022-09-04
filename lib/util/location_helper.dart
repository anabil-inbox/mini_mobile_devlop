import 'dart:async';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class LocationHelper {

  LocationHelper._();
  static final LocationHelper instance = LocationHelper._();
  factory LocationHelper() => instance;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await _geolocatorPlatform.checkPermission();

    // Test if location services are enabled.
    if (!serviceEnabled) {
      Logger().i("Test_getCurrentPositionPlatform 2");
      openLocationSettings();
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Logger().d("Test_getCurrentPositionPlatform serviceEnabled:$serviceEnabled");
      return Future.error('Location services are disabled.');
    } else {
      Logger().i("Test_getCurrentPositionPlatform 7");
    }
    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      Logger().i("Test_getCurrentPositionPlatform 4");

      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        Logger().d("Test_getCurrentPositionPlatform ${LocationPermission.denied}");
        return Future.error('Location permissions are denied');
      }
    }

    Logger().i("Test_getCurrentPositionPlatform 3 $permission");
    if (permission == LocationPermission.deniedForever) {
      Logger().i("Test_getCurrentPositionPlatform 5");
      permission = await _geolocatorPlatform.requestPermission();
      // Permissions are denied forever, handle appropriately.
      Logger().d("Test_getCurrentPositionPlatform ${LocationPermission.deniedForever}");
      await openLocationSettings();
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    if (GetUtils.isNull(permission)) {
      Logger().i("Test_getCurrentPositionPlatform 8");
      permission = await _geolocatorPlatform.requestPermission();
      // Permissions are denied forever, handle appropriately.
      Logger().d("Test_getCurrentPositionPlatform $permission");
     openLocationSettings();
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Logger().i("Test_getCurrentPositionPlatform 6");
    return Platform.isIOS
        ? await _geolocatorPlatform.getLastKnownPosition() ??
        await Geolocator.getCurrentPosition(timeLimit: null)
        : await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: false,
        timeLimit: null);
  }

  // void openAppSettings() async {
  //   final opened = await _geolocatorPlatform.openAppSettings();
  //   String displayValue = "";
  //   if (opened) {
  //     displayValue = 'Opened Application Settings.';
  //   } else {
  //     displayValue = 'Error opening Application Settings.';
  //   }
  // }

  Future<bool> isDenied()async{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await _geolocatorPlatform.checkPermission();

    // Test if location services are enabled.
    if (!serviceEnabled) {
      Logger().i("Test_getCurrentPositionPlatform 2");
      openLocationSettings();
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Logger().d("Test_getCurrentPositionPlatform serviceEnabled:$serviceEnabled");
      return false;
    } else {
      Logger().i("Test_getCurrentPositionPlatform 7");
    }
    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      Logger().i("Test_getCurrentPositionPlatform 4");

      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        Logger().d("Test_getCurrentPositionPlatform ${LocationPermission.denied}");
        return false;
      }
    }

    Logger().i("Test_getCurrentPositionPlatform 3 $permission");
    if (permission == LocationPermission.deniedForever) {
      Logger().i("Test_getCurrentPositionPlatform 5");
      permission = await _geolocatorPlatform.requestPermission();
      // Permissions are denied forever, handle appropriately.
      Logger().d("Test_getCurrentPositionPlatform ${LocationPermission.deniedForever}");
      await openLocationSettings();
      return false;
    }
    if (GetUtils.isNull(permission)) {
      Logger().i("Test_getCurrentPositionPlatform 8");
      permission = await _geolocatorPlatform.requestPermission();
      // Permissions are denied forever, handle appropriately.
      Logger().d("Test_getCurrentPositionPlatform $permission");
      openLocationSettings();
      return false;
    }
    Logger().i("Test_getCurrentPositionPlatform 6");
    // /*return*/ Platform.isIOS
    //     ? await _geolocatorPlatform.getLastKnownPosition() ??
    //     await Geolocator.getCurrentPosition(timeLimit: null)
    //     : await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high,
    //     forceAndroidLocationManager: false,
    //     timeLimit: null);
    return true;
  }
   openLocationSettings() async {
    final opened = await _geolocatorPlatform.openLocationSettings();
    if (opened) {
    } else {
    }
  }

}
// class LocationHelper{
//
//   LocationHelper._();
//   static final LocationHelper instance = LocationHelper._();
//   factory LocationHelper() => instance;
//
//   static const String _kLocationServicesDisabledMessage = 'Location services are disabled.';
//   static const String _kPermissionDeniedMessage = 'Permission denied.';
//   static const String _kPermissionDeniedForeverMessage = 'Permission denied forever.';
//   static const String _kPermissionGrantedMessage = 'Permission granted.';
//
//   final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
//   final List<_PositionItem> _positionItems = <_PositionItem>[];
//   StreamSubscription<Position>? _positionStreamSubscription;
//   StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;
//   bool positionStreamStarted = false;
//
//
//   Future<void> getCurrentPosition() async {
//     final hasPermission = await _handlePermission();
//
//     if (!hasPermission) {
//       //getCurrentPositionPlatform();
//       return;
//     }
//
//     // final position = await _geolocatorPlatform.getCurrentPosition();
//     // _updatePositionList(
//     //   _PositionItemType.position,
//     //   position.toString(),
//     // );
//   }
//
//   Future<bool> _handlePermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Test if location services are enabled.
//     serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       _updatePositionList(
//         _PositionItemType.log,
//         _kLocationServicesDisabledMessage,
//       );
//
//       return false;
//     }
//
//     permission = await _geolocatorPlatform.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await _geolocatorPlatform.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         _updatePositionList(
//           _PositionItemType.log,
//           _kPermissionDeniedMessage,
//         );
//
//         return false;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       _updatePositionList(
//         _PositionItemType.log,
//         _kPermissionDeniedForeverMessage,
//       );
//
//       return false;
//     }
//
//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     _updatePositionList(
//       _PositionItemType.log,
//       _kPermissionGrantedMessage,
//     );
//     return true;
//   }
//
//   void _updatePositionList(_PositionItemType type, String displayValue) {
//     _positionItems.add(_PositionItem(type, displayValue));
//     // setState(() {});
//   }
//
//   bool _isListening() => !(GetUtils.isNull(_positionStreamSubscription)  ||
//       _positionStreamSubscription!.isPaused);
//
//   Color _determineButtonColor() {
//     return _isListening() ? Colors.green : Colors.red;
//   }
//
//   void toggleServiceStatusStream() {
//     if (GetUtils.isNull(_serviceStatusStreamSubscription) ) {
//       final serviceStatusStream = _geolocatorPlatform.getServiceStatusStream();
//       _serviceStatusStreamSubscription =
//           serviceStatusStream.handleError((error) {
//             _serviceStatusStreamSubscription?.cancel();
//             // _serviceStatusStreamSubscription = null;
//           }).listen((serviceStatus) {
//             String serviceStatusValue;
//             if (serviceStatus == ServiceStatus.enabled) {
//               if (positionStreamStarted) {
//                 _toggleListening();
//               }
//               serviceStatusValue = 'enabled';
//             } else {
//               if (!GetUtils.isNull(_positionStreamSubscription)) {
//                 // setState(() {
//                 _positionStreamSubscription?.cancel();
//                 // _positionStreamSubscription = null;
//                 _updatePositionList(
//                     _PositionItemType.log, 'Position Stream has been canceled');
//                 // });
//               }
//               serviceStatusValue = 'disabled';
//             }
//             _updatePositionList(
//               _PositionItemType.log,
//               'Location service has been $serviceStatusValue',
//             );
//           });
//     }
//   }
//
//   void _toggleListening() {
//     if (GetUtils.isNull(_positionStreamSubscription)) {
//       final positionStream = _geolocatorPlatform.getPositionStream();
//       _positionStreamSubscription = positionStream.handleError((error) {
//         _positionStreamSubscription?.cancel();
//         // _positionStreamSubscription = null;
//       }).listen((position) => _updatePositionList(
//         _PositionItemType.position,
//         position.toString(),
//       ));
//       _positionStreamSubscription?.pause();
//     }
//
//     // setState(() {
//     if (GetUtils.isNull(_positionStreamSubscription)) {
//       return;
//     }
//
//     String statusDisplayValue;
//     if (_positionStreamSubscription!.isPaused) {
//       _positionStreamSubscription!.resume();
//       statusDisplayValue = 'resumed';
//     } else {
//       _positionStreamSubscription!.pause();
//       statusDisplayValue = 'paused';
//     }
//
//     _updatePositionList(
//       _PositionItemType.log,
//       'Listening for position updates $statusDisplayValue',
//     );
//     // });
//   }
//
//
//   void dispose() {
//     if (!GetUtils.isNull(_positionStreamSubscription)) {
//       _positionStreamSubscription!.cancel();
//       // _positionStreamSubscription = null;
//     }
//   }
//
//   void _getLastKnownPosition() async {
//     final position = await _geolocatorPlatform.getLastKnownPosition();
//     if (position != null) {
//       _updatePositionList(
//         _PositionItemType.position,
//         position.toString(),
//       );
//     } else {
//       _updatePositionList(
//         _PositionItemType.log,
//         'No last known position available',
//       );
//     }
//   }
//
//   void _getLocationAccuracy() async {
//     final status = await _geolocatorPlatform.getLocationAccuracy();
//     _handleLocationAccuracyStatus(status);
//   }
//
//   void _requestTemporaryFullAccuracy() async {
//     final status = await _geolocatorPlatform.requestTemporaryFullAccuracy(
//       purposeKey: "TemporaryPreciseAccuracy",
//     );
//     _handleLocationAccuracyStatus(status);
//   }
//
//   void _handleLocationAccuracyStatus(LocationAccuracyStatus status) {
//     String locationAccuracyStatusValue;
//     if (status == LocationAccuracyStatus.precise) {
//       locationAccuracyStatusValue = 'Precise';
//     } else if (status == LocationAccuracyStatus.reduced) {
//       locationAccuracyStatusValue = 'Reduced';
//     } else {
//       locationAccuracyStatusValue = 'Unknown';
//     }
//     _updatePositionList(
//       _PositionItemType.log,
//       '$locationAccuracyStatusValue location accuracy granted.',
//     );
//   }
//
//   void openAppSettings() async {
//     final opened = await _geolocatorPlatform.openAppSettings();
//     String displayValue;
//
//     if (opened) {
//       displayValue = 'Opened Application Settings.';
//     } else {
//       displayValue = 'Error opening Application Settings.';
//     }
//
//     _updatePositionList(
//       _PositionItemType.log,
//       displayValue,
//     );
//   }
//
//   void openLocationSettings() async {
//     final opened = await _geolocatorPlatform.openLocationSettings();
//     String displayValue;
//
//     if (opened) {
//       displayValue = 'Opened Location Settings';
//     } else {
//       displayValue = 'Error opening Location Settings';
//     }
//
//     _updatePositionList(
//       _PositionItemType.log,
//       displayValue,
//     );
//   }
// }
//
// enum _PositionItemType {
//   log,
//   position,
// }
//
// class _PositionItem {
//   _PositionItem(this.type, this.displayValue);
//
//   final _PositionItemType type;
//   final String displayValue;
// }
