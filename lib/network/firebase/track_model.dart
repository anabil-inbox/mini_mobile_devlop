// ignore_for_file: prefer_null_aware_operators

import 'dart:convert' as j;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inbox_clients/network/firebase/driver_modle.dart';
import 'package:inbox_clients/network/firebase/sales_order.dart';
import 'package:logger/logger.dart';

class TrackModel {
  TrackModel(
      {this.serialOrderData,
      this.serialOrderDriverData,
      this.serialOrderDriverLocation});

  SalesOrder? serialOrderData;
  Driver? serialOrderDriverData;
  LatLng? serialOrderDriverLocation;

  factory TrackModel.fromJson(dynamic json) {
    try {
      // Logger().d("TrackModel_ $json");
      if (json == null) {
        return TrackModel(
          serialOrderData: null,
          serialOrderDriverData: null,
          serialOrderDriverLocation: null,
        );
      } else if (json.isEmpty) {
        return TrackModel(
          serialOrderData: null,
          serialOrderDriverData: null,
          serialOrderDriverLocation: null,
        );
      } else {
        return TrackModel(
          serialOrderData: json["serialOrderData"] == null
              ? null
              : SalesOrder.fromJson(j.json.decode(json["serialOrderData"])),
          serialOrderDriverData: json["serialOrderDriverData"] == null
              ? null
              : Driver.fromJson(j.json.decode(json["serialOrderDriverData"])),
          serialOrderDriverLocation: json["serialOrderDriverLocation"] == null
              ? null
              : LatLng.fromJson(json["serialOrderDriverLocation"]),
        );
      }
    } catch (e) {
      print(e);
      return TrackModel.fromJson({});
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {
        "serialOrderData":
            serialOrderData == null ? null : serialOrderData?.toJson(),
        "serialOrderDriverData": serialOrderDriverData == null
            ? null
            : serialOrderDriverData?.toJson(),
        "serialOrderDriverLocation": serialOrderDriverLocation == null
            ? null
            : serialOrderDriverLocation?.toJson(),
      };
    } catch (e) {
      print(e);
      return {
        "serialOrderData": null,
        "serialOrderDriverData": null,
        "serialOrderDriverLocation": null,
      };
    }
  }
}
