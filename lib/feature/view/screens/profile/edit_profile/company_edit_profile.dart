import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class CompanyEditProfile extends StatelessWidget {
   CompanyEditProfile({ Key? key }) : super(key: key);


    ProfileViewModle profileViewModle = Get.find<ProfileViewModle>();

    static final _formKey = GlobalKey<FormState>();

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffoldRegistrationBody,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 1,
        title: Text(
          "${AppLocalizations.of(Get.context!)!.edit_profile}",
          style: textStyleAppBarTitle(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(Get.context!);
          },
          icon: SvgPicture.asset("assets/svgs/back_arrow.svg"),
        ),
        centerTitle: true,
        backgroundColor: colorBackground,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: sizeH20!),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: sizeH25,
                ),
                 Stack(
                  children: [
                    GetBuilder<ProfileViewModle>(
                      builder: (_) {
                        return InkWell(
                          onTap: () async{
                           await profileViewModle.getImage();
                          },
                          child: profileViewModle.img != null ? CircleAvatar(
                            radius: 50,
                           backgroundImage : Image.file(
                              profileViewModle.img!,
                              fit: BoxFit.cover,
                            ).image,
                            backgroundColor: colorPrimary.withOpacity(0.5),
                          ) : CircleAvatar(
                            radius: 50,
                            backgroundColor: colorPrimary.withOpacity(0.5),
                        )
                        );
                      },
                    ),
                    PositionedDirectional(
                      end: 0,
                      child: SvgPicture.asset("assets/svgs/update_red.svg"),
                    )
                  ],
                
                ),
                SizedBox(
                  height: sizeH25,
                ),
              
              ],
            ),
          ),
        ),
      ),
    );
  }

}