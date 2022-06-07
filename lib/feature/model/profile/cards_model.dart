class CardsData {
  CardsData({
    this.cards,
  });

  List<CardModel>? cards;

  factory CardsData.fromJson(Map<String, dynamic> json) => CardsData(
        cards: json["cards"] == null
            ? null
            : List<CardModel>.from(json["cards"].map((x) => CardModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cards": cards == null
            ? null
            : List<dynamic>.from(cards!.map((x) => x.toJson())),
      };
}

class CardModel {
  CardModel({
    this.id,
    this.created,
    this.object,
    this.address,
    this.customer,
    this.funding,
    this.fingerprint,
    this.brand,
    this.scheme,
    this.name,
    this.expMonth,
    this.expYear,
    this.lastFour,
    this.firstSix,
  });

  String? id;
  int? created;
  String? object;
  AddressCard? address;
  String? customer;
  String? funding;
  String? fingerprint;
  String? brand;
  String? scheme;
  String? name;
  int? expMonth;
  int? expYear;
  String? lastFour;
  String? firstSix;

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        id: json["id"] == null ? null : json["id"],
        created: json["created"] == null ? null : json["created"],
        object: json["object"] == null ? null : json["object"],
        address:
            json["address"] == null ? null : AddressCard.fromJson(json["address"]),
        customer: json["customer"] == null ? null : json["customer"],
        funding: json["funding"] == null ? null : json["funding"],
        fingerprint: json["fingerprint"] == null ? null : json["fingerprint"],
        brand: json["brand"] == null ? null : json["brand"],
        scheme: json["scheme"] == null ? null : json["scheme"],
        name: json["name"] == null ? null : json["name"],
        expMonth: json["exp_month"] == null ? null : json["exp_month"],
        expYear: json["exp_year"] == null ? null : json["exp_year"],
        lastFour: json["last_four"] == null ? null : json["last_four"],
        firstSix: json["first_six"] == null ? null : json["first_six"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "created": created == null ? null : created,
        "object": object == null ? null : object,
        "address": address == null ? null : address!.toJson(),
        "customer": customer == null ? null : customer,
        "funding": funding == null ? null : funding,
        "fingerprint": fingerprint == null ? null : fingerprint,
        "brand": brand == null ? null : brand,
        "scheme": scheme == null ? null : scheme,
        "name": name == null ? null : name,
        "exp_month": expMonth == null ? null : expMonth,
        "exp_year": expYear == null ? null : expYear,
        "last_four": lastFour == null ? null : lastFour,
        "first_six": firstSix == null ? null : firstSix,
      };
}

class AddressCard {
  AddressCard();

  factory AddressCard.fromJson(Map<String, dynamic> json) => AddressCard();

  Map<String, dynamic> toJson() => {};
}
