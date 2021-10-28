class User {
    User({
        this.mobile,
        this.countryCode,
        this.email,
        this.fullName,
        this.udid,
        this.deviceType,
        this.fcm,
    });

    String? mobile;
    String? countryCode;
    String? email;
    String? fullName;
    String? udid;
    String? deviceType;
    String? fcm;

    factory User.fromJson(Map<String, dynamic> json) => User(
        mobile: json["mobile"],
        countryCode: json["country_code"],
        email: json["email"],
        fullName: json["full_name"],
        udid: json["udid"],
        deviceType: json["device_type"],
        fcm: json["fcm"],
    );
    

    Map<String, dynamic> toJson() => {
        "country_code": "$countryCode",
        "mobile": "$mobile",
         "udid": "$udid",
        "device_type": "$deviceType",
        "fcm": "$fcm",
        "email": "$email",
        "full_name": "$fullName",
    };
}
