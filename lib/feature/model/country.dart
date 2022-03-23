import 'package:logger/logger.dart';

class Country {
    Country({
        this.name,
        this.flag,
        this.prefix,
    });

    String? name;
    String? flag;
    String? prefix;

    factory Country.fromJson(Map<String, dynamic> json) {
      try{
      return Country(
        name: json["name"] ?? "",
        flag: json["flag"] ?? "",
        prefix: json["prefix"] ?? "",
    );
      } catch(e){
      Logger().d(e);
      return Country.fromJson({});
      }
      
    }

    Map<String, dynamic> toJson() => {
        "name": name ?? "",
        "flag": flag ?? "",
        "prefix": prefix ?? "",
    };

    @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}

