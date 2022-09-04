import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/utils.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/qty_widget.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/tag_box_item_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

import 'photo_item_widget.dart';

class AddItemWidget extends StatefulWidget {
  const AddItemWidget({
    Key? key,
    required this.box,
    this.isUpdate = false,
    required this.boxItem,
    this.isFromGallery = false,
    this.isMultiSelect = false,
    this.isFromAddItem = false,
  }) : super(key: key);

  final Box box;
  final bool? isUpdate;
  final BoxItem boxItem;
  final bool? isFromGallery;
  final bool? isMultiSelect;
  final bool? isFromAddItem;

  @override
  State<AddItemWidget> createState() => _AddItemWidgetState();
}

class _AddItemWidgetState extends State<AddItemWidget> {
  ItemViewModle itemViewModle = Get.find<ItemViewModle>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    //   itemViewModle.tdName.dispose();
    //   itemViewModle.tdTag.dispose();
    // });
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(padding30!))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding20!),
        child: Form(
          key: /*itemViewModle.*/formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: sizeH20,
                ),
                SpacerdColor(),
                SizedBox(
                  height: sizeH20,
                ),
                Text(widget.isFromGallery!
                    ? tr.add_from_gallery
                    : widget.isUpdate ?? false
                        ? tr.update_item
                        : tr.add_item),
                SizedBox(
                  height: sizeH20,
                ),
                if (!widget.isFromGallery! || widget.isFromAddItem!) ...[
                  TextFormField(
                     controller: itemViewModle.tdName,
                    validator: (e) {
                      if (e!.trim().length < 1) {
                        return "${tr.fill_your_name}";
                      }
                      return null;
                    },
                    // onChanged: (_){
                    //   itemViewModle.tdName.text = _.toString();
                    //   itemViewModle.update();
                    // },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorBorderContainer),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorBorderContainer),
                        ),
                        hintText: "${tr.name}"),
                  ),
                  SizedBox(
                    height: sizeH16,
                  ),
                  QtyWidget(),
                  SizedBox(
                    height: sizeH16,
                  ),
                  TagBoxItemWidget(
                    boxItem: widget.boxItem,
                    isUpdate: widget.isUpdate ?? false,
                  ),
                  SizedBox(
                    height: sizeH16,
                  ),
                ],
                Container(
                    width: double.infinity,
                    child: Text(
                      tr.photos,
                      textAlign: TextAlign.start,
                    )),
                SizedBox(
                  height: sizeH6,
                ),
                GetBuilder<ItemViewModle>(
                  init: ItemViewModle(),
                  initState: (_) {},
                  builder: (builder) {
                    return Row(
                      children: [
                        InkWell(
                          child: SvgPicture.asset("assets/svgs/add_cont.svg"),
                          onTap: () {
                            builder.getImageBottomSheet(
                                isFromGallery: widget.isFromGallery,
                                isFromAddItem: widget.isFromAddItem,
                                isMultiSelect: widget.isMultiSelect,
                                box: widget.box,
                                boxItem: widget.boxItem,
                                isUpdate: widget.isUpdate);
                          },
                        ),
                        Expanded(
                          child: SizedBox(
                            height: sizeH50,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              primary: true,
                              children: [
                                builder.images.isNotEmpty
                                    ? SizedBox(
                                        height: sizeH50,
                                        child: ListView(
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: builder.images
                                              .map((e) => PhotoItem(
                                                    isFromLocal: true,
                                                    img: e,
                                                  ))
                                              .toList(),
                                        ),
                                      )
                                    : const SizedBox(),
                                !(GetUtils.isNull(widget.boxItem.itemGallery) ||
                                        widget.boxItem.itemGallery!.isEmpty)
                                    ? SizedBox(
                                        height: sizeH50,
                                        child: ListView(
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: widget.boxItem.itemGallery!
                                              .map((e) => PhotoItem(
                                                    img: null,
                                                    isFromLocal: false,
                                                    url: e.attachment,
                                                  ))
                                              .toList(),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        // builder.images.isNotEmpty
                        //     ? Expanded(
                        //         child: Container(
                        //           height: sizeH50,
                        //           child: ListView(
                        //             scrollDirection: Axis.horizontal,
                        //             children: builder.images
                        //                 .map((e) => PhotoItem(
                        //                       isFromLocal: true,
                        //                       img: e,
                        //                     ))
                        //                 .toList(),
                        //           ),
                        //         ),
                        //       )
                        //     : const SizedBox(),
                        // !(GetUtils.isNull(boxItem.itemGallery) ||
                        //         boxItem.itemGallery!.isEmpty)
                        //     ? Expanded(
                        //         child: Container(
                        //           height: sizeH50,
                        //           child: ListView(
                        //              primary: false,
                        //                 shrinkWrap: true,
                        //             scrollDirection: Axis.horizontal,
                        //             children: boxItem.itemGallery!
                        //                 .map((e) => PhotoItem(
                        //                       img: null,
                        //                       isFromLocal: false,
                        //                       url: e["attachment"],
                        //                     ))
                        //                 .toList(),
                        //           ),
                        //         ),
                        //       )
                        //     : const SizedBox(),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: sizeH16,
                ),
                GetBuilder<ItemViewModle>(
                  init: ItemViewModle(),
                  initState: (_) {},
                  builder: (builder) {
                    return PrimaryButton(
                        textButton: widget.isUpdate ?? false
                            ? tr.update_item
                            : tr.add_item,
                        isLoading: builder.isLoading,
                        onClicked: () async {
                          if (/*itemViewModle.*/formKey.currentState!.validate()) {
                            if (widget.isUpdate!) {
                              await itemViewModle.updateItem(
                                gallary: widget.boxItem.itemGallery,
                                serialNo: widget.box.serialNo ??
                                    itemViewModle.operationsBox?.serialNo ??
                                    "",
                                itemId: widget.boxItem.id!,
                              );
                            } else {
                              await itemViewModle.addItem(
                                  serialNo: widget.box.serialNo ??
                                      itemViewModle.operationsBox?.serialNo ??
                                      "");
                            }
                          }
                        },
                        isExpanded: true);
                  },
                ),
                SizedBox(
                  height: sizeH6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
