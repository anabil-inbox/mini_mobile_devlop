import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/auth/country/choose_country_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserEditProfileScreen extends StatelessWidget {
  const UserEditProfileScreen({Key? key}) : super(key: key);

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
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: colorPrimary.withOpacity(0.5),
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
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "${AppLocalizations.of(context)!.full_name}"),
                  validator: (e) {
                    if (e!.isEmpty) {
                      return '${AppLocalizations.of(context)!.fill_your_name}';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: sizeH16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText:
                          "${AppLocalizations.of(context)!.email_address}"),
                  validator: (e) {
                    if (e!.isEmpty) {
                      return '${AppLocalizations.of(context)!.fill_your_email}';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: sizeH16,
                ),
                Container(
                    width: double.infinity,
                    child: Text(
                      "Alternative Contact",
                      textAlign: TextAlign.start,
                    )),
                SizedBox(
                  height: sizeH10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(() => ChooseCountryScreen());
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          height: sizeH54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: colorTextWhite,
                          ),
                          child: Row(
                            textDirection: TextDirection.ltr,
                            children: [
                              SizedBox(
                                width: sizeW18,
                              ),
                              SvgPicture.asset("assets/svgs/qatar_flag.svg"),
                              VerticalDivider(),
                              GetBuilder<ProfileViewModle>(
                                init: ProfileViewModle(),
                                initState: (_) {},
                                builder: (value) {
                                  return Text("");
                                },
                              ),
                              Expanded(
                                child: TextFormField(
                                  textDirection: TextDirection.ltr,
                                  maxLength: 9,
                                  onSaved: (newValue) {
                                    // controller.tdMobileNumber.text =
                                    // newValue.toString();
                                    // controller.update();
                                  },
                                  decoration: InputDecoration(
                                    counterText: "",
                                  ),
                                  //   controller: controller.tdMobileNumber,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '${AppLocalizations.of(Get.context!)!.fill_your_phone_number}';
                                    } else if (value.length != 9) {
                                      return "${AppLocalizations.of(Get.context!)!.phone_number_invalid}";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: sizeW4,
                    ),
                    SvgPicture.asset(
                      "assets/svgs/add.svg",
                      fit: BoxFit.cover,
                    )
                  ],
                ),
                SizedBox(
                  height: sizeH270,
                ),
                GetBuilder<ProfileViewModle>(
                  builder: (value) {
                    return PrimaryButton(
                        textButton: "${AppLocalizations.of(context)!.save}",
                        isLoading: value.isLoading,
                        onClicked: (){
                          if(!_formKey.currentState!.validate()){
                            
                          }
                        },
                        isExpanded: true);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
