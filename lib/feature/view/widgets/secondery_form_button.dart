import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:inbox_clients/feature/view/screens/user&&company_auth/company_both_login.dart';
import 'package:inbox_clients/feature/view/screens/user&&company_auth/user_both_login_screen.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SeconderyFormButton extends StatelessWidget {
  const SeconderyFormButton({ Key? key , required this.buttonText}) : super(key: key);

  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: sizeH50,
      child: ElevatedButton(
        
        style: seconderyButtonBothFormStyle,
        onPressed:  (){
           if (buttonText.contains("${AppLocalizations.of(context)!.company}")) {
             print("Pressed As User To Company");
             Get.off(() => CompanyBothLoginScreen());
           }else if(buttonText.contains("${AppLocalizations.of(context)!.user}")){
             Get.off(() => UserBothLoginScreen());
             print("Pressed As Company To User");
           }
        },
        child: Text("$buttonText" , style: textStyleHint()!.copyWith(color: colorHint),),
      ),
    );
  }
}

