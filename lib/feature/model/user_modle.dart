class User {
  User(
      {this.mobile,
      this.countryCode,
      this.email,
      this.fullName,
      this.udid,
      this.deviceType,
      this.fcm,
      this.conversionFactor});

  String? mobile;
  String? countryCode;
  String? email;
  String? fullName;
  String? udid;
  String? deviceType;
  String? fcm;
  String? conversionFactor;

  factory User.fromJson(Map<String, dynamic> json) => User(
      mobile: json["mobile_number"],
      countryCode: json["country_code"],
      email: json["email"],
      fullName: json["full_name"],
      udid: json["udid"],
      deviceType: json["device_type"],
      fcm: json["fcm"],
      conversionFactor: json["conversion_factor"]);

  Map<String, dynamic> toJson() => {
        "country_code": "$countryCode",
        "mobile_number": "$mobile",
        "udid": "$udid",
        "conversion_factor": conversionFactor,
        "device_type": "$deviceType",
        "fcm": "$fcm",
        "email": "$email",
        "full_name": "$fullName",
      };
}
