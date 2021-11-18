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
    List<dynamic>? contactNumber;

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"] ?? "",
        customerName: json["customer_name"] ?? "",
        crNumber: json["cr_number"] ?? "",
        email: json["email"] ?? "",
        companySector: json["company_sector"] ?? "",
        applicantName: json["applicant_name"] ?? "",
        applicantDepartment: json["applicant_department"] ?? "",
        mobile: json["mobile"] ?? "",
        countryCode: json["country_code"] ?? "",
        image: json["image"] ?? "",
        contactNumber: List<dynamic>.from(json["contact_number"].map((x) => x)) ,
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
        "contact_number": List<dynamic>.from(contactNumber!.map((x) => x)),
    };
}


