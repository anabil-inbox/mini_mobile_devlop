import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class RequestNewStorageHeader extends StatelessWidget {
  const RequestNewStorageHeader({Key? key, required this.currentLevel})
      : super(key: key);

  final int currentLevel;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.all(padding16!),
      margin: EdgeInsets.symmetric(vertical: padding20!),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(padding6!),
          color: colorTextWhite),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Column(
                textDirection: TextDirection.ltr,
                mainAxisSize: MainAxisSize.min,
                children: [
                  currentLevel == 0
                      ? SvgPicture.asset("assets/svgs/level_one_orange.svg")//level_one
                      : currentLevel == 1
                      ? SvgPicture.asset("assets/svgs/level_two_oranage.svg")//level_two
                      : SvgPicture.asset("assets/svgs/level_three_orange.svg"),
                ],
              ),
              SizedBox(
                height: sizeH7,
              ),
              Container(
                width: MediaQuery.of(context).size.width - sizeW90!,
                child: Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${tr.type}",
                      style: currentLevel == 0
                          ? TextStyle(color: colorPrimary)
                          : TextStyle(),
                    ),
                    const Spacer(),
                    Text(
                      "${tr.location}",
                      style: currentLevel == 1
                          ? TextStyle(color: colorPrimary)
                          : TextStyle(),
                    ),
                    const Spacer(),
                    Text(
                      "${tr.payment}",
                      style: currentLevel == 2
                          ? TextStyle(color: colorPrimary)
                          : TextStyle(),
                    ),
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
