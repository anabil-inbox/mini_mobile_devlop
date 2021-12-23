import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/add_item/widgets/qty_widget.dart';
import 'package:inbox_clients/feature/view/screens/add_item/widgets/tag_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

import 'photo_item_widget.dart';

class AddItemWidget extends StatelessWidget {
  const AddItemWidget({Key? key, required this.box}) : super(key: key);

  static ItemViewModle itemViewModle = Get.find<ItemViewModle>();
  final Box box;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(padding30!))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding20!),
        child: Form(
          key: itemViewModle.formKey,
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
              Text("Add Item"),
              SizedBox(
                height: sizeH20,
              ),
              TextFormField(
                controller: itemViewModle.tdName,
                validator: (e) {
                  if (e!.trim().length < 1) {
                    return "${tr.fill_your_name}";
                  }
                },
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
              TagWidget(),
              SizedBox(
                height: sizeH16,
              ),
              Container(
                  width: double.infinity,
                  child: Text(
                    "Photos",
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
                          builder.getImageBottomSheet();
                        },
                      ),
                      builder.images.isNotEmpty
                          ? Expanded(
                              child: Container(
                                height: sizeH50,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: builder.images
                                      .map((e) => PhotoItem(
                                            img: e,
                                          ))
                                      .toList(),
                                ),
                              ),
                            )
                          : const SizedBox(),
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
                      textButton: "Add Item",
                      isLoading: builder.isLoading,
                      onClicked: () {
                        if (itemViewModle.formKey.currentState!.validate()) {
                          itemViewModle.addItem(serialNo: box.serialNo ?? "");
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
    );
  }
}
