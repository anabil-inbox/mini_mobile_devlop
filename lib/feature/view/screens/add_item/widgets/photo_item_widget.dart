import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class PhotoItem extends StatelessWidget {
  const PhotoItem({Key? key, required this.img}) : super(key: key);

  final File img;

  @override
  Widget build(BuildContext context) {
    return Container(
       height: sizeH50,
        width: sizeW50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(padding6!),
      ),
      child: Image.file(
        img,
        height: sizeH50,
        width: sizeW50,
      ),
    );
  }
}
