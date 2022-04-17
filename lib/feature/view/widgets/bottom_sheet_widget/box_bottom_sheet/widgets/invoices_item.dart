import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/inside_box/invoices.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class InvoicesItem extends StatelessWidget {
  const InvoicesItem({Key? key , required this.invoices}) : super(key: key);

  final Invoices invoices;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Text(invoices.name ?? ""),
          Spacer(),
          Text(
            getPriceWithFormate(price: invoices.price ?? 0),
            style: Theme.of(context).textTheme.headline6?.copyWith(
                color: colorPrimary,
                fontWeight: FontWeight.bold,
                fontSize: fontSize16),
          )
        ],
      ),
    );
  }
}
