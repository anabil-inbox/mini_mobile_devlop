import 'package:inbox_clients/feature/model/store/product_item.dart';
import 'package:inbox_clients/network/api/model/product.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:logger/logger.dart';

class ProductHelper {
  ProductHelper._();

  static final ProductHelper getInstance = ProductHelper._();
  var log = Logger();

  Future<List<ProductItem>> getAllProduct({required int pageSize, required int page}) async {
    var appResponse = await ProductApi.getInstance.getMyProducts(
        // queryParameters: {
        //   "${ConstanceNetwork.page}": "$page",
        //   "${ConstanceNetwork.pageSize}": "$pageSize"
        // },
        url: "${ConstanceNetwork.allOrder}?page=$page&page_size=$pageSize",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {

      List data = appResponse.data["data"];
      return /* data */ data.map((e) => ProductItem.fromJson(e)).toSet().toList();
    } else {
      return [];
    }
  }

  Future getProductDetails({required String productId}) async {
    var appResponse = await ProductApi.getInstance.getProductDetails(
        // body: body,
        url:
            "${ConstanceNetwork.orderDetails}?${ConstanceNetwork.productId}=$productId",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      Logger().e(appResponse.data["items"]);
      return appResponse
          .data["items"] /*ProductSales.fromJson(appResponse.data["order"])*/;
    } else {
      return appResponse.data;
    }
  }
}
