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
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/tasks_widgets/box_in_sales_order.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/tasks_widgets/box_item_in_sales_order.dart';
import 'package:inbox_clients/feature/view/screens/profile/address/add_address.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/quantity_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/edit_new_storage/widget/bottom_sheet_storage_categorires.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/edit_new_storage/widget/space_and_quantity_edit_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_three_widgets/payment_widget.dart';
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

class EditNewStorageView extends StatefulWidget {
  //editNewStorageView
  EditNewStorageView({
    Key? key,
    required this.newOrderSales,
    required this.viewModel,
  }) : super(key: key);


  final OrderSales newOrderSales;
  final MyOrderViewModle viewModel;

  @override
  State<EditNewStorageView> createState() => _EditNewStorageViewState();
}

class _EditNewStorageViewState extends State<EditNewStorageView> {
  static HomeViewModel _homeViewModel = Get.find<HomeViewModel>();
  static StorageViewModel _storageViewModel = Get.find<StorageViewModel>();

  // static MyOrderViewModle _myOrderViewModle = Get.put/*<MyOrderViewModle>*/(MyOrderViewModle());
  static ProfileViewModle _profileViewModle = Get.put /*<ProfileViewModle>*/(
      ProfileViewModle());

  // num initPrice = 0;
  Widget get actionBtn =>
      GetBuilder<MyOrderViewModle>(
          init: MyOrderViewModle(),
          builder: (logic) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: sizeW10!),
              child: PrimaryButton(
                  isExpanded: true,
                  isLoading: logic.isLoading ,
                  onClicked: () => onClickUpdate(logic),
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
                  initState: (_) {

                  },
                  builder: (log) {
                    return GetBuilder<StorageViewModel>(
                      init: StorageViewModel(),
                      initState: (_) {
                        WidgetsBinding.instance
                            ?.addPostFrameCallback((timeStamp) {
                          _storageViewModel.selectedPaymentMethod = null;
                          _storageViewModel.selectedDateTime = null;
                          _storageViewModel.selectedDay = null;
                          _storageViewModel.selectedStringOption.clear();
                          _storageViewModel.getStoreAddress();
                          _storageViewModel.selectedDateTime =
                              widget.newOrderSales.deliveryDate;
                          _storageViewModel.selectedDay = getDayByNumber(
                            selectedDateTime: _storageViewModel.myOrderViewModel.newOrderSales.deliveryDate!,
                          ).first;
                          _storageViewModel.selectedDayEdit = getDayByNumber(
                            selectedDateTime: _storageViewModel.myOrderViewModel.newOrderSales.deliveryDate!,
                          ).first;
                          Logger().d("_date_${_storageViewModel.selectedDayEdit?.toJson()}");
                          _storageViewModel.selctedWorksHours = getDayByNumber(
                            selectedDateTime: _storageViewModel.myOrderViewModel.newOrderSales.deliveryDate!,
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
                            if (widget.newOrderSales.orderShippingAddress !=
                                null &&
                                widget.newOrderSales
                                    .orderShippingAddress!.isNotEmpty) {
                              try {
                                var address = log.userAddress.toList()
                                    .firstWhere(
                                        (element) =>
                                    element.id != null &&
                                        element.id!.toLowerCase() ==
                                            widget.newOrderSales
                                                .orderShippingAddress!
                                                .toLowerCase());
                                _storageViewModel.selectedAddress = address;
                                _storageViewModel.update();
                              } catch (e) {
                                var address = log.userAddress
                                    .toList()
                                    .first;
                                _storageViewModel.selectedAddress = address;
                                _storageViewModel.update();
                              }
                            }
                            if (widget.newOrderSales.orderWarehouseAddress !=
                                null &&
                                widget.newOrderSales.orderWarehouseAddress
                                    .toString()
                                    .isNotEmpty &&
                                _storageViewModel.storeAddress.isNotEmpty) {
                              try {
                                try {
                                  var address = _storageViewModel.storeAddress
                                      .toList().firstWhere((element) =>
                                  element.id!.toLowerCase() ==
                                      widget.newOrderSales
                                          .orderWarehouseAddress!
                                          .toLowerCase());
                                  _storageViewModel.selectedStore = address;
                                  _storageViewModel.update();
                                } catch (e) {
                                  var address = _storageViewModel.storeAddress
                                      .toList()
                                      .first;
                                  _storageViewModel.selectedStore = address;
                                  _storageViewModel.update();
                                  print(e);
                                }
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
                          height: log.userAddress.isNotEmpty &&
                              log.userAddress.length >= 3
                              ? sizeH270
                              : sizeH100,
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
          // SizedBox(
          //   height: sizeH90,
          // ),
          SizedBox(
            height: sizeH20,
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
        child: (widget.newOrderSales.orderItems?.length == 0)
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
            Text("${widget.newOrderSales.orderId}"),
            SizedBox(
              height: sizeH2,
            ),
            Text(
              "${widget.newOrderSales.statusName}",
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
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.viewModel.initPrice = 0;
      widget.viewModel.totalBalance = 0;
      if( widget.viewModel.newOrderSales.orderItems != null) {
        for (var item in widget.viewModel.newOrderSales.orderItems!) {
          item.quantity = item.oldQuantity;
        }
      }
      // widget.viewModel.handleTotalPrice();
      widget.viewModel..update();
      widget.viewModel
        .newOrderSales.orderItems?.forEach((element) {
          widget.viewModel
            .initPrice =
                widget.viewModel.initPrice +
                    (element.price! * element.quantity!);
        });


      // widget.viewModel..update();
      // Logger().wtf(widget.viewModel..initPrice);
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _storageViewModel.clearNewStorageData();
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: CustomAppBarWidget(
        isCenterTitle: true,
        titleWidget: CustomTextView(
          txt: "${widget.newOrderSales.orderId}",
          textStyle: textStyleAppBarTitle(),
          maxLine: Constance.maxLineOne,
        ),
      ),
      body: GetBuilder<MyOrderViewModle>(
          init: MyOrderViewModle(),
          builder: (logic) {
        return Padding(
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
                    // GetBuilder<MyOrderViewModle>(
                    //     init: MyOrderViewModle(),
                    //
                    //     builder: (logic) {
                    //       return 
                    //         Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           SeconderyButtom(
                    //               textButton: "${tr.add_item}",
                    //               isExpanded: true,
                    //               onClicked: () {
                    //                 Logger().wtf(logic.newOrderSales.toJson());
                    //
                    //                 // if( logic.newOrderSales.orderItems != null &&
                    //                 //     logic.newOrderSales.orderItems!.isNotEmpty &&
                    //                 //     newOrderSales.orderItems != null &&
                    //                 //     newOrderSales.orderItems!.isNotEmpty){
                    //                 //   var orderItem = logic.newOrderSales.orderItems?.firstWhere((element) => element.storageType != null );
                    //                 //   var firstWhere = newOrderSales.orderItems?.firstWhere((element) => element.storageType != null);
                    //                 //   if(orderItem?.storageType.toString() == firstWhere?.storageType.toString()){
                    //                 //     var storageCategories = _storageViewModel.storageCategoriesList.firstWhere((element) {
                    //                 //       Logger().e(element.id);
                    //                 //       return element.id == orderItem?.item;
                    //                 //     });
                    //                 //     _storageViewModel.showMainStorageBottomSheet(
                    //                 //         storageCategoriesData: storageCategories,
                    //                 //         isFromOrderEdit:true);
                    //                 //   }
                    //                 // }
                    //
                    //                 if (logic.newOrderSales.orderItems != null &&
                    //                     logic.newOrderSales.orderItems!
                    //                         .isNotEmpty) {
                    //                   var orderItem = logic.newOrderSales
                    //                       .orderItems?.firstWhere((element) =>
                    //                   element.storageType
                    //                       .toString()
                    //                       .isNotEmpty);
                    //                   Get.bottomSheet(
                    //                       StorageCategoriesBottomSheet(
                    //                         orderItem: orderItem,
                    //                         onSelectStorageCategoriesData: (
                    //                             StorageCategoriesData storageCategoriesData) async {
                    //                           Get.back();
                    //                           _storageViewModel
                    //                               .showMainStorageBottomSheet(
                    //                               storageCategoriesData: storageCategoriesData,
                    //                               isFromOrderEdit: true);
                    //
                    //                           // Get.back();
                    //                         },
                    //                       ));
                    //                 }
                    //
                    //
                    //                 // _storageViewModel.showMainStorageBottomSheet(
                    //                 //           storageCategoriesData: _storageViewModel.storageCategoriesList.firstWhere((element) {
                    //                 //             return element.items.toString().contains("Regular Box-in");
                    //                 //           })/*[3]*/,
                    //                 //           isFromOrderEdit:true);
                    //                 //  if(logic.newOrderSales.orderItems!.where((element) => element.itemName == "Regular Box" ||element.itemName ==  "Standard Box").isNotEmpty){
                    //                 //   _storageViewModel.showMainStorageBottomSheet(
                    //                 //       storageCategoriesData: _storageViewModel.storageCategoriesList.firstWhere((element) {
                    //                 //         return element.id.toString().contains("Regular Box-in");
                    //                 //       })/*[3]*/,
                    //                 //       isFromOrderEdit:true);
                    //                 // }else{
                    //                 //   _storageViewModel.showMainStorageBottomSheet(
                    //                 //       storageCategoriesData: _storageViewModel.storageCategoriesList.firstWhere((element) {
                    //                 //         return !element.id.toString().contains("Regular Box-in");
                    //                 //       })/*_storageViewModel.storageCategoriesList[2]*/,
                    //                 //       isFromOrderEdit:true);
                    //                 // }
                    //               }),
                    //           SizedBox(
                    //             height: sizeH16,
                    //           ),
                    //           if (logic.newOrderSales.orderItems != null &&
                    //               logic.newOrderSales.orderItems!.isNotEmpty) ...[
                    //             ListView.builder(
                    //                 physics: NeverScrollableScrollPhysics(),
                    //                 shrinkWrap: true,
                    //                 itemCount:
                    //                 logic.newOrderSales.orderItems?.length,
                    //                 itemBuilder: (context, index) {
                    //                   return SpaceAndQuantityEditWidget(
                    //                     orderItem: logic
                    //                         .newOrderSales.orderItems![index],
                    //                     index: index,
                    //                     arraySize: logic
                    //                         .newOrderSales.orderItems?.length,
                    //                     viewModel: logic,
                    //                     storageViewModel: _storageViewModel,
                    //                   );
                    //                 }),
                    //           ],
                    //         ],
                    //       );
                    //     }),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SeconderyButtom(
                            textButton: "${tr.add_item}",
                            isExpanded: true,
                            onClicked: () {
                              Logger().wtf(logic.newOrderSales.toJson());

                              // if( logic.newOrderSales.orderItems != null &&
                              //     logic.newOrderSales.orderItems!.isNotEmpty &&
                              //     newOrderSales.orderItems != null &&
                              //     newOrderSales.orderItems!.isNotEmpty){
                              //   var orderItem = logic.newOrderSales.orderItems?.firstWhere((element) => element.storageType != null );
                              //   var firstWhere = newOrderSales.orderItems?.firstWhere((element) => element.storageType != null);
                              //   if(orderItem?.storageType.toString() == firstWhere?.storageType.toString()){
                              //     var storageCategories = _storageViewModel.storageCategoriesList.firstWhere((element) {
                              //       Logger().e(element.id);
                              //       return element.id == orderItem?.item;
                              //     });
                              //     _storageViewModel.showMainStorageBottomSheet(
                              //         storageCategoriesData: storageCategories,
                              //         isFromOrderEdit:true);
                              //   }
                              // }



                              if (logic.newOrderSales.orderItems != null &&
                                  logic.newOrderSales.orderItems!.isNotEmpty) {
                                var orderItem = logic.newOrderSales.orderItems?.firstWhere((element) =>
                                element.storageType.toString().isNotEmpty);
                                Get.bottomSheet(
                                    StorageCategoriesBottomSheet(
                                      orderItem: orderItem,
                                      onSelectStorageCategoriesData: (
                                          StorageCategoriesData storageCategoriesData) async {
                                        Get.back();
                                        _storageViewModel
                                            .showMainStorageBottomSheet(
                                            storageCategoriesData: storageCategoriesData,
                                            isFromOrderEdit: true);

                                        // Get.back();
                                      },
                                    ));
                              }


                              // _storageViewModel.showMainStorageBottomSheet(
                              //           storageCategoriesData: _storageViewModel.storageCategoriesList.firstWhere((element) {
                              //             return element.items.toString().contains("Regular Box-in");
                              //           })/*[3]*/,
                              //           isFromOrderEdit:true);
                              //  if(logic.newOrderSales.orderItems!.where((element) => element.itemName == "Regular Box" ||element.itemName ==  "Standard Box").isNotEmpty){
                              //   _storageViewModel.showMainStorageBottomSheet(
                              //       storageCategoriesData: _storageViewModel.storageCategoriesList.firstWhere((element) {
                              //         return element.id.toString().contains("Regular Box-in");
                              //       })/*[3]*/,
                              //       isFromOrderEdit:true);
                              // }else{
                              //   _storageViewModel.showMainStorageBottomSheet(
                              //       storageCategoriesData: _storageViewModel.storageCategoriesList.firstWhere((element) {
                              //         return !element.id.toString().contains("Regular Box-in");
                              //       })/*_storageViewModel.storageCategoriesList[2]*/,
                              //       isFromOrderEdit:true);
                              // }
                            }),
                        SizedBox(
                          height: sizeH16,
                        ),
                        if (logic.newOrderSales.orderItems != null &&
                            logic.newOrderSales.orderItems!.isNotEmpty) ...[
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                              logic.newOrderSales.orderItems?.length,
                              itemBuilder: (context, index) {
                                return SpaceAndQuantityEditWidget(
                                  orderItem: logic
                                      .newOrderSales.orderItems![index],
                                  index: index,
                                  arraySize: logic
                                      .newOrderSales.orderItems?.length,
                                  viewModel: logic,
                                  storageViewModel: _storageViewModel,
                                );
                              }),
                        ],
                      ],
                    ),

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
                                /*"${tr.schedule_pickup}"*/
                                "${tr.delivery_date}",
                                style: textStyleHints(),
                              ),
                            ),
                            SizedBox(
                              height: sizeH6,
                            ),
                            SchedulePickup(isFromEdit:true),
                          ],
                        )),
                    SizedBox(
                      height: sizeH16,
                    ),
                    addressWidget,
                    SizedBox(
                      height: sizeH10,
                    ),
                    if(widget.viewModel.totalBalance >
                        widget.viewModel.initPrice)...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                            width: double.infinity,
                            child: PaymentWidget(isRecivedOrderPayment: false)),
                      ),
                      SizedBox(
                        height: sizeH90,
                      ),
                    ],
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
                      height: padding69,
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
        );
      }),
    );
  }

  onClickUpdate(MyOrderViewModle logic) async {
    if(logic.totalBalance > logic.initPrice){
      if(_storageViewModel.selectedPaymentMethod == null || GetUtils.isNull(_storageViewModel.selectedPaymentMethod)){
      snackError(
          "${tr.error_occurred}", "${tr.you_have_to_select_payment_method}");
        return ;
      }

      if(_storageViewModel.selectedPaymentMethod != null &&  _storageViewModel.selectedPaymentMethod?.id  == null){
        snackError(
            "${tr.error_occurred}", "${tr.you_have_to_select_payment_method}");
        return ;
      }

      await handlePayment(logic);

    }else{
      widget.viewModel.editOrderRequest(
          _storageViewModel, _homeViewModel,
          isNewStorage: true);
    }

    // if(newOrderSales.paymentMethod == LocalConstance.bankCard){
    //
    // }else {
    //   widget.viewModel.editOrderRequest(_storageViewModel, _homeViewModel,
    //    isNewStorage: true);
    // }
  }

  Future<void> handlePayment(MyOrderViewModle logic)async {
    if (_storageViewModel.selectedPaymentMethod?.id == Constance.cashId ||
        _storageViewModel.selectedPaymentMethod?.id ==
            Constance.pointOfSaleId) {
      widget.viewModel.editOrderRequest(
          _storageViewModel, _homeViewModel, isNewStorage: true);
    } else if (_storageViewModel.selectedPaymentMethod?.id ==
        Constance.bankTransferId) {
      //todo here i will check if user upload or select image i will allow to send request
      widget.viewModel.editOrderRequest(
          _storageViewModel, _homeViewModel, isNewStorage: true);
    } else
    if ((_storageViewModel.selectedPaymentMethod?.id == Constance.walletId)) {
      if (num.parse(_profileViewModle.myWallet.balance.toString()) > (logic.totalBalance /*- logic.initPrice*/)) {
        widget.viewModel.editOrderRequest(
            _storageViewModel, _homeViewModel, isNewStorage: true);
      } else {
        snackError("", tr.wallet_balance_is_not_enough);
      }
    } else {
       logic.isLoading = true;
      logic.update();
      await _storageViewModel.goToPaymentMethod(
          isFromEditOrder: true,
          cartModels: [],
          isOrderProductPayment: false,
          isFromCart: false,
          isFromNewStorage: true,
          editOrder: () =>
              widget.viewModel.editOrderRequest(
                  _storageViewModel, _homeViewModel,
                  isNewStorage: true),
          storageViewModel: _storageViewModel,
          amount: (logic.totalBalance /*- logic.initPrice*/));
      logic.isLoading = false;
      logic.update();
    }
  }
}
