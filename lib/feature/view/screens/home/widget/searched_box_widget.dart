import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/search_body_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class SearchedBoxWidget extends StatelessWidget {
  const SearchedBoxWidget({Key? key}) : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<HomeViewModel>(
        init: HomeViewModel(),
        initState: (_) {},
        builder: (_) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding20!),
            child: Column(
              children: [
                SizedBox(
                  height: sizeH20,
                ),
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(padding6!)),
                  child: ExpansionPanelList(
                    animationDuration: const Duration(seconds: 1),
                    expansionCallback: (int index, bool isExpanded) {
                      homeViewModel.searchedBoxess.toList()[index].isExpanded =
                          !isExpanded;
                      homeViewModel.update();
                    },
                    children: homeViewModel.searchedBoxess
                        .toList()
                        .map((item) => buildExpansionPanel(item: item))
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ExpansionPanel buildExpansionPanel({required Box item}) {
    return ExpansionPanel(
      isExpanded: item.isExpanded!,
      canTapOnHeader: true,
      
      headerBuilder: (BuildContext context, bool isExpanded) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(padding6!)),
          child: Column(
            children: [
              SizedBox(
                height: sizeH18,
              ),
              Row(
                children: [
                  SizedBox(
                    width: sizeW15,
                  ),
                  SvgPicture.asset("assets/svgs/folder_icon.svg"),
                  SizedBox(
                    width: sizeW10,
                  ),
                  Expanded(child: CustomTextView(txt: "${item.storageName}")),
                ],
              ),
              SizedBox(
                height: sizeH18,
              ),
            ],
          ),
        );
      },
      body: ListView(
        padding: const EdgeInsets.all(0),
            shrinkWrap: true,
        children: item.items!.map((e) => SearchBodyWidget(
                  item: e,
                  date: item.modified,
                ))
            .toList(),
      ),
    );
  }
}
