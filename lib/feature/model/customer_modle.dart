import 'package:inbox_clients/feature/model/country.dart';

class Customer {
  Customer({
    this.id,
    this.customerName,
    this.crNumber,
    this.email,
    this.companySector,
    this.applicantName,
    this.applicantDepartment,
    this.mobile,
    this.countryCode,
    this.image,
    this.contactNumber,
    this.isDisabled,
    this.country,
    this.conversionFactor,
    this.reporterMobile,
    this.reporterEmail,
  });

  String? id;
  String? customerName;
  dynamic crNumber;
  String? email;
  dynamic companySector;
  dynamic applicantName;
  dynamic applicantDepartment;
  String? mobile;
  String? countryCode;
  dynamic image;
  List<Map<String, dynamic>>? contactNumber;
  bool? isDisabled;
  List<Country>? country;
  num? conversionFactor;
  String? reporterMobile;
  String? reporterEmail;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"] ?? "",
        reporterEmail: json["reporter_email"] ?? "",
        reporterMobile: json["reporter_mobile"] ?? "",
        customerName: json["customer_name"] ?? "",
        crNumber: json["cr_number"] ?? "",
        conversionFactor: json["conversion_factor"] ?? "",
        email: json["email"] ?? "",
        companySector: json["company_sector"] ?? "",
        applicantName: json["applicant_name"] ?? "",
        applicantDepartment: json["applicant_department"] ?? "",
        mobile: json["mobile_number"] ?? "",
        countryCode: json["country_code"] ?? "",
        image: json["image"] ?? "",
        contactNumber: json["contact_number"] == null
            ? null
            : List<Map<String, dynamic>>.from(
                json["contact_number"].map((x) => x)),
        isDisabled: json["is_disabled"],
        country: json["country"] == null
            ? null
            : List<Country>.from(
                json["country"].map((x) => Country.fromJson(x)),
              ),
        //  country: List<Country>.from(json["country"].map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reporter_mobile": reporterMobile ?? "",
        "reporter_email": reporterEmail ?? "",
        "customer_name": customerName,
        "cr_number": crNumber,
        "email": email,
        "conversion_factor": conversionFactor,
        "company_sector": companySector,
        "applicant_name": applicantName,
        "applicant_department": applicantDepartment,
        "mobile_number": mobile,
        "country_code": countryCode,
        "image": image,
        "contact_number": contactNumber == null
            ? null
            : List<Map<String, dynamic>>.from(contactNumber!.map((x) => x)),
        "is_disabled": isDisabled,
        "country": country == null
            ? null
            : List<dynamic>.from(country!.map((x) => x.toJson())),
      };
}
