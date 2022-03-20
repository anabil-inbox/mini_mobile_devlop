import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';

import '../../../../../../util/app_shaerd_data.dart';
import 'intro_unactive_dot_widget.dart';

// ignore: must_be_immutable
class IntroActiveDot extends StatelessWidget {
  IntroActiveDot({Key? key, required this.index, required this.numberOfDots})
      : super(key: key);

  int numberOfDots = 0;
  int index;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);

    return  Container(
      height: 3,
      width: 28,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: numberOfDots,
        itemBuilder: (context, index) => 
        numberOfDots == index + 1? 
        Container(
          alignment: Alignment.center,
          color: colorPrimary,  
          width: 100/3,
          height: 3,
        ) : IntroUnActiveDot(),
      ),
    );
  }
}
