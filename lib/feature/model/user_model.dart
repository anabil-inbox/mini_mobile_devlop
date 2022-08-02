class Company {
  Company({
    this.crNumber,
    this.mobile,
    this.countryCode,
    this.email,
    this.companyName,
    this.companySector,
    this.applicantName,
    this.applicantDepartment,
    this.udid,
    this.deviceType,
    this.conversionFactor,
    this.fcm,
    this.reporterMobile,
    this.reporterEmail,
  });

  String? crNumber;
  String? mobile;
  String? countryCode;
  String? email;
  String? companyName;
  String? companySector;
  String? applicantName;
  String? applicantDepartment;
  String? udid;
  String? deviceType;
  String? conversionFactor;
  String? fcm;
  String? reporterMobile;
  String? reporterEmail;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        crNumber: json["cr_number"] ?? "",
        mobile: json["mobile_number"] ?? "",
        reporterEmail: json["reporter_email"] ?? "",
        reporterMobile: json["reporter_mobile"] ?? "",
        countryCode: json["country_code"] ?? "",
        email: json["email"] ?? "",
        conversionFactor: json["conversion_factor;"],
        companyName: json["company_name"] ?? "",
        companySector: json["company_sector"] ?? "",
        applicantName: json["applicant_name"] ?? "",
        applicantDepartment: json["applicant_department"] ?? "",
        udid: json["udid"] ?? "",
        deviceType: json["device_type"] ?? "",
        fcm: json["fcm"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "cr_number": crNumber,
        "reporter_mobile": reporterMobile ?? "",
        "reporter_email": reporterEmail ?? "",
        "mobile_number": mobile,
        "country_code": countryCode,
        "email": email,
        "conversion_factor": conversionFactor,
        "company_name": companyName,
        "company_sector": companySector,
        "applicant_name": applicantName,
        "applicant_department": applicantDepartment,
        "udid": udid,
        "device_type": deviceType,
        "fcm": fcm,
      };
}
