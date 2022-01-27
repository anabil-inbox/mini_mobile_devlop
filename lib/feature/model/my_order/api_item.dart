import '../app_setting_modle.dart';

class ApiItem {
  ApiItem({
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
    this.orderTo,
    this.orderFrom,
    this.orderTime,
    this.space,
    this.spaceXaxis,
    this.spaceYaxis,
    this.processType,
    this.storageChildIn,
    this.itemsChildIn,
    this.beneficiaryNameIn
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
  String? orderTo;
  String? orderFrom;
  String? orderTime;
  int? space;
  int? spaceXaxis;
  int? spaceYaxis;
  String? processType;
  String? storageChildIn;
  List<dynamic>? itemsChildIn;
  String? beneficiaryNameIn;

  factory ApiItem.fromJson(Map<String, dynamic> json) => ApiItem(
        itemCode: json["item_code"],
        qty: json["qty"],
        deliveryDate: json["delivery_date"],
        subscription: json["subscription"],
        subscriptionDuration: json["subscription_duration"],
        subscriptionPrice: json["subscription_price"],
        groupId: json["group_id"],
        storageType: json["storage_type"],
        itemParent: json["item_parent"],
        needAdviser: json["need_adviser"],
        orderTo: json["order_to"],
        orderFrom: json["order_from"],
        orderTime: json["order_time"],
        space: json["space"],
        spaceXaxis: json["space_xaxis"],
        spaceYaxis: json["space_yaxis"],
        processType: json["process_type"],
        storageChildIn: json["storage_child_in"],
        itemsChildIn: List<dynamic>.from(json["items_child_in"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "item_code": itemCode,
        "qty": qty,
        "delivery_date": deliveryDate,
        "subscription": subscription,
        "subscription_duration": subscriptionDuration,
        "subscription_price": subscriptionPrice,
        "group_id": groupId,
        "storage_type": "Process",
        "item_parent": 0,
        "need_adviser": 0,
        "order_to": orderTo,
        "order_from": orderFrom,
        "order_time": orderTime,
        "space": 0,
        "space_xaxis": 0,
        "space_yaxis": 0,
        "process_type": processType,
        "storage_child_in": storageChildIn,
        "items_child_in": List<dynamic>.from(itemsChildIn!.map((x) => x)),
      };

   static Map<String, dynamic> getApiObjectToSend(
      {required String itemCode,
      required int qty,
      required num subscriptionPrice,
      required DateTime? selectedDateTime,
      required int? groupId,
      required int? itemParent,
      required Day? selectedDay,
      required String? boxessSeriales,
      required String? beneficiaryNameIn
      }) {
    return ApiItem(
      itemCode: itemCode,
      qty: qty,
      deliveryDate: selectedDateTime == null
          ? DateTime.now().toString()
          : selectedDateTime.toString(),
      itemParent: itemParent ?? 0,
      subscriptionPrice : subscriptionPrice, 
       storageType: "Process",
      subscription: "Daily",
      subscriptionDuration: 1,
      groupId: groupId ?? 1,
      needAdviser: 0,
      orderTo: "${selectedDay?.to ?? "13:20"}",
      orderFrom: "${selectedDay?.from ?? "14:20"}",
      orderTime:"${selectedDay?.to ?? "13:20"} -- ${selectedDay?.from ?? "14:20"}",
      storageChildIn: boxessSeriales,
      itemsChildIn: [],
      space: 0,
      spaceXaxis: 0,
      spaceYaxis: 0,
      beneficiaryNameIn: beneficiaryNameIn
    ).toJson();
  }
}
