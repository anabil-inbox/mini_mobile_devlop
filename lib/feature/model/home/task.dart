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
    List<dynamic>? areaZones;
    List<dynamic>? vas;

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        task: json["task"],
        taskName: json["task_name"],
        price: json["price"],
        areaZones: List<dynamic>.from(json["area_zones"].map((x) => x)),
        vas: List<dynamic>.from(json["VAS"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "task": task,
        "task_name": taskName,
        "price": price,
        "area_zones": List<dynamic>.from(areaZones!.map((x) => x)),
        "VAS": List<dynamic>.from(vas!.map((x) => x)),
    };
}
