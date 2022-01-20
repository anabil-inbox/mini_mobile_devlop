import 'dart:convert';

import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';

class CartModel {
  String? id;
  String? userId;
  Task? task;
  List<Box>? box;
  List<BoxItem>? boxItem;
  Day? orderTime;
  Address? address;
  String? title;

  CartModel({this.id,
      this.userId,
      required this.task,
      required this.box,
      required this.boxItem,
      required this.orderTime,
      required this.address,
      required this.title});

  factory CartModel.fromJson(Map<String, dynamic> jsons) {
    try {
      return CartModel(
              id:jsons["id"] == null ? null:jsons["id"]  ,
              userId:jsons["userId"] == null ? null: jsons["userId"],
              address:jsons["address"] == null ? null:Address.fromJson(json.decode(jsons["address"])) ,
              title:jsons["title"] == null ? null: jsons["title"],
              orderTime:jsons["orderTime"] == null ? null:Day.fromJson(json.decode(jsons["orderTime"])) ,
              box:jsons["box"] == null ? null: List<Box>.from(json.decode(jsons["box"].map((x) => Box.fromJson(x)))),
              boxItem:jsons["boxItem"] == null ? null:List<BoxItem>.from(json.decode(jsons["boxItem"].map((x) => BoxItem.fromJson(x)))) ,
              task:jsons["task"] == null ? null:Task.fromJson(json.decode(jsons["task"])) );
    } catch (e) {
      Logger().d(e);
      return CartModel.fromJson({});
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id??"",
      "userId":"${SharedPref.instance.getCurrentUserData().id.toString()}",
       "boxItem":json.encode(boxItem == null ? null:List<dynamic>.from(boxItem!.map((x) => x)))  ,
       "orderTime":json.encode(orderTime?.toJson()??{}),
       "address":json.encode(address?.toJson()??{}) ,
       "title": title??"",
        "box":json.encode(box == null ? null:List<dynamic>.from(box!.map((x) => x)))  ,
       "task":json.encode(task?.toJson()??{})
    };
    // try {
    //
    // } catch (e) {
    //   Logger().d(e);
    //   return {};
    // }
  }

}
