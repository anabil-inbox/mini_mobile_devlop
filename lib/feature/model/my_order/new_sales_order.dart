class NewSalesOrder {
  NewSalesOrder({
     this.salesOrder,
  });

  List<SalesOrderElement>? salesOrder;

  factory NewSalesOrder.fromJson(Map<String, dynamic> json) => NewSalesOrder(
    salesOrder: List<SalesOrderElement>.from(json["sales_order"].map((x) => SalesOrderElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sales_order": List<dynamic>.from(salesOrder!.map((x) => x.toJson())),
  };
}

class SalesOrderElement {
  SalesOrderElement({
     this.order,
      this.type,
      this.address,
  });

  List<Order>? order;
  String? type;
  String? address;


  factory SalesOrderElement.fromJson(Map<String, dynamic> json) => SalesOrderElement(
    order: json["order"] == null ? null : List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
    type: json["type"] == null ? null : json["type"],
    address: json["address"] == null ? null : json["address"],

  );

  Map<String, dynamic> toJson() => {
    "order": order == null ? null : List<dynamic>.from(order!.map((x) => x.toJson())),
    "type": type == null ? null : type,
    "address": address == null ? null : address,
  };
}

class Order {
  Order({
     this.itemCode,
     this.qty,
     this.deliveryDate,
     this.subscription,
     this.subscriptionDuration,
     this.subscriptionPrice,
     this.groupId,
     this.storageType,
     this.itemParent,
     this.needAdviser,
  });

  String? itemCode;
  int? qty;
  DateTime? deliveryDate;
  String? subscription;
  int? subscriptionDuration;
  int? subscriptionPrice;
  int? groupId;
  String? storageType;
  int? itemParent;
  int? needAdviser;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    itemCode:json["item_code"] == null ? null: json["item_code"],
    qty:json["qty"] == null ? null: json["qty"],
    deliveryDate:json["delivery_date"] == null ? null: DateTime.parse(json["delivery_date"]),
    subscription:json["subscription"] == null ? null: json["subscription"],
    subscriptionDuration:json["subscription_duration"] == null ? null: json["subscription_duration"],
    subscriptionPrice:json["subscription_price"] == null ? null: json["subscription_price"],
    groupId:json["group_id"] == null ? null: json["group_id"],
    storageType:json["storage_type"] == null ? null: json["storage_type"],
    itemParent:json["item_parent"] == null ? null: json["item_parent"],
    needAdviser:json["need_adviser"] == null ? null: json["need_adviser"],
  );

  Map<String, dynamic> toJson() => {
    "item_code": itemCode,
    "qty": qty,
    "delivery_date": "${deliveryDate?.year.toString().padLeft(4, '0')}-${deliveryDate?.month.toString().padLeft(2, '0')}-${deliveryDate?.day.toString().padLeft(2, '0')}",
    "subscription": subscription,
    "subscription_duration": subscriptionDuration,
    "subscription_price": subscriptionPrice,
    "group_id": groupId,
    "storage_type": storageType,
    "item_parent": itemParent,
    "need_adviser": needAdviser,
  };
}
