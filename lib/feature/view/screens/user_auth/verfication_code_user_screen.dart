import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/screens/user_auth/header_verfication_code.dart';

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