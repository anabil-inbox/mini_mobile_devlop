import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomTextView extends StatelessWidget {
  final String? txt;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final int? maxLine;
  final TextOverflow? textOverflow;
  final bool? IsUpperCase;

  const CustomTextView({Key? key, this.txt, this.textAlign, this.textStyle, this.maxLine, this.textOverflow, this.IsUpperCase = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      IsUpperCase!?txt!.toUpperCase():txt!,
      textDirection: TextDirection.ltr,
      overflow: textOverflow,
      textAlign: textAlign,
      style: textStyle,
      maxLines: maxLine,
    );
  }
}
