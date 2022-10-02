import 'dart:convert';

import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';

class CartModel {
  //String? id;
  int? id;
  String? userId;
  Task? task;
  List<Box>? box;
  List<BoxItem>? boxItem;
  Day? orderTime;
  Address? address;
  String? title;
  bool? isFirstPickUp;

  CartModel(
      {this.id,
      this.userId,
      this.isFirstPickUp = false,
      required this.task,
      required this.box,
      required this.boxItem,
      required this.orderTime,
      required this.address,
      required this.title});

  factory CartModel.fromJson(Map<String, dynamic> jsons) {
    try {
      var data = json.decode(jsons["box"]).map((x) => Box.fromJson(x));
      print(data);
      return CartModel(
          id: jsons["id"] == null ? null : jsons["id"],
          userId: jsons["userId"] == null ? null : jsons["userId"],
          isFirstPickUp: jsons["isFirstPickUp"] == null ? false : jsons["isFirstPickUp"] == "true" ? true:false,
          address: jsons["address"] == null
              ? null
              : Address.fromJson(json.decode(jsons["address"])),
          title: jsons["title"] == null ? null : jsons["title"],
          orderTime: jsons["orderTime"] == null
              ? null
              : Day.fromJson(json.decode(jsons["orderTime"])),
          box: List<Box>.from(
              json.decode(jsons["box"]).map((x) => Box.fromJson(x))),
          // box:jsons["box"] == null ? null: List<Box>.from(json.decode(jsons["box"].map((x) => Box.fromJson(x)))),
          //   box: List<Box>.from(jsons["box"].map((x) => Box.fromJson(x))),
          boxItem: List<BoxItem>.from(
              json.decode(jsons["boxItem"]).map((x) => BoxItem.fromJson(x))),
          // boxItem:jsons["boxItem"] == null ? null:List<BoxItem>.from(json.decode(jsons["boxItem"].map((x) => BoxItem.fromJson(x)))) ,
          task: jsons["task"] == null
              ? null
              : Task.fromJson(json.decode(jsons["task"])));
    } catch (e) {
      Logger().d(e);
      return CartModel.fromJson({});
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id ?? "",
      "userId": "${SharedPref.instance.getCurrentUserData().id.toString()}",
      "boxItem": json.encode(
          boxItem == null ? null : List<dynamic>.from(boxItem!.map((x) => x))),
      "orderTime": json.encode(orderTime?.toJson() ?? {}),
      "address": json.encode(address?.toJson() ?? {}),
      "isFirstPickUp": "$isFirstPickUp" ,
      "title": title ?? "",
      "box": json
          .encode(box == null ? null : List<dynamic>.from(box!.map((x) => x))),
      "task": json.encode(task?.toJson() ?? {})
    };
    // try {
    //
    // } catch (e) {
    //   Logger().d(e);
    //   return {};
    // }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartModel &&
          runtimeType == other.runtimeType &&
          task == other.task &&
          title == other.title &&
          box?.first.serialNo == other.box?.first.serialNo
          /* &&
          orderTime == other.orderTime &&
          address == other.address &&*/
          /*title == other.title*/;

  @override
  int get hashCode =>
      task.hashCode ^
      box.hashCode ^
      boxItem.hashCode ^
      orderTime.hashCode ^
      address.hashCode ^
      title.hashCode;
}
