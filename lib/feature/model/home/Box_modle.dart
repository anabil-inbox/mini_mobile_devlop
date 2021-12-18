class Box {
  Box(
      {this.id,
      this.serialNo,
      this.storageName,
      this.saleOrder,
      this.storageStatus,
      this.enabled,
      this.modified,
      this.isExpanded
      });

  String? id;
  String? serialNo;
  String? storageName;
  String? saleOrder;
  String? storageStatus;
  int? enabled;
  String? modified;
  bool? isExpanded = false;

  factory Box.fromJson(Map<String, dynamic> json) => Box(
      id: json["id"],
      serialNo: json["serial_no"] ?? null,
      storageName: json["storage_name"] ?? null,
      saleOrder: json["sale_order"] ?? null,
      storageStatus: json["storage_status"] ?? null,
      enabled: json["enabled"] ?? null,
      modified: json["modified"] ?? null,
      isExpanded: false
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "serial_no": serialNo,
        "storage_name": storageName,
        "sale_order": saleOrder,
        "storage_status": storageStatus,
        "enabled": enabled,
        "modified": modified,
        "isExpanded" : isExpanded
      };
}
