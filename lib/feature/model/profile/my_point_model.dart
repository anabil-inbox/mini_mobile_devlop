class MyPoints {
  MyPoints({
    this.totalPoints,
    this.transactions,
  });

  num? totalPoints;
  List<Transaction>? transactions;

  factory MyPoints.fromJson(Map<String, dynamic> json) => MyPoints(
        totalPoints: json["total_points"] == null ? 0 :json["total_points"],
        transactions:json["transactions"] == null ? <Transaction>[]: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_points": totalPoints,
        "transactions": List<dynamic>.from(transactions!.map((x) => x.toJson())),
      };
}

class Transaction {
  Transaction({
    this.loyaltyPoints,
    this.date,
    this.salesOrder,
  });

  int? loyaltyPoints;
  DateTime? date;
  String? salesOrder;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        loyaltyPoints: json["loyalty_points"] == null ? 0:json["loyalty_points"],
        date: DateTime.parse(json["date"]),
        salesOrder: json["sales_order"],
      );

  Map<String, dynamic> toJson() => {
        "loyalty_points": loyaltyPoints,
        "date":
            "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "sales_order": salesOrder,
      };
}
