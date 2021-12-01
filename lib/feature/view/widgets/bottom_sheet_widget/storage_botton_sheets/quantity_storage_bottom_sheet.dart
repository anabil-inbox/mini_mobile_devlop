import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/options_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/period_storage_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/price_bottom_sheet_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/quantity_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class QuantityStorageBottomSheet extends StatelessWidget {
  const QuantityStorageBottomSheet(
      {Key? key, required this.storageCategoriesData})
      : super(key: key);

  final StorageCategoriesData storageCategoriesData;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(padding30!)),
          color: colorTextWhite,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: sizeH20,
            ),
            Container(
              height: sizeH5,
              width: sizeW50,
              decoration: BoxDecoration(
                  color: colorSpacer,
                  borderRadius: BorderRadius.circular(padding3)),
            ),
            SizedBox(
              height: sizeH20,
            ),
            Text(storageCategoriesData.storageName ?? ""),
            SizedBox(
              height: sizeH20,
            ),
            PriceBottomSheetWidget(),
            SizedBox(
              height: sizeH16,
            ),
            QuantityWidget(),
            SizedBox(
              height: sizeH16,
            ),
            PeriodStorageWidget(),
            SizedBox(
              height: sizeH16,
            ),
            OptionWidget(storageCategoriesData: storageCategoriesData,),
            SizedBox(
              height: sizeH16,
            ),
            PrimaryButton(
                textButton: "Next",
                isLoading: false,
                onClicked: () {},
                isExpanded: true),
            SizedBox(
              height: sizeH16,
            ),

          ],
        ),
      ),
    );
  }
}
