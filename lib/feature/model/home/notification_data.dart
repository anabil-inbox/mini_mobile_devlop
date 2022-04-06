class NotificationData {
  NotificationData({
    this.id,
    this.title,
    this.message,
    this.date,
    this.receiveStatus,
  });

  String? id;
  String? title;
  String? message;
  DateTime? date;
  String? receiveStatus;

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    id:json["id"] == null ? null: json["id"],
    title:json["title"] == null ? null: json["title"],
    message:json["message"] == null ? null: json["message"],
    date:json["date"] == null ? null: DateTime.parse(json["date"]),
    receiveStatus:json["receive_status"] == null ? null: json["receive_status"],
  );

  Map<String, dynamic> toJson() => {
    "id":id == null ? null: id,
    "title":title == null ? null: title,
    "message":message == null ? null: message,
    "date":date == null ? null: date!.toIso8601String(),
    "receive_status":receiveStatus == null ? null: receiveStatus,
  };
}
