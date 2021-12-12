import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/viedo_player.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class BottomSheetDetaielsWidget extends StatelessWidget {
  const BottomSheetDetaielsWidget(
      {Key? key, required this.storageCategoriesData, required this.media})
      : super(key: key);

  final StorageCategoriesData storageCategoriesData;
  final List<String> media;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(padding30!)),
          color: colorTextWhite,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: sizeH20,
            ),
            Container(
              height: sizeH5,
              width: sizeW50,
              decoration: BoxDecoration(
                  color: colorSpacer,
                  borderRadius: BorderRadius.circular(padding3)),
            ),
            SizedBox(
              height: sizeH20,
            ),
            Text(storageCategoriesData.storageName ?? ""),
            SizedBox(
              height: sizeH20,
            ),
            getPageCount(array: media) == 0
                ? const SizedBox()
                : Column(
                    children: [
                      Container(
                        height: sizeH300,
                        width: sizeW320,
                        child: PageView.builder(
                          itemCount: getPageCount(array: media),
                          itemBuilder: (context, index) {
                            return isVideo(path: media[index])
                                ? VideoPlayer(
                                    videoUrl: "${media[index]}",
                                  )
                                : imageNetwork(
                                    url:
                                        "${ConstanceNetwork.imageUrl}${media[index]}");
                          
                          },
                        ),
                      ),
                      
                    ],
                  ),
            SizedBox(
              height: sizeH20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeH30!),
              child:
                  CustomTextView(txt: storageCategoriesData.description ?? ""),
            ),
            SizedBox(
              height: sizeH20,
            ),
          ],
        ),
      ),
    );
  }
}
