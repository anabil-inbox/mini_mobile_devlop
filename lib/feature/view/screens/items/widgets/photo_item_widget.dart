import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class PhotoItem extends StatelessWidget {
  const PhotoItem(
      {Key? key, required this.img, this.url, required this.isFromLocal})
      : super(key: key);

  final File? img;
  final String? url;
  final bool isFromLocal;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(padding6!),
      ),
      child: isFromLocal
          ? Image.file(
              img!,
              fit: BoxFit.cover,
              height: sizeH50,
              width: sizeH50,
            )
          : imageNetwork(
              url: ConstanceNetwork.imageUrl + (url ?? urlPlacholder!),
              fit: BoxFit.cover,
              height: sizeH50,
              width: sizeW100,
            ),
    );
  }
}
