class Invoices {
  Invoices({this.name, this.price , this.paymentEntryId});

  String? name;
  num? price;
  String? paymentEntryId;

  // Map<String, dynamic> toJson() => {};

  factory Invoices.fromJson(Map<String, dynamic> json) => Invoices(
        name: json["name"] == null ? null : json["name"],
        price: json["total"] == null ? null : json["total"],
        paymentEntryId: json["payment_entry_id"] == null ? null : json["payment_entry_id"],
      );

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'price': this.price,
      'paymentEntryId': this.paymentEntryId,
    };
  }

}
