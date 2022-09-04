import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/home/home_page_holder.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/recived_order_screen.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/my_order_address_widget.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/my_order_box_item.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/new_order_item.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/price_bottom_sheet_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/my_order_view_modle/my_order_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:logger/logger.dart';

import '../../../../util/app_shaerd_data.dart';
import '../../../model/my_order/order_sales.dart';
import '../../../model/storage/payment.dart';
import '../../widgets/bottom_sheet_widget/rate_bottom_sheet.dart';
import 'widgets/my_order_time_widget.dart';
import 'widgets/status_widget.dart';

class OrderDetailesScreen extends StatefulWidget {
  const OrderDetailesScreen(
      {Key? key, required this.orderId, required this.isFromPayment})
      : super(key: key);

  final String orderId;
  final bool isFromPayment;
  static MyOrderViewModle myOrderViewModle =
      Get.put(MyOrderViewModle(), permanent: true);
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override
  State<OrderDetailesScreen> createState() => _OrderDetailesScreenState();
}

class _OrderDetailesScreenState extends State<OrderDetailesScreen> {
  Widget get bodyOrderDetailes {
    //to do this when The Status Is An Task :
    if (GetUtils.isNull(
            OrderDetailesScreen.myOrderViewModle.newOrderSales.orderItems) ||
        OrderDetailesScreen.myOrderViewModle.newOrderSales.orderItems?.length ==
            0 ||
        GetUtils.isNull(OrderDetailesScreen.myOrderViewModle.newOrderSales)) {
      return const SizedBox();
    } else {
      return GetBuilder<MyOrderViewModle>(
        builder: (myOrder) {
          return ListView(
            primary: false,
            shrinkWrap: true,
            children: myOrder.newOrderSales.orderItems!
                .asMap()
                .map((i, element) => MapEntry(i, GetBuilder<MyOrderViewModle>(
                      builder: (controller) {
                        if (element.item == "shipping_sv") {
                          return const SizedBox();
                        } else if (controller.isTask(
                            orderItem: element.item ?? "")) {
                          return NewOrderItemTask(
                            index: i,
                            orderItem: element,
                          );
                        } else {
                          return MyOrderBoxItem(orderItem: element ,sealOrder:myOrder.newOrderSales);
                        }
                      },
                    )))
                .values
                .toList(),
          );
        },
      );
    }
  }

  Future<bool> onWillPop() async {
    if (widget.isFromPayment) {
      Get.off(() => HomePageHolder());
    } else {
      Get.back();
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await OrderDetailesScreen.myOrderViewModle
          .getOrderDetaile(orderId: widget.orderId);
      OrderDetailesScreen.myOrderViewModle.update();

      setState(() {});
      OrderDetailesScreen.homeViewModel.isLoading = false;
      OrderDetailesScreen.homeViewModel.update();
      Logger().w(OrderDetailesScreen.myOrderViewModle.newOrderSales.toJson());
      if (OrderDetailesScreen.myOrderViewModle.newOrderSales.isRated! ==
              false &&
          OrderDetailesScreen.myOrderViewModle.newOrderSales.status ==
              LocalConstance.completed) {
        Get.bottomSheet(
            RateBottomSheet(
              orderSales: OrderDetailesScreen.myOrderViewModle.newOrderSales,
            ),
            isScrollControlled: true);
      }
    });
    //Get.put(MapViewModel()).getStreamLocation(OrderDetailesScreen.myOrderViewModle.newOrderSales);
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
        appBar: CustomAppBarWidget(
          elevation: 0,
          titleWidget: Text(
            "${widget.orderId}",
            style: textStyleAppBarTitle(),
          ),
          isCenterTitle: true,
          onBackBtnClick: () => onWillPop(),
          actionsWidgets: [
            // IconButton(
            //     onPressed: () async{
            //       await OrderDetailesScreen.homeViewModel
            //           .getTaskResponse(
            //           salersOrder: OrderDetailesScreen.myOrderViewModle
            //               .newOrderSales
            //               .orderId ??
            //               "");
            //       setupPaymentMethod();
            //       Get.to(() => ReciverOrderScreen(OrderDetailesScreen.homeViewModel));
            //     },
            //     icon: SvgPicture.asset("assets/svgs/update.svg")),
          ],
        ),
        body: GetBuilder<MyOrderViewModle>(
          builder: (myOrders) {
            if (myOrders.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                primary: true,
                child: GetBuilder<MyOrderViewModle>(
                  builder: (builder) {
                    if (OrderDetailesScreen
                            .myOrderViewModle.newOrderSales.totalPrice ==
                        null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding20!),
                      child: Column(
                        children: [
                          SizedBox(
                            height: sizeH20,
                          ),
                          GetBuilder<MyOrderViewModle>(
                            builder: (cont) {
                              return PriceBottomSheetWidget(
                                backGroundColor: colorBackground,
                                priceTitle: tr.total_price,
                                totalPalance: cont.newOrderSales.totalPrice,
                              );
                            },
                          ),
                          SizedBox(
                            height: sizeH10,
                          ),
                          GetBuilder<MyOrderViewModle>(
                            builder: (build) {
                              return StatusWidget(
                                status: build.newOrderSales.statusName/*status*/,
                                statusOriginal: build.newOrderSales.status/*status*/,
                              );
                            },
                          ),
                          SizedBox(
                            height: sizeH10,
                          ),
                          GetBuilder<MyOrderViewModle>(
                            builder: (controller) {
                              return MyOrderAddressWidget(
                                newOrderSales: controller.newOrderSales,
                              );
                            },
                          ),
                          SizedBox(
                            height: sizeH10,
                          ),
                          GetBuilder<MyOrderViewModle>(
                            builder: (order) {
                              return OrderDateWidget(
                                date:
                                    order.newOrderSales.deliveryDate.toString(),
                              );
                            },
                          ),
                          SizedBox(
                            height: sizeH10,
                          ),
                          bodyOrderDetailes,
                          SizedBox(
                            height: sizeH32,
                          ),
                          // if (widget.isFromPayment)
                          //   PrimaryButton(
                          //       textButton: tr.back_to_home,
                          //       isLoading: false,
                          //       onClicked: () async {
                          //         Get.off(() => HomePageHolder());
                          //       },
                          //       isExpanded: true),
                          if (!widget.isFromPayment) ...[
                            GetBuilder<HomeViewModel>(builder: (logic) {
                              bool isHaveDetailes = true;
                              for (OrderItem item
                                  in myOrders.newOrderSales.orderItems ?? []) {
                                if (item.item!.toLowerCase().contains("cage") ||
                                    item.item!
                                        .toLowerCase()
                                        .contains("space") ||
                                    item.item!.toLowerCase().contains("bulk") ||
                                    myOrders.newOrderSales.proccessType ==
                                        LocalConstance.productSv) {
                                  isHaveDetailes = false;
                                }
                              }
                              return (myOrders.newOrderSales.status ==
                                          LocalConstance.completed ||
                                  myOrders.newOrderSales.status ==
                                      LocalConstance.cancelled   ||
                                      isHaveDetailes == false ||
                                      myOrders.newOrderSales.proccessType ==
                                          LocalConstance.productSv ||
                                      myOrders.newOrderSales.proccessType ==
                                          LocalConstance
                                              .giveawayId /*||
                                  !myOrders.newOrderSales.hasTasks!*/
                                          && myOrders.newOrderSales.customerVisit!)
                                  ? const SizedBox()
                                  : PrimaryButton(
                                      textButton: tr.order_details,
                                      isLoading: logic.isLoading,
                                      onClicked: () async {
                                        await OrderDetailesScreen.homeViewModel
                                            .getTaskResponse(
                                                salersOrder: myOrders
                                                        .newOrderSales
                                                        .orderId ??
                                                    "");
                                        setupPaymentMethod();
                                        Get.to(() => ReciverOrderScreen(logic));
                                      },
                                      isExpanded: true);
                            })
                          ],
                          SizedBox(
                            height: sizeH10,
                          ),
                          Row(
                            children: [
                              if (myOrders.isAllowToCancel(myOrders.newOrderSales)  && !myOrders.newOrderSales.customerVisit!) ...[
                                Expanded(
                                  child: PrimaryButton(
                                      textButton: tr.cancle_order,
                                      isLoading: myOrders.isLoadingCancel,
                                      onClicked: () => _onCancelClick(myOrders),
                                      isExpanded: true),
                                ),
                                if(myOrders.isAllowToEdit(myOrders.newOrderSales))
                                SizedBox(
                                  width: sizeW10,
                                ),
                              ],
                              if (myOrders.isAllowToEdit(myOrders.newOrderSales) && !myOrders.newOrderSales.customerVisit!) ...[
                                Expanded(
                                  child: PrimaryButton(
                                      colorBtn: colorBtnGray,
                                      colorText: colorBlack,
                                      textButton: tr.edit_order,
                                      isLoading: false,
                                      onClicked: () => _onEditClick(myOrders),
                                      isExpanded: true),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(
                            height: sizeH10,
                          ),
                          if (widget.isFromPayment)
                            PrimaryButton(
                                textButton: tr.back_to_home,
                                isLoading: false,
                                onClicked: () async {
                                  Get.off(() => HomePageHolder());
                                },
                                isExpanded: true),
                          SizedBox(
                            height: sizeH32,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  setupPaymentMethod() {
    OrderDetailesScreen.storageViewModel.selectedPaymentMethod = PaymentMethod(
      id: OrderDetailesScreen.homeViewModel.operationTask.paymentMethod,
      name: OrderDetailesScreen.homeViewModel.operationTask.paymentMethod,
    );
    OrderDetailesScreen.storageViewModel.update();
  }

  _onCancelClick(MyOrderViewModle myOrders) {
    myOrders.cancelOrder(myOrders.newOrderSales , OrderDetailesScreen.homeViewModel, OrderDetailesScreen.storageViewModel);
  }

  _onEditClick(MyOrderViewModle myOrders) {
    myOrders.editOrder(myOrders.newOrderSales , OrderDetailesScreen.homeViewModel, OrderDetailesScreen.storageViewModel);
  }
}
