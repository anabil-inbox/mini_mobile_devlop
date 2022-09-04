import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class IntroBody extends StatelessWidget {
  const IntroBody(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.description,
      required this.index})
      : super(key: key);
  final String imagePath;
  final String title;
  final String description;
  final int index;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          imageNetwork(
              url:"$imagePath",
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width),
          if (title.isNotEmpty) ...[
            SizedBox(
              height:  sizeH36!,
            ),
            Text(
              "$title",
              textAlign: TextAlign.center,
              style:
              textStyleIntroTitle()!.copyWith(fontSize: fontSize21),
            ),
            SizedBox(
              height: sizeH7,
            ),
          ],
          if (description.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeW12!),
              child: CustomTextView(
                txt: "$description",
                textAlign: TextAlign.start,
                maxLine: 12,
                textOverflow: TextOverflow.ellipsis,
                textStyle: textStyleIntroBody()!
                    .copyWith(height: 1.5, fontSize: fontSize14),
              ),
            ),
            SizedBox(
              height: sizeH28,
            ),
          ],
        ],
      ),
    );
  }
}
