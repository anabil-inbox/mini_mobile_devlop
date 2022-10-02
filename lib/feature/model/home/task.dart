import 'package:inbox_clients/feature/model/app_setting_modle.dart';

class Task {
  Task(
      {this.id,
      this.task,
      this.taskName,
      this.price,
      this.areaZones,
      this.vas,
      this.selectedVas});

  String? id;
  String? task;
  String? taskName;
  num? price;
  List<AreaZone>? areaZones;
  List<VAS>? vas;
  List<VAS>? selectedVas;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id:json["id"] == null ? null:  json["id"],
        task:json["task"] == null ? null:  json["task"],
        taskName : json["task_name"] == null ? null:  json["task_name"],
        price:json["price"] == null ? null:  json["price"],
        selectedVas:  json["selected_VAS"] == null ? null : List<VAS>.from(json["selected_VAS"].map((x) => VAS.fromJson(x))),
        areaZones:json["area_zones"] == null ? null:  List<AreaZone>.from(
            json["area_zones"].map((x) => AreaZone.fromJson(x))),
        vas:json["VAS"] == null ? null:  List<VAS>.from(json["VAS"].map((x) => VAS.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id":id == null ? null: id,
        "task":task == null ? null: task,
        "task_name":taskName == null ? null: taskName,
        "price":price == null ? null: price,
        "area_zones":areaZones == null ? null: List<AreaZone>.from(areaZones!.map((x) => x)),
        "VAS":vas == null ? null: List<VAS>.from(vas!.map((x) => x)),
        "selected_VAS":selectedVas == null ? null: List<VAS>.from(selectedVas!.map((x) => x)),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Task copyWith({
    String? id,
    String? task,
    String? taskName,
    num? price,
    List<AreaZone>? areaZones,
    List<VAS>? vas,
    List<VAS>? selectedVas,
  }) {
    return Task(
      id: id ?? this.id,
      task: task ?? this.task,
      taskName: taskName ?? this.taskName,
      price: price ?? this.price,
      areaZones: areaZones ?? this.areaZones,
      vas: vas ?? this.vas,
      selectedVas: selectedVas ?? this.selectedVas,
    );
  }
}

class VAS {
  VAS({
    this.id,
    this.name,
    this.price,
  });

  String? id;
  String? name;
  num? price;

  factory VAS.fromJson(Map<String, dynamic> json) => VAS(
        id: json["id"] == null ?null :json["id"],
        name: json["name"] == null ?null :json["name"],
        price: json["price"] == null ? null:json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
