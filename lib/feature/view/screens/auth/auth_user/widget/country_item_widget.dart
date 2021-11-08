import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/model/country.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

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
          child: Column(
            children: [
              Container(
                color: colorTextWhite,
                child: ListTile(
                  trailing: Text("${item.prefix}"),
                  leading: selectedIndex == cellIndex ?  SvgPicture.asset("assets/svgs/check.svg") : SvgPicture.asset("assets/svgs/uncheck.svg"),
                  title: Text(item.name!),
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
