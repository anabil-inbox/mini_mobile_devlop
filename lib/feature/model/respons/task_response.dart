// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

import 'package:inbox_clients/feature/model/home/box_model.dart';

class TaskResponse {
  TaskResponse(
      {this.salesOrder,
      this.isNew,
      this.customerId,
      this.childOrder,
      this.total,
      this.totalPaid,
      this.totalDue,
      this.paymentMethod,
      this.boxes,
      this.scannedBoxes,
      this.customerScanned,
      this.driverDelivered,
      this.customerDelivered,
      this.signatureType,
      this.signatureFile,
      this.processType,
      this.driverToken,
      this.taskStatus,
      this.waitingTime = 0.0,
      this.lateFees,
      this.urlPayment,
      this.items,
      this.waittingFees,
      this.cancellationFees,
        this.hasDeliveredScan,
      this.hasTimeRequest,
        this.driverId,
        this.hasTasks = false,
        this.isRated = false,
      this.notificationId});

  String? salesOrder;
  bool? isNew;
  String? customerId;
  ChildOrder? childOrder;
  num? total;
  num? totalPaid;
  num? totalDue;
  num? cancellationFees;
  bool? hasTimeRequest;
  String? paymentMethod;
  List<BoxModel>? boxes;
  List<BoxModel>? scannedBoxes;
  List<BoxModel>? customerScanned;
  List<BoxModel>? driverDelivered;
  List<BoxModel>? customerDelivered;
  String? signatureType;
  dynamic signatureFile;
  String? processType;
  String? driverToken;
  String? taskStatus;
  String? notificationId;
  num? waitingTime;
  List<LateFees>? lateFees;
  List<FetchedItem>? items;
  num? waittingFees;
  bool? hasDeliveredScan;
  bool? isRated;
  bool? hasTasks;
  String? driverId;
  String? urlPayment;
  factory TaskResponse.fromJson(Map<String, dynamic> json,
      {required bool isFromNotification}) {
    if (isFromNotification) {
      return TaskResponse(
        salesOrder: json["sales_order"],
        urlPayment: json["url"] == null ? null:json["url"],
        isNew: json["is_new"] == "false"
            ? false
            : json["is_new"] == "true"
                ? true
                : false,
        hasTimeRequest: json["has_time_request"] == "false"
            ? false
            : json["has_time_request"] == "true"
                ? true
                : false,
        customerId: json["customer_id"],
        waittingFees: num.tryParse(json["waiting_fees"].toString()),
        childOrder: json["child_order"] == null
            ? null
            : ChildOrder.fromJson(jsonDecode(json["child_order"])),
        total: num.tryParse(json["total"].toString()),
        totalPaid: num.tryParse(json["total_paid"].toString()),
        totalDue: num.tryParse(json["total_due"].toString()),
        paymentMethod: json["payment_method"],
        items: json["items"] == null
            ? null
            : List<FetchedItem>.from(
                jsonDecode(json["items"]).map((x) => FetchedItem.fromJson(x))),
        notificationId: json["id"],
        boxes: json["boxes"] == null
            ? []
            : List<BoxModel>.from(
                    jsonDecode(json["boxes"]).map((x) => BoxModel.fromJson(x)))
                .toSet()
                .toList(),
        lateFees: json["late_fees"] == null
            ? []
            : List<LateFees>.from(jsonDecode(json["late_fees"])
                .map((x) => LateFees.fromJson(x))).toSet().toList(),
        scannedBoxes: json["scanned_boxes"] == null
            ? []
            : List<BoxModel>.from(jsonDecode(json["scanned_boxes"])
                .map((x) => BoxModel.fromJson(x))).toSet().toList(),
        customerScanned: json["customer_scanned"] == null
            ? []
            : List<BoxModel>.from(jsonDecode(json["customer_scanned"])
                .map((x) => BoxModel.fromJson(x))).toSet().toList(),
        driverDelivered: json["driver_delivered"] == null
            ? []
            : List<BoxModel>.from(jsonDecode(json["driver_delivered"])
                .map((x) => BoxModel.fromJson(x))).toSet().toList(),
        customerDelivered: json["customer_delivered"] == null
            ? []
            : List<BoxModel>.from(jsonDecode(json["customer_delivered"])
                .map((x) => BoxModel.fromJson(x))).toSet().toList(),
        signatureType: json["signature_type"],
        signatureFile: json["signature_file"],
        processType: json["process_type"],
        driverToken: json["driver_token"],
        taskStatus: json["task_status"],
        waitingTime: num.tryParse(json["waiting_time"].toString()) ?? 0.0,
        cancellationFees:
            num.tryParse(json["cancellation_fees"].toString()) ?? 0.0,
    hasDeliveredScan: json["has_delivered_scan"] == "false"
    ? false
        : json["has_delivered_scan"] == "true"?true:false,
    isRated: json["is_rated"] != null &&  json["is_rated"] == "true" ? true : json["is_rated"] != null &&  json["is_rated"] == "false" ? false:false,
    hasTasks: json["has_tasks"] != null &&  json["has_tasks"] == "true" ? true : json["has_tasks"] != null &&  json["has_tasks"] == "false" ? false:false,
    driverId: json["driver_id"] == null ? "" : json["driver_id"],
      );
    } else {
      return TaskResponse(
        salesOrder: json["sales_order"],
        isNew: json["is_new"] == null ? null : json["is_new"],
        urlPayment: json["url"] == null ? null:json["url"],
        hasTimeRequest:
            json["has_time_request"] == null ? null : json["has_time_request"],
        customerId: json["customer_id"],
        waittingFees: num.tryParse(json["waiting_fees"].toString()),
        childOrder: json["child_order"] == null
            ? null
            : ChildOrder.fromJson(json["child_order"]),
        total: num.tryParse(json["total"].toString()),
        totalPaid: num.tryParse(json["total_paid"].toString()),
        totalDue: num.tryParse(json["total_due"].toString()),
        paymentMethod: json["payment_method"],
        notificationId: json["id"],
        items: json["items"] == null
            ? null
            : List<FetchedItem>.from(
                json["items"].map((x) => FetchedItem.fromJson(x))),
        boxes: json["boxes"] == null
            ? []
            : List<BoxModel>.from(
                json["boxes"].map((x) => BoxModel.fromJson(x))),
        lateFees: json["late_fees"] == null
            ? []
            : List<LateFees>.from(
                json["late_fees"].map((x) => LateFees.fromJson(x))),
        scannedBoxes: json["scanned_boxes"] == null
            ? []
            : List<BoxModel>.from(
                json["scanned_boxes"].map((x) => BoxModel.fromJson(x))),
        customerScanned: json["customer_scanned"] == null
            ? []
            : List<BoxModel>.from(
                json["customer_scanned"].map((x) => BoxModel.fromJson(x))),
        driverDelivered: json["driver_delivered"] == null
            ? []
            : List<BoxModel>.from(
                json["driver_delivered"].map((x) => BoxModel.fromJson(x))),
        customerDelivered: json["customer_delivered"] == null
            ? []
            : List<BoxModel>.from(
                json["customer_delivered"].map((x) => BoxModel.fromJson(x))),
        signatureType: json["signature_type"],
        signatureFile: json["signature_file"],
        processType: json["process_type"],
        driverToken: json["driver_token"],
        taskStatus: json["task_status"],
        cancellationFees:
            num.tryParse(json["cancellation_fees"].toString()) ?? 0.0,
        waitingTime: num.tryParse(json["waiting_time"].toString()) ?? 0.0,
    hasDeliveredScan: json["has_delivered_scan"] == null? null: json["has_delivered_scan"],
    isRated: json["is_rated"] == null ? false : json["is_rated"],
    hasTasks: json["has_tasks"] == null ? false : json["has_tasks"],
    driverId: json["driver_id"] == null ? "" : json["driver_id"],
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "sales_order": salesOrder,
        "is_new": isNew,
        "customer_id": customerId,
        "waiting_time": waitingTime ?? 0.0,
        "child_order": childOrder,
        "total": total,
        "url": urlPayment,
        "total_paid": totalPaid,
        "total_due": totalDue,
        "payment_method": paymentMethod,
        "id": notificationId,
        "boxes": boxes == null
            ? []
            : List<dynamic>.from(boxes!.map((x) => x.toJson())),
        "scanned_boxes": scannedBoxes == null
            ? []
            : List<dynamic>.from(scannedBoxes!.map((x) => x.toJson())),
        "customer_scanned": customerScanned == null
            ? []
            : List<dynamic>.from(customerScanned!.map((x) => x)),
        "driver_delivered": driverDelivered == null
            ? []
            : List<dynamic>.from(driverDelivered!.map((x) => x)),
        "customer_delivered": customerDelivered == null
            ? []
            : List<dynamic>.from(customerDelivered!.map((x) => x)),
        "late_fees":
            lateFees == null ? [] : List<dynamic>.from(lateFees!.map((x) => x)),
        "signature_type": signatureType,
        "signature_file": signatureFile,
        "process_type": processType,
        "driver_token": driverToken,
        "task_status": taskStatus,
        "is_rated": isRated == null ? null : isRated,
        "has_tasks": hasTasks == null ? null : hasTasks,
        "driver_id": driverId == null ? null : driverId,
      };
}

class ChildOrder {
  ChildOrder({
    this.id,
    this.paymentMethod,
    this.items,
  });

  String? id;
  String? paymentMethod;
  List<Item>? items;

  factory ChildOrder.fromJson(Map<String, dynamic> json) => ChildOrder(
        id: json["id"],
        paymentMethod: json["payment_method"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "payment_method": paymentMethod,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.product,
    this.name,
    this.price,
    this.qty,
    this.image,
  });

  String? product;
  String? name;
  num? price;
  num? qty;
  dynamic image;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        product: json["product"],
        name: json["name"],
        price: json["price"],
        qty: json["qty"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "name": name,
        "price": price,
        "qty": qty,
        "image": image,
      };
}

class LateFees {
  LateFees({
    this.mFrom,
    this.mTo,
    this.fees,
  });

  int? mFrom;
  int? mTo;
  num? fees;

  factory LateFees.fromJson(Map<String, dynamic> json) => LateFees(
        mFrom: json["m_from"] == null ? null : json["m_from"],
        mTo: json["m_to"] == null ? null : json["m_to"],
        fees: json["fees"] == null ? null : json["fees"],
      );

  Map<String, dynamic> toJson() => {
        "m_from": mFrom == null ? null : mFrom,
        "m_to": mTo == null ? null : mTo,
        "fees": fees == null ? null : fees,
      };
}

class FetchedItem {
  FetchedItem({
    this.id,
    this.itemName,
    this.itemGallery,
  });

  String? id;
  String? itemName;
  List<dynamic>? itemGallery;

  factory FetchedItem.fromJson(Map<String, dynamic> json) => FetchedItem(
        id: json["id"],
        itemName: json["item_name"],
        itemGallery: json["item_gallery"] == null
            ? []
            : List<dynamic>.from(json["item_gallery"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_name": itemName,
        "item_gallery": List<dynamic>.from(itemGallery!.map((x) => x)),
      };
}
