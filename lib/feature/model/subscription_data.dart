class SubscriptionData {
  SubscriptionData({
    this.id,
    this.status,
    this.startDate,
    this.endDate,
    this.storageType,
    this.plans,
  });

  String? id;
  String? status;
  DateTime? startDate;
  DateTime? endDate;
  String? storageType;
  List<PlanElement>? plans;

  factory SubscriptionData.fromJson(Map<String, dynamic> json) => SubscriptionData(
    id:json["id"] == null ? null: json["id"],
    status:json["status"] == null ? null: json["status"],
    startDate:json["start_date"] == null ? null: DateTime.parse(json["start_date"]),
    endDate:json["end_date"] == null ? null: DateTime.parse(json["end_date"]),
    storageType:json["storage_type"] == null ? null: json["storage_type"],
    plans:json["plans"] == null ? null: List<PlanElement>.from(json["plans"].map((x) => PlanElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id":id == null ? null: id ,
    "status":status == null ? null: status,
    "start_date":startDate == null ? null: "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date":endDate == null ? null: "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "storage_type":storageType == null ? null: storageType == null ? null : storageType,
    "plans":plans == null ? null: List<dynamic>.from(plans!.map((x) => x.toJson())),
  };
}

class PlanElement {
  PlanElement({
    this.plan,
    this.qty,
  });

  String? plan;
  int? qty;

  factory PlanElement.fromJson(Map<String, dynamic> json) => PlanElement(
    plan:json["plan"] == null ? null: json["plan"],
    qty:json["qty"] == null ? null: json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "plan":plan == null ? null: plan,
    "qty":qty == null ? null: qty,
  };
}



