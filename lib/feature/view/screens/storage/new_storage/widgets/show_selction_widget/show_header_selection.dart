import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class ShowHeaderSelection extends StatelessWidget {
  const ShowHeaderSelection({ Key? key  , required this.storageName , required this.quantityOrSpace}) : super(key: key);


  final String storageName;
  final String quantityOrSpace;
  
  @override
  Widget build(BuildContext context) {
    return Row(
            children: [
              SvgPicture.asset("assets/svgs/folder_icon.svg"),
              SizedBox(
                width: sizeW5,
              ),
              Text(
                "$storageName",
                style: textStyleNormalBlack(),
              ),
              const Spacer(),
              Container(
                  decoration: BoxDecoration(
                      color: colorTextWhite,
                      borderRadius: BorderRadius.circular(padding9!)),
                  padding: EdgeInsets.symmetric(
                      vertical: padding9!, horizontal: padding4!),
                  child: Text("3 x 6")),
              SizedBox(
                width: sizeW20,
              ),
              SvgPicture.asset("assets/svgs/delete.svg"),
              SizedBox(
                width: sizeW10,
              ),
              SvgPicture.asset("assets/svgs/update_icon.svg"),
            ],
          );
  }
}