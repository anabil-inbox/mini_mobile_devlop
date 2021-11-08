import 'package:flutter/material.dart';
import '../widget/header_verfication_code_widget.dart';

class VerficationCodeUserScreen extends StatelessWidget {
  const VerficationCodeUserScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderVervication(),
          
        ],
      ),
    );
  }
}