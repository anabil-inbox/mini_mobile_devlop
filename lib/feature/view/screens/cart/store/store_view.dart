import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/cart/store/widget/gv_item_box_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/product_view_model/product_view_model.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';

class StoreView extends StatelessWidget {
  const StoreView({Key? key}) : super(key: key);
  ProductViewModel get productViewModel => Get.put<ProductViewModel>(ProductViewModel());
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
          init: productViewModel,
          initState: (state) => initListeners(),
          builder: (logic) {
        return Padding(
          padding: EdgeInsets.only(
              top: sizeH20!, right: sizeW20!, left: sizeW20!),
          child: GridView.builder(
            // controller: homeViewModel.scrollcontroller,
            physics: customScrollViewIOS(),
            clipBehavior: Clip.hardEdge,
            itemCount: /*homeViewModel.userBoxess.toList().length*/10,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: sizeW10!,
                crossAxisSpacing: sizeH10!,
                childAspectRatio: (sizeW165! / sizeH160!)),
            itemBuilder: (context, index) => StoreItemWidget(),
          ),
        );
      }),
    );
  }

  void initListeners() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    productViewModel.getMyAllProduct();
    });
  }
}
