// class TaskResponse {
//   TaskResponse(
//       {this.isNew,
//       this.customerId,
//       this.total,
//       this.totalPaid,
//       this.totalDue,
//       this.paymentMethod,
//       this.salesOrder,
//       this.proccessType});

//   bool? isNew;
//   String? customerId;
//   num? total;
//   num? totalPaid;
//   num? totalDue;
//   String? paymentMethod;
//   String? proccessType;
//   String? salesOrder;

//   factory TaskResponse.fromJson(Map<String, dynamic> json) => TaskResponse(
//         isNew: json["is_new"],
//         customerId: json["customer_id"],
//         total: json["total"],
//         salesOrder: json["sales_order"],
//         proccessType: json["process_type"],
//         paymentMethod: json["payment_method"],
//         totalPaid: json["total_paid"],
//         totalDue: json["total_due"],
//       );

//   Map<String, dynamic> toJson() => {
//         "is_new": isNew,
//         "customer_id": customerId,
//         "process_type": proccessType,
//         "total": total,
//         "sales_order": salesOrder,
//         "payment_method": paymentMethod,
//         "total_paid": totalPaid,
//         "total_due": totalDue,
//       };
// }

import 'dart:convert';

class TaskResponse {
  TaskResponse({
    this.childOrderId,
    this.productCode,
    this.qty,
    this.productPrice,
    this.productImage,
    this.salesOrder,
    this.isNew,
    this.customerId,
    this.processType,
    this.paymentMethod,
    this.childOrder,
    this.total,
    this.totalPaid,
    this.totalDue,
    this.notificationId
  });

  String? childOrderId;
  String? productCode;
  String? qty;
  String? productPrice;
  dynamic productImage;
  String? salesOrder;
  String? isNew;
  String? customerId;
  String? processType;
  String? paymentMethod;
  ChildOrder? childOrder;
  dynamic total;
  dynamic totalPaid;
  dynamic totalDue;
  dynamic notificationId;

  factory TaskResponse.fromJson(Map<String, dynamic> json) => TaskResponse(
        childOrderId: json["child_order_id"],
        productCode: json["product_code"],
        qty: json["qty"],
        productPrice: json["product_price"],
        productImage: json["product_image"],
        salesOrder: json["sales_order"],
        isNew: json["is_new"],
        customerId: json["customer_id"],
        processType: json["process_type"],
        paymentMethod: json["payment_method"],
        childOrder: json["child_order"] == null
            ? ChildOrder(items: [])
            : ChildOrder.fromJson(jsonDecode(json["child_order"])),
        total: json["total"],
        totalPaid: json["total_paid"],
        totalDue: json["total_due"],
      notificationId : json["id"]
      );

  Map<String, dynamic> toJson() => {
        "child_order_id": childOrderId,
        "product_code": productCode,
        "qty": qty,
        "product_price": productPrice,
        "product_image": productImage,
        "sales_order": salesOrder,
        "is_new": isNew,
        "customer_id": customerId,
        "process_type": processType,
        "payment_method": paymentMethod,
        "child_order": childOrder?.toJson(),
        "total": total,
        "total_paid": totalPaid,
        "total_due": totalDue,
         "notificationId" : notificationId
      };
}

class ChildOrder {
  ChildOrder({
    this.id,
    this.items,
  });

  String? id;
  List<Item>? items;

  factory ChildOrder.fromJson(Map<String, dynamic> json) => ChildOrder(
        id: json["id"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.product,
    this.name,
    this.price,
    this.qty,
  });

  String? product;
  String? name;
  num? price;
  num? qty;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        product: json["product"],
        name: json["name"],
        price: json["price"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "name": name,
        "price": price,
        "qty": qty,
      };
}
