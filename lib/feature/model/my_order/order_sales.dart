class OrderSales {
  OrderSales({
    this.orderId,
    this.customerId,
    this.orderType,
    this.totalPrice,
    this.orderShippingAddress,
    this.orderWarehouseAddress,
    this.deliveryDate,
    this.status,
    this.orderItems,
  });

  String? orderId;
  String? customerId;
  String? orderType;
  num? totalPrice;
  String? orderShippingAddress;
  dynamic orderWarehouseAddress;
  DateTime? deliveryDate;
  String? status;
  List<OrderItem>? orderItems;

  factory OrderSales.fromJson(Map<String, dynamic> json) => OrderSales(
        orderId: json["order_id"] ?? "",
        customerId: json["customer_id"]?? "",
        orderType: json["order_type"]?? "",
        totalPrice: json["total_price"]?? "",
        orderShippingAddress: json["order_shipping_address"] ?? "",
        orderWarehouseAddress: json["order_warehouse_address"]?? "",
        deliveryDate: DateTime.parse(json["delivery_date"]),
        status: json["status"] ?? "",
        orderItems: json["order_items"] == null
            ? []
            : List<OrderItem>.from(json["order_items"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "customer_id": customerId,
        "order_type": orderType,
        "total_price": totalPrice,
        "order_shipping_address": orderShippingAddress,
        "order_warehouse_address": orderWarehouseAddress,
        "delivery_date":
            "${deliveryDate?.year.toString().padLeft(4, '0')}-${deliveryDate?.month.toString().padLeft(2, '0')}-${deliveryDate?.day.toString().padLeft(2, '0')}",
        "status": status,
        "order_items":  (orderItems == null || orderItems!.isEmpty)
            ? []
            : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
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
    this.quantity,
    this.totalPrice,
    this.groupId,
    this.itemStatus,
    this.isParent,
    this.itemsList,
    this.options,
    this.boxes
  });

  String? itemParent;
  String? item;
  int? needAdviser;
  num? price;
  num? quantity;
  num? totalPrice;
  String? groupId;
  List<String>? options;
  String? itemStatus;
  List<String>? boxes;
  dynamic isParent;
  List<ItemsList>? itemsList;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        itemParent: json["item_parent"],
        item: json["item"],
        needAdviser: json["need_Adviser"],
        price: json["price"],
        options: json["options"] == null ? [] : List<String>.from(json["options"].map((x) => x)),
        quantity: json["quantity"],
        boxes: json["boxes"] == null ? [] : List<String>.from(json["boxes"].map((x) => x)),
        totalPrice: json["totalPrice"],
        groupId: json["group_id"],
        itemStatus: json["item_status"] == null ? null : json["item_status"],
        isParent: json["is_parent"],
        itemsList: json["items_list"] == null
            ? null
            : List<ItemsList>.from(
                json["items_list"].map((x) => ItemsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "item_parent": itemParent,
        "item": item,
        "need_Adviser": needAdviser,
        "price": price,
        "quantity": quantity,
        "totalPrice": totalPrice,
        "options": options,
        "group_id": groupId,
        "item_status": itemStatus == null ? null : itemStatus,
        "is_parent": isParent,
        "items_list": itemsList == null
            ? null
            : List<dynamic>.from(itemsList!.map((x) => x.toJson())),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderItem &&
          runtimeType == other.runtimeType &&
          itemParent == other.itemParent &&
          item == other.item &&
          needAdviser == other.needAdviser &&
          price == other.price &&
          quantity == other.quantity &&
          totalPrice == other.totalPrice &&
          groupId == other.groupId &&
          itemStatus == other.itemStatus &&
          isParent == other.isParent &&
          itemsList == other.itemsList;

  @override
  int get hashCode =>
      itemParent.hashCode ^
      item.hashCode ^
      needAdviser.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      totalPrice.hashCode ^
      groupId.hashCode ^
      itemStatus.hashCode ^
      isParent.hashCode ^
      itemsList.hashCode;
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
