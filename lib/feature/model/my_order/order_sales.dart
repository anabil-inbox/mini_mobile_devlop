import 'package:inbox_clients/util/sh_util.dart';

class OrderSales {
  OrderSales(
      {this.orderId,
      this.customerId,
      this.orderType,
      this.proccessType,
      this.totalPrice,
      this.orderShippingAddress,
      this.orderWarehouseAddress,
      this.deliveryDate,
      this.status,
      this.orderItems,
      this.isRated = false,
      this.driverId,
      this.hasTasks = false,
      this.editable = false,
      this.isCancelled = false,
      this.boxes,
      this.statusName,
      this.timeFrom,
      this.timeTo,
      this.customerVisit = false,
      this.paymentMethod,
      this.discountAmount});

  String? orderId;
  String? customerId;
  String? orderType;
  num? totalPrice;
  num? discountAmount;
  String? orderShippingAddress;
  dynamic orderWarehouseAddress;
  DateTime? deliveryDate;
  String? status;
  String? statusName;
  String? timeFrom;
  String? timeTo;
  String? proccessType;
  String? paymentMethod;
  List<OrderItem>? orderItems;
  List<String>? boxes;
  bool? isRated;
  bool? editable;
  bool? isCancelled;
  bool? customerVisit;
  bool? hasTasks;
  String? driverId;

  factory OrderSales.fromJson(Map<String, dynamic> json) => OrderSales(
        orderId: json["order_id"] ?? "",
        customerId: json["customer_id"] ?? "",
        proccessType: json["process"] ?? "",
        orderType: json["order_type"] ?? "",
        timeFrom: json["time_from"] == null ? null : json["time_from"],
        timeTo: json["time_to"] == null ? null : json["time_to"],
        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
        totalPrice: json["total_price"] ?? "",
        discountAmount:
            json["discount_amount"] == null ? null : json["discount_amount"],
        orderShippingAddress: json["order_shipping_address"] ?? "",
        orderWarehouseAddress: json["order_warehouse_address"] ?? "",
        deliveryDate: DateTime.parse(json["delivery_date"]),
        status: json["status"] ?? "",
        statusName: json["status_name"] ?? json["status"] ?? "",
        isRated: json["is_rated"] == null ? false : json["is_rated"],
        customerVisit: json["customer_visit"] == null ? false : json["customer_visit"],
        editable: json["editable"] == null ? false : json["editable"],
        isCancelled:
            json["is_cancelled"] == null ? false : json["is_cancelled"],
        hasTasks: json["has_tasks"] == null ? false : json["has_tasks"],
        driverId: json["driver_id"] == null ? "" : json["driver_id"],
        orderItems: json["order_items"] == null
            ? []
            : List<OrderItem>.from(
                json["order_items"].map((x) => OrderItem.fromJson(x))),
        boxes: json["boxes"] == null
            ? []
            : List<String>.from(json["boxes"].map((x) => x.toString())),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "customer_id": customerId,
        "time_from": timeFrom ?? "",
        "time_to": timeTo ?? "",
        "order_type": orderType,
        "payment_method": paymentMethod,
        "process": proccessType,
        "total_price": totalPrice,
        "discount_amount": discountAmount,
        "order_shipping_address": orderShippingAddress,
        "order_warehouse_address": orderWarehouseAddress,
        "is_rated": isRated == null ? null : isRated,
        "editable": editable == null ? null : editable,
        "is_cancelled": isCancelled == null ? null : isCancelled,
        "customer_visit": customerVisit == null ? null : customerVisit,
        "has_tasks": hasTasks == null ? null : hasTasks,
        "driver_id": driverId == null ? null : driverId,
        "delivery_date":
            "${deliveryDate?.year.toString().padLeft(4, '0')}-${deliveryDate?.month.toString().padLeft(2, '0')}-${deliveryDate?.day.toString().padLeft(2, '0')}",
        "status": status ?? null,
        "status_name": statusName ?? null,
        "order_items": (orderItems == null || orderItems!.isEmpty)
            ? []
            : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        "boxes": (boxes == null || boxes!.isEmpty)
            ? []
            : List<dynamic>.from(boxes!.map((x) => x)),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderSales &&
          runtimeType == other.runtimeType &&
          orderId == other.orderId;

  @override
  int get hashCode => orderId.hashCode;
}

class OrderItem {
  OrderItem({
    this.itemParent,
    this.item,
    this.needAdviser,
    this.price,
    this.oldPrice,
    this.quantity,
    this.oldQuantity,
    this.totalPrice,
    this.groupId,
    this.itemStatus,
    this.isParent,
    this.itemsList,
    this.options,
    this.editable = false,
    this.boxes,
    this.itemName,
    this.storageType,
    this.subscriptionType,
    this.dailyPrice,
    this.monthlyPrice,
    this.yearlyPrice,
    this.subscriptionDuration,
  });

  bool? editable;
  String? itemParent;
  String? item;
  String? itemName;
  String? storageType;

  // String? storageType;
  String? subscriptionType;
  dynamic dailyPrice;
  dynamic monthlyPrice;
  dynamic yearlyPrice;
  int? needAdviser;
  int? subscriptionDuration;
  num? price;
  num? oldPrice;
  num? quantity;
  num? oldQuantity;
  num? totalPrice;
  String? groupId;
  List<String>? options;
  String? itemStatus;
  List<String>? boxes;
  dynamic isParent;
  List<ItemsList>? itemsList;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        itemParent: json["item_parent"] == null ? null : json["item_parent"],
        item: json["item"] == null ? null : json["item"],
        subscriptionType: json["subscription_type"] == null
            ? null
            : json["subscription_type"],
        dailyPrice: json["daily_price"] == null ? null : json["daily_price"],
        monthlyPrice:
            json["monthly_price"] == null ? null : json["monthly_price"],
        yearlyPrice: json["yearly_price"] == null ? null : json["yearly_price"],
        subscriptionDuration: json["subscription_duration"] == null
            ? SharedPref.instance.getAppSettings()?.minDays ?? 1
            : json["subscription_duration"],
        itemName: json["item_name"] == null ? null : json["item_name"],
        storageType:
            json["storage_type"] == null ? null : json["storage_type"] ?? "",
        needAdviser: json["need_Adviser"] == null ? null : json["need_Adviser"],
        price: json["price"] == null ? null : json["price"],
        oldPrice: json["price"] == null ? null : json["price"],
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"].map((x) => x)),
        quantity: json["quantity"] == null ? 1 : json["quantity"],
        oldQuantity: json["quantity"] == null ? 1 : json["quantity"],
        boxes: json["boxes"] == null
            ? []
            : List<String>.from(json["boxes"].map((x) => x)),
        totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
        groupId: json["group_id"] == null ? null : json["group_id"],
        itemStatus: json["item_status"] == null ? null : json["item_status"],
        isParent: json["is_parent"] == null ? null : json["is_parent"],
        editable: json["editable"] == null ? false : json["editable"],
        itemsList: json["items_list"] == null
            ? null
            : List<ItemsList>.from(
                json["items_list"].map((x) => ItemsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "item_parent": itemParent,
        "item": item,
        "subscription_type": subscriptionType,
        "subscription_duration": subscriptionDuration,
        "daily_price": dailyPrice,
        "monthly_price": monthlyPrice,
        "yearly_price": yearlyPrice,
        "item_name": itemName,
        "storage_type": storageType,
        "need_Adviser": needAdviser,
        "price": price,
        "oldPrice": oldPrice,
        "quantity": quantity,
        "oldQuantity": quantity,
        "totalPrice": totalPrice,
        "options": options,
        "group_id": groupId,
        "editable": editable == null ? null : editable,
        "item_status": itemStatus == null ? null : itemStatus,
        "is_parent": isParent,
        "items_list": itemsList == null
            ? null
            : List<dynamic>.from(itemsList!.map((x) => x.toJson())),
        "boxes": (boxes == null || boxes!.isEmpty)
            ? []
            : List<dynamic>.from(boxes!.map((x) => x)),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderItem &&
          runtimeType == other.runtimeType &&
          /*storageType == other.storageType &&*/
          itemName == other.itemName &&
          subscriptionDuration == other.subscriptionDuration &&
          subscriptionType == other.subscriptionType;

  @override
  int get hashCode =>
      // storageType.hashCode ^
      subscriptionDuration.hashCode ^
      itemName.hashCode ^
      subscriptionType.hashCode;

// @override
// bool operator ==(Object other) =>
//     identical(this, other) ||
//     other is OrderItem &&
//         runtimeType == other.runtimeType &&
//         itemParent == other.itemParent &&
//         item == other.item &&
//         needAdviser == other.needAdviser &&
//         price == other.price &&
//         quantity == other.quantity &&
//         totalPrice == other.totalPrice &&
//         groupId == other.groupId &&
//         itemStatus == other.itemStatus &&
//         isParent == other.isParent &&
//         editable == other.editable &&
//         boxes == other.boxes &&
//         itemName == other.itemName &&
//         itemsList == other.itemsList;
//
// @override
// int get hashCode =>
//     itemParent.hashCode ^
//     item.hashCode ^
//     needAdviser.hashCode ^
//     price.hashCode ^
//     quantity.hashCode ^
//     totalPrice.hashCode ^
//     groupId.hashCode ^
//     itemStatus.hashCode ^
//     isParent.hashCode ^
//     editable.hashCode ^
//     boxes.hashCode ^
//     itemName.hashCode ^
//     itemsList.hashCode;
}

class ItemsList {
  ItemsList({
    this.itemParent,
    this.item,
    this.needAdviser,
    this.price,
    this.quantity,
    this.totalPrice,
    this.groupId,
  });

  String? itemParent;
  String? item;
  int? needAdviser;
  num? price;
  num? quantity;
  num? totalPrice;
  String? groupId;

  factory ItemsList.fromJson(Map<String, dynamic> json) => ItemsList(
        itemParent: json["item_parent"],
        item: json["item"],
        needAdviser: json["need_Adviser"],
        price: json["price"],
        quantity: json["quantity"],
        totalPrice: json["total_price"],
        groupId: json["group_id"],
      );

  Map<String, dynamic> toJson() => {
        "item_parent": itemParent,
        "item": item,
        "need_Adviser": needAdviser,
        "price": price,
        "quantity": quantity,
        "total_price": totalPrice,
        "group_id": groupId,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemsList &&
          runtimeType == other.runtimeType &&
          itemParent == other.itemParent &&
          item == other.item &&
          needAdviser == other.needAdviser &&
          price == other.price &&
          quantity == other.quantity &&
          totalPrice == other.totalPrice &&
          groupId == other.groupId;

  @override
  int get hashCode =>
      itemParent.hashCode ^
      item.hashCode ^
      needAdviser.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      totalPrice.hashCode ^
      groupId.hashCode;
}
