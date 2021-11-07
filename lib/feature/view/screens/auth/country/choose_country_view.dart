import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/country.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../auth_user/widget/country_item_widget.dart';

// ignore: must_be_immutable
class ChooseCountryScreen extends StatelessWidget {
  ChooseCountryScreen({Key? key}) : super(key: key);
  
  final controller = PagingController<int, Country>(firstPageKey: 1);
  final repo = AuthViewModle();
  Logger log = Logger();
  Country selctedCountry = Country();

  @override
  Widget build(BuildContext context) {
    
    controller.addPageRequestListener((pageKey) async {
      final data = await repo.getCountries(1 + (pageKey ~/ 10) , 10);
      controller.appendPage(data.toList(), pageKey + data.length);
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(Get.context!);
          },
          icon: SvgPicture.asset("assets/svgs/back_arrow.svg"),
        ),
        title: Text(
          "${AppLocalizations.of(Get.context!)!.choose_country}",
          style: textStyleLargeText(),
        ),
        centerTitle: true,
        backgroundColor: colorBackground,
      ),
      body: GetBuilder<AuthViewModle>(
        init: AuthViewModle(),
        initState: (_) {},
        builder: (logic) {
          return Column(
            children: [
              Container(
                color: colorScaffoldRegistrationBody,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          "assets/svgs/search_icon.svg",
                        ),
                      ),
                      hintText:
                          "${AppLocalizations.of(Get.context!)!.search_for_country}"),
                  onChanged: (newVal) {
                    logic.tdSearch.text = newVal.toString();
                    logic.update();
                  },
                ),
              ),
              Container(
                height: sizeH10,
                color: colorScaffoldRegistrationBody,
              ),
              Expanded(
                child: PagedListView(
                  pagingController: controller,
                  builderDelegate: PagedChildBuilderDelegate<Country>(
                      itemBuilder: (context, item, index) {
                    return InkWell(
                      onTap: () {
                        logic.selectedIndex = -1;
                        logic.selectedIndex = index;
                        selctedCountry = item;
                        logic.update();
                      },
                      child: Container(
                          color: colorScaffoldRegistrationBody,
                          padding: EdgeInsets.symmetric(horizontal: sizeH20!),
                          child: logic.tdSearch.text.isEmpty ||
                                  item.name.toString().toUpperCase().contains(
                                      logic.tdSearch.text.toUpperCase())
                              ? CountryItem(
                                  cellIndex: index,
                                  selectedIndex: logic.selectedIndex,
                                  item: item,
                                )
                              : SizedBox()),
                    );
                  }),
                ),
              ),
              Container(
                color: colorScaffoldRegistrationBody,
                padding: EdgeInsets.all(10),
                child: PrimaryButton(
                    isLoading: false,
                    textButton: "${AppLocalizations.of(Get.context!)!.ok}",
                    onClicked: () {
                      logic.defCountry = selctedCountry;
                      logic.update();
                      Navigator.pop(context);
                    },
                    isExpanded: true),
              ),
              Container(
                height: sizeH20,
                color: colorScaffoldRegistrationBody,
              ),
            ],
          );
        },
      ),
    );
  }
}
