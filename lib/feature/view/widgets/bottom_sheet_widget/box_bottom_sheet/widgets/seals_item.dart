import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/inside_box/seal.dart';

class SealsItem extends StatelessWidget {
  const SealsItem({Key? key, required this.seal}) : super(key: key);

  final Seal seal;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            seal.seal ?? "",
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
