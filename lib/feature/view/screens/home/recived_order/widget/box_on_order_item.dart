import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class BoxOnOrderItem extends StatelessWidget {
  const BoxOnOrderItem({Key? key , required this.boxModel}) : super(key: key);

  final Box boxModel;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: padding10!),
      child: InkWell(
        child: Row(
          children: [
            SvgPicture.asset('assets/svgs/Folder_Shared_1.svg'),
            SizedBox(width: sizeW5),
            CustomTextView(
              txt: boxModel.storageName,
              textStyle: textStyleNormal()?.copyWith(color: colorBlack),
            )
            
          ],
        ),
      ),
    );
  }
}
