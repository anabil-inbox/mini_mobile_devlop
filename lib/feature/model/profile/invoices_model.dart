class InvoicesData {
  InvoicesData({
    this.name,
    this.total,
    this.paymentEntryId,
  });

  String? name;
  dynamic total;
  String? paymentEntryId;

  InvoicesData copyWith({
    String? name,
    dynamic total,
    String? paymentEntryId,
  }) =>
      InvoicesData(
        name: name ?? this.name,
        total: total ?? this.total,
        paymentEntryId: paymentEntryId ?? this.paymentEntryId,
      );

  factory InvoicesData.fromJson(Map<String, dynamic> json) => InvoicesData(
    name: json["name"] == null ? null : json["name"],
    total: json["total"] == null ? null : json["total"],
    paymentEntryId: json["payment_entry_id"] == null ? null : json["payment_entry_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "total": total == null ? null : total,
    "payment_entry_id": paymentEntryId == null ? null : paymentEntryId,
  };
}