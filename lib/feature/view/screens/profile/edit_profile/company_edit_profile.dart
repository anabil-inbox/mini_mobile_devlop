import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_company/widget/company_sector_item_widget.dart';
import 'package:inbox_clients/feature/view/screens/auth/country/choose_country_view.dart';
import 'package:inbox_clients/feature/view/screens/profile/edit_profile/contact_item_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';

// ignore: must_be_immutable
class CompanyEditProfile extends StatefulWidget {
  CompanyEditProfile({Key? key}) : super(key: key);

  static final _formKey = GlobalKey<FormState>();

  @override
  State<CompanyEditProfile> createState() => _CompanyEditProfileState();
}

class _CompanyEditProfileState extends State<CompanyEditProfile> {
  ProfileViewModle profileViewModle = Get.put(ProfileViewModle());

    @override
  void initState() {
    super.initState();
    Logger().i("${SharedPref.instance.getCurrentUserData().toJson().toString()}");
   profileViewModle.tdCompanyApplicantDepartment.text = SharedPref.instance.getCurrentUserData().applicantName ?? "";
   profileViewModle.tdCompanyNameEdit.text = SharedPref.instance.getCurrentUserData().customerName ?? "";
   profileViewModle.tdCompanyMobileNumber.text = SharedPref.instance.getCurrentUserData().mobile ?? "";
   profileViewModle.tdCompanyNameOfApplicationEdit.text = SharedPref.instance.getCurrentUserData().applicantName ?? "";
    profileViewModle.companySector!.sectorName = SharedPref.instance.getCurrentUserData().companySector ?? "";
    profileViewModle.tdCompanyEmailEdit.text = SharedPref.instance.getCurrentUserData().email ?? "";
   profileViewModle.contactMap = SharedPref.instance.getCurrentUserData().contactNumber ??  [{}];  
  }

  var countryCode = "";

  var flagUrl = "";

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
            key: CompanyEditProfile._formKey,
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
                            splashColor: colorTrans,
                            highlightColor: colorTrans,
                            onTap: () async {
                              await profileViewModle.getImage();
                            },
                            child: profileViewModle.img != null
                                ? CircleAvatar(
                              radius: 50,
                              backgroundImage: Image
                                  .file(
                                profileViewModle.img!,
                                fit: BoxFit.cover,
                              )
                                  .image,
                              backgroundColor:
                              colorPrimary.withOpacity(0.5),
                            )
                                : CircleAvatar(
                              radius: 50,
                              backgroundColor:
                              colorPrimary.withOpacity(0.5),
                            ));
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
                  controller: profileViewModle.tdCompanyNameEdit,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${tr.fill_your_company_name}';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    profileViewModle.tdCompanyNameEdit.text = newValue!;
                    profileViewModle.update();
                  },
                  decoration: InputDecoration(hintText: "${tr.company_name}"),
                ),
                SizedBox(
                  height: sizeH16,
                ),

                TextFormField(
                  controller: profileViewModle.tdCompanyEmailEdit,
                  onSaved: (newValue) {
                    profileViewModle.tdCompanyEmailEdit.text = newValue!;
                    profileViewModle.update();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${tr.fill_your_company_email}';
                    } else if (!GetUtils.isEmail(value)) {
                      return '${tr.please_enter_valid_email}';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                  InputDecoration(hintText: "${tr.your_email_address}"),
                ),
                SizedBox(
                  height: sizeH16,
                ),
                GetBuilder<ProfileViewModle>(
                  init: ProfileViewModle(),
                  initState: (_) {},
                  builder: (logic) {
                    return TextFormField(
                        controller: TextEditingController(
                            text:
                            GetUtils.isNull(logic.companySector!.sectorName)
                                ? ""
                                : logic.companySector!.sectorName),
                        readOnly: true,
                        onTap: () {
                          chooseSectorCompany();
                        },
                        decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                              SvgPicture.asset("assets/svgs/dropdown.svg"),
                            ),
                            hintText: "${tr.company_sector}"));
                  },
                ),
                SizedBox(
                  height: sizeH16,
                ),
                // GetBuilder<AuthViewModle>(
                //   init: AuthViewModle(),
                //   initState: (_) {},
                //   builder: (logic) {
                //     return TextFormField(
                //         controller:
                //             TextEditingController(text: GetUtils.isNull(logic.companySector!.sectorName) ? "" : logic.companySector!.sectorName),
                //         readOnly: true,
                //         onTap: () {
                //           chooseSectorCompany();
                //         },
                //         decoration: InputDecoration(
                //             suffixIcon: Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: SvgPicture.asset("assets/svgs/dropdown.svg"),
                //             ),
                //             hintText:
                //                 "${tr.company_sector}"));
                //   },
                // ),
                // SizedBox(
                //   height: padding16,
                // ),
                TextFormField(
                  controller: profileViewModle.tdCompanyNameOfApplicationEdit,
                  onSaved: (newValue) {
                    profileViewModle.tdCompanyNameOfApplicationEdit.text = newValue!;
                    profileViewModle.update();
                  },
                  textCapitalization: TextCapitalization.sentences,
                  
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${tr.fill_name_of_applicant}';
                    }
                    return null;
                  },
                  decoration:
                  InputDecoration(hintText: "${tr.name_of_application}"),
                ),
                SizedBox(
                  height: padding16,
                ),
                TextFormField(
                   controller: profileViewModle.tdCompanyApplicantDepartment,
                  onSaved: (newValue) {
                    profileViewModle.tdCompanyApplicantDepartment.text = newValue!;
                    profileViewModle.update();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${tr.fill_the_applicant_department}';
                    }
                    return null;
                  },
                  decoration:
                  InputDecoration(hintText: "${tr.applicant_department}"),
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
                              // profileViewModle.defCountry.name!.toLowerCase().contains("qatar")
                              // ? SvgPicture.asset("assets/svgs/qatar_flag.svg")
                              // : imageNetwork(
                              //  url: "${ConstanceNetwork.imageUrl}${profileViewModle.defCountry.flag}" ,
                              //  width: 36,
                              //  height: 26
                              // ),
                              GetBuilder<AuthViewModle>(
                                init: AuthViewModle(),
                                initState: (_) {},
                                builder: (value) {
                                  countryCode =
                                      value.defCountry.prefix.toString();
                                  if (value.defCountry.name!
                                      .toLowerCase()
                                      .contains("qatar"))
                                    flagUrl = "assets/svgs/qatar_flag.svg";
                                  else
                                    flagUrl = value.defCountry.flag.toString();
                                  return
                                    Row(
                                      children: [
                                        value.defCountry.name!
                                            .toLowerCase()
                                            .contains("qatar")
                                            ? SvgPicture.asset(
                                            "assets/svgs/qatar_flag.svg")
                                            : imageNetwork(
                                            url:
                                            "${ConstanceNetwork.imageUrl}${value
                                                .defCountry.flag}",
                                            width: 36,
                                            height: 26),
                                        VerticalDivider(),
                                        Text(
                                          "${value.defCountry.prefix}",
                                          textDirection: TextDirection.ltr,
                                        ),
                                      ],
                                    );
                                },
                              ),
                              Expanded(
                                child: TextFormField(
                                  textDirection: TextDirection.ltr,
                                  maxLength: 9,
                                 
                                  decoration: InputDecoration(
                                    counterText: "",
                                  ),
                             
                                  controller: profileViewModle.tdCompanyMobileNumber,
                                onSaved: (newValue) {
                                  profileViewModle.tdCompanyMobileNumber.text = newValue!;
                                  profileViewModle.update();
                                },
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
                      onTap: _addNewContact,
                      child: SvgPicture.asset(
                        "assets/svgs/add.svg",
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: sizeH20,
                ),
                GetBuilder<ProfileViewModle>(
                    builder: (logic) {
                  return ListView.builder(
                    shrinkWrap: true,
                    keyboardDismissBehavior:ScrollViewKeyboardDismissBehavior.onDrag ,
                    itemCount: logic.contactMap.length,
                    itemBuilder: (context, index) {
                      return ContactItemWidget(
                        deleteContact: (){
                          logic.contactMap.removeAt(index);
                          logic.update();
                        },
                        mobileNumber: logic.contactMap[index]["mobile_number"] ,
                        onChange: (_) {
                        logic.contactMap[index][ConstanceNetwork.mobileNumberKey] = _;
                        logic.update();
                      },flag:flagUrl ,prefix: logic.contactMap[index][ConstanceNetwork.countryCodeKey],);
                    },
                  );
                }),
                SizedBox(
                  height: sizeH31,
                ),
                GetBuilder<ProfileViewModle>(
                  builder: (logic) {
                    return PrimaryButton(
                        isLoading: logic.isLoading,
                        isExpanded: true,
                        textButton: "${tr.save}",
                        onClicked: () {
                          if (CompanyEditProfile._formKey.currentState!.validate()) {
                            CompanyEditProfile._formKey.currentState!.save();
                            logic.editProfileUser();
                          }
                        });
                  },
                ),
                SizedBox(
                  height: sizeH31,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void chooseSectorCompany() {
    Get.bottomSheet(Container(
      decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      padding: EdgeInsets.symmetric(horizontal: sizeH20!),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: sizeH40),
          Text(
            "${tr.company_sector}",
            style: textStyleTitle(),
          ),
          SizedBox(height: sizeH22),
          Expanded(
            child: ListView.builder(
              itemCount: SharedPref.instance.getAppSectors()!.length,
              itemBuilder: (context, index) {
                return GetBuilder<ProfileViewModle>(
                  init: ProfileViewModle(),
                  builder: (logic) {
                    return Column(
                      children: [
                        InkWell(
                            onTap: () {
                              logic.selectedIndex = -1;
                              logic.update();
                              logic.selectedIndex = index;
                              logic.temproreySectorName = ApiSettings
                                  .fromJson(
                                  json.decode(SharedPref.instance
                                      .getAppSetting()!
                                      .toString()))
                                  .companySectors![index];
                              logic.update();
                            },
                            child: CompanySectorItem(
                                cellIndex: index,
                                selectedIndex: logic.selectedIndex,
                                sector: ApiSettings
                                    .fromJson(json.decode(
                                    SharedPref.instance
                                        .getAppSetting()!
                                        .toString()))
                                    .companySectors![index])),
                        SizedBox(
                          height: sizeH10,
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: sizeH18,
          ),
          PrimaryButton(
              isLoading: false,
              textButton: "${tr.select}",
              onClicked: () {
                profileViewModle.companySector =
                    profileViewModle.temproreySectorName;
                profileViewModle.update();
                Get.back();
              },
              isExpanded: true),
          SizedBox(
            height: sizeH34,
          ),
        ],
      ),
    ));
  }

  void _addNewContact() {
    ///todo here i check if number is empty  i will not do any thing
    ///else i will add item to map and pass to list of map to show in listview
    if (profileViewModle.tdUserMobileNumberEdit.text.isEmpty) {
      return;
    }
    Map<String, dynamic> map = {
      "${ConstanceNetwork.countryCodeKey}": "${countryCode/*.replaceAll("+", "")*/}",
     "${ConstanceNetwork.mobileNumberKey}": "${profileViewModle.tdUserMobileNumberEdit.text}",
    };

    profileViewModle.contactMap.add(map);
    profileViewModle.update();
  }
}
