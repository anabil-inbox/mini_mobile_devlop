import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/country.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';


import '../auth_user/widget/country_item_widget.dart';

// ignore: must_be_immutable
class ChooseCountryScreen extends StatefulWidget {
  ChooseCountryScreen({Key? key}) : super(key: key);

  @override
  State<ChooseCountryScreen> createState() => _ChooseCountryScreenState();
}

class _ChooseCountryScreenState extends State<ChooseCountryScreen> {
  final controller = PagingController<int, Country>(firstPageKey: 1);

  final repo = AuthViewModle();

  Logger log = Logger();

  Country selctedCountry = Country();
  AuthViewModle authViewModle = Get.put(AuthViewModle());
  @override
  void initState() {
    super.initState();

    authViewModle.tdSearch.clear();
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    controller.addPageRequestListener((pageKey) async {
      final data = await repo.getCountries(1 + (pageKey ~/ 10), 250);
      controller.appendPage(data.toList(), pageKey + data.length);
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(Get.context!);
          },
          icon: SvgPicture.asset(isArabicLang()?"assets/svgs/back_arrow_ar.svg":"assets/svgs/back_arrow.svg"),
        ),
        title: Text(
          "${tr.choose_country}",
        // style: textStyleAppbar(),
          style : textStyleAppBarTitle(),
        ),
        centerTitle: true,
        backgroundColor: colorBackground,
      ),
      body: GetBuilder<AuthViewModle>(
        init: AuthViewModle(),
        builder: (logic) {
          return Column(
            children: [
              Container(
                height: sizeH10,
                color: colorScaffoldRegistrationBody,
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorScaffoldRegistrationBody,
                ),
                padding: EdgeInsets.symmetric(horizontal: sizeH20!),
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          "assets/svgs/search_icon.svg",
                        ),
                      ),
                      hintText:
                          "${tr.search_for_country}"),
                  onChanged: (newVal) {
                    logic.tdSearch.text = newVal.toString();
                    logic.update();
                  },
                ),
              ),
              SizedBox(height: sizeH16,),
              Expanded(
                child: PagedListView(
                  pagingController: controller,
                  builderDelegate: PagedChildBuilderDelegate<Country>(
                      newPageProgressIndicatorBuilder: (ctx) {
                    return const SizedBox();
                  }, itemBuilder: (context, item, index) {
                    return InkWell(
                      onTap: () {
                        logic.selectedIndex = -1;
                        logic.selectedIndex = index;
                        selctedCountry = item;
                        logic.update();
                      },
                      child: Container(
                          color: colorScaffoldRegistrationBody,
                          padding: EdgeInsets.symmetric(horizontal: sizeH20!,),
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
                    textButton: "${tr.ok}",
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
