import 'package:inbox_clients/feature/model/app_setting_modle.dart';

class Task {
    Task({
        this.id,
        this.task,
        this.taskName,
        this.price,
        this.areaZones,
        this.vas,
    });

    String? id;
    String? task;
    String? taskName;
    num? price;
    List<AreaZone>? areaZones;
    List<VAS>? vas;

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        task: json["task"],
        taskName: json["task_name"],
        price: json["price"],
        areaZones: List<AreaZone>.from(json["area_zones"].map((x) => AreaZone.fromJson(x))),
        vas: List<VAS>.from(json["VAS"].map((x) => VAS.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "task": task,
        "task_name": taskName,
        "price": price,
        "area_zones": List<AreaZone>.from(areaZones!.map((x) => x)),
        "VAS": List<VAS>.from(vas!.map((x) => x)),
    };

    @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
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
        id: json["id"],
        name: json["name"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
    };

    @override
    bool operator ==(Object other) =>
        identical(this, other) ||
            other is Task && runtimeType == other.runtimeType && id == other.id;

    @override
    int get hashCode => id.hashCode;
}
