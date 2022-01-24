class Beneficiary {
  Beneficiary({
    this.id,
    this.name,
    this.address,
    this.mobileNumber,
  });

  String? id;
  String? name;
  String? address;
  String? mobileNumber;

  factory Beneficiary.fromJson(Map<String, dynamic> json) => Beneficiary(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        address: json["address"] ?? "",
        mobileNumber: json["mobile_number"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "mobile_number": mobileNumber,
      };
}
