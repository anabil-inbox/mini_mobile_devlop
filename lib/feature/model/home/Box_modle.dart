import 'package:inbox_clients/feature/model/address_modle.dart';

class Box {
    Box({
        this.id,
        this.serialNo,
        this.storageName,
        this.saleOrder,
        this.storageStatus,
        this.enabled,
        this.modified,
        this.tags,
        this.items,
        this.options,
        this.address
    });

    String? id;
    String? serialNo;
    String? storageName;
    String? saleOrder;
    String? storageStatus;
    int? enabled;
    DateTime? modified;
    List<ItemTag>? tags;
    List<BoxItem>? items;
    bool? isExpanded = false;
    List<String>? options;
    Address? address;

    factory Box.fromJson(Map<String, dynamic> json) => Box(
        id: json["id"],
        serialNo: json["serial_no"],
        storageName: json["storage_name"],
        saleOrder: json["sale_order"],
        storageStatus: json["storage_status"],
        enabled: json["enabled"],
        modified: DateTime.parse(json["modified"]),
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        options: json["options"] == null ? null : List<String>.from(json["options"].map((x) => x)),
        tags: json["tags"] == null ?  null : List<ItemTag>.from(json["tags"].map((x) => ItemTag.fromJson(x))),
        items: json["items"] == null ?  null : List<BoxItem>.from(json["items"].map((x) => BoxItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "serial_no": serialNo,
        "storage_name": storageName,
        "sale_order": saleOrder,
        "storage_status": storageStatus,
        "enabled": enabled,
        "modified": modified?.toIso8601String(),
        "tags": List<dynamic>.from(tags!.map((x) => x)),
        "options":List<String>.from(options!.map((e) => e)),
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class BoxItem {
    BoxItem({
        this.itemName,
        this.itemQuantity,
        this.itemGallery,
        this.itemTags,
    });

    String? itemName;
    String? itemQuantity;
    List<dynamic>? itemGallery;
    List<ItemTag>? itemTags;

    factory BoxItem.fromJson(Map<String, dynamic> json) => BoxItem(
        itemName: json["item_name"],
        itemQuantity: json["item_quantity"],
        itemGallery: json["item_gallery"] == null ?  null : List<dynamic>.from(json["item_gallery"].map((x) => x)),
        itemTags: json["item_tags"] == null ?  null : List<ItemTag>.from(json["item_tags"].map((x) => ItemTag.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "item_name": itemName,
        "item_quantity": itemQuantity,
        "item_gallery":  List<dynamic>.from(itemGallery!.map((x) => x)),
        "item_tags": List<dynamic>.from(itemTags!.map((x) => x.toJson())),
    };
}

class ItemTag {
    ItemTag({
        this.tag,
        this.enabled,
    });

    String? tag;
    int? enabled;

    factory ItemTag.fromJson(Map<String, dynamic> json) => ItemTag(
        tag: json["tag"] == null ? null : json["tag"],
        enabled: json["enabled"],
    );

    Map<String, dynamic> toJson() => {
        "tag": tag == null ? null : tag,
        "enabled": enabled,
    };
}
