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
import 'package:inbox_clients/util/sh_util.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class UserEditProfileScreen extends StatefulWidget {
  UserEditProfileScreen({Key? key}) : super(key: key);
  static final _formKey = GlobalKey<FormState>();

  @override
  State<UserEditProfileScreen> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  ProfileViewModle profileViewModle = Get.find<ProfileViewModle>();

  @override
  void initState() {
    super.initState();
    profileViewModle.tdUserFullNameEdit.text =
        SharedPref.instance.getCurrentUserData().customerName ?? "";
    profileViewModle.tdUserEmailEdit.text =
        SharedPref.instance.getCurrentUserData().email ?? "";
    profileViewModle.tdUserMobileNumberEdit.text =
        SharedPref.instance.getCurrentUserData().mobile ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffoldRegistrationBody,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 1,
        title: Text(
          "${tr.edit_profile}",
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
            key: UserEditProfileScreen._formKey,
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
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: profileViewModle.tdUserFullNameEdit,
                  onSaved: (e) {
                    profileViewModle.tdUserFullNameEdit.text = e!;
                    profileViewModle.update();
                  },
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
                  controller: profileViewModle.tdUserEmailEdit,
                  onSaved: (e) {
                    profileViewModle.tdUserEmailEdit.text = e!;
                    profileViewModle.update();
                  },
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
                              // authViewModle.defCountry.name!.toLowerCase().contains("qatar")
                              // ? SvgPicture.asset("assets/svgs/qatar_flag.svg")
                              // : imageNetwork(
                              //  url: "${ConstanceNetwork.imageUrl}${authViewModle.defCountry.flag}" ,
                              //  width: 36,
                              //  height: 26
                              // ),
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
                                    profileViewModle.tdUserMobileNumberEdit
                                        .text = newValue.toString();
                                    profileViewModle.update();
                                  },
                                  decoration: InputDecoration(
                                    counterText: "",
                                  ),
                                  controller:
                                      profileViewModle.tdUserMobileNumberEdit,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '${tr.fill_your_phone_number}';
                                    } else if (value.length != 9) {
                                      return "${tr.phone_number_invalid}";
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
                    InkWell(
                      onTap: (){
                        print("object");
                      },
                      child: SvgPicture.asset(
                        "assets/svgs/add.svg",
                        fit: BoxFit.cover,
                      ),
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
                        onClicked: () {
                          if (UserEditProfileScreen._formKey.currentState!
                              .validate()) {
                                value.editProfileUser();
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
