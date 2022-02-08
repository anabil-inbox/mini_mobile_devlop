// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class BoxItemInSalesOrder extends StatelessWidget {
  BoxItemInSalesOrder({Key? key, required this.boxItem}) : super(key: key);

  final BoxItem boxItem;
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      initState: (_) {},
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: sizeH22,
              ),
             
              imageNetwork(
                  url: (GetUtils.isNull(boxItem.itemGallery) ||
                          boxItem.itemGallery!.isEmpty)
                      ? urlPlacholder
                      : "${ConstanceNetwork.imageUrl}${(boxItem.itemGallery?[0].attachment ?? urlPlacholder)}",
                  height: sizeH40,
                  width: sizeW40,
                  fit: BoxFit.cover),
              SizedBox(
                height: sizeH6,
              ),
              Text("${boxItem.itemName}"),
              SizedBox(
                height: sizeH2,
              ),
              SizedBox(
                height: sizeH16,
              ),
            ],
          ),
        );
      },
    );
  }
}
