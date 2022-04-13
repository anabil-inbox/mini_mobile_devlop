class Invoices {
  Invoices({this.name, this.price});

  String? name;
  num? price;

  Map<String, dynamic> toJson() => {};

  factory Invoices.fromJson(Map<String, dynamic> json) => Invoices(
        name: json["name"] == null ? null : json["name"],
        price: json["total"] == null ? null : json["total"],
      );
}
