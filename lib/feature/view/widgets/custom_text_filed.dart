// import 'dart:ui';


// import 'package:e_commerce_app/util/app_dimen.dart';
// import 'package:e_commerce_app/util/app_shaerd_data.dart';
// import 'package:e_commerce_app/util/app_color.dart';
// import 'package:e_commerce_app/util/string.dart';
// import 'package:e_commerce_app/util/app_style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class CustomTextFormFiled extends StatelessWidget  with AppDimen , AppStyle , AppSharedData{
//   final String? label;
//   final TextInputType? keyboardType;
//   final bool? obscureText, isBorder, isFill, isInputFormatters;
//   final Function(String)? customValid;
//   final Function(String)? onSubmitted;
//   final Function(String)? onChange;
//   final TextEditingController? controller;
//   final Color? fillColor;
//   final VoidCallback? fun;
//   final TextInputAction? textInputAction;
//   final bool? isSmallPadding, isSmallPaddingWidth, isReadOnly;
//   final int? maxLine, minLine;
//   final TextAlign? textAlign;
//   final int? maxLength;
//   final FocusNode? focusNode , nexFocusNode;
//   final bool? autoFocus;

//    CustomTextFormFiled({
//     Key? key,
//     this.label,
//     this.keyboardType,
//     this.obscureText = false,
//     this.customValid,
//     this.controller,
//     this.isBorder = true,
//     this.isFill = false,
//     this.fillColor,
//     this.isInputFormatters = false,
//     this.fun,
//     this.textInputAction,
//     this.isSmallPadding = false,
//     this.maxLine,
//     this.isSmallPaddingWidth = false,
//     this.minLine,
//     this.isReadOnly = false,
//     this.textAlign,
//     this.maxLength,
//     this.onSubmitted,
//     this.onChange, this.focusNode, this.nexFocusNode, this.autoFocus = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     screenUtil(context);
//     return TextFormField(
//       maxLength: maxLength,
//       autofocus: autoFocus!,
//       focusNode: focusNode,
//       onTap: fun,
//       cursorColor: colorPrimaryDark,
//       textAlignVertical: TextAlignVertical.top,
//       textAlign: textAlign ?? TextAlign.left,
//       controller: controller,
//       obscureText: obscureText!,
//       obscuringCharacter: '*',
//       maxLines: maxLine ?? 1,
//       minLines: minLine ?? 1,
//       readOnly: isReadOnly ?? false,
//       style: textInputFiled(),
//       textDirection:TextDirection.ltr ,
//       // textDirection:obscureText!?TextDirection.ltr:TextDirection.rtl ,
//       textInputAction: textInputAction ?? TextInputAction.newline,
//       // ignore: missing_return
//       validator: (String? value) {
//         if (value!.isEmpty || value == "") {
//           return messageFiled;
//         } else if (customValid != null) {
//           return customValid!(value);
//         } else {
//           return null;
//         }
//       },
//       onChanged: (value) {
//         if (onChange != null) onChange!(value);
//       },
//       onFieldSubmitted: (value) {
//         try {
//           focusNode?.unfocus();
//           FocusScope.of(context).requestFocus(nexFocusNode/*?? FocusNode()*/);
//           onSubmitted!(value);

//         } catch (e) {
//           print(e);
//           focusNode?.unfocus();
//         }
//       },
//       onSaved: (newValue) {
//         focusNode?.unfocus();
//         FocusScope.of(context).requestFocus(nexFocusNode/*?? FocusNode()*/); //remo
//       },
//       decoration: InputDecoration(
//           counterText: "",
//           isDense: true,
//           filled: isFill,
//           errorStyle: TextStyle(
//               /*  height: 0,*/ /*backgroundColor: colorBackground*/
//               ),
//           enabledBorder: isFill!
//               ? UnderlineInputBorder(
//                   borderRadius: BorderRadius.circular(sizeRadius!),
//                   borderSide: BorderSide(color: colorTrans))
//               : UnderlineInputBorder(
//                   borderRadius: BorderRadius.circular(sizeRadius!),
//                   borderSide: BorderSide(color: colorBorderTextFiled)),
//           fillColor: fillColor ?? colorBackground,
//           contentPadding: EdgeInsets.only(
//               left: isSmallPaddingWidth! ? sizeW10! : sizeW40!,
//               right: isSmallPaddingWidth! ? sizeW10! : sizeW26!,
//               top: isSmallPadding! ? sizeW18! : sizeH20!,
//               bottom: isSmallPadding! ? sizeW18! : sizeH20!),
//           hintText: label,
//           hintStyle: textInputFiledHint(),
//           focusedBorder: isBorder!
//               ?  UnderlineInputBorder(
//                   borderRadius: BorderRadius.circular(sizeRadius!),
//                   borderSide: BorderSide(color: colorPrimary, width: 2))
//               : InputBorder.none,
//           border: isBorder!
//               ? UnderlineInputBorder(
//                   borderRadius: BorderRadius.circular(sizeRadius!),
//                   borderSide: BorderSide(color: colorBorderTextFiled ))
//               : InputBorder.none),
//       keyboardType: keyboardType ?? TextInputType.emailAddress,

//       inputFormatters: isInputFormatters!
//           ? [FilteringTextInputFormatter.digitsOnly, new CustomInputFormatter()]
//           : [],
//     );
//   }
// }

// class CustomInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     var text = newValue.text;

//     if (newValue.selection.baseOffset == 0) {
//       return newValue;
//     }

//     var buffer = new StringBuffer();
//     for (int i = 0; i < text.length; i++) {
//       buffer.write(text[i]);
//       var nonZeroIndex = i + 1;
//       if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
//         buffer.write(
//             ' '); // Replace this with anything you want to put after each 4 numbers
//       }
//     }

//     var string = buffer.toString();
//     return newValue.copyWith(
//         text: string,
//         selection: new TextSelection.collapsed(offset: string.length));
//   }
// }
