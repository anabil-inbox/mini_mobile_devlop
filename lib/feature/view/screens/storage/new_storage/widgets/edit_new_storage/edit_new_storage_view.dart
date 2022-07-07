// ignore_for_file: unused_field, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/tasks_widgets/box_in_sales_order.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/tasks_widgets/box_item_in_sales_order.dart';
import 'package:inbox_clients/feature/view/screens/profile/address/add_address.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/edit_new_storage/widget/space_and_quantity_edit_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_two_widgets/pickup_address_item.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_two_widgets/schedule_pickup_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/bottom_sheet_payment_widaget.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/option_item_string.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button%20copy.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/feature/view_model/cart_view_model/cart_view_model.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/feature/view_model/my_order_view_modle/my_order_view_modle.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/local_database/model/cart_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:logger/logger.dart';

class EditNewStorageView extends StatelessWidget {
  //editNewStorageView
  EditNewStorageView({
    Key? key,
    required this.newOrderSales,
    required this.viewModel,
  }) : super(key: key);

  static HomeViewModel _homeViewModel = Get.find<HomeViewModel>();
  static StorageViewModel _storageViewModel = Get.find<StorageViewModel>();

  final OrderSales newOrderSales;
  final MyOrderViewModle viewModel;

  Widget get actionBtn =>
      GetBuilder<MyOrderViewModle>(
          init: MyOrderViewModle(),
          builder: (logic) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: sizeW10!),
              child: PrimaryButton(
                  isExpanded: true,
                  isLoading: logic.isLoading,
                  onClicked: onClickUpdate,
                  textButton: "${tr.update}"),
            );
          });

  Widget get addressWidget =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
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
                        WidgetsBinding.instance
                            ?.addPostFrameCallback((timeStamp) {
                          _storageViewModel.selectedDateTime = null;
                          _storageViewModel.selectedDay = null;
                          _storageViewModel.selectedStringOption.clear();
                          _storageViewModel.getStoreAddress();
                          _storageViewModel.selectedDateTime =
                              newOrderSales.deliveryDate;
                          _storageViewModel.selectedDay = getDayByNumber(
                            selectedDateTime: newOrderSales.deliveryDate!,
                          ).first;
                          _storageViewModel.selctedWorksHours = getDayByNumber(
                            selectedDateTime: newOrderSales.deliveryDate!,
                          );
                          _storageViewModel.update();
                          // var orderWarehouseAddress =
                          //     newOrderSales.orderWarehouseAddress;
                          // var orderShippingAddress =
                          //     newOrderSales.orderShippingAddress;
                          // Logger().wtf(
                          //     "orderWarehouseAddress : $orderWarehouseAddress ,"
                          //         " orderShippingAddress : $orderShippingAddress  \n"
                          //         " ${log.userAddress.toString()} \n"
                          //         " ${_storageViewModel.storeAddress.toString()}");
                          if (log.userAddress.isNotEmpty) {
                            if (newOrderSales.orderShippingAddress != null &&
                                newOrderSales
                                    .orderShippingAddress!.isNotEmpty) {
                              var address = log.userAddress.toList().firstWhere(
                                      (element) =>
                                  element.id!.toLowerCase() ==
                                      newOrderSales.orderShippingAddress!
                                          .toLowerCase());
                              _storageViewModel.selectedAddress = address;
                              _storageViewModel.update();
                            }
                            if (newOrderSales.orderWarehouseAddress != null &&
                                newOrderSales.orderWarehouseAddress
                                    .toString()
                                    .isNotEmpty &&
                                _storageViewModel.storeAddress.isNotEmpty) {
                              try {
                                var address = _storageViewModel.storeAddress
                                    .toList()
                                    .firstWhere((element) =>
                                element.id!.toLowerCase() ==
                                    newOrderSales.orderWarehouseAddress!
                                        .toLowerCase());
                                _storageViewModel.selectedStore = address;
                                _storageViewModel.update();
                              } catch (e) {
                                print(e);
                                Logger().e(e);
                              }
                            }
                          }
                          // if (isFromCart!) {
                          //   _storageViewModel.selectedDateTime = DateTime.parse(
                          //       "${cartModel?.orderTime?.delivery.toString()}");
                          //   _storageViewModel.selectedAddress =
                          //       cartModel!.address;
                          //   _storageViewModel.selectedDay =
                          //       cartModel!.orderTime;
                          //   task.vas = cartModel?.task?.vas;
                          //   task.areaZones = cartModel?.task?.areaZones;
                          // }
                        });
                      },
                      builder: (_) {
                        return log.userAddress.isNotEmpty
                            ? SizedBox(
                          height: sizeH270,
                          child: ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: log.userAddress
                                .map((e) =>
                                PickupAddressItem(
                                  address: e,
                                ))
                                .toList(),
                          ),
                        )
                            : const SizedBox();
                      },
                    );
                  },
                ),
                SizedBox(
                  height: sizeH20,
                ),
              ],
            ),
          ),
          SizedBox(
            height: sizeH10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding10!),
            child: SeconderyButtom(
                textButton: "${tr.add_new_address}",
                isExpanded: true,
                onClicked: () {
                  Get.to(() => AddAddressScreen());
                }),
          ),
        ],
      );

  Widget get headerBox =>
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: scaffoldColor,
            borderRadius: BorderRadius.circular(padding6!)),
        margin: EdgeInsets.symmetric(horizontal: sizeH10!),
        padding: EdgeInsets.symmetric(horizontal: sizeH20!),
        child: (newOrderSales.orderItems?.length == 0)
            ? Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: sizeH22,
            ),
            SvgPicture.asset("assets/svgs/folder_icon.svg"),
            SizedBox(
              height: sizeH6,
            ),
            Text("${newOrderSales.orderId}"),
            SizedBox(
              height: sizeH2,
            ),
            Text(
              "${newOrderSales.status}",
              style: textStyleHints()!.copyWith(fontSize: fontSize13),
            ),
            SizedBox(
              height: sizeH20,
            ),
          ],
        )
            : const SizedBox(),
      );

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: CustomAppBarWidget(
        isCenterTitle: true,
        titleWidget: CustomTextView(
          txt: "${newOrderSales.orderId}",
          textStyle: textStyleAppBarTitle(),
          maxLine: Constance.maxLineOne,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeW15!),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: sizeH16,
                  ),
                  headerBox,
                  SizedBox(
                    height: sizeH16,
                  ),
                  GetBuilder<MyOrderViewModle>(
                      init: MyOrderViewModle(),
                      builder: (logic) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SeconderyButtom(
                            textButton: "${tr.add_item}",
                            isExpanded: true,
                            onClicked: () {
                              _storageViewModel.showMainStorageBottomSheet(
                                  storageCategoriesData: _storageViewModel.storageCategoriesList[3],
                                  isFromOrderEdit:true);
                            }),

                        SizedBox(
                          height: sizeH16,
                        ),
                        if (logic.newOrderSales.orderItems != null &&
                            logic.newOrderSales.orderItems!.isNotEmpty) ...[
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: logic.newOrderSales.orderItems?.length,
                              itemBuilder: (context, index) {
                                return SpaceAndQuantityEditWidget(
                                  orderItem: logic.newOrderSales.orderItems![index],
                                  index: index,
                                  arraySize : logic.newOrderSales.orderItems?.length,
                                  viewModel: logic,
                                );
                              }),
                        ],

                      ],
                    );
                  }),

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
                  SizedBox(
                    height: sizeH10,
                  ),
                  // TextFormField(
                  //   minLines: 2,
                  //   maxLines: 2,
                  //   decoration: InputDecoration(
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: colorHint2.withOpacity(0.2),
                  //         ),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: colorHint2.withOpacity(0.2),
                  //         ),
                  //       ),
                  //       labelText: tr.notes),
                  // ),
                  // SizedBox(
                  //   height: sizeH16,
                  // ),
                  // actionBtn,
                  SizedBox(
                    height: padding32,
                  ),
                ],
              ),
            ),
            PositionedDirectional(
                bottom: sizeH32,
                start: sizeW15,
                end: sizeW15,
                child: actionBtn),
          ],
        ),
      ),
    );
  }

  onClickUpdate() {
    viewModel.editOrderRequest(_storageViewModel, _homeViewModel , isNewStorage:true);
  }
}
