import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class ContactItemWidget extends StatelessWidget {
  final String? flag;
  final String? prefix;
  final String? mobileNumber;
  final Function(String)? onChange;
  final Function()? deleteContact;

  const ContactItemWidget(
      {Key? key,
      this.flag,
      this.prefix,
      this.onChange,
      this.mobileNumber,
      this.deleteContact})
      : super(key: key);

  ProfileViewModle get viewModel => Get.find<ProfileViewModle>();
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Row(
      children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.hardEdge,
            height: sizeH54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: colorTextWhite,
            ),
            child: Row(
              textDirection: TextDirection.ltr,
              children: [
                SizedBox(
                  width: sizeW18,
                ),
                Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    Text(
                      "$prefix",
                      textDirection: TextDirection.ltr,
                    ),
                         SizedBox(
                            width: sizeW5,
                          ),
                    VerticalDivider(),
                  ],
                ),
                Text("$mobileNumber")
              ],
            ),
          ),
        ),
        SizedBox(
          width: sizeW4,
        ),
        InkWell(
          onTap: deleteContact ?? () {},
          child: SvgPicture.asset(
            "assets/svgs/delete_box_widget.svg",
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
