class OrderSales {
  OrderSales(
      {this.orderId,
      this.customerId,
      this.orderType,
      this.totalPrice,
      this.deliveryDate,
      this.status,
      this.orderItems,
      this.orderShippingAddress,
      this.orderWarehouseAddress});

  String? orderId;
  String? customerId;
  String? orderType;
  num? totalPrice;
  DateTime? deliveryDate;
  String? status;
  List<OrderItem>? orderItems;
  String? orderShippingAddress;
  String? orderWarehouseAddress;

  factory OrderSales.fromJson(Map<String, dynamic> json) => OrderSales(
        orderId: json["order_id"],
        customerId: json["customer_id"],
        orderType: json["order_type"],
        totalPrice: json["total_price"],
        deliveryDate: json["delivery_date"] == null
            ? null
            : DateTime.parse(json["delivery_date"]),
        status: json["status"],
        orderShippingAddress: json["order_shipping_address"] == null
            ? null
            : json["order_shipping_address"],
        orderWarehouseAddress: json["order_warehouse_address"] == null
            ? null
            : json["order_warehouse_address"],
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "customer_id": customerId,
        "order_type": orderType,
        "total_price": totalPrice,
        "delivery_date":
            "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
        "status": status,
        "order_shipping_address": orderShippingAddress,
        "order_warehouse_address": orderWarehouseAddress,
        "order_items": List<dynamic>.from(orderItems!.map((x) => x.toJson())),
      };
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
  });

  String? itemParent;
  String? item;
  int? needAdviser;
  num? price;
  num? quantity;
  num? totalPrice;
  String? groupId;
  String? itemStatus;
  dynamic? isParent;
  List<ItemsList>? itemsList;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        itemParent: json["item_parent"],
        item: json["item"],
        needAdviser: json["need_Adviser"],
        price: json["price"],
        quantity: json["quantity"],
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
        "group_id": groupId,
        "item_status": itemStatus == null ? null : itemStatus,
        "is_parent": isParent,
        "items_list": itemsList == null
            ? null
            : List<dynamic>.from(itemsList!.map((x) => x.toJson())),
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
}
