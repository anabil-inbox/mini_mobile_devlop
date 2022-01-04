import 'package:inbox_clients/feature/model/home/Box_modle.dart';
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





}
