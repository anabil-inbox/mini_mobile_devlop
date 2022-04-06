import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/store/product_item.dart';
import 'package:inbox_clients/network/api/feature/product_helper.dart';
import 'package:logger/logger.dart';

class ProductViewModel extends GetxController {
  // ProductModel? productModel;
  var pageSize = 30;
  var pageNum = 1;
  var isLoadingProduct = false;
  List<ProductItem> productItems = <ProductItem>[];

  getMyAllProduct() async {
    try {
      isLoadingProduct = true;
      update();
      await ProductHelper.getInstance
          .getAllProduct(pageSize: pageSize, page: pageNum)
          .then((value) {
        // pageNum = value.currentPage!;
        // Logger().d(value.toJson());
        // if(value.items != null && value.items!.isNotEmpty) {
        //  productItems.addAll(value.items!);
        // }
        productItems.addAll(value);
        isLoadingProduct = false;
        update();
      }).catchError((onError) {
        isLoadingProduct = false;
        update();
      });
    } catch (e) {
      Logger().d(e.toString());
      isLoadingProduct = false;
      update();
    }
  }
}
