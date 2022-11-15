import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/profile/invoice/widget/my_invoices_item.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:logger/logger.dart';

class InvoiceView extends StatelessWidget {
  const InvoiceView({Key? key}) : super(key: key);

  ProfileViewModle get viewModel => Get.put(ProfileViewModle());

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleWidget: Text(
          tr.invoice,
          style: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
        actionsWidgets: [
          GetBuilder<ProfileViewModle>(builder: (logic) {
            return InkWell(
                onTap: () {
                  if (viewModel.invoicesList.isNotEmpty) {
                    Logger().i("message");
                    viewModel.addAllToSelectedBills();
                  }
                },
                child: viewModel.invoicesSelectedId.isNotEmpty
                    ? Icon(
                  Icons.check_box,
                  color: colorPrimary,
                )
                    : Icon(
                  Icons.check_box_outline_blank,
                  color: colorHint3,
                ));
          }),
          SizedBox(
            width: sizeW12,
          ),
        ],
      ),
      body: GetBuilder<ProfileViewModle>(
          init: ProfileViewModle(),
          initState: (state) {
            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
              state.controller?.getMyBills();
            });
          },
          builder: (logic) {
            if (logic.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (logic.invoicesList.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Text("${tr.no_bills_yet}")),
                ],
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(
                        left: sizeW10!, top: sizeH20!, right: sizeW10!),
                    itemCount: logic.invoicesList.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return MyInvoicesItem(
                        invoices: logic.invoicesList[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                  ),
                ),
                SizedBox(
                  height: sizeH20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeW20!),
                  child: PrimaryButton(
                      textButton: "${tr.ok} (${logic.getTotalInvoicePrice()})",
                      isLoading: logic.isLoading,
                      onClicked: onClicked,
                      isExpanded: true),
                ),
                SizedBox(
                  height: sizeH20,
                ),
              ],
            );
          }),
    );
  }

  onClicked() {
    if (viewModel.invoicesSelectedId.isNotEmpty)
      viewModel.getInvoiceUrlPayment();
  }
}
