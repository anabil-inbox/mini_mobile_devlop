import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:logger/logger.dart';

class CartModel {
  int? id;
  Task? task;
  List<Box>? box;
  List<BoxItem>? boxItem;
  Day? orderTime;
  Address? address;
  String? title;

  CartModel({this.id,
      required this.task,
      required this.box,
      required this.boxItem,
      required this.orderTime,
      required this.address,
      required this.title});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    try {
      return CartModel(
              id:json["id"] == null ? null: json["id"],
              address:json["address"] == null ? null:Address.fromJson(json["address"]) ,
              title:json["title"] == null ? null: json["title"],
              orderTime:json["orderTime"] == null ? null:Day.fromJson(json["orderTime"]) ,
              box:json["box"] == null ? null: List<Box>.from(json["box"].map((x) => Box.fromJson(x))),
              boxItem:json["boxItem"] == null ? null:List<BoxItem>.from(json["boxItem"].map((x) => BoxItem.fromJson(x))) ,
              task:json["task"] == null ? null:Task.fromJson(json["task"]) );
    } catch (e) {
      Logger().d(e);
      return CartModel.fromJson({});
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {
          "id": id??"",
          "boxItem":List<dynamic>.from(boxItem!.map((x) => x)) ,
          "orderTime":orderTime?.toJson()??{} ,
          "address": address?.toJson()??{},
          "title": title??"",
          "box": List<dynamic>.from(box!.map((x) => x)) ,
          "task": task?.toJson()??{}
        };
    } catch (e) {
      Logger().d(e);
      return {};
    }
  }

}
