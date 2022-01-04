import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class PhotoItem extends StatelessWidget {
  const PhotoItem({Key? key, required this.img , this.url , required this.isFromLocal}) : super(key: key);

  final File? img;
  final String? url;
  final bool isFromLocal;
  @override
  Widget build(BuildContext context) {
    return Container(
       height: sizeH50,
        width: sizeW50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(padding6!),
      ),
      child: isFromLocal ? Image.file(
        img!,
        height: sizeH50,
        width: sizeW50,
      ) : imageNetwork(url: ConstanceNetwork.imageUrl+(url ?? urlPlacholder!)),
    );
  }
}
