import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class RequestNewStorageHeader extends StatelessWidget {
  const RequestNewStorageHeader({Key? key, required this.currentLevel})
      : super(key: key);

  final int currentLevel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding16!),
      margin: EdgeInsets.symmetric(vertical : padding20!),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(padding6!),
          color: colorTextWhite),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SvgPicture.asset("assets/svgs/level_one.svg"),
              Container(
                width: 300,
                child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Boxes"),
                    Text("Location"),
                    Text("Payment")
                  ],
                ),
              ),
              
            ],
          )
        ],
      ),
    );
  }
}
