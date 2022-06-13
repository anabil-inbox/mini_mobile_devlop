import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/auth/country/choose_country_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'package:inbox_clients/util/sh_util.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

import 'contact_item_widget.dart';

class UserEditProfileScreen extends StatefulWidget {
  UserEditProfileScreen({Key? key}) : super(key: key);
  static final _formKey = GlobalKey<FormState>();

  @override
  State<UserEditProfileScreen> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  ProfileViewModle profileViewModle = Get.put(ProfileViewModle());
  AuthViewModle authViewModle = Get.put(AuthViewModle());

  @override
  void initState() {
    super.initState();
    profileViewModle.tdUserFullNameEdit.text =
        SharedPref.instance.getCurrentUserData().customerName ?? "";
    profileViewModle.tdUserEmailEdit.text =
        SharedPref.instance.getCurrentUserData().email ?? "";
    profileViewModle.contactMap.clear();
    profileViewModle.contactMap =
        SharedPref.instance.getCurrentUserData().contactNumber!.toList();
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
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
          icon: isArabicLang()
              ? SvgPicture.asset("assets/svgs/back_arrow_ar.svg")
              : SvgPicture.asset("assets/svgs/back_arrow.svg"),
        ),
        centerTitle: true,
        backgroundColor: colorBackground,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              primary: true,
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
                                  onTap: () async {
                                    await profileViewModle.getImage();
                                  },
                                  child: profileViewModle.img != null
                                      ? CircleAvatar(
                                          radius: 50,
                                          backgroundImage: Image.file(
                                            profileViewModle.img!,
                                            fit: BoxFit.cover,
                                          ).image,
                                          backgroundColor:
                                              colorPrimary.withOpacity(0.5),
                                        )
                                      : GetUtils.isNull(SharedPref.instance
                                                  .getCurrentUserData()
                                                  .image) ||
                                              SharedPref.instance
                                                  .getCurrentUserData()
                                                  .image
                                                  .toString()
                                                  .isEmpty
                                          ? CircleAvatar(
                                              radius: 50,
                                              backgroundColor:
                                                  colorPrimary.withOpacity(0.5),
                                            )
                                          : CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage(
                                                  "${SharedPref.instance.getCurrentUserData().image}"),
                                            ));
                            },
                          ),
                          PositionedDirectional(
                            end: 0,
                            child:
                                SvgPicture.asset("assets/svgs/update_orange.svg")/*update_red.svg*/,
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
                        decoration:
                            InputDecoration(hintText: "${tr.full_name}"),
                        validator: (e) {
                          if (e.toString().trim().isEmpty) {
                            return '${tr.fill_your_name}';
                          } else if (e!.length < 2) {
                            return '${tr.fill_your_name}';
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
                        decoration:
                            InputDecoration(hintText: "${tr.email_address}"),
                        validator: (e) {
                          if (e!.isEmpty) {
                            return '${tr.fill_your_email}';
                          } else if (!GetUtils.isEmail(e)) {
                            return "${tr.please_enter_valid_email}";
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
                            "${tr.alternative_contact}",
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
                                    GetBuilder<AuthViewModle>(
                                      init: AuthViewModle(),
                                      initState: (_) {},
                                      builder: (value) {
                                        return Row(
                                          children: [
                                            Text(
                                              "${value.defCountry.prefix}",
                                              textDirection: TextDirection.ltr,
                                            ),
                                            SizedBox(
                                              width: sizeW5,
                                            ),
                                            VerticalDivider(),
                                          ],
                                        );
                                      },
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        enabled: true,
                                        textDirection: TextDirection.ltr,
                                        maxLength: 10,
                                        onSaved: (newValue) {
                                          profileViewModle
                                              .tdUserMobileNumberEdit
                                              .text = newValue.toString();
                                          profileViewModle.update();
                                        },
                                        validator: (e) {
                                          if (e!.isEmpty) {
                                            return null;
                                          }
                                          return phoneVaild(e.toString());
                                        },
                                        decoration: InputDecoration(
                                          counterText: "",
                                        ),
                                        controller: profileViewModle
                                            .tdUserMobileNumberEdit,
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
                          GetBuilder<AuthViewModle>(
                            init: AuthViewModle(),
                            initState: (_) {},
                            builder: (logic) {
                              return InkWell(
                                onTap: () {
                                  addNewContact("${logic.defCountry.prefix}");
                                },
                                child: SvgPicture.asset(
                                  "assets/svgs/add_orange.svg"/*add.svg*/,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: sizeH20,
                      ),
                      GetBuilder<ProfileViewModle>(builder: (logic) {
                        return ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          reverse: true,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          itemCount: logic.contactMap.length,
                          itemBuilder: (context, index) {
                            return ContactItemWidget(
                                deleteContact: () {
                                  logic.contactMap.removeAt(index);
                                  logic.update();
                                },
                                mobileNumber: logic.contactMap[index]
                                    ["${ConstanceNetwork.mobileNumberKey}"],
                                onChange: (_) {
                                  logic.contactMap[index]
                                      [ConstanceNetwork.mobileNumberKey] = _;
                                  logic.update();
                                },
                                prefix: logic.contactMap[index]
                                    ["${ConstanceNetwork.countryCodeKey}"]);
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeH20!),
            child: GetBuilder<ProfileViewModle>(
              builder: (value) {
                return PrimaryButton(
                    textButton: "${tr.save}",
                    isLoading: value.isLoading,
                    onClicked: () {
                      if (UserEditProfileScreen._formKey.currentState!
                          .validate()) {
                        value.editProfileUser();
                      }
                    },
                    isExpanded: true);
              },
            ),
          ),
          SizedBox(
            height: sizeH31,
          ),
        ],
      ),
    );
  }

  addNewContact(String countryCode) {
    print("_addNewContact");

    if (profileViewModle.tdUserMobileNumberEdit.text.isEmpty) {
      return;
    }
    if (UserEditProfileScreen._formKey.currentState!.validate()) {
      Map<String, String> map = {
        "${ConstanceNetwork.countryCodeKey}": "$countryCode",
        "${ConstanceNetwork.mobileNumberKey}":
            "${profileViewModle.tdUserMobileNumberEdit.text}",
      };
      profileViewModle.contactMap.add(map);
      profileViewModle.tdUserMobileNumberEdit.clear();
      profileViewModle.update();
    }
  }
}
