import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/company_both_login/company_both_login_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/user_both_login/user_both_login_view.dart';
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
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4)
      ),
      child: MaterialButton(
        color: seconderyButton,
        onPressed:  (){
          
           if (buttonText.toLowerCase().contains("${AppLocalizations.of(context)!.company.toString().toLowerCase()}")) {
             Get.off(() => CompanyBothLoginScreen());
           }else if(buttonText.toLowerCase().contains("${AppLocalizations.of(context)!.user.toString().toLowerCase()}")){
             Get.off(() => UserBothLoginScreen());
           }
        },
        child: Text("$buttonText" , style: textStyleHint()!.copyWith(color: colorHint , fontWeight: FontWeight.bold,fontSize: 15),),
      ),
    );
  }
}

