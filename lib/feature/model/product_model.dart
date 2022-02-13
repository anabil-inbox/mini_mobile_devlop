import 'package:logger/logger.dart';

class ProductModel {
  ProductModel({
    this.items,
    this.totalPages,
    this.currentPage,
  });

  List<ItemElement>? items;
  int? totalPages;
  int? currentPage;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    try {
      return ProductModel(
          items:json["items"] == null ? null: List<ItemElement>.from(json["items"].map((x) => ItemElement.fromJson(x))),
          totalPages:json["total_pages"] == null ? null: json["total_pages"],
          currentPage:json["current_page"] == null ? null: json["current_page"],
        );
    } catch (e) {
      Logger().e(e.toString());
      return ProductModel.fromJson({});
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {
          "items":items == null ? null: List<dynamic>.from(items!.map((x) => x.toJson())),
          "total_pages": totalPages,
          "current_page": currentPage,
        };
    } catch (e) {
      Logger().e(e.toString());
      return {};
    }
  }
}

class ItemElement {
  ItemElement({
    this.orderId,
    this.customerId,
    this.orderType,
    this.totalPrice,
    this.paymentMethod,
    this.paymentId,
    this.orderShippingAddress,
    this.orderWarehouseAddress,
    this.deliveryDate,
    this.status,
    this.orderItems,
  });

  String? orderId;
  String? customerId;
  String? orderType;
  int? totalPrice;
  String? paymentMethod;
  String? paymentId;
  String? orderShippingAddress;
  dynamic orderWarehouseAddress;
  DateTime? deliveryDate;
  String? status;
  List<OrderItem>? orderItems;

  factory ItemElement.fromJson(Map<String, dynamic> json) {
    try {
      return ItemElement(
          orderId:json["order_id"] == null ? null: json["order_id"],
          customerId:json["customer_id"] == null ? null: json["customer_id"],
          orderType:json["order_type"] == null ? null: json["order_type"],
          totalPrice:json["total_price"] == null ? null: json["total_price"],
          paymentMethod: json["payment_method"] == null ? null:json["payment_method"],
          paymentId:json["payment_id"] == null ? null: json["payment_id"],
          orderShippingAddress:json["order_shipping_address"] == null ? null: json["order_shipping_address"],
          orderWarehouseAddress:json["order_warehouse_address"] == null ? null: json["order_warehouse_address"],
          deliveryDate:json["delivery_date"] == null ? null: DateTime.parse(json["delivery_date"]),
          status:json["status"] == null ? null: json["status"],
          orderItems:json["order_items"] == null ? null: List<OrderItem>.from(json["order_items"].map((x) => OrderItem.fromJson(x))),
        );
    } catch (e) {
      Logger().e(e.toString());
      return ItemElement.fromJson({});
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {
          "order_id": orderId,
          "customer_id": customerId,
          "order_type": orderType,
          "total_price": totalPrice,
          "payment_method": paymentMethod,
          "payment_id": paymentId,
          "order_shipping_address": orderShippingAddress,
          "order_warehouse_address": orderWarehouseAddress,
          "delivery_date": "${deliveryDate?.year.toString().padLeft(4, '0')}-${deliveryDate?.month.toString().padLeft(2, '0')}-${deliveryDate?.day.toString().padLeft(2, '0')}",
          "status": status,
          "order_items":orderItems == null ? null: List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        };
    } catch (e) {
      Logger().e(e.toString());
      return {};
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemElement &&
          runtimeType == other.runtimeType &&
          orderId == other.orderId &&
          customerId == other.customerId &&
          orderType == other.orderType &&
          totalPrice == other.totalPrice &&
          paymentMethod == other.paymentMethod &&
          paymentId == other.paymentId &&
          orderShippingAddress == other.orderShippingAddress &&
          orderWarehouseAddress == other.orderWarehouseAddress &&
          deliveryDate == other.deliveryDate &&
          status == other.status &&
          orderItems == other.orderItems;

  @override
  int get hashCode =>
      orderId.hashCode ^
      customerId.hashCode ^
      orderType.hashCode ^
      totalPrice.hashCode ^
      paymentMethod.hashCode ^
      paymentId.hashCode ^
      orderShippingAddress.hashCode ^
      orderWarehouseAddress.hashCode ^
      deliveryDate.hashCode ^
      status.hashCode ^
      orderItems.hashCode;
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
    this.isParent,
    this.beneficiaryNameIn,
    this.itemsList,
  });

  String? itemParent;
  String? item;
  int? needAdviser;
  int? price;
  int? quantity;
  int? totalPrice;
  String? groupId;
  String? isParent;
  dynamic beneficiaryNameIn;
  List<ItemsList>? itemsList;

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    try {
      return OrderItem(
          itemParent:json["item_parent"] == null ? null: json["item_parent"],
          item:json["item"] == null ? null: json["item"],
          needAdviser:json["need_Adviser"] == null ? null: json["need_Adviser"],
          price:json["price"] == null ? null: json["price"],
          quantity:json["quantity"] == null ? null: json["quantity"],
          totalPrice:json["totalPrice"] == null ? null: json["totalPrice"],
          groupId:json["group_id"] == null ? null: json["group_id"],
          isParent:json["is_parent"] == null ? null: json["is_parent"],
          beneficiaryNameIn:json["beneficiary_name_in"] == null ? null: json["beneficiary_name_in"],
          itemsList:json["items_list"] == null ? null: List<ItemsList>.from(json["items_list"].map((x) => ItemsList.fromJson(x))),
        );
    } catch (e) {
      Logger().e(e.toString());
      return OrderItem.fromJson({});
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {
          "item_parent": itemParent,
          "item": item,
          "need_Adviser": needAdviser,
          "price": price,
          "quantity": quantity,
          "totalPrice": totalPrice,
          "group_id": groupId,
          "is_parent": isParent,
          "beneficiary_name_in": beneficiaryNameIn,
          "items_list":itemsList == null ?null : List<dynamic>.from(itemsList!.map((x) => x.toJson())),
        };
    } catch (e) {
      Logger().e(e.toString());
      return {};
    }
  }

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
          isParent == other.isParent &&
          beneficiaryNameIn == other.beneficiaryNameIn &&
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
      isParent.hashCode ^
      beneficiaryNameIn.hashCode ^
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
    this.beneficiaryNameIn,
  });

  String? itemParent;
  String? item;
  int? needAdviser;
  int? price;
  int? quantity;
  int? totalPrice;
  String? groupId;
  dynamic beneficiaryNameIn;

  factory ItemsList.fromJson(Map<String, dynamic> json) {
    try {
      return ItemsList(
          itemParent:json["item_parent"] == null ? null: json["item_parent"],
          item:json["item"] == null ? null: json["item"],
          needAdviser:json["need_Adviser"] == null ? null: json["need_Adviser"],
          price:json["price"] == null ? null: json["price"],
          quantity:json["quantity"] == null ? null: json["quantity"],
          totalPrice:json["total_price"] == null ? null: json["total_price"],
          groupId:json["group_id"] == null ? null: json["group_id"],
          beneficiaryNameIn:json["beneficiary_name_in"] == null ? null: json["beneficiary_name_in"],
        );
    } catch (e) {
      Logger().e(e.toString());
      return ItemsList.fromJson({});
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {
          "item_parent": itemParent,
          "item":item,
          "need_Adviser": needAdviser,
          "price": price,
          "quantity": quantity,
          "total_price": totalPrice,
          "group_id": groupId,
          "beneficiary_name_in": beneficiaryNameIn,
        };
    } catch (e) {
      Logger().e(e.toString());
      return {};
    }
  }

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
          groupId == other.groupId &&
          beneficiaryNameIn == other.beneficiaryNameIn;

  @override
  int get hashCode =>
      itemParent.hashCode ^
      item.hashCode ^
      needAdviser.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      totalPrice.hashCode ^
      groupId.hashCode ^
      beneficiaryNameIn.hashCode;
}

