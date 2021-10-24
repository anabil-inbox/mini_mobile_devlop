class Country {
    Country({
        this.name,
        this.flag,
        this.prefix,
    });

    String? name;
    String? flag;
    String? prefix;

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json["name"],
        flag: json["flag"],
        prefix: json["prefix"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "flag": flag,
        "prefix": prefix,
    };
}

