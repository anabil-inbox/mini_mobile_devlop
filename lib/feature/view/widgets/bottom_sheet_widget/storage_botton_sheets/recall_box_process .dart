import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/schedule_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/option_item.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/options_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_two_widgets/pickup_address_item.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_two_widgets/schedule_pickup_widget.dart';
import 'package:inbox_clients/feature/view/widgets/option_item_string.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/date_time_util.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:logger/logger.dart';

import '../../custome_text_view.dart';



class RecallBoxProcessSheet extends StatelessWidget {
  const RecallBoxProcessSheet({Key? key, required this.box,this.index }) : super(key: key);

  final Box box;
  final int? index;
  static HomeViewModel _homeViewModel = Get.find<HomeViewModel>();
  static StorageViewModel _storageViewModel = Get.find<StorageViewModel>();


  Widget get actionBtn =>  Container(
    margin: EdgeInsets.symmetric(horizontal: sizeW10!),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Expanded(
          child: PrimaryButton(
            isExpanded: true,
            isLoading: false,
            onClicked: onClickBreakSeal,
            textButton: "${tr.recall_now}",
          ),
        ),
        SizedBox(
          width: sizeW10,
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: SeconderyFormButton(
              buttonText: "${tr.add_to_cart}",
              onClicked: onClickBringBox,
            ),
          ),
        ),

      ],
    ),
  );


  Widget get addressWidget => Container(
  alignment: Alignment.center,
  padding: EdgeInsets.only(left: sizeW10! , right:sizeW10! ,top: sizeH20!),
  margin: EdgeInsets.symmetric(horizontal: sizeW10!),
  decoration: BoxDecoration(
  boxShadow: [boxShadowLight()!],
  color: colorTextWhite,
  borderRadius: BorderRadius.circular(sizeRadius10!)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${tr.pickup_address}"),
        SizedBox(
          height: sizeH10,
        ),
        GetBuilder<StorageViewModel>(
          init: StorageViewModel(),
          initState: (_) {
            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
              _storageViewModel.selectedDateTime = null;
              _storageViewModel.selectedDay = null;
              _storageViewModel.selectedStringOption.clear();
              _storageViewModel.getStoreAddress();
            });
          },
          builder: (_) {
            return _storageViewModel.storeAddress.isNotEmpty
                ? ListView(
              primary: false,
              shrinkWrap: true,
              children: _storageViewModel.storeAddress
                  .map((e) => e.addresses!.isNotEmpty
                  ? PickupAddressItem(
                  store: e,
                  address: e.addresses?[0] ??
                      Address(title: e.addresses?[0].title ?? ""))
                  : const SizedBox())
                  .toList(),
            )
                : const SizedBox();
          },
        ),
        SizedBox(
          height: sizeH10,
        ),
      ],
    ),
  );

  Widget get optionsList => box.options?.length == 0 ? const SizedBox.shrink():Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(left: sizeW10! , right:sizeW10! ,top: sizeH20!),
    margin: EdgeInsets.symmetric(horizontal: sizeW10!),
    decoration: BoxDecoration(
      boxShadow: [boxShadowLight()!],
      color: colorTextWhite,
      borderRadius: BorderRadius.circular(sizeRadius10!)
    ),
    child: ListView.builder(
      padding: EdgeInsets.all(padding0!),
      shrinkWrap: true,
      itemCount: box.options?.length,
      primary: false,
      itemBuilder: (context, index) => OptionStringItem(option: box.options?[index] ,options :box.options),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizeW15!),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(padding30!)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.start ,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: sizeH30,
            ),
            Align(
                alignment: Alignment.center,
                child: SpacerdColor()),
            SizedBox(
              height: sizeH30,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: scaffoldColor,
                  borderRadius: BorderRadius.circular(padding6!)),
               margin: EdgeInsets.symmetric(horizontal: sizeH10!),
               padding: EdgeInsets.symmetric(horizontal: sizeH20!),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: sizeH22,
                  ),
                  SvgPicture.asset("assets/svgs/folder_icon.svg"),
                  SizedBox(
                    height: sizeH6,
                  ),
                  Text("${box.storageName}"),
                  SizedBox(
                    height: sizeH2,
                  ),
                  Text(
                    "${box.storageStatus}",
                    style: textStyleHints()!.copyWith(fontSize: fontSize13),
                  ),
                  SizedBox(
                    height: sizeH20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: sizeH16,
            ),

            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: sizeW10! , right:sizeW10! ,top: sizeH20!),
                margin: EdgeInsets.symmetric(horizontal: sizeW10!),
                decoration: BoxDecoration(
                    boxShadow: [boxShadowLight()!],
                    color: colorTextWhite,
                    borderRadius: BorderRadius.circular(sizeRadius10!)
                ),
                child: Column(
                  children: [
                    Align(
                      alignment:isArabicLang() ?Alignment.centerRight : Alignment.centerLeft,
                      child: Text(
                        "${tr.schedule_pickup}",
                        style: textStyleHints(),
                      ),
                    ),
                    SizedBox(
                      height: sizeH6,
                    ),
                    SchedulePickup(),
                  ],
                )),
            SizedBox(
              height: sizeH16,
            ),
            addressWidget,
            // Container(
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //       color: scaffoldColor,
            //       borderRadius: BorderRadius.circular(padding6!)),
            //   // margin: EdgeInsets.symmetric(horizontal: sizeH20!),
            //   padding: EdgeInsets.symmetric(horizontal: sizeH20!),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       SizedBox(
            //         height: sizeH22,
            //       ),
            //       Text("Order Summary:"),
            //       !(GetUtils.isNull(box.options) || box.options!.isEmpty)
            //           ? SizedBox(
            //               height: sizeH16,
            //             )
            //           : const SizedBox(),
            //       !(GetUtils.isNull(box.options) || box.options!.isEmpty)
            //           ? Text("${tr.options} :")
            //           : const SizedBox(),
            //       !(GetUtils.isNull(box.options) || box.options!.isEmpty)
            //           ? SizedBox(
            //               height: sizeH10,
            //             )
            //           : const SizedBox(),
            //       !(GetUtils.isNull(box.options) || box.options!.isEmpty)
            //           ? ListView(
            //               padding: EdgeInsets.symmetric(horizontal: padding10!),
            //               shrinkWrap: true,
            //               children: box.options!.map((e) => Text("$e")).toList(),
            //             )
            //           : const SizedBox(),
            //       SizedBox(
            //         height: sizeH22,
            //       ),
            //       Text("${DateUtility.getChatTime(box.modified.toString())}"),
            //       SizedBox(
            //         height: sizeH22,
            //       ),
            //       Text('${box.address?.zone} , ${box.address?.streat} , ${box.address?.buildingNo}'),
            //       SizedBox(
            //         height: sizeH4,
            //       ),
            //       Text("Doha, Qatar"),
            //       SizedBox(
            //         height: sizeH22,
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: sizeH20,
            ),
            optionsList,
            SizedBox(
              height: sizeH20,
            ),
            actionBtn,
            SizedBox(
              height: padding32,
            ),
          ],
        ),
      ),
    );
  }

  onClickBreakSeal() {
    Get.back();
  }

  onClickBringBox() {
    Get.back();

    // Get.bottomSheet(bottomsheet);
  }
}


