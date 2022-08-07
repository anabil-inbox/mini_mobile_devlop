// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/home/box_model.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/three_size_dot.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:logger/logger.dart';

import '../../../../../../util/app_shaerd_data.dart';

class BoxOnOrderItem extends StatefulWidget {
  BoxOnOrderItem({Key? key, required this.boxModel,required this.isBox,required this.isScanDeliverdBox,required this.isProduct, this.hidReceiveBtn = false, }) : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  BoxModel boxModel;
  final bool isBox, isScanDeliverdBox, isProduct;
  final bool? hidReceiveBtn;
  @override
  State<BoxOnOrderItem> createState() => _BoxOnOrderItemState();
}

class _BoxOnOrderItemState extends State<BoxOnOrderItem> {
  GlobalKey<FormState> formFieldKey = GlobalKey<FormState>();
  bool isLoading = false;
//Receive
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    // Logger().w(!widget.hidReceiveBtn! &&
    //     BoxOnOrderItem.homeViewModel.operationTask.customerScanned != null &&
    //     !BoxOnOrderItem.homeViewModel.operationTask.customerScanned!.contains(widget.boxModel) &&
    //     (BoxOnOrderItem.homeViewModel.operationTask.driverId != null &&
    //         BoxOnOrderItem.homeViewModel.operationTask.driverId.toString().isNotEmpty));
    // Logger().w(!widget.hidReceiveBtn!);
    // Logger().w(BoxOnOrderItem.homeViewModel.operationTask.customerScanned != null );
    // Logger().w(!BoxOnOrderItem.homeViewModel.operationTask.customerScanned!.contains(widget.boxModel)  );
    // Logger().w((BoxOnOrderItem.homeViewModel.operationTask.driverId != null &&
    //     BoxOnOrderItem.homeViewModel.operationTask.driverId.toString().isNotEmpty) );
    return Container(
      margin: EdgeInsets.all(padding10!),
      child: InkWell(
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/svgs/Folder_Shared_1.svg'),
                SizedBox(width: sizeW5),
                Expanded(
                  child: CustomTextView(
                    txt: widget.boxModel.serial,
                    textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                  ),
                ),
                if(!widget.hidReceiveBtn! /*&&
                    BoxOnOrderItem.homeViewModel.operationTask.customerScanned != null &&
                    !BoxOnOrderItem.homeViewModel.operationTask.customerScanned!.contains(widget.boxModel)*/ /*&&
                    (BoxOnOrderItem.homeViewModel.operationTask.driverId != null &&
                        BoxOnOrderItem.homeViewModel.operationTask.driverId.toString().isNotEmpty)*/ )
                Container(
                  padding: EdgeInsets.all(sizeRadius10!),
                  decoration: BoxDecoration(
                    color: colorTextWhite,
                    borderRadius: BorderRadius.circular(sizeRadius10!)
                  ),
                  child: InkWell(
                    onTap: () async{
                      setState(() {
                        isLoading = true;
                      });
                      await BoxOnOrderItem.homeViewModel.createQrOrderConfirm(
                        code: widget.boxModel.serial.toString(),
                        storageViewModel: BoxOnOrderItem.storageViewModel,
                        isBox: widget.isBox,
                        homeViewModel: BoxOnOrderItem.homeViewModel,
                        isScanDeliverdBox: widget.isScanDeliverdBox,
                        isProduct: widget.isProduct);
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: isLoading?ThreeSizeDot(
                      color_1: colorPrimary,
                      color_2: colorPrimary,
                      color_3: colorPrimary,
                    ): CustomTextView(
                      txt: tr.received, //received
                      textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: sizeH12,
            ),
          ],
        ),
      ),
    );
  }
}
