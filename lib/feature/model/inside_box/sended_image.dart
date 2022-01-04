
import 'package:dio/dio.dart' as multiPart;


class SendedImage {
  SendedImage({this.attachment, this.type});
  String? type;
  multiPart.MultipartFile? attachment;

  Map<String, dynamic> toJson() => {"type": type, "attachment": attachment};

  factory SendedImage.fromJson(Map<String, dynamic> json) => SendedImage(
        type: json["type"],
        attachment : json["attachment"]
      );
}
