// ignore_for_file: prefer_if_null_operators

import '../../feature/model/country.dart';

class Driver {
  Driver(
      {this.id,
      this.driverName,
      this.mobileNumber,
      this.countryCode,
      this.image,
      this.udId,
      this.deviceType,
      this.fcm,
      this.contactNumber,
      this.email,
      this.country});

  String? id;
  String? driverName;
  String? mobileNumber;
  String? countryCode;
  String? udId;
  String? deviceType;
  String? fcm;
  dynamic image;
  List<Map<String, dynamic>>? contactNumber;
  String? email;
  List<Country>? country;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"] ?? "",
        driverName: json["driver_name"],
        mobileNumber: json["mobile_number"],
        countryCode: json["country_code"] ?? "",
        image: json["image"] ?? "",
        udId: json["udid"] ?? "",
        deviceType: json["device_type"] ?? "",
        email: json["email"] ?? "",
        fcm: json["fcm"],
        contactNumber: json["contact_number"] == null
            ? null
            : List<Map<String, dynamic>>.from(
                json["contact_number"].map((x) => x)),
        country: json["country"] == null
            ? null
            : List<Country>.from(
                json["country"].map((x) => Country.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "id":id == null ? null: id,
        "driver_name":driverName == null ? null: driverName,
        "mobile_number":mobileNumber == null ? null: mobileNumber,
        "country_code":countryCode == null ? null: countryCode,
        "image":image == null ? null: image,
        "udid":udId == null ? null: udId,
        "fcm":fcm == null ? null: fcm,
        "email": email == null ? null:email,
        "contact_number":contactNumber == null ? null: contactNumber == null
            ? null
            : List<Map<String, dynamic>>.from(contactNumber!.map((x) => x)),
        "country":contactNumber == null ? null: country == null
            ? null
            : List<dynamic>.from(country!.map((x) => x.toJson())),
      };
}
