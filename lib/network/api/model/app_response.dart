
import 'package:get/utils.dart';
import 'package:logger/logger.dart';

class AppResponse {
  Status? status;
  dynamic data;

  AppResponse({this.status, this.data});

  factory AppResponse.fromJson(var map) {
    try {
      if (GetUtils.isNull(map["data"])|| map["data"] == {}) {
        return AppResponse(
          status: Status.fromJson(map["status"]??{
            "message":"error accord",
            "code":403,
            "success":false,
          }),
        );
      } else {
        return AppResponse(
          status: Status.fromJson(map["status"]??{
            "message":"error accord",
            "code":403,
            "success":false,
          }),
          data: map["data"] == null ? null : map["data"],
        );
      }
    } catch (e) {
      
      return AppResponse(status: Status(
        message: "$e",
        code: 403,
        success: false,
      ));
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {"status": status?.toJson()??{}, "data": data??{}};
    } catch (e) {
      Logger().e(e);
      return {"": ""};
    }
  }
}

class Status {
  Status({
    this.message,
    this.code,
    this.success = false,
  });

  String? message;
  int? code;
  bool? success;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        message: json["message"] ?? "",
        code: json["code"] ?? "",
        success: json["success"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "message": message ?? "",
        "code": code ?? "",
        "success": success ?? "",
      };
}
