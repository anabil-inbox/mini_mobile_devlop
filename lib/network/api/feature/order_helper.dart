import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/network/api/model/app_response.dart';
import 'package:inbox_clients/network/api/model/order_api.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:logger/logger.dart';

class OrderHelper {
  OrderHelper._();

  static final OrderHelper getInstance = OrderHelper._();
  var log = Logger();

  Future<Set<OrderSales>> getCustomerBoxess(
      {required int pageSize, required int page}) async {
    var appResponse = await OrderApi.getInstance.getMyOrders(
        queryParameters: {
          "${ConstanceNetwork.page}": "$page",
          "${ConstanceNetwork.pageSize}": "$pageSize"
        },
        url: "${ConstanceNetwork.getMyOrddersEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      List data = appResponse.data["items"];
      return data.map((e) => OrderSales.fromJson(e)).toSet();
    } else {
      return {};
    }
  }

  Future<AppResponse> newSalesOrder({var body}) async {
    var appResponse = await OrderApi.getInstance.newSalesOrder(
        body: body,
        url: "${ConstanceNetwork.newSalesOrder}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      // List data = appResponse.data["items"];
      // return data.map((e) => OrderSales.fromJson(e)).toSet();
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<OrderSales> getOrderDetaile(
      {required Map<String, String> body}) async {
    var appResponse = await OrderApi.getInstance.getOrderDetails(
        body: body,
        url: "${ConstanceNetwork.myOrderDetailesEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      Logger().e(appResponse.data["order"]);
      return OrderSales.fromJson(appResponse.data["order"]);
    } else {
      return appResponse.data;
    }
  }
}
