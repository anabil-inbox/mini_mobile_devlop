import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';

class IntroActiveDot extends StatelessWidget {
  const IntroActiveDot({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      child: Container(
      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:  colorPrimary
                        ),
                        child: SizedBox(
                                width: 28,
                                height: 3,
                              )  
                      ),
    );
  }
}