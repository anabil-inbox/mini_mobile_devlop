class BoxModel {
  BoxModel(
      {this.boxId, this.boxName, this.boxOperations, required this.serial});

  String? boxId;
  String? boxName;
  List<BoxOperation>? boxOperations;
  String? serial;
  factory BoxModel.fromJson(Map<String, dynamic> json) => BoxModel(
        boxId: json["serial"],
        serial: json["serial"],
        boxName: json["box_name"],
        boxOperations: json["box_operations"] == null
            ? []
            : List<BoxOperation>.from(
                json["box_operations"].map((x) => BoxOperation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "box_id": boxId,
        "box_name": boxName,
        "serial": serial,
        "box_operations":
            List<dynamic>.from(boxOperations!.map((x) => x.toJson())),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoxModel &&
          runtimeType == other.runtimeType &&
          boxId == other.boxId;

  @override
  int get hashCode => boxId.hashCode;
}

class BoxOperation {
  BoxOperation({
    this.operation,
    this.enabled,
  });

  String? operation;
  int? enabled;

  factory BoxOperation.fromJson(Map<String, dynamic> json) => BoxOperation(
        operation: json["operation"],
        enabled: json["enabled"],
      );

  Map<String, dynamic> toJson() => {
        "operation": operation,
        "enabled": enabled,
      };
}
