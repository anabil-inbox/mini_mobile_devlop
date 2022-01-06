// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class OptionStringItem extends StatelessWidget {
  const OptionStringItem(
      {Key? key, required this.option, required this.options})
      : super(key: key);

  static StorageViewModel _storageViewModel = Get.find<StorageViewModel>();

  final String? option;
  final List<String>? options;
  @override
  Widget build(BuildContext context) {
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
                _storageViewModel.addStringOption(option);
                _storageViewModel.update();
              },
              child: Row(
                children: [
                  _storageViewModel.selectedStringOption.contains(option)
                      ? SvgPicture.asset("assets/svgs/true.svg")
                      : SvgPicture.asset("assets/svgs/uncheck.svg"),
                  SizedBox(
                    width: sizeW10,
                  ),
                  Text("$option"),
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
