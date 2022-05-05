class Seal {
  Seal({this.seal});

  String? seal;

  Map<String, dynamic> toJson() => {};

  factory Seal.fromJson(Map<String, dynamic> json) => Seal(
        seal: json["seal"] == null ? null : json["seal"],
      );
}
