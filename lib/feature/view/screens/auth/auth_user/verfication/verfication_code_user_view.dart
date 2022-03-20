import 'package:flutter/material.dart';
import '../../../../../../util/app_shaerd_data.dart';
import '../widget/header_verfication_code_widget.dart';

class VerficationCodeUserScreen extends StatelessWidget {
  const VerficationCodeUserScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      body: Column(
        children: [
          HeaderVervication(),
          
        ],
      ),
    );
  }
}