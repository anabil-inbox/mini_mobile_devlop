import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
    children: [
     Positioned(
  right: 0,
  left: 0,
  bottom:0,
  child: SvgPicture.asset("assets/svgs/intro_photo_2.svg",fit: BoxFit.fill,)
  
  )
    ],
  )
    );
  }
}