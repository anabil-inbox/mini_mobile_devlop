import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/profile/address/add_address.dart';
import 'package:inbox_clients/feature/view/screens/profile/widget/address_item.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

class GetAddressScreen extends GetWidget<ProfileViewModle> {
  const GetAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: CustomAppBarWidget(
        isCenterTitle: true,
        titleWidget: Text(
          "${tr.my_address}",
          style: textStyleAppBarTitle(),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: sizeH20,
          ),
          Expanded(
            child: GetBuilder<ProfileViewModle>(
              init: ProfileViewModle(),
              builder: (logic) {
                return logic.userAddress.isEmpty
                    ? const SizedBox()
                    : ListView(
                        children: controller.userAddress
                            .map((e) => AddressItem(address: e))
                            .toList());
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                right: sizeH20!, left: sizeH20!, bottom: sizeH34!),
            child: PrimaryButton(
                textButton: "${tr.add_new_address}",
                isLoading: false,
                onClicked: () {
                  Get.to(AddAddressScreen());
                },
                isExpanded: true),
          )
        ],
      ),
    );
  }
}
