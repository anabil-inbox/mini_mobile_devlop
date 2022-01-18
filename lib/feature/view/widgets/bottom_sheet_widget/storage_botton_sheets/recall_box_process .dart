// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/tasks_widgets/box_in_sales_order.dart';
import 'package:inbox_clients/feature/view/screens/profile/address/add_address.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_two_widgets/pickup_address_item.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_two_widgets/schedule_pickup_widget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/bottom_sheet_payment_widaget.dart';
import 'package:inbox_clients/feature/view/widgets/option_item_string.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:logger/logger.dart';

import '../../secondery_button.dart';

class RecallBoxProcessSheet extends StatelessWidget {
  const RecallBoxProcessSheet(
      {Key? key,
      required this.box,
      this.index,
      required this.task,
      required this.boxes})
      : super(key: key);

  final Box? box;
  final int? index;
  static HomeViewModel _homeViewModel = Get.find<HomeViewModel>();
  static StorageViewModel _storageViewModel = Get.find<StorageViewModel>();
  final Task task;
  final List<Box> boxes;

  Widget get actionBtn => Container(
        margin: EdgeInsets.symmetric(horizontal: sizeW10!),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PrimaryButton(
                isExpanded: true,
                isLoading: false,
                onClicked: onClickBreakSeal,
                textButton: task.id == LocalConstance.recallId
                    ? "${tr.recall_now}"
                    : "${tr.pickup}",
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
        padding:
            EdgeInsets.only(left: sizeW10!, right: sizeW10!, top: sizeH20!),
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
            GetBuilder<ProfileViewModle>(
              init: ProfileViewModle(),
              initState: (_) {},
              builder: (log) {
                return GetBuilder<StorageViewModel>(
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
                    return log.userAddress.isNotEmpty
                        ? ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: log.userAddress
                                .map((e) => PickupAddressItem(
                                      address: e,
                                    ))
                                .toList(),
                          )
                        : const SizedBox();
                  },
                );
              },
            ),
            SizedBox(
              height: sizeH10,
            ),
          ],
        ),
      );

  Widget get optionsList => task.vas?.length == 0
      ? const SizedBox.shrink()
      : Container(
          alignment: Alignment.center,
          padding:
              EdgeInsets.only(left: sizeW10!, right: sizeW10!, top: sizeH20!),
          margin: EdgeInsets.symmetric(horizontal: sizeW10!),
          decoration: BoxDecoration(
              boxShadow: [boxShadowLight()!],
              color: colorTextWhite,
              borderRadius: BorderRadius.circular(sizeRadius10!)),
          child: ListView(
            padding: EdgeInsets.all(padding0!),
            shrinkWrap: true,
            // itemCount: task?.vas?.length,
            primary: false,
            // itemBuilder: (context, index) => OptionStringItem(option: task?.vas?[index].toString() ,options :task?.vas),
            children: task.vas!
                .map((e) => OptionStringItem(
                      vas: e,
                    ))
                .toList(),
          ),
        );

  Widget get headerBox => Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: scaffoldColor,
            borderRadius: BorderRadius.circular(padding6!)),
        margin: EdgeInsets.symmetric(horizontal: sizeH10!),
        padding: EdgeInsets.symmetric(horizontal: sizeH20!),
        child: boxes.length == 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: sizeH22,
                  ),
                  SvgPicture.asset("assets/svgs/folder_icon.svg"),
                  SizedBox(
                    height: sizeH6,
                  ),
                  Text("${box?.storageName}"),
                  SizedBox(
                    height: sizeH2,
                  ),
                  Text(
                    "${box?.storageStatus}",
                    style: textStyleHints()!.copyWith(fontSize: fontSize13),
                  ),
                  SizedBox(
                    height: sizeH20,
                  ),
                ],
              )
            : SizedBox(
                height: sizeH140,
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: boxes.map((e) => BoxInSalesOrder(box: e)).toList(),
                ),
              ),
      );
  @override
  Widget build(BuildContext context) {
    print("msg_boxess_length ${boxes.length}");
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: sizeH30,
            ),
            Align(alignment: Alignment.center, child: SpacerdColor()),
            SizedBox(
              height: sizeH30,
            ),
            headerBox,
            SizedBox(
              height: sizeH16,
            ),

            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    left: sizeW10!, right: sizeW10!, top: sizeH20!),
                margin: EdgeInsets.symmetric(horizontal: sizeW10!),
                decoration: BoxDecoration(
                    boxShadow: [boxShadowLight()!],
                    color: colorTextWhite,
                    borderRadius: BorderRadius.circular(sizeRadius10!)),
                child: Column(
                  children: [
                    Align(
                      alignment: isArabicLang()
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
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
            SeconderyButtom(
                textButton: "${tr.add_new_address}",
                onClicked: () {
                  Get.to(() => AddAddressScreen());
                }),
            SizedBox(
              height: sizeH16,
            ),
            TextFormField(
              minLines: 4,
              maxLines: 4,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colorHint2.withOpacity(0.2),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colorHint2.withOpacity(0.2),
                    ),
                  ),
                  labelText: "Notes"),
            ),
            SizedBox(
              height: sizeH16,
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
    if (_storageViewModel.isValidateTask()) {
      Get.back();
      Get.bottomSheet(
          BottomSheetPaymentWidget(
            boxes: boxes,
            box: box!,
            task: task,
          ),
          isScrollControlled: true);
    }

    // try {
    //   var addressTitle = "${_storageViewModel.selectedStore?.addresses?.first.addressTitle??_storageViewModel.selectedAddress?.addressTitle}";
    //   var buildingNo = "${_storageViewModel.selectedStore?.addresses?.first.buildingNo??_storageViewModel.selectedAddress?.buildingNo}";
    //   var geoAddress = "${_storageViewModel.selectedStore?.addresses?.first.geoAddress??_storageViewModel.selectedAddress?.geoAddress}";
    //   String fullAddress = "$addressTitle,$buildingNo,$geoAddress";
    //   String type = "${box.salexOrder}";
    //   var date = _storageViewModel.selectedDateTime;
    //   _storageViewModel.addNewSealsOrder( box , fullAddress ,type,date , itemCode:LocalConstance.recallId);
    // } catch (e) {
    //   Logger().d(e);
    // }
  }

  onClickBringBox() {
    Get.back();
    Logger().d("onClickBringBox");
  }
}
