import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:logger/logger.dart';

import '../inside_box/invoices.dart';
import '../inside_box/seal.dart';

class Box {
  Box(
      {this.id,
      this.serialNo,
      this.storageName,
      this.saleOrder,
      this.storageStatus,
      this.enabled,
      this.modified,
      this.tags,
      this.items,
      this.allowed = false,
      this.firstPickup = false,
      this.logSeals,
      this.options,
      this.isPickup,
      this.invoices,
      this.address});

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
  bool? firstPickup = false;
  List<String>? options;
  Address? address;
  bool? allowed;
  bool? isPickup;
  List<Seal>? logSeals;
  List<Invoices>? invoices;


  factory Box.fromJson(Map<String, dynamic> json) => Box(
        id: json["id"] == null ? null : json["id"],
        serialNo: json["serial"] == null ? null : json["serial"],
        storageName: json["storage_name"] == null ? null : json["storage_name"],
        saleOrder: json["sales_order"] == null ? null : json["sales_order"],
        allowed: json["allowed"] == null ? false : json["allowed"],
    firstPickup: json["first_pickup"] == null ? false : json["first_pickup"],
        isPickup: json["is_pickup"] == null ? false:json["is_pickup"],
        storageStatus:
            json["storage_status"] == null ? null : json["storage_status"],
        enabled: json["enabled"] == null ? null : json["enabled"],
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        logSeals: json["seals_log"] == null
            ? null
            : List<Seal>.from(json["seals_log"].map((x) => Seal.fromJson(x))),
        options: json["options"] == null
            ? null
            : List<String>.from(json["options"].map((x) => x)),
        tags: json["tags"] == null
            ? null
            : List<ItemTag>.from(json["tags"].map((x) => ItemTag.fromJson(x))),

        invoices: json["invoices"] == null
            ? null
            : List<Invoices>.from(json["invoices"].map((x) => Invoices.fromJson(x))),    
        items: json["items"] == null
            ? null
            : List<BoxItem>.from(json["items"].map((x) => BoxItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() {
    try {
      return {
        "id": id,
        "serial": serialNo,
        "first_pickup": firstPickup,
        "storage_name": storageName,
        "sale_order": saleOrder,
        "storage_status": storageStatus,
        "enabled": enabled,
        "is_pickup": isPickup,
        "modified": modified?.toIso8601String(),
        "tags": (GetUtils.isNull(tags) || tags?.length == 0)
            ? null
            : List<dynamic>.from(tags!.map((x) => x)),
        "options": (GetUtils.isNull(options) || options?.length == 0)
            ? null
            : List<String>.from(options!.map((e) => e)),
        "items": (GetUtils.isNull(items) || items?.length == 0)
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
    } catch (e) {
      Logger().e(e);
      return {};
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Box && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Box{id: $id, serialNo: $serialNo, storageName: $storageName, saleOrder: $saleOrder, storageStatus: $storageStatus, enabled: $enabled, modified: $modified, tags: $tags, items: $items, isExpanded: $isExpanded, options: $options, address: $address}';
  }
}

class BoxItem {
  BoxItem(
      {this.itemName,
      this.itemQuantity,
      this.itemGallery,
      this.itemTags,
      this.createdAt,
      this.maxQty,
      //  this.selectedImages,
      this.id});

  String? itemName;
  String? itemQuantity;
  int? maxQty;
  String? id;
  String? createdAt;
  List<Attachment>? itemGallery;
  List<ItemTag>? itemTags;
  // List<String>? selectedImages = [];

  factory BoxItem.fromJson(Map<String, dynamic> json) {
    return BoxItem(
      itemName: json["item_name"],
      itemQuantity: json["item_quantity"],
      maxQty: int.parse(json["item_quantity"] ?? "1"),
      id: json["id"],
      createdAt: json["created_at"],
      itemGallery: json["item_gallery"] == null
          ? []
          : List<Attachment>.from(
              json["item_gallery"].map((x) => Attachment.fromJson(x))),
      itemTags: json["item_tags"] == null
          ? []
          : List<ItemTag>.from(
              json["item_tags"].map((x) => ItemTag.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "item_name": itemName,
        "item_quantity": itemQuantity,
        "id": id,
        "created_at": createdAt,
        "item_gallery": List<dynamic>.from(itemGallery!.map((x) => x.toJson())),
        "item_tags": List<dynamic>.from(itemTags!.map((x) => x.toJson())),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoxItem && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class Attachment {
  Attachment({this.type, this.attachment, this.enabled});

  String? attachment;
  int? enabled;
  String? type;

  factory Attachment.fromJson(Map<String, dynamic> json) {
    try {
      return Attachment(
          attachment: json["attachment"] == null ? null : json["attachment"],
          enabled: json["enabled"] == null ? null : json["enabled"],
          type: json["type"] == null ? null : json["type"]);
    } catch (e) {
      print(e);
      Logger().d(e);
      return Attachment.fromJson({});
    }
  }

  Map<String, dynamic> toJson() =>
      {"attachment": attachment, "enabled": enabled, "type": type};
}

// class ReciveBoxItem {
//   ReciveBoxItem(
//       {this.itemName,
//       this.itemQuantity,
//       this.itemGallery,
//       this.itemTags,
//       this.id});
//   String? itemName;
//   String? itemQuantity;
//   String? id;
//   List<dynamic>? itemGallery;
//   List<ItemTag>? itemTags;
//   factory ReciveBoxItem.fromJson(Map<String, dynamic> json) => ReciveBoxItem(
//         itemName: json["item_name"],
//         itemQuantity: json["item_quantity"],
//         id: json["id"],
//         itemGallery: json["item_gallery"] == null
//             ? []
//             : List<dynamic>.from(json["item_gallery"].map((x) => x)),
//         itemTags: json["item_tags"] == null
//             ? []
//             : List<ItemTag>.from(
//                 json["item_tags"].map((x) => ItemTag.fromJson(x))),
//       );
//   Map<String, dynamic> toJson() => {
//         "item_name": itemName,
//         "item_quantity": itemQuantity,
//         "id": id,
//         "item_gallery": List<dynamic>.from(itemGallery!.map((x) => x)),
//         "item_tags": List<dynamic>.from(itemTags!.map((x) => x.toJson())),
//       };
// }

class ItemTag {
  ItemTag({
    this.tag,
    this.enabled,
  });

  String? tag;
  int? enabled;

  factory ItemTag.fromJson(Map<String, dynamic> json) => ItemTag(
        tag: json["tag"] == null ? null : json["tag"],
        enabled: json["enabled"] == null ? null : json["enabled"],
      );

  Map<String, dynamic> toJson() => {
        "tag": tag == null ? null : tag,
        "enabled": enabled == null ? 0 : enabled,
      };
}
