class Address {
    Address({
        this.id,
        this.addressTitle,
        this.buildingNo,
        this.unitNo,
        this.zone,
        this.streat,
        this.extraDetails,
        this.longitude,
        this.latitude,
        this.isPrimaryAddress,
    });

    String? id;
    String? addressTitle;
    String? buildingNo;
    String? unitNo;
    String? zone;
    String? streat;
    String? extraDetails;
    double? longitude;
    double? latitude;
    int? isPrimaryAddress;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        addressTitle: json["address_title"],
        buildingNo: json["building_no"],
        unitNo: json["unit_no"],
        zone: json["zone"],
        streat: json["streat"],
        extraDetails: json["extra_details"],
        longitude: json["longitude"].toDouble(),
        latitude: json["latitude"].toDouble(),
        isPrimaryAddress: json["is_primary_address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "address_title": addressTitle,
        "building_no": buildingNo,
        "unit_no": unitNo,
        "zone": zone,
        "streat": streat,
        "extra_details": extraDetails,
        "longitude": longitude,
        "latitude": latitude,
        "is_primary_address": isPrimaryAddress,
    };
}
