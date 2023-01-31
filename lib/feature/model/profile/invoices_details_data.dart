class InvoicesDetailsData {
    InvoicesDetailsData({
        this.id,
        this.salesOrder,
        this.serialNo,
        this.totalDays,
        this.total,
    });

    String? id;
    String? salesOrder;
    String? serialNo;
    int? totalDays;
    double? total;

    InvoicesDetailsData copyWith({
        String? id,
        String? salesOrder,
        String? serialNo,
        int? totalDays,
        double? total,
    }) => 
        InvoicesDetailsData(
            id: id ?? this.id,
            salesOrder: salesOrder ?? this.salesOrder,
            serialNo: serialNo ?? this.serialNo,
            totalDays: totalDays ?? this.totalDays,
            total: total ?? this.total,
        );

    factory InvoicesDetailsData.fromJson(Map<String, dynamic> json) => InvoicesDetailsData(
        id: json["id"] == null  ? null : json["id"],
        salesOrder: json["sales_order"] == null  ? null : json["sales_order"],
        serialNo: json["serial_no"] == null  ? null : json["serial_no"],
        totalDays: json["total_days"] == null  ? null : json["total_days"],
        total: json["total"] == null  ? null : json["total"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "sales_order": salesOrder == null ? null : salesOrder,
        "serial_no": serialNo == null ? null : serialNo,
        "total_days": totalDays == null ? null : totalDays,
        "total": total == null ? null : total,
    };
}
