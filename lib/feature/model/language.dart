class Language {
    Language({
        this.name,
        this.languageName,
    });

    String? name;
    String? languageName;

    factory Language.fromJson(Map<String, dynamic> json) => Language(
        name: json["name"],
        languageName: json["language_name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "language_name": languageName,
    };
}