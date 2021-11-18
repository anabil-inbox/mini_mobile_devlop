import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/feature/view/screens/home/home_screen.dart';
import 'package:inbox_clients/feature/view/screens/profile/profile_screen.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class Controller extends StatefulWidget {
  const Controller({Key? key}) : super(key: key);

  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreen(),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () { 

          },
          child: Icon(Icons.add),
          elevation: 2.0,
        ),
      bottomNavigationBar: Container(
        height: sizeH60,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
             top:  Radius.circular(sizeH20!),
         
        )),
        child: BottomNavigationBar(
          backgroundColor: colorTextWhite,
          
          type: BottomNavigationBarType.fixed,
            currentIndex: index,
            onTap: (int index) => setState(() {
                  this.index = index;
                }),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Theme.of(context).primaryColor,
            items: [
              BottomNavigationBarItem(icon: index == 0 ? SvgPicture.asset("assets/svgs/home_selected.svg") :  SvgPicture.asset("assets/svgs/home.svg"), label: ""),
              BottomNavigationBarItem(icon: index == 1 ? SvgPicture.asset("assets/svgs/document_selected.svg") : SvgPicture.asset("assets/svgs/document.svg"), label: ""),
              BottomNavigationBarItem(icon: index == 2 ? SvgPicture.asset("assets/svgs/notification_selected.svg") : SvgPicture.asset("assets/svgs/notification.svg"), label: ""),
              BottomNavigationBarItem(icon: index == 3 ? SvgPicture.asset("assets/svgs/profile_selected.svg") : SvgPicture.asset("assets/svgs/profile.svg"), label: ""),
            ]),
      ),
    );
  }

  Widget _getScreen() {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 3:
        return const ProfileScreen();
      default:
        return Center(child: const Text("Screen"));
    }
  }
}
