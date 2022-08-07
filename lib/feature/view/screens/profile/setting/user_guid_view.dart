import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/view/screens/profile/setting/user_guid_details.dart';
import 'package:inbox_clients/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';

class UserGuidView extends StatefulWidget {
  const UserGuidView({Key? key}) : super(key: key);

  @override
  State<UserGuidView> createState() => _UserGuidViewState();
}

class _UserGuidViewState extends State<UserGuidView> {
   List<UserGuide>? _userGuid = [];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _runFilter("");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorTextWhite,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 1,
        title: Text(
          "${tr.user_guid}",
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
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: CustomTextFormFiled(
            //     icon: Icons.search,
            //     label: tr.search,
            //     isBorder: true,
            //     isFill: false,
            //     fillColor: colorBtnGray,
            //     isOutlineBorder: true,
            //     enabledBorderColor: colorBtnGray,
            //     textInputAction: TextInputAction.search,
            //     keyboardType: TextInputType.text,
            //     onChange: (vale) {
            //      /* if (vale.isNotEmpty && vale.length > 3)*/ _runFilter(vale);
            //     },
            //   ),
            // ),
            /*SharedPref.instance.getAppSettings()?.userGuide != null &&
                    SharedPref.instance.getAppSettings()!.userGuide!.isNotEmpty*/
            _userGuid!.isNotEmpty
                ? ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                      top: sizeH20!, right: sizeW15!, left: sizeW15!),
                  itemCount:
                  _userGuid!.length/*SharedPref.instance.getAppSettings()!.userGuide!.length*/,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var userGuide = /*SharedPref.instance
                        .getAppSettings()!
                        .userGuide*/_userGuid![index];
                    return InkWell(
                      onTap: (){
                        Get.to(UserGuidDetails(userGuide:userGuide));
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        padding: EdgeInsets.all( padding12!),
                        decoration: BoxDecoration(
                            color: colorTextWhite,
                            borderRadius: BorderRadius.circular(padding12!),
                            border: Border.all(color: Colors.transparent),
                            boxShadow: [boxShadowLight()!]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            CustomTextView(txt: userGuide.title.toString(),),
                            isArabicLang()
                                ? Icon(Icons.arrow_forward_ios , size: 12,)
                                : Icon(Icons.arrow_forward_ios, size: 12,),
                          ],
                        )
                        /*Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(

                            collapsedIconColor: colorBlack,
                            collapsedBackgroundColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            childrenPadding:
                                EdgeInsets.symmetric(horizontal: padding12!),
                            textColor: colorBlack,
                            collapsedTextColor: colorBlack,
                            iconColor: colorBlack,
                            title: Text(
                              userGuide.title.toString(),
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                            children: <Widget>[
                              HtmlWidget(
                                '${userGuide.text}',
                                enableCaching: true,
                                baseUrl:
                                    Uri.parse("${ConstanceNetwork.imageUrl}"),
                                onLoadingBuilder:
                                    (context, element, loadingProgress) =>
                                        Center(child: CircularProgressIndicator()),
                                onTapUrl: (url) {
                                  Logger().d(url);
                                  openBrowser(url);
                                  return true;
                                },
                                onErrorBuilder: (context, element, error) {
                                  return Center(child: CircularProgressIndicator());
                                },
                                webView: true,
                                webViewDebuggingEnabled: true,
                                webViewJs: true,
                                webViewMediaPlaybackAlwaysAllow: true,
                                webViewUserAgent:
                                    "${ConstanceNetwork.imageUrl}",
                                renderMode: RenderMode.column,
                              ),
                              SizedBox(
                                height: sizeH10!,
                              ),
                            ],
                          ),
                        )*/,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(color: colorTrans,);
                  },
                )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<UserGuide>? results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      if(SharedPref.instance.getAppSettings()?.userGuide != null &&
          SharedPref.instance.getAppSettings()!.userGuide!.isNotEmpty) {
        results = SharedPref.instance.getAppSettings()!.userGuide;
      }else{
        results = [];
      }
    } else {
      results = SharedPref.instance
          .getAppSettings()!
          .userGuide!
          .where((user) =>
              user.title!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _userGuid = results;
    });
  }
}
