import '../address_modle.dart';

class Store {
    Store({
        this.id,
        this.addresses,
    });

    String? id;
    List<Address>? addresses;

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"] == null ? null : json["id"],
        addresses: json["addresses"] == null  ?  null : List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "addresses": List<dynamic>.from(addresses!.map((x) => x.toJson())),
    };
}