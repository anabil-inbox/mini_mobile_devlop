import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class IconBtn extends StatelessWidget {
  final Color? backgroundColor, borderColor, iconColor;
  final double? width , height;
  final Function()? onPressed;

  const IconBtn(
      {Key? key,
      this.backgroundColor,
      this.borderColor,
      this.iconColor,this.width, this.height, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      width: sizeW50,
      height: sizeH50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(sizeRadius10!),
          color: backgroundColor ??colorTextWhite,
          border: Border.all(color:borderColor?? colorRed)),
      child: MaterialButton(
        height:height?? sizeH50,
        minWidth:width ?? sizeW50,
        onPressed: onPressed??() {},
        clipBehavior: Clip.hardEdge,
        child: SvgPicture.asset("assets/svgs/delete_widget.svg" ,color: iconColor ?? colorRed,),
      ),
    );
  }
}
