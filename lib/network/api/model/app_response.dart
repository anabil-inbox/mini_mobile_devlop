import 'package:logger/logger.dart';

class AppResponse {
  Status? status;
  dynamic data;

  AppResponse({this.status, this.data});

  factory AppResponse.fromJson(Map<String, dynamic> map) {
    try {
      return AppResponse(
       status: Status.fromJson(map["status"]),
        data: map["data"],
      );
    } catch (e) {
      
      Logger().e(e);
      return AppResponse.fromJson({});
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {"status": status?.toJson(), "data": data};
    } catch (e) {
      Logger().e(e);
      return {};
    }
  }
}

class Status {
    Status({
        this.message,
        this.code,
        this.success,
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
        "message": message,
        "code": code,
        "success": success,
    };
}

