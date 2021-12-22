import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/sh_util.dart';

class NotAllowedScreen extends StatelessWidget {
  const NotAllowedScreen({Key? key}) : super(key: key);

 static List<NotAllowed>? notAlwoed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Column(
        children: [
          SizedBox(
            height: sizeH40,
          ),
          Row(
            children: [
              SizedBox(
                width: sizeW20,
              ),
              IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset("assets/svgs/cross.svg")),
              SizedBox(
                width: sizeW50,
              ),
              Text("Not allowed Content"),
              const Spacer()
            ],
          ),
          GetBuilder<StorageViewModel>(
            init: StorageViewModel(),
            initState: (_) {
              notAlwoed = ApiSettings.fromJson(SharedPref.instance.getAppSetting()).notAllowed ;
            },
            builder: (_) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: sizeW10!,
                      crossAxisSpacing: sizeH10!,
                      childAspectRatio: (sizeW165! / sizeH150)),
                  itemBuilder: (context, index) => Text("data"));
            },
          )
        ],
      ),
    );
  }
}
