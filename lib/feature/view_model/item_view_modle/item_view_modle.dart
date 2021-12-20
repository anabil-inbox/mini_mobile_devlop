import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/inside_box/item.dart';
import 'package:inbox_clients/feature/view/screens/add_item/widgets/add_item_widget.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button%20copy.dart';
import 'package:inbox_clients/network/api/feature/item_helper.dart';
import 'package:inbox_clients/network/api/model/item_api.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/base_controller.dart';
import 'package:inbox_clients/util/string.dart';
import 'package:logger/logger.dart';

class ItemViewModle extends BaseController {
  // to do here item Editting Controllers ::
  final formKey = GlobalKey<FormState>();
  final TextEditingController tdName = TextEditingController();
  final TextEditingController tdTag = TextEditingController();
  int itemQuantity = 1;
  Set<String> usetTags = {};
  List<File> images = [];
  // here for loading ::

  bool isLoading = false;
  // start Loaging Function ::
  void startLoading() {
    isLoading = true;
    update();
  }

  // end Loaging Function ::
  void endLoading() {
    isLoading = false;
    update();
  }

  // here for adding item

  Future<void> addItem({required String serialNo}) async {
    startLoading();
    List<Tag> tags = [];

    for (var tag in usetTags) {
      tags.add(Tag(isEnabled: 1, name: tag));
    }

    await ItemHelper.getInstance.addItem(body: {
      "name": "${tdName.text}",
      "storage": "$serialNo",
      "qty": "$itemQuantity",
      "tags": tags,
      "item_gallery": images
    }).then((value) => {
          if (value.status!.success!)
            {
              Logger().i("${value.toJson()}"),
              snackSuccess("${tr.success}", "${value.status!.message}"),
              Get.back(),
              endLoading()
            }
          else
            {
              snackError("${tr.error_occurred}", "${value.status!.message}"),
              endLoading()
            }
        });
  }

  // here for delete item
  Future<void> deleteItem({required String itemName}) async {
    startLoading();
    await ItemHelper.getInstance.deleteItem(body: {
      "name": "$itemName"
    }).then((value) => {
          if (value.status!.success!)
            {
              Logger().i("${value.toJson()}"),
              snackSuccess("${tr.success}", "${value.status!.message}"),
              endLoading()
            }
          else
            {
              snackError("${tr.error_occurred}", "${value.status!.message}"),
              endLoading()
            }
        });
  }

  

  // adding image to item functions ::

  final picker = ImagePicker();

  void getImageBottomSheet() {
    Get.bottomSheet(Container(
      height: sizeH240,
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(padding30!))),
      child: Column(
        children: [
          SizedBox(
            height: sizeH20,
          ),
          Container(
            height: sizeH5,
            width: sizeH50,
            decoration: BoxDecoration(
                color: colorUnSelectedWidget,
                borderRadius: BorderRadius.circular(2.5)),
          ),
          SizedBox(
            height: sizeH20,
          ),
          Text(
            "Select Image",
            style: textStyleAppBarTitle(),
          ),
          SizedBox(
            height: sizeH25,
          ),
          SeconderyButtom(
            buttonTextStyle: textSeconderyButtonUnBold(),
            textButton: "Camera",
            onClicked: () async {
              await getImage(ImageSource.camera);
              Get.back();
            },
            isExpanded: true,
          ),
          SizedBox(
            height: sizeH20,
          ),
          SeconderyButtom(
            buttonTextStyle: textSeconderyButtonUnBold(),
            textButton: "Gallery",
            onClicked: () async {
              await getImage(ImageSource.gallery);
              Get.back();
            },
            isExpanded: true,
          ),
          SizedBox(
            height: sizeH20,
          ),
        ],
      ),
    ));
  }

  Future getImage(ImageSource source) async {
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      images.add(File(pickedImage.path));
      update();
    }
  }

  void increaseQty() {
    itemQuantity++;
    update();
  }

  void minesQty() {
    if (itemQuantity > 1) {
      itemQuantity--;
    }
    update();
  }

  // to get Box With His Serial No..
  Future<Box> getBoxBySerial({required String serial}) async {
    Box box = Box();
    await ItemHelper.getInstance
        .getBoxBySerial(body: {"serial": serial}).then((value) => {
              if (value.status!.success!)
                {
                  Logger().i("${value.toJson()}"),
                  box = Box.fromJson(value.data["Storages"]),
                }
              else
                {
                  snackError("$error", "${value.status!.message}"),
                }
            });
    return box;
  }

  // to show Adding item BottomSheet :

  void showAddItemBottomSheet({required Box box}) {
    Get.bottomSheet(
        AddItemWidget(
          box: box,
        ),
        isScrollControlled: true);
  }

  //  Future<void> scanBarcodeNormal() async {
  //   String barcodeScanRes;
  //   try {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //         '#ff6666', 'Cancel', true, ScanMode.BARCODE);
  //     print(barcodeScanRes);
  //   } on PlatformException {
  //     barcodeScanRes = 'Failed to get platform version.';
  //   }
  // }
  //  Future<void> scanQR() async {
  //   String barcodeScanRes;
  //   try {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //         '#ff6666', 'Cancel', true, ScanMode.QR);
  //     print(barcodeScanRes);
  //   } on PlatformException {
  //     barcodeScanRes = 'Failed to get platform version.';
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
  }
}
