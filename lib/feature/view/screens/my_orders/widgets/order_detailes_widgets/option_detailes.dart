import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/show_selction_widget/show_option_item.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class OptionDeatailes extends StatelessWidget {
  const OptionDeatailes({Key? key, required this.orderItem}) : super(key: key);

  final OrderItem orderItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: sizeH10,
          ),
          orderItem.options!.isEmpty
              ? const SizedBox()
              : SizedBox(width: double.infinity, child: Text(tr.options)),
          orderItem.options!.isEmpty
              ? const SizedBox()
              : SizedBox(
                  height: sizeH10,
                ),
          ListView(
            shrinkWrap: true,
            primary: false,
            children: orderItem.options!
                .map((option) => ShowOptionItem(
                    optionTitle: option, isShowingPrice: false , price: ""))
                .toList(),
          )
        ],
      ),
    );
  }
}
