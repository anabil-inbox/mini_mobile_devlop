import 'package:inbox_clients/feature/model/language.dart';

class ApiSettings {
    ApiSettings({
        this.customerType,
        this.aboutUs,
        this.termOfConditions,
        this.contactInfo,
        this.companySectors,
        this.notAllowed,
        this.languges,
        this.workingHours
    });

    String? customerType;
    String? aboutUs;
    String? termOfConditions;
    ContactInfo? contactInfo;
    List<CompanySector>? companySectors;
    List<dynamic>? notAllowed;
    List<Language>? languges;
    WorkingHours? workingHours;
    factory ApiSettings.fromJson(Map<String, dynamic> json) => ApiSettings(
        customerType: json["customer_type"],
        aboutUs: json["about_us"] == null ? "" : json["about_us"],
        termOfConditions: json["term_of_conditions"],
        contactInfo: ContactInfo.fromJson(json["contact_info"]),
        companySectors: List<CompanySector>.from(json["company_sectors"].map((x) => CompanySector.fromJson(x))),
        notAllowed: List<dynamic>.from(json["not_allowed"].map((x) => x)),
        languges: List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
        workingHours: WorkingHours.fromJson(json["working_hours"]),
    );

    Map<String, dynamic> toJson() => {
        "customer_type": customerType,
        "about_us": aboutUs,
        "term_of_conditions": termOfConditions,
        "contact_info": contactInfo!.toJson(),
        "company_sectors": List<dynamic>.from(companySectors!.map((x) => x.toJson())),
        "not_allowed": List<dynamic>.from(notAllowed!.map((x) => x)),
        "languages" : List<dynamic>.from(languges!.map((x) => x.toJson())),
        "working_hours" : workingHours?.toJson()
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


class WorkingHours {
    WorkingHours({
        this.sunday,
        this.monday,
        this.tuesday,
        this.wednesday,
        this.thuersday,
        this.friday,
        this.saturday,
    });

    List<Day>? sunday;
    List<Day>? monday;
    List<Day>? tuesday;
    List<Day>? wednesday;
    List<Day>? thuersday;
    List<Day>? friday;
    List<Day>? saturday;

    factory WorkingHours.fromJson(Map<String, dynamic> json) => WorkingHours(
        sunday: List<Day>.from(json["sunday"].map((x) => Day.fromJson(x))),
        monday: List<Day>.from(json["monday"].map((x) => Day.fromJson(x))),
        tuesday: List<Day>.from(json["tuesday"].map((x) => Day.fromJson(x))),
        wednesday: List<Day>.from(json["wednesday"].map((x) => Day.fromJson(x))),
        thuersday: List<Day>.from(json["thuersday"].map((x) => Day.fromJson(x))),
        friday: List<Day>.from(json["friday"].map((x) => Day.fromJson(x))),
        saturday: List<Day>.from(json["saturday"].map((x) => Day.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sunday": List<dynamic>.from(sunday!.map((x) => x.toJson())),
        "monday": List<dynamic>.from(monday!.map((x) => x.toJson())),
        "tuesday": List<dynamic>.from(tuesday!.map((x) => x.toJson())),
        "wednesday": List<dynamic>.from(wednesday!.map((x) => x.toJson())),
        "thuersday": List<dynamic>.from(thuersday!.map((x) => x.toJson())),
        "friday": List<dynamic>.from(friday!.map((x) => x.toJson())),
        "saturday": List<dynamic>.from(saturday!.map((x) => x.toJson())),
    };
}

class Day {
    Day({
        this.from,
        this.to,
        this.day
    });

    String? from;
    String? to;
    String? day;

    factory Day.fromJson(Map<String, dynamic> json) => Day(
        from: json["from"],
        to: json["to"],
    );

     Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
    };
}