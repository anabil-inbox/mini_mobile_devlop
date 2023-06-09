import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

import 'widget/searched_box_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            Container(
              color: colorTextWhite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: sizeH50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: sizeW20,
                      ),
                      Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: scaffoldColor,
                              borderRadius: BorderRadius.circular(12)
                            ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: sizeW20,
                            ),
                            SvgPicture.asset(
                              "assets/svgs/search_icon.svg",
                            ),
                            Expanded(
                              child: CustomTextFormFiled(
                                // icon: Icons.search,
                                onChange: (p0) {
                                  if (p0.isEmpty) {
                                    homeViewModel.searchedBoxess.clear();
                                  } else {
                                    homeViewModel.searchForBox(searchText: p0);
                                  }
                                },
                                autoFocus: true,
                                // iconSize: 24,
                                isFill: true,
                                isSmallPaddingWidth: true,
                                controller: homeViewModel.tdSearch,
                                fillColor: scaffoldColor,
                              ),
                            ),
                          ],
                        ),
                      )),
                      SizedBox(
                        width: sizeW10,
                      ),
                      TextButton(
                          onPressed: () {
                            homeViewModel.tdSearch.clear();
                            homeViewModel.searchedBoxess.clear();
                            Get.close(1);
                          },
                          child: Text(
                            "${tr.cancle}",
                            style: textStylePrimary()!
                                .copyWith(fontSize: fontSize14),
                          )),
                      SizedBox(
                        width: sizeW10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizeH10,
                  )
                ],
              ),
            ),
            GetBuilder<HomeViewModel>(
              init: HomeViewModel(),
              initState: (_) {},
              builder: (_) {
                return SearchedBoxWidget();
              },
            )
          ],
        ),
      ),
    );
  }
}
