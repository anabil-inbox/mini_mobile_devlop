// ignore_for_file: prefer_if_null_operators

import '../../feature/model/home/box_model.dart';

class SalesOrder {
  SalesOrder({
    this.orderId,
    this.taskId,
    this.contentStatus,
    this.customerId,
    this.customerMobile,
    this.orderType,
    this.totalPrice,
    this.orderShippingAddress,
    this.orderWarehouseAddress,
    this.deliveryDate,
    this.status,
    this.totalBoxes,
    this.totalReceived,
    this.orderDoc,
    this.customerImage,
    this.orderItems,
    this.taskStatus,
    this.latituide,
    this.longitude,
    this.boxes,
    this.buildingNo,
    this.fromTime,
    this.paymentMethod,
    this.street,
    this.toTime,
    this.unitNo,
  });

  String? orderId;
  String? taskId;
  String? contentStatus;
  String? customerId;
  String? customerImage;
  dynamic customerMobile;
  String? taskStatus;
  String? orderType;
  num? totalPrice;
  String? orderShippingAddress;
  dynamic orderWarehouseAddress;
  DateTime? deliveryDate;
  String? status;
  num? totalBoxes;
  num? totalReceived;
  String? orderDoc;
  List<OrderItem>? orderItems;
  double? latituide;
  double? longitude;
  String? buildingNo;
  String? unitNo;
  String? street;
  String? fromTime;
  String? toTime;
  String? paymentMethod;
  List<BoxModel>? boxes;

  factory SalesOrder.fromJson(Map<String, dynamic> json) => SalesOrder(
        orderId: json["order_id"],
        taskId: json["task_id"],
        contentStatus: json["content_status"],
        customerId: json["customer_id"],
        customerImage:
            json["customer_image"] == null ? null : json["customer_image"],
        customerMobile: json["customer_mobile"],
        longitude: json["longitude"],
        latituide: json["latitude"],
        orderType: json["order_type"],
        totalPrice: json["total_price"],
        taskStatus: json["task_status"].toString().toLowerCase(),
        orderShippingAddress: json["order_shipping_address"],
        orderWarehouseAddress: json["order_warehouse_address"],
        deliveryDate: DateTime.parse(json["delivery_date"]),
        status: json["status"],
        totalBoxes: json["total_boxes"],
        totalReceived: json["total_received"],
        orderDoc: json["order_doc"],
        buildingNo: json["building_no"],
        unitNo: json["unit_no"],
        street: json["street"],
        fromTime: json["from_time"].toString().split(".")[0],
        toTime: json["to_time"].toString().split(".")[0],
        paymentMethod: json["payment_method"],
        boxes:
            List<BoxModel>.from(json["boxes"].map((x) => BoxModel.fromJson(x))),
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_id":orderId == null ? null: orderId,
        "task_id":taskId == null ? null: taskId,
        "content_status":contentStatus == null ? null: contentStatus,
        "customer_id":customerId == null ? null: customerId,
        "customer_mobile":customerMobile == null ? null: customerMobile,
        "order_type":orderType == null ? null: orderType,
        "total_price":totalPrice == null ? null: totalPrice,
        "task_status":taskStatus == null ? null: taskStatus,
        "building_no":buildingNo == null ? null: buildingNo,
        "unit_no":unitNo == null ? null: unitNo,
        "street":street == null ? null: street,
        "from_time":fromTime == null ? null: fromTime,
        "to_time":toTime == null ? null: toTime,
        "payment_method":paymentMethod == null ? null: paymentMethod,
        "order_shipping_address":orderShippingAddress == null ? null: orderShippingAddress,
        "order_warehouse_address":orderWarehouseAddress == null ? null: orderWarehouseAddress,
        "delivery_date":deliveryDate == null ? null:
            "${deliveryDate?.year.toString().padLeft(4, '0')}-${deliveryDate?.month.toString().padLeft(2, '0')}-${deliveryDate?.day.toString().padLeft(2, '0')}",
        "status":status == null ? null: status,
        "total_boxes":totalBoxes == null ? null: totalBoxes,
        "total_received":totalReceived == null ? null: totalReceived,
        "order_doc":orderDoc == null ? null: orderDoc,
        "order_items":orderItems == null ? null: List<dynamic>.from(orderItems!.map((x) => x.toJson())),
      };
}

class OrderItem {
  OrderItem(
      {this.itemParent,
      this.item,
      this.needAdviser,
      this.price,
      this.quantity,
      this.totalPrice,
      this.groupId,
      this.isParent,
      this.itemsList,
      this.itemStatus,
      this.boxes,
      this.options});

  String? itemParent;
  String? item;
  num? needAdviser;
  num? price;
  num? quantity;
  num? totalPrice;
  String? groupId;
  String? isParent;
  List<String>? options;
  List<String>? boxes;

  List<ItemsList>? itemsList;
  String? itemStatus;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        itemParent: json["item_parent"],
        item: json["item"],
        needAdviser: json["need_Adviser"],
        price: json["price"],
        quantity: json["quantity"],
        totalPrice: json["totalPrice"],
        groupId: json["group_id"],
        boxes: json["boxes"] == null
            ? []
            : List<String>.from(json["boxes"].map((x) => x)),
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"].map((x) => x)),
        isParent: json["is_parent"] == null ? null : json["is_parent"],
        itemsList: json["items_list"] == null
            ? null
            : List<ItemsList>.from(
                json["items_list"].map((x) => ItemsList.fromJson(x))),
        itemStatus: json["item_status"] == null ? null : json["item_status"],
      );

  Map<String, dynamic> toJson() => {
        "item_parent": itemParent,
        "item": item,
        "need_Adviser": needAdviser,
        "price": price,
        "quantity": quantity,
        "totalPrice": totalPrice,
        "group_id": groupId,
        "is_parent": isParent == null ? null : isParent,
        "items_list": itemsList == null
            ? null
            : List<dynamic>.from(itemsList!.map((x) => x.toJson())),
        "item_status": itemStatus == null ? null : itemStatus,
      };
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
  num? needAdviser;
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
}
