// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_dimen.dart';

import '../../../util/app_shaerd_data.dart';

class OptionStringItem extends StatelessWidget {
  const OptionStringItem({Key? key, required this.vas}) : super(key: key);

  static StorageViewModel _storageViewModel = Get.find<StorageViewModel>();

  final VAS? vas;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<StorageViewModel>(
      init: StorageViewModel(),
      initState: (_) {
        // _storageViewModel.selectedStringOption = options!;
      },
      builder: (_) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                _storageViewModel.addStringOption(vas: vas!);
                _storageViewModel.update();
              },
              child: Row(
                children: [
                  _storageViewModel.searchOperationById(vasId: vas?.id ?? "")
                      ? SvgPicture.asset("assets/svgs/true_orange.svg")//true
                      : SvgPicture.asset("assets/svgs/uncheck.svg"),
                  SizedBox(
                    width: sizeW10,
                  ),
                  Text("${vas?.name ?? ""}"),
                  const Spacer(),
                  //PopInfoDialog(title: "${storageFeatures.addedPrice}",),//${/*tr.price*/}
                  //SvgPicture.asset("assets/svgs/InfoCircle.svg"),
                ],
              ),
            ),
            SizedBox(
              height: sizeH25,
            ),
          ],
        );
      },
    );
  }
}
