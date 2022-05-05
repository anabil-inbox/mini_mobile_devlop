class CasesData {
  CasesData({
    this.name,
  });

  String? name;

  factory CasesData.fromJson(Map<String, dynamic> json) => CasesData(
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
  };
}