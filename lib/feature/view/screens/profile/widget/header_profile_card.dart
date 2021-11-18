import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_clients/feature/view/screens/profile/change_mobile/change_mobild_screen.dart';
import 'package:inbox_clients/feature/view/screens/profile/edit_profile/company_edit_profile.dart';
import 'package:inbox_clients/feature/view/screens/profile/edit_profile/user_edit_profile_screen.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HeaderProfileCard extends StatelessWidget {
 const HeaderProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorTextWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: sizeH60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: sizeH16,
              ),
              CircleAvatar(
                backgroundColor: colorPrimary,
                radius: 35,
              ),
              SizedBox(
                width: sizeH10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 // Text("${SharedPref.instance.getCurrentUserData().customerName}"),
                 Text("Ahmed Ali Abdullah"),
                  SizedBox(
                    height: sizeH4,
                  ),
                  Row(
                    children: [
                      // Text(
                      //   "${SharedPref.instance.getCurrentUserData().mobile}",
                      //   style: textStyleHint()!
                      //       .copyWith(fontWeight: FontWeight.normal),
                      // ),
                     Text(
                        "+974 2228 0808",
                        style: textStyleHint()!
                            .copyWith(fontWeight: FontWeight.normal),
                      ), 
                      SizedBox(
                        width: sizeH9,
                      ),
                      InkWell(
                        onTap: (){
                          print("Cliked");
                          Get.to(() => ChangeMobileScreen());
                        },
                        child: SvgPicture.asset("assets/svgs/edit_pen.svg")),
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: sizeH16,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: sizeH20!),
              child: PrimaryButtonOpacityColor(
                  textButton: "${AppLocalizations.of(context)!.edit_profile}",
                  isLoading: false,
                  onClicked: () {
                 //  Get.to(() => UserEditProfileScreen());
                 // Get.to(() => CompanyEditProfile());
                  },
                  isExpanded: true)),
                  SizedBox(
                    height: sizeH20,
                  ),
        ],
      ),
    );
  }
}
