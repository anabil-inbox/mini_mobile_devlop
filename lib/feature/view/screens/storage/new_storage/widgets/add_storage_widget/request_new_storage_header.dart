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
              currentLevel == 0
                  ? SvgPicture.asset("assets/svgs/level_one.svg")
                  : currentLevel == 1
                      ? SvgPicture.asset("assets/svgs/level_two.svg")
                      : SvgPicture.asset("assets/svgs/level_three.svg"),
              SizedBox(
                height: sizeH7,
              ),
              Container(
                width: MediaQuery.of(context).size.width - sizeW90!,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${tr.boxes}",
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
