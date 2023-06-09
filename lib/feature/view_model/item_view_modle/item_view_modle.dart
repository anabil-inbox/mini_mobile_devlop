// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as multiPart;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/inside_box/invoices.dart';
import 'package:inbox_clients/feature/model/inside_box/item.dart';
import 'package:inbox_clients/feature/model/inside_box/seal.dart';
import 'package:inbox_clients/feature/model/inside_box/sended_image.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/check_in_box_widget.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/add_item_widget.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/chooce_add_method_widget.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/items_operations_widget_BS.dart';
import 'package:inbox_clients/feature/view/screens/payment/payment_screen.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/box_bottom_sheet/seals_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/gloable_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button%20copy.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/network/api/feature/home_helper.dart';
import 'package:inbox_clients/network/api/feature/item_helper.dart';
import 'package:inbox_clients/network/api/feature/order_helper.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/base_controller.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/string.dart';
import 'package:logger/logger.dart';
import 'package:share/share.dart';

import '../../view/widgets/bottom_sheet_widget/box_bottom_sheet/invoices_bottom_sheet.dart';

class ItemViewModle extends BaseController {
  //to update Get Home View Modle and Update Oprations Box ::
  final HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  String? paymentEntryId;

  ItemViewModle._();

  factory ItemViewModle() => ItemViewModle._();

  // to decler here search value ::

  String search = "";

  // to do here item Editting Controllers ::
  //   GlobalKey<FormState> formKey = GlobalKey<FormState>();
   final TextEditingController tdName = TextEditingController();
   final TextEditingController tdTag = TextEditingController();
  int itemQuantity = 1;
  Set<String> usesBoxTags = {};
  Set<String> usesBoxItemsTags = {};
  List<File> images = [];
  File? itemImage;
  Box? operationsBox;

  bool isUpdateBoxDetails = false;

  @override
  onInit() {
    super.onInit();
  }

  // to update Box Here ::
  Future<void> updateBox({required Box box, required int index}) async {
    Get.back();
    startLoading();

    List<SendedTag> tags = [];

    for (var tag in usesBoxTags) {
      tags.add(SendedTag(isEnable: 1, tag: tag));
    }

    await HomeHelper.getInstance.updateBox(body: {
      ConstanceNetwork.nameKey: box.storageName,
      ConstanceNetwork.serial: box.serialNo,
      ConstanceNetwork.qtyKey: itemQuantity,
      ConstanceNetwork.newNameKey: tdName.text,
      ConstanceNetwork.tagsKey: jsonEncode(tags),
    }).then((valueApp) async => {
          if (valueApp.status!.success!)
            {
               // homeViewModel.getCustomerBoxes(),
               operationsBox = Box.fromJson(valueApp.data[ConstanceNetwork.dataKey]),
                await getBoxBySerial(serial: /*box.serialNo!*/valueApp.data[ConstanceNetwork.dataKey]["serial"]),
              snackSuccess("${tr.success}", "${valueApp.status?.message}"),
              update(),
              homeViewModel.userBoxess.clear(),
              homeViewModel.getCustomerBoxes(),

            }
          else
            {snackError("${tr.error_occurred}", "${valueApp.status?.message}")}
        });
    // await getBoxBySerial(serial: box.serialNo!);
    tags.clear();
    tdName.clear();

    usesBoxTags.clear();
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
    var returedItemId;
    List<SendedTag> tags = [];
    List<SendedImage> innerImages = [];
    Map<String, dynamic> map = {};

    for (var tag in usesBoxItemsTags) {
      tags.add(SendedTag(isEnable: 1, tag: tag));
    }

    for (var item in images) {
      var compressfile = await compressImage(item);
      innerImages.add(SendedImage(
          attachment: multiPart.MultipartFile.fromFileSync(/*item*/compressfile!.path.toString()),
          type: ConstanceNetwork.imageKey));
    }
    for (var i = 0; i < innerImages.length; i++) {
      map["image[$i]"] = innerImages[i].attachment;
      map["file[$i]"] = innerImages[i].type;
    }
    var qty = itemQuantity;
    map[ConstanceNetwork.nameKey] = tdName.text;
    map[ConstanceNetwork.storageKey] = serialNo;
    map[ConstanceNetwork.qtyKey] = qty;
    map[ConstanceNetwork.tagsKey] = jsonEncode(tags);

    await ItemHelper.getInstance.addItem(body: map).then((value) => {
          if (value.status!.success!)
            {
              Logger().i("${value.data[ConstanceNetwork.dataKey]}"),
              operationsBox?.items
                  ?.add(BoxItem.fromJson(value.data[ConstanceNetwork.dataKey])),
              snackSuccess("${tr.success}", "${value.status!.message}"),
              endLoading(),
              Get.back(),
            }
          else
            {
              snackError("${tr.error_occurred}", "${value.status!.message}"),
              endLoading()
            }
        });

    images.clear();
    tags.clear();
    usesBoxItemsTags.clear();
    tdTag.clear();
    tdName.clear();
    // isAllowToShowGallery = false;
    itemQuantity = 1;
    update();
    // Get.close(1);
    getBoxBySerial(serial: serialNo);
  }

  bool allowedClear = true;//allowedClear
  clearBottomSheetItem() {
    images.clear();
    usesBoxItemsTags.clear();
    if(allowedClear) {
      tdTag.clear();
      tdName.clear();
    }
    itemQuantity = 1;
    // isAllowToShowGallery = false;
    update();
  }

  // here for updateing the Item

  Future<void> updateItem(
      {required String serialNo,
      required String itemId,
      required var gallary}) async {
    startLoading();
    List<SendedTag> tags = [];
    List<SendedImage> innerImages = [];
    Map<String, dynamic> map = {};

    for (var tag in usesBoxItemsTags) {
      tags.add(SendedTag(isEnable: 1, tag: tag));
    }

    for (var item in images) {
      innerImages.add(SendedImage(
          attachment: multiPart.MultipartFile.fromFileSync(item.path),
          type: ConstanceNetwork.imageKey));
    }

    for (var i = 0; i < innerImages.length; i++) {
      map["image[$i]"] = innerImages[i].attachment;
      map["file[$i]"] = innerImages[i].type;
    }

    map[ConstanceNetwork.idKey] = itemId;
    map[ConstanceNetwork.newNameKey] = tdName.text;
    map[ConstanceNetwork.qtyKey] = itemQuantity;
    map[ConstanceNetwork.tagsKey] = jsonEncode(tags);
    map[ConstanceNetwork.gallerykey] = jsonEncode(gallary);

    await ItemHelper.getInstance.updateItem(body: map).then((value) => {
          if (value.status!.success!)
            {
              Logger().i("${value.toJson()}"),
              snackSuccess("${tr.success}", "${value.status!.message}"),
              // getBoxBySerial(serial: operationsBox!.serialNo.toString()),
              // operationsBox =
              Get.back(),
              endLoading()
            }
          else
            {
              snackError("${tr.error_occurred}", "${value.status!.message}"),
              endLoading()
            }
        });
    await getBoxBySerial(serial: operationsBox?.serialNo.toString()??serialNo);
    images.clear();
    tags.clear();
    tdName.clear();
    usesBoxItemsTags.clear();
    tdTag.clear();
    itemQuantity = 1;
    update();
  }

  // here for Adding item without Name ::
  Future<void> addItemWithPhoto({required String serialNo}) async {
    Get.back();
    startLoading();
    await ItemHelper.getInstance.addItem(body: {
      ConstanceNetwork.storageKey: "$serialNo",
      "image[0]": itemImage != null
          ? multiPart.MultipartFile.fromFileSync(itemImage!.path)
          : [],
      "file[0]": ConstanceNetwork.imageKey,
      LocalConstance.quantity: 1,
    }).then((value) => {
          if (value.status!.success!)
            {
              snackSuccess("${tr.success}", "${value.status!.message}"),
              operationsBox?.items
                  ?.add(BoxItem.fromJson(value.data[ConstanceNetwork.dataKey])),
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

  // here for delete item Func && Botttom Sheet Alarm ::
  Future<void> showDeleteItemBottomSheet(
      {required String serialNo, required String id}) async {
    await Get.bottomSheet(GlobalBottomSheet(
      isTwoBtn: true,
      title: tr.want_delete,
      onOkBtnClick: () async {
        Get.close(2);
        await deleteItem(serialNo: serialNo, id: id);
      },
      onCancelBtnClick: () {
        Get.back();
      }, isDelete: true,
    ));
  }

  Future<void> deleteItem(
      {required String serialNo, required String id}) async {
    startLoading();
    await ItemHelper.getInstance.deleteItem(body: {
      ConstanceNetwork.idKey: id
    }).then((value) => {
          if (value.status!.success!)
            {
              Logger().i("${value.toJson()}"),
              snackSuccess("${tr.success}", "${value.status!.message}"),
              getBoxBySerial(serial: serialNo),
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

  Future<void> getImageBottomSheet(
      {bool? isMultiSelect = false,
      bool? isFromGallery = false,
      BoxItem? boxItem,
      bool? isUpdate = false,
      Box? box, bool? isFromAddItem = false}) async {
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
            tr.select_image,
            style: textStyleAppBarTitle(),
          ),
          SizedBox(
            height: sizeH25,
          ),
          SeconderyButtom(
            buttonTextStyle: textSeconderyButtonUnBold(),
            textButton: tr.camera,
            onClicked: () async {
              await getImage(ImageSource.camera, isMultiSelect: isMultiSelect!,
                  isFromGallery: isFromGallery,
                  boxItem: boxItem,
                  isUpdate: isUpdate,
                  box: box);
              Get.back();
            },
            isExpanded: true,
          ),
          SizedBox(
            height: sizeH20,
          ),
          SeconderyButtom(
            buttonTextStyle: textSeconderyButtonUnBold(),
            textButton: tr.gallery,
            onClicked: () async {
              if(isFromAddItem!) {
                allowedClear = false;
                update();
                Get.back();
                Get.back();
              }
                await getImage(ImageSource.gallery,
                  isMultiSelect: true/*isMultiSelect!*/,
                  isFromAddItem:isFromAddItem,
                  isFromGallery: isFromGallery,
                  boxItem: boxItem,
                  isUpdate: isUpdate,
                  box: box);
              if(!isFromAddItem) {
                Get.back();
              }
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

  Future getImage(ImageSource source,
      {bool? isMultiSelect = false,
      bool? isFromGallery = false,
      BoxItem? boxItem,
      bool? isUpdate = false,
      Box? box, bool? isFromAddItem = false}) async {
    // isAllowToShowGallery = false;
    // update();
    if ((isMultiSelect! || (isMultiSelect && isFromAddItem!)) && source == ImageSource.gallery) {
      final pickedImage = await picker.pickMultiImage();
      if (pickedImage != null) {
        pickedImage.forEach((element) {
          images.add(File(element.path));
        });
        update();
         // Get.back();
        Future.delayed(Duration.zero).then((value) {
          Get.bottomSheet(
              AddItemWidget(
                isMultiSelect:isMultiSelect,
                isFromAddItem: isFromAddItem,
                isFromGallery: true,
                boxItem: BoxItem(),
                isUpdate: isUpdate,
                box: box!,
              ),
              isScrollControlled: true)
              .whenComplete(() {
            // if(isUpdate){
            clearBottomSheetItem();
            // }
          });
        });
      }
    }/*else if (isMultiSelect && source == ImageSource.camera){
      final pickedImage = await picker.pickImage(source: source);
      if (pickedImage != null) {
        images.add(File(pickedImage.path));
        update();
        Future.delayed(Duration.zero).then((value) {
          Get.bottomSheet(
              AddItemWidget(
                isFromGallery: true,
                isFromAddItem: isFromAddItem,
                boxItem: BoxItem(),
                isUpdate: isUpdate,
                box: box!,
              ),
              isScrollControlled: true)
              .whenComplete(() {
            // if(isUpdate){
            clearBottomSheetItem();
            // }
          });
        });
      }
    } */else {
      final pickedImage = await picker.pickImage(source: source);
      if (pickedImage != null) {
        images.add(File(pickedImage.path));
        update();
      }
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

  // box Operations Dec ::
  // Box? operationsBox;
  // to get Box With His Serial No..
  Future<void> getBoxBySerial({required String serial}) async {
    try {
      if(serial.isEmpty){
        return;
      }
      Logger().w("getBoxBySerial $serial");
      startLoading();
      await ItemHelper.getInstance.getBoxBySerial(body: {
        ConstanceNetwork.serial: serial
      }).then((value) => {
            if (value.status!.success!)
              {
                operationsBox = null,
                Logger().e("${value.toJson()}"),
                operationsBox = Box.fromJson(value.data),
                endLoading(),
              }
            else
              {
                snackError("$error", "${value.status!.message}"),
                endLoading(),
              }
          });
    } catch (e) {
      Logger().d("${e.toString()}");
      endLoading();
    }
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

  changeFlagUpdate(bool isUpdate) {
    isUpdateBoxDetails = isUpdate;
    update();
  }

  // to show update Box Bottom Sheet ::
  Future<void> showUpdatBoxBottomSheet(
      {required Box box, required bool isUpdate}) async {
    changeFlagUpdate(isUpdate);
    tdName.text = box.storageName ?? "";
    Get.bottomSheet(
            CheckInBoxWidget(
              isUpdate: isUpdate,
              box: box,
            ),
            isScrollControlled: true)
        .whenComplete(() {
      getBoxBySerial(serial: box.serialNo ?? "");
    });
  }

  Future<void> shareItem({required BoxItem boxItem}) async {
    String strToShare = '\n Item Name : ${boxItem.itemName}' +
        '\n Item Quantity : ${boxItem.itemQuantity} \n';
    if (boxItem.itemTags!.isNotEmpty) {
      strToShare += 'Item Tags : ';
      for (var item in boxItem.itemTags!) {
        strToShare += '${item.tag ?? ''}';
      }
    }
    if (boxItem.itemGallery!.isNotEmpty) {
      strToShare += '\n Item Attachment :';
      for (var item in boxItem.itemGallery!) {
        strToShare += '\n ${ConstanceNetwork.imageUrl + item.attachment!}';
      }
    }
    try {
      Share.share(strToShare);
    } catch (e) {
      printError();
    }
  }

  Future<void> shareBox({required Box box}) async {
    try {
      String strToShare = '\n Box Name : ${box.storageName}';
      if (box.tags!.isNotEmpty) {
        strToShare += '\n Box Tags : ';
        for (var item in box.tags!) {
          strToShare += ' ${item.tag ?? ''} ';
        }
      }

      if (box.items!.isNotEmpty) {
        strToShare += '\n Box Items: ';
        for (int i = 0; i < box.items!.length; i++) {
          if (box.items!.isNotEmpty) {
            strToShare +=
                '\n  Item [${i + 1}] : \n Item Name : ${box.items![i].itemName}' +
                    '\n Item Quantity : ${box.items![i].itemQuantity}';
            if (box.items![i].itemTags!.isNotEmpty) {
              strToShare += '\n Item Tags : ';
              for (var item in box.items![i].itemTags!) {
                strToShare += '${item.tag ?? ''}';
              }
            }
            if (box.items![i].itemGallery!.isNotEmpty) {
              strToShare += '\n Item Attachment : \n';
              for (var item in box.items![i].itemGallery!) {
                strToShare +=
                    '${ConstanceNetwork.imageUrl + item.attachment!} \n';
              }
            } else {
              strToShare += '\n';
            }
          }
        }
        strToShare += '\n ';
      }

      Share.share(strToShare);
    } catch (e) {
      printError();
    }
  }

  // here Function For Update And Delete And Share Box Bottom Sheet ::

  Future<void> showOptionOperationBottomSheet(
      {required BoxItem boxItem, required Box box}) async {
    Get.bottomSheet(
        ItemsOperationBS(
          box: box,
          boxItem: boxItem,
        ),
        isScrollControlled: true);
  }

  // Here Functions For Filtering and Selected:

  //todo this for appbar select btn
  bool? isSelectBtnClick = false;
  bool isSelectAllClick = false;
  List<BoxItem> listIndexSelected = <BoxItem>[];

  //this is For Selcting an Item Photos in Fetching Task :
  List<String> selectedItmePhotos = [];

  //todo this for show selection btn
  updateSelectBtn() {
    isSelectBtnClick = !isSelectBtnClick!;
    update();
  }

  //todo this for select all item
  updateSelectAll(List<BoxItem> list) {
    isSelectAllClick = !isSelectAllClick;
    update();
    insertAllItemToList(list);
  }

  //todo this for add single item to selected List item
  addIndexToList(BoxItem itemName) {
    if (listIndexSelected.contains(itemName)) {
      listIndexSelected.remove(itemName);
      update();
    } else {
      listIndexSelected.add(itemName);
      update();
    }
  }

  //todo this for add all item to selected List item
  void insertAllItemToList(List<BoxItem> list) {
    if (isSelectAllClick) {
      listIndexSelected.clear();
      listIndexSelected.addAll(list);
      update();
    } else {
      listIndexSelected.clear();
      update();
    }
  }

  showInvoicesBottomSheet(
      {required List<Invoices> invoices, required Box? operationsBox}) {
    Get.bottomSheet(
        InvoicesBottomSheet(
          invoices: invoices,
          viewModel: this,
          operationsBox: operationsBox,
        ),
        isScrollControlled: true);
  }

  showSealssBottomSheet({required List<Seal> seals}) {
    Get.bottomSheet(
        SealsBottomSheet(
          seals: seals,
        ),
        isScrollControlled: true);
  }

  @override
  InternalFinalCallback<void> get onDelete => super.onDelete;

  bool isLoadingInvoice = false;

  Future<void> getInvoiceUrl(String? paymentEntryId,
      {Box? operationsBox}) async {
    isLoadingInvoice = true;
    this.paymentEntryId = paymentEntryId;
    update();
    var boxId = paymentEntryId;
    var appResponse = await OrderHelper.getInstance
        .getInvoiceUrlPaymentApi(body: {LocalConstance.id: boxId});
    isLoadingInvoice = false;
    update();
    if (appResponse.status!.success!) {
      var data = appResponse.data;
      var paymentUrl = data["url"];
      Get.to(PaymentScreen(
        isFromNewStorage: false,
        isFromCart: false,
        url: paymentUrl,
        paymentId: '',
        cartModels: [],
        isOrderProductPayment: false,
        isFromInvoice: true,
        boxIdInvoice: boxId,
        operationsBox: operationsBox,
      ));
    }
  }
}
