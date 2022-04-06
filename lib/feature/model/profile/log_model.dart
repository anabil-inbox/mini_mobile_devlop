
class Log {
    Log({
        this.id,
        this.message,
        this.date,
    });

    String? id;
    String? message;
    DateTime? date;

    factory Log.fromJson(Map<String, dynamic> json) => Log(
        id: json["id"],
        message: json["message"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "date": date?.toIso8601String(),
    };
}