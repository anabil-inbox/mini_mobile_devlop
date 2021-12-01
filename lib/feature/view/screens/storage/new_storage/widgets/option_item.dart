import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_dimen.dart';

// ignore: must_be_immutable
class OptionItem extends StatelessWidget {
 OptionItem({ Key? key , required this.optionTitle }) : super(key: key);

  StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  final String optionTitle;
  bool isSelcted = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StorageViewModel>(
      init: StorageViewModel(),
      initState: (_) {},
      builder: (_) {
        return Column(
          children: [
            InkWell(
              onTap: (){
                isSelcted = !isSelcted;
                storageViewModel.update();
              },
              child: Row(
                children: [
                 isSelcted ? SvgPicture.asset("assets/svgs/true.svg") : SvgPicture.asset("assets/svgs/uncheck.svg"),
                  SizedBox(width: sizeW10,),
                  Text(optionTitle),
                  const Spacer(),
                  SvgPicture.asset("assets/svgs/InfoCircle.svg"),
                 
                ],
              ),
            ),
            SizedBox(height: sizeH25,)
      ],
    ); 
      },
    );
  }
}