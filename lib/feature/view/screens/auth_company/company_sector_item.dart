import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';


class CompanySectorItem extends StatelessWidget {
  const CompanySectorItem({ Key? key , required this.sector , required this.cellIndex,required this.selectedIndex}) : super(key: key);

  final int cellIndex;
  final int selectedIndex;
  final CompanySector sector;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorScaffoldRegistrationBody,
      height: sizeH40,
      width: sizeH330,
      child: Row(
        children: [
          SizedBox(width: sizeW13,),
          selectedIndex == cellIndex ?  SvgPicture.asset("assets/svgs/check.svg") : SvgPicture.asset("assets/svgs/uncheck.svg"),
          SizedBox(width: sizeW15,),
          Text("${sector.sectorName}")
        ],
      ),
      
    );
  }
}