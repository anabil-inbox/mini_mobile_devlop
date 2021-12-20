import 'package:inbox_clients/network/api/model/app_response.dart';
import 'package:inbox_clients/network/api/model/item_api.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:logger/logger.dart';

class ItemHelper{
   ItemHelper._();
  static final ItemHelper getInstance = ItemHelper._();
  var log = Logger();



    Future<AppResponse> getBoxBySerial({required var body}) async {
    var appResponse = await ItemApi.getInstance.getBoxBySerial(
        body: body,
        url: "${ConstanceNetwork.getBoxBySerialEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

    Future<AppResponse> addItem({required var body}) async {
    var appResponse = await ItemApi.getInstance.addItem(
        body: body,
        url: "${ConstanceNetwork.addItemEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }


      Future<AppResponse> deleteItem({required var body}) async {
    var appResponse = await ItemApi.getInstance.deleteItem(
        body: body,
        url: "${ConstanceNetwork.deleteItemEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }
}