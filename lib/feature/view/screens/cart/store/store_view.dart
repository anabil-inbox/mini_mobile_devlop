import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/cart/store/widget/gv_item_box_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/product_view_model/product_view_model.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:logger/logger.dart';

class StoreView extends StatelessWidget {
  const StoreView({Key? key}) : super(key: key);
  // static ProductViewModel productViewModel = Get.put<ProductViewModel>(ProductViewModel());

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: CustomAppBarWidget(
        isCenterTitle: true,
        titleWidget: CustomTextView(
          txt: "${tr.store}",
          textStyle: textStyleAppBarTitle(),
          maxLine: Constance.maxLineOne,
        ),
      ),
      body: GetBuilder<ProductViewModel>(
        init: ProductViewModel(),
        initState: (_) async {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
            await _.controller?.getMyAllProduct();
          });
        },
        builder: (productViewModel) {
          if (productViewModel.isLoadingProduct) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (productViewModel.productItems.isEmpty) {
            return const SizedBox();
          } else {
            return Padding(
              padding: EdgeInsets.only(
                  top: sizeH20!, right: sizeW20!, left: sizeW20!),
              child: GridView.builder(
                // controller: homeViewModel.scrollcontroller,
                clipBehavior: Clip.hardEdge,
                itemCount: productViewModel.productItems.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: sizeW10!,
                    crossAxisSpacing: sizeH10!,
                    childAspectRatio: (sizeW165! / sizeH160!)),
                itemBuilder: (context, index) {
                  Logger().w(productViewModel.productItems[index].toJson());
                  return StoreItemWidget(
                  productItem: productViewModel.productItems[index],
                );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
