import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_company/widget/header_code_verfication_widget.dart';
import 'package:inbox_clients/util/app_color.dart';

class ChangeMobileScreen extends StatelessWidget {
  const ChangeMobileScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: colorScaffoldRegistrationBody,
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          HeaderCodeVerfication(),
          
          
          ]),
    );
  }
}