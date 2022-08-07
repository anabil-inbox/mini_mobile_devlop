import 'package:inbox_clients/feature/model/storage/local_bulk_modle.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';

class StorageCategoriesData {
  StorageCategoriesData(
      {this.name,
      this.storageName,
      this.storageCategoryType,
      this.pricePerDay,
      this.pricePerMonth,
      this.pricePerYear,
      this.priceForUnlimited,
      this.id,
      this.storageFeatures,
      this.items,
      this.storageItem,
      this.image,
      this.video,
      this.description,
      this.selectedDuration,
      this.userPrice,
      this.quantity,
      this.numberOfDays,
      this.x,
      this.y,
      this.selectedItem,
      this.localBulk,
      this.groupId,
      this.defaultImage});

  String? name;
  String? defaultImage;
  String? storageName;
  String? storageCategoryType;
  double? pricePerDay;
  double? pricePerMonth;
  double? pricePerYear;
  double? priceForUnlimited;
  String? id;
  List<StorageFeatures>? storageFeatures;
  List<Item>? items;
  List<StorageItem>? storageItem;
  String? image;
  String? video;
  String? description;
  num? userPrice;
  int? quantity = 1;
  int? groupId;
  StorageItem? selectedItem;
  String? selectedDuration;
  int? numberOfDays = (SharedPref.instance.getAppSettings()?.minDays ??1);
  int? x;
  int? y;
  LocalBulk? localBulk;
  bool? needAdviser = false;

  factory StorageCategoriesData.fromJson(Map<String, dynamic> json) {
    try {
      return StorageCategoriesData(
        name: json["name"] == null ? null : json["name"],
        defaultImage: json["default_image"] == null ? null : json["default_image"],
        storageName: json["storage_name"] == null ? null : json["storage_name"],
        storageCategoryType: json["storage_category_type"] == null
            ? null
            : json["storage_category_type"],
        pricePerDay: json["price_per_day"] == null
            ? null
            : json["price_per_day"].toDouble(),
        pricePerMonth: json["price_per_month"] == null
            ? null
            : json["price_per_month"].toDouble(),
        pricePerYear: json["price_per_year"] == null
            ? null
            : json["price_per_year"].toDouble(),
        priceForUnlimited: json["price_for_unlimited"] == null
            ? null
            : json["price_for_unlimited"].toDouble(),
        id: json["id"] == null ? null : json["id"],
        video: json["video"] == null ? null : json["video"],
        image: json["image"] == null ? null : json["image"],
        groupId: json["group_id"] == null ? null : json["group_id"],
        description: json["description"] == null ? null : json["description"],
        storageFeatures: json["storage_features"] == null
            ? null
            : List<StorageFeatures>.from(json["storage_features"]
                .map((x) => StorageFeatures.fromJson(x))),
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        storageItem: json["storage_item"] == null
            ? null
            : List<StorageItem>.from(
                json["storage_item"].map((x) => StorageItem.fromJson(x))),
      );
    } catch (e) {
      Logger().d(e);
      return StorageCategoriesData.fromJson({});
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {
        "name": name,
        "storage_name": storageName,
        "default_image": defaultImage,
        "storage_category_type": storageCategoryType,
        "price_per_day": pricePerDay,
        "price_per_month": pricePerMonth,
        "price_per_year": pricePerYear,
        "price_for_unlimited": priceForUnlimited,
        "id": id,
        "image": image,
        "video": video,
        "description": description,
        "group_id": groupId,
        "storage_features":
            List<dynamic>.from(storageFeatures!.map((x) => x.toJson())),
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "storage_item": List<dynamic>.from(storageItem!.map((x) => x.toJson())),
      };
    } catch (e) {
      Logger().d(e);
      return {};
    }
  }
}

class Item {
  Item(
      {this.from,
      this.to,
      this.pricePerDay,
      this.pricePerMonth,
      this.pricePerYear,
      this.priceForUnlimited,
      this.description,
      this.storageType,
      this.image,
      this.video,
      this.quantity,
      this.storageName});

  int? from;
  int? to;
  double? pricePerDay;
  double? pricePerMonth;
  double? pricePerYear;
  double? priceForUnlimited;
  String? storageType;
  String? description;
  dynamic video;
  dynamic image;
  int? quantity;
  String? storageName;

  factory Item.fromJson(Map<String, dynamic> json) {
    try {
      return Item(
          from: json["_from"] == null ? null : json["_from"],
          to: json["_to"] == null ? null : json["_to"],
          pricePerDay: json["price_per_day"] == null
              ? null
              : json["price_per_day"].toDouble(),
          pricePerMonth: json["price_per_month"] == null
              ? null
              : json["price_per_month"].toDouble(),
          pricePerYear: json["price_per_year"] == null
              ? null
              : json["price_per_year"].toDouble(),
          priceForUnlimited: json["price_for_unlimited"] == null
              ? null
              : json["price_for_unlimited"].toDouble(),
          storageType:
              json["storage_type"] == null ? null : json["storage_type"],
          description: json["description"] == null ? null : json["description"],
          video: json["video"] == null ? null : json["video"],
          image: json["image"] == null ? null : json["image"],
          storageName:
              json["storage_name"] == null ? null : json["storage_name"]);
    } catch (e) {
      Logger().d(e);
      return Item.fromJson({});
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {
        "_from": from,
        "_to": to,
        "price_per_day": pricePerDay,
        "price_per_month": pricePerMonth,
        "price_per_year": pricePerYear,
        "price_for_unlimited": priceForUnlimited,
        "storage_type": storageType,
        "description": description,
        "video": video,
        "image": image,
        "quantity": quantity,
        "storage_name": storageName
      };
    } catch (e) {
      Logger().d(e);
      return {};
    }
  }
}

class StorageFeatures {
  StorageFeatures({this.storageFeature, this.addedPrice, this.id});

  String? storageFeature;
  double? addedPrice;
  String? id;

  factory StorageFeatures.fromJson(Map<String, dynamic> json) {
    try {
      return StorageFeatures(
        id: json["id"] == null ? null : json["id"],
        storageFeature:
            json["storage_feature"] == null ? null : json["storage_feature"],
        addedPrice:
            json["added_price"] == null ? null : json["added_price"].toDouble(),
      );
    } catch (e) {
      Logger().d(e);
      return StorageFeatures.fromJson({});
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {
        "storage_feature": storageFeature,
        "added_price": addedPrice,
        "id": id
      };
    } catch (e) {
      Logger().d(e);
      return {};
    }
  }
}

class StorageItem {
  StorageItem(
      {this.options,
      this.name,
      this.price,
      this.item,
      this.from,
      this.to,
      this.x,
      this.y,
      this.monthlyPrice,
      this.quantity,
      this.yearlyPrice});

  List<String>? options;
  String? name;
  String? price;
  String? item;
  String? from;
  String? to;
  String? x;
  String? y;
  String? monthlyPrice;
  String? yearlyPrice;
  int? quantity;

  factory StorageItem.fromJson(Map<String, dynamic> json) {
    try {
      return StorageItem(
          options: json["options"] == null
              ? null
              : List<String>.from(json["options"].map((x) => x)),
          name: json["name"] == null ? null : json["name"],
          price: json["price"] == null ? null : json["price"],
          item: json["item"] == null ? null : json["item"],
          from: json["from"] == null ? null : json["from"],
          to: json["to"] == null ? null : json["to"],
          monthlyPrice:
              json["monthly_price"] == null ? null : json["monthly_price"],
          yearlyPrice:
              json["yearly_price"] == null ? null : json["yearly_price"]);
    } catch (e) {
      Logger().d(e);
      return StorageItem.fromJson({});
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {
        "options": List<dynamic>.from(options!.map((x) => x)),
        "name": name,
        "price": price,
        "item": item == null ? null : item,
        "from": from == null ? null : from,
        "to": to == null ? null : to,
        "monthly_price": monthlyPrice == null ? null : monthlyPrice,
        "yearly_price": yearlyPrice == null ? null : yearlyPrice,
        "qty" : quantity
      };
    } catch (e) {
      Logger().d(e);
      return {};
    }
  }
}
