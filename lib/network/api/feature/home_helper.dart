import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/beneficiary.dart';
import 'package:inbox_clients/feature/model/home/notification_data.dart';
import 'package:inbox_clients/network/api/model/app_response.dart';
import 'package:inbox_clients/network/api/model/home_api.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:logger/logger.dart';

class HomeHelper {
  HomeHelper._();
  static final HomeHelper getInstance = HomeHelper._();
  var log = Logger();

  Future<List<Box>> getCustomerBoxess(
      {required int pageSize, required int page}) async {
    var appResponse = await HomeApi.getInstance.getCustomerBoxes(
        queryParameters: {"${ConstanceNetwork.page}": "$page", "${ConstanceNetwork.pageSize}": "$pageSize"},
        url: "${ConstanceNetwork.getCustomerBoxessEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      List data = appResponse.data["Storages"];
      return data.map((e) => Box.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<NotificationData>> getNotifications() async {
    var appResponse = await HomeApi.getInstance.getNotifications(
        url: "${ConstanceNetwork.getNotificationsApi}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      List data = appResponse.data;
      return data.map((e) => NotificationData.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<Set<Box>> getBoxessWithSearch({required String serchText}) async {
    var appResponse = await HomeApi.getInstance.getSearchBoxes(
        body: {"search" : "$serchText"},
        url: "${ConstanceNetwork.getSearchBoxessEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      List data = appResponse.data;
      return data.map((e) => Box.fromJson(e)).toSet();
    } else {
      return {};
    }
  }

  Future<AppResponse> updateBox({required var body}) async {
    var appResponse = await HomeApi.getInstance.updateBox(
        body: body,
        url: "${ConstanceNetwork.updatetBoxEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }


  Future<List<Beneficiary>> getBeneficiary() async {
    var appResponse = await HomeApi.getInstance.getBeneficiary(
        url: "${ConstanceNetwork.getBeneficiaryEndPoint}",
        header: ConstanceNetwork.header(0));
    if (appResponse.status?.success == true) {
       List data = appResponse.data;
      return data.map((e) => Beneficiary.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<AppResponse> checkTimeSlot({required var body}) async {
    var appResponse = await HomeApi.getInstance.checkTimeSlot(
        body: body,
        url: "${ConstanceNetwork.checkTimeSlotEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

 Future<AppResponse> uploadCustomerSignature({var body}) async {
      var appResponse = await HomeApi.getInstance.checkTimeSlot(
        body: body,
        url: "${ConstanceNetwork.uploadOrderSignatureEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

 Future<AppResponse> getTaskResponse({var body}) async {
      var appResponse = await HomeApi.getInstance.getTaskResponse(
        body: body,
        url: "${ConstanceNetwork.getCurrentTaskResponeEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

}
