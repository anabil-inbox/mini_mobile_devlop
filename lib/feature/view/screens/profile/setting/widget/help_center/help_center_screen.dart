import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../../util/app_color.dart';
import '../../../../../../../util/app_dimen.dart';
import '../../../../../../../util/app_shaerd_data.dart';
import '../../../../../../../util/app_style.dart';
import '../../../../../widgets/custome_text_view.dart';
import '../../../../../widgets/primary_button.dart';
import 'help_center_widget/email_box.dart';
import 'help_center_widget/full_name_box.dart';
import 'help_center_widget/social_share_buttons.dart';
import 'help_center_widget/write_her_box.dart';

class HelpCenterScreen extends StatelessWidget {
  final bool? helpCenter;

  const HelpCenterScreen({
    Key? key,
    this.helpCenter = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorScaffoldRegistrationBody,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 1,
          title: Text(
            helpCenter! ? tr.txtHelpCenter: tr.txtTirms,
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
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding20!),
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        right: 104, left: 102, top: 44.5, bottom: 25),
                  ),
                  CustomTextView(
                    textAlign: TextAlign.start,
                    txt: tr.txtFollow,
                    textStyle: textHelpFollow(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        right: 49.3, left: 49, top: 25, bottom: 33),
                  ),
                  const SocialShareButtons(),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 33, bottom: 33),
                      child: Container(
                        color: colorScaffoldRegistrationBody,
                        child: Column(
                          children: [
                            CustomTextView(
                              textAlign: TextAlign.start,
                              txt: tr.txtTechnicalSupport,
                              textStyle: textHelp(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const FullName(),
                  const SingleChildScrollView(
                      child: Padding(
                    padding: EdgeInsets.only(
                        right: 20, left: 20, top: 10, bottom: 10),
                  )),
                  const Email(),
                  const SingleChildScrollView(
                      child: Padding(
                    padding: EdgeInsets.only(
                        right: 20, left: 20, top: 10, bottom: 10),
                  )),
                  const WriteHere(),
                  const SingleChildScrollView(
                      child: Padding(
                    padding: EdgeInsets.only(
                        right: 20, left: 20, top: 10 ),
                  )),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 9.5, left: 20.5, bottom: 33.5 ,top: 165.5),
                      child: Container(
                        color: colorScaffoldRegistrationBody,
                        child: Column(
                          children: [
                            PrimaryButton(
                              isExpanded: true,
                              isLoading: false,
                              textButton: tr.send,
                              onClicked: () {
                                // logic.isSelected = !logic.isSelected;
                                // logic.update();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ]))));
  }
}
