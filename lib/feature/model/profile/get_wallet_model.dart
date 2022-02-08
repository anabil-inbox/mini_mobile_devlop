class GetWallet {
  GetWallet({
    this.id,
    this.balance,
    this.transactions,
  });

  String? id;
  String? balance;
  List<Transactions>? transactions;

  factory GetWallet.fromJson(Map<String, dynamic> json) => GetWallet(
        id: json["id"] == null ? null : json["id"],
        balance: json["balance"] == null ? null : json["balance"],
        transactions: json["transactions"] == null
            ? null
            : List<Transactions>.from(
                json["transactions"].map((x) => Transactions.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "balance": balance,
        "transactions": List<dynamic>.from(transactions!.map((x) => x)),
      };
}

class Transactions {
  Transactions({
    this.amount,
    this.type,
    this.date,
  });

  dynamic amount;
  String? type;
  DateTime? date;

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        amount: json["amount"] == null ? null : json["amount"],
        type: json["type"] == null ? null : json["type"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "type": type,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
      };
}
