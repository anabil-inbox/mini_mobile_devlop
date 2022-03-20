import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

import '../../../../../../../util/app_shaerd_data.dart';

// ignore: must_be_immutable
class QuantityWidget extends StatelessWidget {
  QuantityWidget({Key? key, required this.storageCategoriesData , required this.quantityTitle , required this.increasingFunction, required this.mineassingFunction  ,required this.value})
      : super(key: key);

  final StorageCategoriesData storageCategoriesData;
  StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  final String quantityTitle;
  final Function increasingFunction;
  final Function mineassingFunction;
  final int value;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return  
    Container(
          height: sizeH50,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(padding6!),
              border: Border.all(color: colorBorderContainer)),
          child: Row(
            children: [
              SizedBox(
                width: sizeW15,
              ),
              Text(quantityTitle),
              const Spacer(),
              Container(
                width: sizeH100,
                height: sizeH30,
                child: Stack(
                  children: [
                    PositionedDirectional(
                        bottom: padding0,
                        start: padding20,
                        end: padding20,
                        top: 0,
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(padding104!),
                        color: scaffoldColor,
                      ),
                      child: GetBuilder<StorageViewModel>(
                        init: StorageViewModel(),
                        initState: (_) {},
                        builder: (logic) {
                          return Text("$value",
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    )),
                    PositionedDirectional(
                        bottom: padding10! * -1,
                        end: padding3,
                        child: GetBuilder<StorageViewModel>(
                          init: StorageViewModel(),
                          initState: (_) {},
                          builder: (builder) {
                            return IconButton(
                              icon:
                                  SvgPicture.asset("assets/svgs/circle_mines.svg"),
                              onPressed: () {
                                mineassingFunction();
                                // builder.minesQuantity(
                                //     storageCategoriesData: storageCategoriesData);
                              },
                            );
                          },
                        )),
                    PositionedDirectional(
                    bottom: padding10! * -1,
                    end: padding52,
                    child: GetBuilder<StorageViewModel>(
                      init: StorageViewModel(),
                      initState: (_) {},
                      builder: (value) {
                        return IconButton(
                          icon: SvgPicture.asset("assets/svgs/circle_add.svg"),
                          onPressed: () {
                            increasingFunction();
                          //  value.increaseQuantity(storageCategoriesData: storageCategoriesData);
                          },
                        );
                      },
                    )),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
