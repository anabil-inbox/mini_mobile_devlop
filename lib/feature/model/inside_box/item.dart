class Item {
  Item({
    this.itemName,
    this.itemQty,
    this.itemDesc,
    this.gallery,
    this.tags,
    this.name,
    this.id
  });
  String? id;
  String? itemName;
  String? itemQty;
  String? itemDesc;
  List<dynamic>? gallery;
  List<Tag>? tags;
  String? name;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemName: json["item_name"],
        itemQty: json["item_qty"],
        itemDesc: json["item_desc"],
        id: json["id"],
        gallery: List<dynamic>.from(json["gallery"].map((x) => x)),
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "item_name": itemName,
        "item_qty": itemQty,
        "item_desc": itemDesc,
        "id" : id,
        "gallery":
            gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x)),
        "tags": tags == null
            ? []
            : List<dynamic>.from(tags!.map((x) => x.toJson())),
      };
}

class Tag {
  Tag({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.parent,
    this.parentfield,
    this.parenttype,
    this.idx,
    this.docstatus,
    this.tag,
    this.isEnabled,
    this.doctype,
    this.unsaved,
  });

  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  String? parent;
  String? parentfield;
  String? parenttype;
  int? idx;
  int? docstatus;
  String? tag;
  int? isEnabled;
  String? doctype;
  int? unsaved;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json["name"],
        owner: json["owner"],
        creation: DateTime.parse(json["creation"]),
        modified: DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        parent: json["parent"],
        parentfield: json["parentfield"],
        parenttype: json["parenttype"],
        idx: json["idx"],
        docstatus: json["docstatus"],
        tag: json["tag"],
        isEnabled: json["is_enabled"],
        doctype: json["doctype"],
        unsaved: json["__unsaved"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "parent": parent,
        "parentfield": parentfield,
        "parenttype": parenttype,
        "idx": idx,
        "docstatus": docstatus,
        "tag": tag,
        "is_enabled": isEnabled,
        "doctype": doctype,
        "__unsaved": unsaved,
      };
}



class SendedTag {
  SendedTag({
    this.tag,
    this.isEnable
  });

  String? tag;
  int? isEnable;
  factory SendedTag.fromJson(Map<String, dynamic> json) => SendedTag(
        tag: json["tag"],
        isEnable : json["is_enabled"]
      );

  Map<String, dynamic> toJson() => {
        "tag": tag,
        "is_enabled":isEnable
      };
}
