import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/widget/back_btn_widget.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  final bool? isCenterTitle;
  final Widget? titleWidget;
  final List<Widget>? actionsWidgets;
  final Color? appBarColor;
  final Brightness? brightness;
  final double? elevation;
  final Widget? leadingWidget;
  final Function()? onBackBtnClick;
final double? leadingWidth;

  const CustomAppBarWidget({Key? key, this.isCenterTitle = false, this.titleWidget, this.actionsWidgets, this.appBarColor, this.brightness, this.elevation, this.leadingWidget, this.onBackBtnClick, this.leadingWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return AppBar(
      // leadingWidth:leadingWidth?? sizeW90,
     titleSpacing: 10,
      automaticallyImplyLeading: true,
      centerTitle: isCenterTitle,
      title: titleWidget??const SizedBox.shrink(),
      actions: actionsWidgets??[],
      backgroundColor: appBarColor??colorTextWhite,
      brightness: brightness??Brightness.light,
      elevation: elevation??1,
      leading: leadingWidget??BackBtnWidget(onTap: onBackBtnClick??_getBack,),
      
    );
  }
   _getBack()=> Get.back();
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(sizeH60!);
}
