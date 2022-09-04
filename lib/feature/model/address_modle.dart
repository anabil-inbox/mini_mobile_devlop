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
        this.title,
        this.zoneNumber
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
    dynamic zoneNumber;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        addressTitle: json["address_title"] == null ? null : json["address_title"],
        buildingNo: json["building_no"] == null ? null : json["building_no"],
        unitNo: json["unit_no"] == null ? null : json["unit_no"],
        zone: json["zone"] == null ? "":json["zone"],
        // streat: json["streat"],
        streat: json["street"] == null ? null : json["street"],
        geoAddress: json["geo_address"] == null ? null : json["geo_address"],
        zoneNumber: json["zone_number"] == null ? null:json["zone_number"],
        extraDetails: json["extra_details"] == null ? null : json["extra_details"],
        longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
        latitude: json["latitude"] == null ? null :json["latitude"].toDouble(),
        isPrimaryAddress: json["is_primary_address"] == null ? null : json["is_primary_address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "address_title": addressTitle == null ? null : addressTitle,
        "building_no": buildingNo == null ? null : buildingNo,
        "unit_no": unitNo == null ? null : unitNo,
         "zone": zone == null ? "":zone,
        "geo_address":geoAddress == null ? null : geoAddress,
        // "streat": streat,
        "street": streat == null ? null : streat,
        "extra_details": extraDetails == null ? null : extraDetails,
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "is_primary_address": isPrimaryAddress == null ? null : isPrimaryAddress,
        "title" : title == null ? null : title,
        "zone_number":zoneNumber == null ? null : zoneNumber
    };

    @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Address && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

    @override
  String toString() {
    return 'Address{id: $id, addressTitle: $addressTitle, buildingNo: $buildingNo, unitNo: $unitNo, zone: $zone, streat: $streat, extraDetails: $extraDetails, longitude: $longitude, latitude: $latitude, geoAddress: $geoAddress, isPrimaryAddress: $isPrimaryAddress, title: $title, zoneNumber: $zoneNumber}';
  }
}
