import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view_model/intro_view_modle/intro_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class LanguageItem extends StatelessWidget {
  const LanguageItem({Key? key, required this.textLanguage}) : super(key: key);

  final String textLanguage;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<IntroViewModle>(
      builder: (logic) {
        return Container(
          color: colorScaffoldRegistrationBody,
          height: sizeH40,
          child: Row(
            children: [
              SizedBox(
                width: 13,
              ),
              SvgPicture.asset("assets/svgs/uncheck.svg"),
              SizedBox(
                width: 15,
              ),
              Text(""),
              SizedBox(
                width: sizeH18,
              ),
            ],
          ),
        );
      },
    );
  }
}
