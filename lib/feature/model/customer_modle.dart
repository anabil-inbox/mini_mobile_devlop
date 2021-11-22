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

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        customerName: json["customer_name"],
        crNumber: json["cr_number"],
        email: json["email"],
        companySector: json["company_sector"],
        applicantName: json["applicant_name"],
        applicantDepartment: json["applicant_department"],
        mobile: json["mobile"],
        countryCode: json["country_code"],
        image: json["image"],
        contactNumber: List<Map<String, dynamic>>.from(json["contact_number"].map((x) => x)),
        isDisabled: json["is_disabled"],
        country: List<Country>.from(json["country"].map((x) => Country.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "customer_name": customerName,
        "cr_number": crNumber,
        "email": email,
        "company_sector": companySector,
        "applicant_name": applicantName,
        "applicant_department": applicantDepartment,
        "mobile": mobile,
        "country_code": countryCode,
        "image": image,
        "contact_number": List<Map<String, dynamic>>.from(contactNumber!.map((x) => x)),
        "is_disabled": isDisabled,
        "country": List<dynamic>.from(country!.map((x) => x.toJson())),
    };
}