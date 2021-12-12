import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

import 'pickup_address_item.dart';

class PickupAddress extends StatelessWidget {
  const PickupAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Pickup Address"),
        SizedBox(
          height: sizeH10,
        ),
        ListView(
          shrinkWrap: true,
          children: [
            PickupAddressItem(),
            PickupAddressItem(),
          ],
        ),
        SizedBox(
          height: sizeH10,
        ),
        SeconderyButtom(textButton: "${tr.add_new_address}", onClicked: () {}),
        
        ],
    );
  }
}
