import 'package:inbox_clients/feature/model/language.dart';
import 'package:inbox_clients/feature/model/storage/payment.dart';

class ApiSettings {
  ApiSettings(
      {this.customerType,
      this.aboutUs,
      this.termOfConditions,
      this.contactInfo,
      this.companySectors,
      this.notAllowed,
      this.languges,
      this.workingHours,
      this.paymentMethod,
      this.areaZones});

  String? customerType;
  String? aboutUs;
  String? termOfConditions;
  ContactInfo? contactInfo;
  List<CompanySector>? companySectors;
  List<NotAllowed>? notAllowed;
  List<Language>? languges;
  WorkingHours? workingHours;
  List<PaymentMethod>? paymentMethod;
  List<AreaZone>? areaZones;

  factory ApiSettings.fromJson(Map<String, dynamic> json) => ApiSettings(
        customerType: json["customer_type"] ?? "both",
        aboutUs: json["about_us"] == null ? "" : json["about_us"],
        termOfConditions: json["term_of_conditions"],
        contactInfo: json["contact_info"] == null
            ? null
            : ContactInfo.fromJson(json["contact_info"]),
        companySectors: json["ccompany_sectors"] == []
            ? []
            : List<CompanySector>.from(json["company_sectors"].map((x) => CompanySector.fromJson(x))),
       
        notAllowed: json["not_allowed"] == null || json["not_allowed"] == []
            ? []
            : List<NotAllowed>.from(json["not_allowed"].map((x) => NotAllowed.fromJson(x))) ,
       
       
        languges: List<Language>.from(
            json["languages"].map((x) => Language.fromJson(x))),
        workingHours: WorkingHours.fromJson(json["working_hours"]),
        paymentMethod: List<PaymentMethod>.from(
            json["payment_method"].map((x) => PaymentMethod.fromJson(x))),
        areaZones: json["area_zones"] == null
            ? null
            : List<AreaZone>.from(
                json["area_zones"].map((x) => AreaZone.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "customer_type": customerType,
        "about_us": aboutUs,
        "term_of_conditions": termOfConditions,
        "contact_info": contactInfo!.toJson(),
        "company_sectors":
            List<dynamic>.from(companySectors!.map((x) => x.toJson())),
        "not_allowed": List<NotAllowed>.from(notAllowed!.map((x) => x)),
        "languages": List<dynamic>.from(languges!.map((x) => x.toJson())),
        "payment_method":
            List<dynamic>.from(paymentMethod!.map((x) => x.toJson())),
        "working_hours": workingHours?.toJson(),
        "area_zones": List<dynamic>.from(areaZones!.map((x) => x.toJson())),
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
        wednesday:
            List<Day>.from(json["wednesday"].map((x) => Day.fromJson(x))),
        thuersday:
            List<Day>.from(json["thuersday"].map((x) => Day.fromJson(x))),
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
  Day({this.from, this.to, this.day});

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

class AreaZone {
  AreaZone({
    this.id,
    this.areaZone,
  });

  String? id;
  String? areaZone;

  factory AreaZone.fromJson(Map<String, dynamic> json) => AreaZone(
        id: json["id"] == null ? null : json["id"],
        areaZone: json["area_zone"] == null ? null : json["area_zone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "area_zone": areaZone,
      };
}

class NotAllowed {
  NotAllowed({
    this.name,
    this.title,
    this.image,
  });

  String? name;
  String? title;
  String? image;

  factory NotAllowed.fromJson(Map<String, dynamic> json) => NotAllowed(
        name: json["name"] ?? "",
        title: json["title"] ?? "",
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "image": image == null ? null : image,
      };
}
