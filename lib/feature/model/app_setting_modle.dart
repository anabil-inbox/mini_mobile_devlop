class ApiSettings {
    ApiSettings({
        this.customerType,
        this.aboutUs,
        this.termOfConditions,
        this.contactInfo,
        this.companySectors,
        this.notAllowed,
    });

    String? customerType;
    dynamic? aboutUs;
    String? termOfConditions;
    ContactInfo? contactInfo;
    List<CompanySector>? companySectors;
    List<dynamic>? notAllowed;

    factory ApiSettings.fromJson(Map<String, dynamic> json) => ApiSettings(
        customerType: json["customer_type"],
        aboutUs: json["about_us"],
        termOfConditions: json["term_of_conditions"],
        contactInfo: ContactInfo.fromJson(json["contact_info"]),
        companySectors: List<CompanySector>.from(json["company_sectors"].map((x) => CompanySector.fromJson(x))),
        notAllowed: List<dynamic>.from(json["not_allowed"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "customer_type": customerType,
        "about_us": aboutUs,
        "term_of_conditions": termOfConditions,
        "contact_info": contactInfo!.toJson(),
        "company_sectors": List<dynamic>.from(companySectors!.map((x) => x.toJson())),
        "not_allowed": List<dynamic>.from(notAllowed!.map((x) => x)),
    };
}

class CompanySector {
    CompanySector({
        this.name,
        this.sectorName,
    });

    String? name;
    String? sectorName;

    factory CompanySector.fromJson(Map<String, dynamic> json) => CompanySector(
        name: json["name"],
        sectorName: json["sector_name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "sector_name": sectorName,
    };
}

class ContactInfo {
    ContactInfo({
        this.email,
        this.mobile,
        this.facbook,
        this.instagram,
    });

    dynamic email;
    dynamic mobile;
    dynamic facbook;
    dynamic instagram;

    factory ContactInfo.fromJson(Map<String, dynamic> json) => ContactInfo(
        email: json["email"],
        mobile: json["mobile"],
        facbook: json["facbook"],
        instagram: json["instagram"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "mobile": mobile,
        "facbook": facbook,
        "instagram": instagram,
    };
}
