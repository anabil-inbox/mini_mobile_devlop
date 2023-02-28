class InvoicesDetailsData {
    InvoicesDetailsData({
        this.id,
        this.salesOrder,
        this.serialNo,
        this.totalDays,
        this.total,
        this.to,
        this.from,
        this.subscription
    });

    String? id;
    String? salesOrder;
    String? serialNo;
    int? totalDays;
    double? total;
    DateTime? from;
    DateTime? to;
    String? subscription;

    InvoicesDetailsData copyWith({
        String? id,
        String? salesOrder,
        String? serialNo,
        int? totalDays,
        double? total,
        DateTime? from,
        DateTime? to,
        String? subscription,
    }) => 
        InvoicesDetailsData(
            id: id ?? this.id,
            salesOrder: salesOrder ?? this.salesOrder,
            serialNo: serialNo ?? this.serialNo,
            totalDays: totalDays ?? this.totalDays,
            total: total ?? this.total,
            from: from ?? this.from ,
            to: to ?? this.to ,
            subscription: subscription ?? this.subscription ,
        );

    factory InvoicesDetailsData.fromJson(Map<String, dynamic> json) => InvoicesDetailsData(
        id: json["id"] == null  ? null : json["id"],
        salesOrder: json["sales_order"] == null  ? null : json["sales_order"],
        serialNo: json["serial_no"] == null  ? null : json["serial_no"],
        totalDays: json["total_days"] == null  ? null : json["total_days"],
        total: json["total"] == null  ? null : json["total"],
        from: json["from"] == null  || json["from"] == "None"? null : DateTime.parse(json["from"]) ,
        to: json["to"] == null   || json["to"] == "None"? null : DateTime.parse(json["to"]),
        subscription: json["subscription"] == null  ? null : json["subscription"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "sales_order": salesOrder == null ? null : salesOrder,
        "serial_no": serialNo == null ? null : serialNo,
        "total_days": totalDays == null ? null : totalDays,
        "total": total == null ? null : total,
        "from": from == null ? null : "${from!.year.toString().padLeft(4, '0')}-${from!.month.toString().padLeft(2, '0')}-${from!.day.toString().padLeft(2, '0')}",
        "to": to == null ? null : "${to!.year.toString().padLeft(4, '0')}-${to!.month.toString().padLeft(2, '0')}-${to!.day.toString().padLeft(2, '0')}",
        "subscription": subscription == null ? null : subscription,
    };
}
