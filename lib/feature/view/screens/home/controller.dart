import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/home/home_screen.dart';
import 'package:inbox_clients/feature/view/screens/profile/profile_screen.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class HomePageHolder extends StatefulWidget {
  const HomePageHolder({Key? key}) : super(key: key);

  @override
  State<HomePageHolder> createState() => _HomePageHolderState();
}

class _HomePageHolderState extends State<HomePageHolder> {
  int index = 1;
  List<Widget> bnbScreens = [
    const HomeScreen(),
    const Center(child: const Text("Screen")),
    const Center(child: const Text("Screen")),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeViewModel>(
          init:HomeViewModel() ,
          builder: (logic) {
        return bnbScreens[logic.currentIndex];
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        onPressed: () {},
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
      bottomNavigationBar: GetBuilder<HomeViewModel>(
        init: HomeViewModel(),
        builder: (logic) {
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(sizeRadius16!),
                    topRight: Radius.circular(sizeRadius16!))),
            child: BottomAppBar(
              color: colorTextWhite,
              shape: CircularNotchedRectangle(),
              notchMargin: 8,
              child: Padding(
                padding: EdgeInsets.all(sizeH6!),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            logic.changeTab(0);
                            print('main');
                          },
                          minWidth: sizeW48,
                          child: logic.currentIndex == 0
                              ? SvgPicture.asset(
                              "assets/svgs/home_selected.svg")
                              : SvgPicture.asset("assets/svgs/home.svg"),
                        ),
                        SizedBox(width: sizeW20),
                        MaterialButton(
                          onPressed: () {
                            logic.changeTab(1);
                            print('Event');
                          },
                          minWidth: sizeW48,
                          child: logic.currentIndex == 1
                              ? SvgPicture.asset(
                              "assets/svgs/document_selected.svg")
                              : SvgPicture.asset("assets/svgs/document.svg"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            logic.changeTab(2);
                          },
                          minWidth: sizeW48,
                          child: logic.currentIndex == 2
                              ? SvgPicture.asset(
                              "assets/svgs/notification_selected.svg")
                              : SvgPicture.asset(
                              "assets/svgs/notification.svg"),
                        ),
                        SizedBox(width: sizeW20),
                        MaterialButton(
                          onPressed: () {
                            logic.changeTab(3);
                          },
                          minWidth: sizeW48,
                          child: logic.currentIndex == 3
                              ? SvgPicture.asset(
                              "assets/svgs/profile_selected.svg")
                              : SvgPicture.asset("assets/svgs/profile.svg"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget buildBottomNavBar(BuildContext context) {
  //   return Container(
  //     height: sizeH60,
  //     width: double.infinity,
  //     clipBehavior: Clip.hardEdge,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.circular(sizeH20!),
  //       ),
  //     ),
  //     child: BottomNavigationBar(
  //         backgroundColor: colorTextWhite,
  //         type: BottomNavigationBarType.fixed,
  //         currentIndex: index,
  //         onTap: (int index) =>
  //             setState(() {
  //               this.index = index;
  //             }),
  //         showSelectedLabels: false,
  //         showUnselectedLabels: false,
  //         selectedItemColor: Theme
  //             .of(context)
  //             .primaryColor,
  //         items: [
  //           BottomNavigationBarItem(
  //               icon: index == 0
  //                   ? SvgPicture.asset("assets/svgs/home_selected.svg")
  //                   : SvgPicture.asset("assets/svgs/home.svg"),
  //               label: ""),
  //           BottomNavigationBarItem(
  //               icon: index == 1
  //                   ? SvgPicture.asset("assets/svgs/document_selected.svg")
  //                   : SvgPicture.asset("assets/svgs/document.svg"),
  //               label: ""),
  //           BottomNavigationBarItem(
  //               icon: index == 2
  //                   ? SvgPicture.asset("assets/svgs/notification_selected.svg")
  //                   : SvgPicture.asset("assets/svgs/notification.svg"),
  //               label: ""),
  //           BottomNavigationBarItem(
  //               icon: index == 3
  //                   ? SvgPicture.asset("assets/svgs/profile_selected.svg")
  //                   : SvgPicture.asset("assets/svgs/profile.svg"),
  //               label: ""),
  //         ]),
  //   );
  // }
  //
  // Widget _getScreen() {
  //   switch (index) {
  //     case 0:
  //       return const HomeScreen();
  //     case 3:
  //       return const ProfileScreen();
  //     default:
  //       return Center(child: const Text("Screen"));
  //   }
  // }
}
