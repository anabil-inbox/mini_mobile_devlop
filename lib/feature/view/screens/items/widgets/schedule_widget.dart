import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_two_widgets/schedule_pickup_widget.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

import '../../../../../util/app_shaerd_data.dart';

class SchedualWidget extends StatelessWidget {
  const SchedualWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(padding30!))),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: padding20!),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: sizeH20,
            ),
            SpacerdColor(),
            SizedBox(
              height: sizeH16,
            ),
            SchedulePickup(),
            
          ],
        ),
      ),
    );
  }
}
