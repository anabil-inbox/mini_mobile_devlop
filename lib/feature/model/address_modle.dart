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
        this.geoAddress,
        this.isPrimaryAddress,
        this.title
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
    String? geoAddress;
    int? isPrimaryAddress;
    String? title;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        title: json["title"],
        addressTitle: json["address_title"],
        buildingNo: json["building_no"],
        unitNo: json["unit_no"],
        zone: json["zone"],
        streat: json["streat"],
        geoAddress: json["geo_address"],
        extraDetails: json["extra_details"],
        longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
        latitude: json["latitude"] == null ? null :json["latitude"].toDouble(),
        isPrimaryAddress: json["is_primary_address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "address_title": addressTitle,
        "building_no": buildingNo,
        "unit_no": unitNo,
        "zone": zone,
        "geo_address":geoAddress,
        "streat": streat,
        "extra_details": extraDetails,
        "longitude": longitude,
        "latitude": latitude,
        "is_primary_address": isPrimaryAddress,
        "title" : title
    };
}
