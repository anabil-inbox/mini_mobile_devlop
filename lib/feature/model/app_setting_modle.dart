import 'package:inbox_clients/feature/model/language.dart';
import 'package:inbox_clients/feature/model/storage/payment.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:logger/logger.dart';

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
      this.areaZones,
      this.deliveryFactor,
      this.socialContact,
      this.userGuide,
      this.minDays,
      this.domain,
      this.currency,
        this.cancelMsg,
      this.pointSpentBoundary,
      this.startsAfter});

  String? customerType;
  String? aboutUs;
  String? currency;
  String? termOfConditions;
  String? cancelMsg;//cancel_msg
  int? minDays;
  dynamic startsAfter;
  ContactInfo? contactInfo;
  List<CompanySector>? companySectors;
  List<NotAllowed>? notAllowed;
  List<Language>? languges;
  WorkingHours? workingHours;
  List<PaymentMethod>? paymentMethod;
  List<AreaZone>? areaZones;
  num? deliveryFactor;
  num? pointSpentBoundary;
  String? domain;
  List<SocialContact>? socialContact;
  List<UserGuide>? userGuide;

  factory ApiSettings.fromJson(Map<String, dynamic> json) {
    // Logger().w("point_spent_boundary: ${json["point_spent_boundary"]}");
    return ApiSettings(
      customerType: json["customer_type"] ?? "both",
      cancelMsg: json["cancel_msg"] == null ? "":json["cancel_msg"],
      currency: json["currency"]  == null ? isArabicLang()?"ريال": "QR" :json["currency"],
      aboutUs: json["about_us"] == null ? "" : json["about_us"],
      domain: json["domain"] == null
          ? ""
          : json["domain"].toString().contains("http")
              ? json["domain"]
              : "http://" + json["domain"],
      termOfConditions: json["term_of_conditions"] ?? "",
      minDays: json["min_days"] == null ? 1 : json["min_days"],
      startsAfter: json["starts_after"] == null ? 1 : json["starts_after"],
      socialContact: json["social_contact"] == null
          ? null
          : List<SocialContact>.from(
              json["social_contact"].map((x) => SocialContact.fromJson(x))),
      userGuide: json["user_guide"] == null
          ? null
          : List<UserGuide>.from(
              json["user_guide"].map((x) => UserGuide.fromJson(x))),
      contactInfo: json["contact_info"] == null
          ? null
          : ContactInfo.fromJson(json["contact_info"]),
      companySectors: (json["company_sectors"] == [] ||
              json["company_sectors"] == null)
          ? []
          : List<CompanySector>.from(
              json["company_sectors"].map((x) => CompanySector.fromJson(x))),
      notAllowed: json["not_allowed"] == null || json["not_allowed"] == []
          ? []
          : List<NotAllowed>.from(
              json["not_allowed"].map((x) => NotAllowed.fromJson(x))),
      languges: (json["languages"] == [] || json["languages"] == null)
          ? []
          : List<Language>.from(
              json["languages"].map((x) => Language.fromJson(x))),
      workingHours: json["working_hours"] == null
          ? null
          : WorkingHours.fromJson(json["working_hours"]),
      paymentMethod:
          (json["payment_method"] == [] || json["payment_method"] == null)
              ? []
              : List<PaymentMethod>.from(
                  json["payment_method"].map((x) => PaymentMethod.fromJson(x))),
      areaZones: json["area_zones"] == null
          ? null
          : List<AreaZone>.from(
              json["area_zones"].map((x) => AreaZone.fromJson(x))),
      deliveryFactor: json["delivery_factor"] ?? 1,
      pointSpentBoundary: json["point_spent_boundary"] == null
          ? 0
          : json["point_spent_boundary"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "customer_type": customerType,
        "point_spent_boundary": pointSpentBoundary,
        "domain": domain,
        "cancel_msg": cancelMsg,
        "currency": currency,
        "min_days": minDays == null ? null : minDays,
        "starts_after": startsAfter == null ? null : startsAfter,
        "social_contact": socialContact == null
            ? null
            : List<dynamic>.from(socialContact!.map((x) => x.toJson())),
        "user_guide": userGuide == null
            ? null
            : List<dynamic>.from(userGuide!.map((x) => x.toJson())),
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
        "area_zones": areaZones == null
            ? null
            : List<dynamic>.from(areaZones!.map((x) => x.toJson())),
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
  Day({this.from, this.to, this.day, this.delivery, this.check = false});

  String? from;
  String? to;
  String? day;
  String? delivery;
  bool? check;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
      from: json["from"] == null ? null : json["from"],
      to: json["to"] == null ? null : json["to"],
      check: json["check"] == null ? null : json["check"],
      delivery: json["delivery"] == null ? null : json["delivery"]);

  Map<String, dynamic> toJson() => {
        "from": from == null ? null : from,
        "to": to == null ? null : to,
        "check": check,
        "delivery": delivery == null ? null : delivery,
      };
}

class AreaZone {
  AreaZone({this.id, this.areaZone, this.price, this.numbers});

  String? id;
  String? areaZone;
  num? price;
  List<dynamic>? numbers;

  factory AreaZone.fromJson(Map<String, dynamic> json) => AreaZone(
        id: json["id"] == null ? null : json["id"],
        price: json["price"] == null ? 0 : json["price"],
        areaZone: json["area_zone"] == null ? null : json["area_zone"],
        numbers: json["numbers"] == null
            ? null
            : List<dynamic>.from(json["numbers"].map((x) => x.toString())),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "area_zone": areaZone == null ? null : areaZone,
        "price": price == null ? null : price,
        "numbers": numbers == null
            ? null
            : List<dynamic>.from(numbers!.map((x) => x.toString())),
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

class SocialContact {
  SocialContact({
    this.type,
    this.url,
    this.image,
  });

  String? type;
  String? url;
  String? image;

  factory SocialContact.fromJson(Map<String, dynamic> json) => SocialContact(
        type: json["type"] == null ? null : json["type"],
        url: json["url"] == null ? null : json["url"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "url": url == null ? null : url,
        "image": image == null ? null : image,
      };
}

class UserGuide {
  UserGuide({
    this.title,
    this.text,
    this.video,
  });

  String? title;
  String? text;
  String? video;

  factory UserGuide.fromJson(Map<String, dynamic> json) => UserGuide(
        title: json["title"] == null ? null : json["title"],
        text: json["text"] == null ? null : json["text"],
        video: json["video"] == null ? null : json["video"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "text": text == null ? null : text,
        "video": video == null ? null : video,
      };
}
