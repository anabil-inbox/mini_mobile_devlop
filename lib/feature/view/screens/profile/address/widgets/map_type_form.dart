import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/location_helper.dart';

import '../map.dart';

class MapTypeForm extends StatelessWidget {
  const MapTypeForm({Key? key}) : super(key: key);

  static ProfileViewModle profileViewModle = Get.find<ProfileViewModle>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Column(
      children: [
        SizedBox(
          height: sizeH20,
        ),
        TextFormField(
          onSaved: (newValue) {
            profileViewModle.tdTitle.text = newValue!;
            profileViewModle.update();
          },
          controller: profileViewModle.tdTitle,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '${tr.fill_the_title_correctly}';
            }
            return null;
          },
          decoration: InputDecoration(hintText: "${tr.title}"),
        ),
        SizedBox(
          height: sizeH10,
        ),


        TextFormField(
          onTap: () async{
            /*var isDenied = */await LocationHelper.instance.isDenied().then((value) {
              if(value) {
                Get.to(() => MapSample());
              }
            });
          },
          onSaved: (newValue) {
            profileViewModle.tdLocation.text = newValue!;
            profileViewModle.update();
          },
          readOnly: true,
          controller: profileViewModle.tdLocation,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '${tr.choose_your_location}';
            }
            return null;
          },
          decoration: InputDecoration(
              enabled: true,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  "assets/png/location_orang.png",
                  width: 10,
                  height: 10,
                ),
              ),
              suffixStyle: TextStyle(color: Colors.transparent),
              hintText: "${tr.choose_your_location}"),
        ),
        SizedBox(
          height: sizeH10,
        ),
        TextFormField(
          onTap: () {
            profileViewModle.showZoneBottmSheet();
          },
          readOnly: true,
          onSaved: (newValue) {
            profileViewModle.tdZone.text = newValue!;
            profileViewModle.update();
          },
          controller: profileViewModle.tdZone,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '${tr.fill_the_zone_correctly}';
            }
            return null;
          },
          decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: (){
                  profileViewModle.showZoneBottmSheet();
                },
                child: Padding(
                  padding: EdgeInsets.all(padding6!),
                  child: SvgPicture.asset("assets/svgs/down_arrow.svg"),
                ),
              ),
              hintText: "${tr.zone}"),
        ),
        SizedBox(
          height: sizeH10,
        ),
        // TextFormField(
        //   onTap: (){
        //     // if(profileViewModle.tdZone.text.isNotEmpty) {
        //       profileViewModle.showZoneNumberBottmSheet();
        //     // }
        //   },
        //   onSaved: (newValue) {
        //     profileViewModle.tdZoneNumber.text = newValue!;
        //     profileViewModle.update();
        //   },
        //   controller: profileViewModle.tdZoneNumber,
        //   // readOnly: true,
        //   validator: (value) {
        //     if (value == null || value.trim().isEmpty) {
        //       return '${tr.fill_the_zone_correctly}';
        //     }
        //     return null;
        //   },
        //   keyboardType: TextInputType.numberWithOptions(),
        //   decoration: InputDecoration(hintText: "${tr.zone_number}" , ),
        // ),
        // SizedBox(
        //   height: sizeH10,
        // ),
        // TextFormField(
        //   onSaved: (newValue) {
        //     profileViewModle.tdStreet.text = newValue!;
        //     profileViewModle.update();
        //   },
        //   controller: profileViewModle.tdStreet,
        //   validator: (value) {
        //     if (value == null || value.trim().isEmpty) {
        //       return '${tr.fill_the_title_correctly}';
        //     }
        //     return null;
        //   },
        //   decoration: InputDecoration(hintText: "${tr.street}"),
        // ),
        // SizedBox(
        //   height: sizeH10,
        // ),
        // TextFormField(
        //   onSaved: (newValue) {
        //     profileViewModle.tdBuildingNo.text = newValue!;
        //     profileViewModle.update();
        //   },
        //   controller: profileViewModle.tdBuildingNo,
        //   validator: (value) {
        //     if (value == null || value.trim().isEmpty) {
        //       return '${tr.fill_the_title_correctly}';
        //     }
        //     return null;
        //   },
        //   decoration: InputDecoration(hintText: "${tr.building_no}"),
        // ),
        // SizedBox(
        //   height: sizeH10,
        // ),
        TextField/*Form*/(
          /*onSaved*/onSubmitted: (newValue) {
            profileViewModle.tdUnitNo.text = newValue/*!*/;
            profileViewModle.update();
          },
          controller: profileViewModle.tdUnitNo,
          // validator: (value) {
          //   if (value == null || value.trim().isEmpty) {
          //     return '${tr.fill_the_title_correctly}';
          //   }
          //   return null;
          // },
          decoration: InputDecoration(hintText: "${tr.unit_no}"),
        ),

        SizedBox(
          height: sizeH10,
        ),
      ],
    );
  }
}
