import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/utils.dart';
import 'package:inbox_clients/feature/model/country.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class CountryItem extends StatelessWidget {
   const CountryItem({Key? key, required this.item , required this.selectedIndex , required this.cellIndex}) : super(key: key);

  final Country item;
  final int cellIndex;
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModle>(
      builder: (_) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4)
          ),
          child: Column(
            children: [
              Container(
                 clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                                      color: colorTextWhite,
                    ),
                child: ListTile(
                  trailing: Text("${item.prefix}",textDirection: TextDirection.ltr,),
                   title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                       selectedIndex == cellIndex ?  
                       SvgPicture.asset("assets/svgs/check.svg") : 
                       SvgPicture.asset("assets/svgs/uncheck.svg"),
                      SizedBox(width: sizeW10,),
                      GetUtils.isNull(item.flag) || 
                      item.flag.toString().isEmpty ? SizedBox(  width: 36,
                        height: 26)
                        : imageNetwork(
                        url: "${ConstanceNetwork.imageUrl}${item.flag}" ,
                        width: 36,
                        height: 26
                      ),
                      SizedBox(width: sizeW10,),
                      Expanded(child: Text(item.name!)),
                    ],
                  ),

                ),
              ),
              Container(
                color: colorScaffoldRegistrationBody,
                height: sizeH10,
              ),
          ],
      ),
    );  
}
);
}
}
