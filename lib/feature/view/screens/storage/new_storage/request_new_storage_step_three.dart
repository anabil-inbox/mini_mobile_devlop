import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/request_new_storage_header.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_three_widgets/payment_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:showcaseview/showcaseview.dart';

import 'widgets/show_selction_widget/my_list_widget.dart';

class RequestNewStorageStepThree extends StatelessWidget {
  const RequestNewStorageStepThree({Key? key}) : super(key: key);

  static ProfileViewModle profileViewModle = Get.find<ProfileViewModle>();

  Widget get acceptTerms => GetBuilder<StorageViewModel>(
        init: StorageViewModel(),
        builder: (value) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  value.isAccept = !value.isAccept;
                  value.update();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    value.isAccept
                        ? SvgPicture.asset("assets/svgs/true_orange.svg")//true
                        : SvgPicture.asset(
                            "assets/svgs/uncheck.svg",
                            color: seconderyColor,
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    CustomTextView(
                      txt: "${tr.redeem_points} ",
                      textStyle: textStyle(),
                    )
                  ],
                ),
              ),
              CustomTextView(
                txt: "${profileViewModle.myPoints.totalPoints} ${tr.points}",
                textAlign: TextAlign.start,
                textStyle: textStyleNormal()!
                    .copyWith(color: colorPrimary, fontSize: fontSize14),
              ),
            ],
          );
        },
      );

  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return ShowCaseWidget(

      onFinish: ()async{
        await SharedPref.instance.setFirstPaymentKey(true);
      },
      builder: Builder(
        builder: (context) {
          storageViewModel.setContext(context);
          return Scaffold(
            backgroundColor: scaffoldColor,
            appBar: CustomAppBarWidget(
              isCenterTitle: true,
              titleWidget: Text(
                "${tr.request_new_storage}",
                style: textStyleAppBarTitle(),
              ),
            ),
            body: GetBuilder<StorageViewModel>(
              initState: (s){
                s.controller?.showPaymentShowCase();
              },
              builder: (logical) {
                if(logical.isLoading){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SizedBox(
                  height: double.infinity,
                  child: Stack(
                    children: [
                      ListView(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        primary: true,
                        children: [
                          GetBuilder<StorageViewModel>(
                            init: StorageViewModel(),
                            initState: (_) {},
                            builder: (val) {
                              return RequestNewStorageHeader(
                                currentLevel: val.currentLevel,
                              );
                            },
                          ),
                          MyListWidget(),
                          SizedBox(
                            height: sizeH16,
                          ),
                          if(storageViewModel.userStorageCategoriesData.isNotEmpty)
                          InkWell(
                            onTap: (){
                              Get.close(2);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.add_circle_outline_rounded , color: colorPrimary,),
                                SizedBox(width: sizeW5,),
                                Text(
                                  "${storageViewModel.userStorageCategoriesData.isNotEmpty ?  tr.add_more_items.replaceAll("...", "") : ""}",
                                  style: textStyleCardTitlePrice()?.copyWith(color: colorBlack),
                                ),
                              ],
                            ),
                          ),
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
                              description: tr.payment_btn_show_case,
                              key: logical.paymentCaseKey,
                              child:*/ PaymentWidget(isRecivedOrderPayment: false, )/*)*/,
                          // SizedBox(height: sizeH16),
                          // acceptTerms,
                          if (logical.selectedPaymentMethod?.id ==
                              Constance.bankTransferId) ...[
                            SizedBox(
                              height: sizeH16,
                            ),
                            CustomTextFormFiled(
                              isReadOnly: true,
                              fun: () async {
                                logical.onBankImageClick();
                              },
                              label: logical.imageBankTransfer != null
                                  ? logical.imageBankTransfer?.path.split("/").last.toString()
                                  : tr.select_image,
                              isFill: true,
                              fillColor: colorTextWhite,
                            ),
                          ],
                          SizedBox(
                            height: sizeH100,
                          ),
                        ],
                      ),

                      PositionedDirectional(
                          bottom: padding32,
                          start: padding20,
                          end: padding20,
                          child: Container(
                              width: sizeW150,
                              child: GetBuilder<StorageViewModel>(
                                builder: (logic) {
                                  return PrimaryButton(
                                    isExpanded: false,
                                    isLoading: logic.isLoading,
                                    textButton: "${tr.request_box}",
                                    onClicked: () async {
                                      if (logic.isValiedToSaveStorage()) {
                                        if (logic.selectedPaymentMethod?.id ==
                                                    Constance.cashId ||
                                                logic.selectedPaymentMethod?.id ==
                                                    Constance
                                                        .pointOfSaleId /*||
                                            logic.selectedPaymentMethod?.id == Constance.bankTransferId*/
                                            ) {
                                          await logic.addNewStorage();
                                          logic.isLoading = false;
                                          logic.update();
                                        } else if (logic.selectedPaymentMethod?.id ==
                                            Constance.bankTransferId) {
                                          //todo here i will check if user upload or select image i will allow to send request
                                          await logic.addNewStorage(isFromBankTransfer:true);
                                          logic.isLoading = false;
                                          logic.update();
                                        } else if ((logic.selectedPaymentMethod?.id ==
                                            Constance.walletId)) {
                                          if (num.parse(profileViewModle
                                                  .myWallet.balance
                                                  .toString()) >
                                              storageViewModel.totalBalance) {
                                            await logic.addNewStorage();
                                            logic.isLoading = false;
                                            logic.update();
                                          } else {
                                            snackError(
                                                "", tr.wallet_balance_is_not_enough);
                                          }
                                        } else {
                                          await logic.goToPaymentMethod(
                                              cartModels: [],
                                              isOrderProductPayment: false,
                                              isFromCart: false,
                                              isFromNewStorage: true,
                                              storageViewModel: storageViewModel,
                                              amount: logic.totalBalance, isFromEditOrder: false);
                                          logic.isLoading = false;
                                          logic.update();
                                        }
                                      }
                                    },
                                  );
                                },
                              ))),
                      // PositionedDirectional(
                      //     bottom: padding32,
                      //     end: padding40,
                      //     child: Container(
                      //         width: sizeW150,
                      //         child: SeconderyFormButton(
                      //           buttonText: "${tr.add_to_cart}",
                      //           onClicked: () {},
                      //         ))),
                    ],
                  ),
                );
              },
            ),
          );
        }
      ),
    );
  }
}
