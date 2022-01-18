class OrderItem {
    OrderItem({
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
        this.from,
        this.to,
        this.spacex,
        this.space,
        this.spacey
    });

    String? itemCode;
    int? qty;
    String? deliveryDate;
    String? subscription;
    int? subscriptionDuration;
    num? subscriptionPrice;
    int? groupId;
    String? storageType;
    int? itemParent;
    int? needAdviser;
    String? from;
    String? to;
    String? spacex;
    String? spacey;
    String? space;
    
    factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        itemCode: json["item_code"],
        qty: json["qty"],
        deliveryDate: json["delivery_date"],
        subscription: json["subscription"],
        subscriptionDuration: json["subscription_duration"],
        subscriptionPrice: json["subscription_price"],
        groupId: json["group_id"],
        storageType: json["storage_type"] == null ? null : json["storage_type"],
        itemParent: json["item_parent"],
        needAdviser: json["need_adviser"] == null ? null : json["need_adviser"],
    );

    Map<String, dynamic> toJson() => {
        "item_code": itemCode,
        "qty": qty,
        "delivery_date": deliveryDate,
        "subscription": subscription,
        "subscription_duration": subscriptionDuration,
        "subscription_price": subscriptionPrice,
        "group_id": groupId,
        "storage_type": storageType == null ? null : storageType,
        "item_parent": itemParent,
        "order_from" : from,
        "order_to": to,
        "order_time" : "$from / $to",
        "spacex" : spacex,
        "spacey" : spacey,
        "space" : int.parse(spacex ?? "0") * int.parse(spacey ?? "0"),
        "need_adviser": needAdviser == null ? null : needAdviser,
    };
}
