import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/options_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/period_storage_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/price_bottom_sheet_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/quantity_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/my_order_view_modle/my_order_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:showcaseview/showcaseview.dart';

class QuantityStorageBottomSheet extends StatefulWidget {
  const QuantityStorageBottomSheet({
    Key? key,
    required this.storageCategoriesData,
    this.isUpdate = false,
    required this.index,
    this.isFromOrderEdit = false,
  }) : super(key: key);

  final StorageCategoriesData storageCategoriesData;
  final bool isUpdate;
  final int index;
  final bool? isFromOrderEdit;

  @override
  State<QuantityStorageBottomSheet> createState() =>
      _QuantityStorageBottomSheetState();
}

class _QuantityStorageBottomSheetState
    extends State<QuantityStorageBottomSheet> {

  static StorageViewModel get storageViewModel =>
      Get.put(StorageViewModel(), permanent: true);
  MyOrderViewModle get orderViewModel => Get.find<MyOrderViewModle>();

  //  StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      // Get.put(StorageViewModel());
      storageViewModel.intialBalance(
          storageCategoriesData: widget.storageCategoriesData);
      storageViewModel.showQtyShowCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return ShowCaseWidget(
      onFinish: ()async{
        await SharedPref.instance.setFirstQtyKey(true);
      },
      builder: Builder(
        builder: (context) {
          storageViewModel.setContext(context);
          return SingleChildScrollView(
            primary: true,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(padding30!)),
                color: colorTextWhite,
              ),
              child: GetBuilder<StorageViewModel>(
                init: StorageViewModel(),
                initState: (_) {},
                builder: (builder) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: sizeH20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(onTap:()=> Get.back(),child: Icon(Icons.close , color: colorBlack,),),
                          Container(
                            height: sizeH5,
                            width: sizeW50,
                            decoration: BoxDecoration(
                                color: colorSpacer,
                                borderRadius: BorderRadius.circular(padding3)),
                          ),
                          InkWell(onTap:()=> Get.back(),child: Icon(Icons.close , color: colorTrans,),),
                        ],
                      ),
                      SizedBox(
                        height: sizeH20,
                      ),
                      Text(widget.storageCategoriesData.storageName ?? ""),
                      SizedBox(
                        height: sizeH20,
                      ),
                      PriceBottomSheetWidget(),
                      SizedBox(
                        height: sizeH16,
                      ),
                     /* Showcase(
                        disableAnimation: Constance.showCaseDisableAnimation,
                        shapeBorder: RoundedRectangleBorder(),
                        radius: BorderRadius.all(Radius.circular(Constance.showCaseRecBorder)),
                        showArrow: Constance.showCaseShowArrow,
                        overlayPadding: EdgeInsets.all(5),
                        blurValue:Constance.showCaseBluer ,
                        description: tr.qty_btn_show_case,
                        key: builder.qtyShowCaseKey,
                        child:*/ QuantityWidget(
                          value: storageViewModel.quantity,
                          increasingFunction: () {
                            builder.increaseQuantity(
                                storageCategoriesData: widget.storageCategoriesData);
                          },
                          mineassingFunction: () {
                            builder.minesQuantity(
                                storageCategoriesData: widget.storageCategoriesData);
                          },
                          quantityTitle: "${tr.count_of_boxes}",
                          storageCategoriesData: widget.storageCategoriesData,
                        ),
                      /*),*/
                      SizedBox(
                        height: sizeH16,
                      ),
                      /*Showcase(
                        disableAnimation: Constance.showCaseDisableAnimation,
                        shapeBorder: RoundedRectangleBorder(),
                        radius: BorderRadius.all(Radius.circular(Constance.showCaseRecBorder)),
                        showArrow: Constance.showCaseShowArrow,
                        overlayPadding: EdgeInsets.all(5),
                        blurValue:Constance.showCaseBluer ,
                        description: tr.subscriptions_btn_show_case,
                        key: builder.subscriptionsShowCaseKey,
                        child:*/ PeriodStorageWidget(
                          storageCategoriesData: widget.storageCategoriesData,
                        ),
                      /*),*/
                      SizedBox(
                        height: sizeH16,
                      ),
                      if (storageViewModel.selectedDuration ==
                          ConstanceNetwork.dailyDurationType)
                        /*Showcase(
                          disableAnimation: Constance.showCaseDisableAnimation,
                          shapeBorder: RoundedRectangleBorder(),
                          radius: BorderRadius.all(Radius.circular(Constance.showCaseRecBorder)),
                          showArrow: Constance.showCaseShowArrow,
                          overlayPadding: EdgeInsets.all(5),
                          blurValue:Constance.showCaseBluer ,
                          description: tr.subscriptions_durations_btn_show_case,
                          key: builder.durationsShowCaseKey,
                          child:*/ QuantityWidget(
                            value: storageViewModel.numberOfDays,
                            increasingFunction: () {
                              builder.increaseDaysDurations(
                                  storageCategoriesData: widget.storageCategoriesData);
                            },
                            mineassingFunction: () {
                              builder.minasDaysDurations(
                                  storageCategoriesData: widget.storageCategoriesData);
                            },
                            quantityTitle: "${tr.days}",
                            storageCategoriesData: widget.storageCategoriesData,
                          )
                        /*,)*/
                      else
                        const SizedBox(),
                      if(widget.storageCategoriesData.storageFeatures != null && widget.storageCategoriesData.storageFeatures!.isNotEmpty)...[
                        SizedBox(
                          height: sizeH16,
                        ),
                        /*Showcase(
                          disableAnimation: Constance.showCaseDisableAnimation,
                          shapeBorder: RoundedRectangleBorder(),
                          radius: BorderRadius.all(Radius.circular(Constance.showCaseRecBorder)),
                          showArrow: Constance.showCaseShowArrow,
                          overlayPadding: EdgeInsets.all(5),
                          blurValue:Constance.showCaseBluer ,
                          description: tr.features_btn_show_case,
                          key: builder.featuresShowCaseKey,
                          child:*/ OptionWidget(
                            storageCategoriesData: widget.storageCategoriesData,
                          ),
                        /*),*/
                      ],
                      SizedBox(
                        height: sizeH16,
                      ),
                      GetBuilder<StorageViewModel>(
                        init: StorageViewModel(),
                        initState: (_) {},
                        builder: (b) {
                          return PrimaryButton(
                              textButton: "${tr.next}",
                              isLoading: b.isLoading,
                              onClicked: () {

                                  storageViewModel.saveStorageDataToArray(
                                      updateIndex: widget.index,
                                      isUpdate: widget.isUpdate,
                                      orderViewModel:orderViewModel,
                                      isFromOrderEdit:widget.isFromOrderEdit!,
                                      storageCategoriesData:
                                          widget.storageCategoriesData);
                                  storageViewModel.checkDaplication();
                              },
                              isExpanded: true);
                        },
                      ),
                      SizedBox(
                        height: sizeH16,
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        }
      ),
    );
  }
}
