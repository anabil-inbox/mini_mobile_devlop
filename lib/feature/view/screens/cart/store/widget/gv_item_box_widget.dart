import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/store/product_item.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';

class StoreItemWidget extends StatelessWidget {
  const StoreItemWidget({Key? key, required this.productItem})
      : super(key: key);

  final ProductItem productItem;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    screenUtil(context);
    return Container(
      alignment: Alignment.center,
      width: sizeW165,
      height: sizeH160,
      padding: EdgeInsets.all(padding10!),
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.circular(sizeRadius5!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imageNetwork(
              height: sizeH80,
              width: sizeW95,
              url: productItem.productGallery!.isEmpty
                  ? "https://www.celladorales.com/wp-content/uploads/2016/12/ShippingBox_sq.jpg"
                  : productItem.productGallery![0],
              fit: BoxFit.cover),
          SizedBox(
            height: sizeH10,
          ),
          CustomTextView(
            txt: "${productItem.name}",
            maxLine: Constance.maxLineTwo,
            textStyle: textStyleNormalBlack(),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: sizeH6,
          ),
          CustomTextView(
            txt: "${getPriceWithFormate(price: productItem.price ?? 0)}",
            maxLine: Constance.maxLineOne,
            textStyle: textStylePrimary(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
