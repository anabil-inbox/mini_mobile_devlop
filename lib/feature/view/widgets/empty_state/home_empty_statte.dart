import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

import '../../../../util/app_shaerd_data.dart';

class EmptyHomeWidget extends StatelessWidget {
  const EmptyHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      body: Stack(
        children: [
          PositionedDirectional(
            top: 50,
            start: 0,
            end: 0,
            child: SvgPicture.asset(
              "assets/svgs/box_empty.svg",
              fit: BoxFit.cover,
            ),
          ),
          PositionedDirectional(
              start: 20,
              end: 0,
              bottom: 200,
              child: Text(
                tr.no_storage,
                style: textStyleIntroTitle(),
                textAlign: TextAlign.center,
              )),
          PositionedDirectional(
              start: 40,
              end: 40,
              bottom: 150,
              child: Text(
                tr.you_have_no_storag,
                textAlign: TextAlign.center,
                style: textStyleHint()!.copyWith(
                    fontSize: fontSize15, fontWeight: FontWeight.normal),
              ))
        ],
      ),
    );
  }
}
