import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/profile/invoices_model.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/order_details_screen.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/order_detailes_screen_deleted.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:intl/intl.dart';

import '../../../../../../util/app_color.dart';
import '../../../../../../util/app_dimen.dart';
import '../../../../../../util/app_shaerd_data.dart';
import '../../../../../../util/constance/constance.dart';
import '../../../../../view_model/home_view_model/home_view_model.dart';
import '../../../../../view_model/item_view_modle/item_view_modle.dart';
import '../../../../screens/items/item_screen.dart';
import '../../../../screens/items/widgets/notifay_for_new_storage.dart';
import '../../../primary_button.dart';

class InvoicesDetailsBottomSheet extends StatelessWidget {
  const InvoicesDetailsBottomSheet({
    Key? key,
    required this.invoices,
  }) : super(key: key);

  final InvoicesData invoices;
  HomeViewModel get homeViewModel =>  Get.find<HomeViewModel>();
  ItemViewModle get itemViewModle =>  Get.find<ItemViewModle>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModle>(
        init: ProfileViewModle(),
        initState: (state) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            state.controller?.getInvoiceDetails(invoices.name);
          });
        },
        builder: (logic) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: sizeW15!),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: colorBackground,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(padding30!)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: sizeH16,
                ),
                SpacerdColor(),
                SizedBox(
                  height: sizeH24,
                ),
                Text("${invoices.name}"),
                SizedBox(
                  height: sizeH24,
                ),
                if (logic.invoicesDetailsLoading) ...[
                  Center(
                    child: CircularProgressIndicator(
                      color: colorPrimary,
                    ),
                  )
                ] else if (!logic.invoicesDetailsLoading &&
                    logic.invoicesDetailsData.id == null) ...[
                  Center(
                    child: Text(tr.no_details_for_this_invoice),
                  )
                ] else ...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        Text(
                          tr.total_days,
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                  /*color: colorPrimary,*/
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize16),
                        ),
                        Spacer(),
                        Text(
                          "${logic.invoicesDetailsData.totalDays}",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                                  color: colorPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize16),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        Text(
                          tr.total,
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                  /*color: colorPrimary,*/
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize16),
                        ),
                        Spacer(),
                        Text(
                          getPriceWithFormate(
                              price: logic.invoicesDetailsData.total ?? 0),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                                  color: colorPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize16),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        Text(
                          tr.invoice_date,
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                  /*color: colorPrimary,*/
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize16),
                        ),
                        Spacer(),
                        Text(
                          "${logic.invoicesDetailsData.from != null ?"${DateFormat("yyyy-MM-dd").format(logic.invoicesDetailsData.from!)}  -" : ""} ${logic.invoicesDetailsData.to != null ?DateFormat("yyyy-MM-dd").format(logic.invoicesDetailsData.to!) : ""}",
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                  /* color: colorPrimary,*/
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize14),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {

                    },
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        children: [
                          Text(
                            tr.subscriptions,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                // color: colorInWarehouse,
                                fontWeight: FontWeight.bold,
                                fontSize: fontSize16),
                          ),
                          Spacer(),
                          Text(
                            "${logic.invoicesDetailsData.subscription??""}",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                // color: colorInWarehouse,
                                fontWeight: FontWeight.bold,
                                fontSize: fontSize14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // InkWell(
                  //   onTap: ()=> Get.off(OrderDetailesScreen(orderId: logic.invoicesDetailsData.salesOrder??"", isFromPayment: false,)),
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  //     child: Row(
                  //       children: [
                  //         Text(
                  //          tr.open_order ,
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .headline6
                  //               ?.copyWith(
                  //                   color: colorInWarehouse,
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: fontSize16),
                  //         ),
                  //         Spacer(),
                  //         Text(
                  //           "${logic.invoicesDetailsData.salesOrder}",
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .headline6
                  //               ?.copyWith(
                  //                   color: colorInWarehouse,
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: fontSize14),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                    onTap: () {
                    //   Get.off(OrderDetailesScreen(
                    //   orderId: logic.invoicesDetailsData.salesOrder ?? "",
                    //   isFromPayment: false,
                    // ));
                      var firstWhere = homeViewModel.userBoxess.toList().firstWhere((element) => element.id == logic.invoicesDetailsData.serialNo);
                      var index =homeViewModel.userBoxess.toList().indexOf(firstWhere);
                      if (homeViewModel.userBoxess.toList()[index].storageStatus ==  LocalConstance.boxOnTheWay &&
                          !homeViewModel.userBoxess.toList()[index].isPickup!) {
                        Get.bottomSheet(
                            NotifayForNewStorage(
                                box: homeViewModel.userBoxess.toList()[index],
                                showQrScanner: true,
                                index: index),
                            isScrollControlled: true);
                        homeViewModel.update();
                      } else {
                        Get.to(() => ItemScreen(
                          box: homeViewModel.userBoxess.toList()[index],
                          getBoxDataMethod: () async {
                            await itemViewModle.getBoxBySerial(
                                serial: homeViewModel.userBoxess
                                    .toList()[index]
                                    .serialNo!);
                          },
                        ));
                        homeViewModel.update();
                        itemViewModle.update();
                      }
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        children: [
                          Text(
                            tr.box_name,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: colorInWarehouse,
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSize16),
                          ),
                          Spacer(),
                          Text(
                            "${logic.invoicesDetailsData.serialNo??""}",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: colorInWarehouse,
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSize14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                SizedBox(
                  height: sizeH12,
                ),
                PrimaryButton(
                    textButton: tr.ok,
                    isLoading: false,
                    onClicked: () {
                      Get.back();
                    },
                    isExpanded: true),
                SizedBox(
                  height: sizeH12,
                ),
              ],
            ),
          );
        });
  }
}
// if (operationsBox?.saleOrder != null &&
//     operationsBox!.saleOrder!.isNotEmpty) ...[
// SizedBox(
//   width: sizeW10,
// ),
// InkWell(
//     onTap: () {
//       viewModel?.getInvoiceUrl(invoices.paymentEntryId,
//           operationsBox: operationsBox);
//     },
//     child: Icon(Icons.payment)),
// ],
