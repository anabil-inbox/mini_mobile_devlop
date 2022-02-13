import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/product_model.dart';
import 'package:inbox_clients/network/api/feature/product_helper.dart';
import 'package:logger/logger.dart';

class ProductViewModel extends GetxController {
 // ProductModel? productModel;
  var pageSize = 30;
  var pageNum = 1;
  var isLoadingProduct = false;
  List<ItemElement>? productItems = <ItemElement>[];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}

  @override
  void onReady() {}

  getMyAllProduct() async {
    try {
      isLoadingProduct = true;
      update();
      await ProductHelper.getInstance.getAllProduct(pageSize: pageSize, page: pageNum).then((value) {
        pageNum = value.currentPage!;
        Logger().d(value.toJson());
        if(value.items != null && value.items!.isNotEmpty) {
          productItems?.addAll(value.items!);
        }
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
