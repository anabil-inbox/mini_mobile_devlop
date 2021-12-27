import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as multiPart;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/inside_box/item.dart';
import 'package:inbox_clients/feature/model/inside_box/sended_image.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/check_in_box_widget.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/chooce_add_method_widget.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button%20copy.dart';
import 'package:inbox_clients/network/api/feature/home_helper.dart';
import 'package:inbox_clients/network/api/feature/item_helper.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/base_controller.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/string.dart';
import 'package:logger/logger.dart';

class ItemViewModle extends BaseController {
  // to do here item Editting Controllers ::
  final formKey = GlobalKey<FormState>();
  final TextEditingController tdName = TextEditingController();
  final TextEditingController tdTag = TextEditingController();
  int itemQuantity = 1;
  Set<String> usesBoxTags = {};
  Set<String> usesBoxItemsTags = {};
  List<File> images = [];
  File? itemImage;

  // to update Box Here ::
  Future<void> updateBox({required Box box}) async {
    Get.back();
    startLoading();
    List<SendedTag> tags = [];

    for (var tag in usesBoxTags) {
      tags.add(SendedTag(isEnable: 1, tag: tag));
    }

    await HomeHelper.getInstance.updateBox(body: {
      "name": box.storageName,
      "serial": box.serialNo,
      "qty": itemQuantity,
      "new_name": tdName.text,
      "tags": jsonEncode(tags),
    }).then((value) => {
          Logger().i("${value.toJson}"),
          if (value.status!.success!)
            {
              //  tdName.text = value.data["storage_name"],
              snackSuccess("${tr.success}", "${value.status?.message}")
            }
          else
            {snackError("${tr.error_occurred}", "${value.status?.message}")}
        });
    await getBoxBySerial(serial: box.serialNo!);
    tags.clear();
    usesBoxTags.clear();
    tdName.clear();
    tdTag.clear();
    endLoading();
  }

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

  // here for adding item With Name ::
  Future<void> addItem({required String serialNo}) async {
    startLoading();
    List<SendedTag> tags = [];
    List<SendedImage> innerImages = [];

    for (var tag in usesBoxItemsTags) {
      tags.add(SendedTag(isEnable: 1, tag: tag));
    }

    for (var item in images) {
      innerImages.add(SendedImage(
          attachment: multiPart.MultipartFile.fromFileSync(item.path),
          type: "Image"));
    }

    for (var item in innerImages) {
      Logger().i(item.toJson());
    }

    await ItemHelper.getInstance.addItem(body: {
      "name": "${tdName.text}",
      "storage": "$serialNo",
      "qty": "$itemQuantity",
      "tags": jsonEncode(tags),
      "gallery": innerImages.isNotEmpty
          ? [
              {
                "type": "image",
                "attachment": /* multiPart.MultipartFile.fromFileSync( */ images[
                        0]
                    .path /*)*/
              }
            ]
          : []
      // "gallery": innerImages.isNotEmpty ? jsonEncode(innerImages) : []
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
    await getBoxBySerial(serial: serialNo);
    images.clear();
    tags.clear();
    usesBoxItemsTags.clear();
    tdName.clear();
    tdTag.clear();
    itemQuantity = 1;
    update();
  }

  // here for Adding item without Name ::
  Future<void> addItemWithPhoto({required String serialNo}) async {
    startLoading();
    await ItemHelper.getInstance.addItem(body: {
      "storage": "$serialNo",
      LocalConstance.qallery: itemImage != null
          ? multiPart.MultipartFile.fromFileSync(itemImage!.path)
          : "",
      LocalConstance.quantity: 1,
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
              Logger().e("${value.toJson()}"),
              snackError("${tr.error_occurred}", "${value.status!.message}"),
              endLoading()
            }
        });

    images.clear();
    itemQuantity = 1;
    update();
  }

  // here for delete item
  Future<void> deleteItem({required String itemName, required String serialNo}) async {
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
    update();
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

  Future getItemImage({required String serialNo}) async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      itemImage = File(pickedImage.path);
      await addItemWithPhoto(serialNo: serialNo);
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

  // box Operations Box::
  Box? operationsBox;
  // to get Box With His Serial No..
  Future<void> getBoxBySerial({required String serial}) async {
    startLoading();
    await ItemHelper.getInstance
        .getBoxBySerial(body: {"serial": serial}).then((value) => {
              if (value.status!.success!)
                {
                  Logger().i("${value.toJson()}"),
                  operationsBox = Box.fromJson(value.data),
                }
              else
                {
                  snackError("$error", "${value.status!.message}"),
                }
            });
    endLoading();
  }

  // to show Adding item BottomSheet :

  Future<void> showAddItemBottomSheet({required Box box}) async {
    Get.bottomSheet(
      ChooseAddMethodWidget(
        isUpdate: false,
        box: box,
      ),
    );
  }

  // to show update Box Bottom Sheet ::

  Future<void> showUpdatBoxBottomSheet({required Box box , required bool isUpdate}) async {
    Get.bottomSheet(
        CheckInBoxWidget(
          isUpdate: isUpdate,
          box: box,
        ),
        isScrollControlled: true);
  }

}
