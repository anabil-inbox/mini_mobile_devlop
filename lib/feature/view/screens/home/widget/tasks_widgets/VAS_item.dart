import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_dimen.dart';

import '../../../../../../util/app_shaerd_data.dart';

class VASItem extends StatelessWidget {
  const VASItem({Key? key, required this.vas}) : super(key: key);

  final VAS vas;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<HomeViewModel>(
      builder: (home) {
        return InkWell(
          onTap: () {
            home.addVASToArray(vas: vas);
          },
          child: Row(
            children: [
              home.selectedVAS.contains(vas)
                  ? SvgPicture.asset("assets/svgs/true.svg")
                  : SvgPicture.asset("assets/svgs/uncheck.svg"),
              SizedBox(
                width: sizeW12,
              ),
              Text("${vas.name}")
            ],
          ),
        );
      },
    );
  }
}
