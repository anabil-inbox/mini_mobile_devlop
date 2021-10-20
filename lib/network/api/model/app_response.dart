import 'package:logger/logger.dart';

class AppResponse {
   bool? status;
  dynamic data;

  AppResponse({this.status, this.data});

  factory AppResponse.fromJson(Map<String, dynamic> map) {
    try {
      return AppResponse(
        status: map["status"],
        data: map["data"],
      );
    } catch (e) {
      Logger().e(e);
      return AppResponse.fromJson({});
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {"status": status, "data": data};
    } catch (e) {
      Logger().e(e);
      return {};
    }
  }
}
