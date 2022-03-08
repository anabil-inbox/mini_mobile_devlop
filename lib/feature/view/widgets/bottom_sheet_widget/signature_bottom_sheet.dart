// ignore_for_file: unused_local_variable

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

import 'package:signature/signature.dart';

import '../custome_text_view.dart';

class SignatureBottomSheet extends StatefulWidget {
  const SignatureBottomSheet({Key? key,required this.onSignatureCallBack}) : super(key: key);
  final Function(SignatureController?)? onSignatureCallBack;

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  static void showSignatureBottomSheet(){
    Get.bottomSheet(SignatureBottomSheet(onSignatureCallBack: (SignatureController? controller) {
       var bytes = controller?.toPngBytes();
       var image = controller?.toImage();
    },));
  }

  @override
  State<SignatureBottomSheet> createState() => _SignatureBottomSheetState();
}

class _SignatureBottomSheetState extends State<SignatureBottomSheet> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.grey,
  );


  Widget get signatureControllerWidget => Container(
    decoration:  BoxDecoration(color: colorUnSelectedWidget),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        //SHOW EXPORTED IMAGE IN NEW ROUTE
        IconButton(
          icon: const Icon(Icons.check),
          color: Colors.black,
          onPressed: onCheckBtnClick,
        ),
        IconButton(
          icon: const Icon(Icons.undo),
          color: Colors.black,
          onPressed: () {
            setState(() => _controller.undo());
          },
        ),
        IconButton(
          icon: const Icon(Icons.redo),
          color: Colors.black,
          onPressed: () {
            setState(() => _controller.redo());
          },
        ),
        //CLEAR CANVAS
        IconButton(
          icon: const Icon(Icons.clear),
          color: Colors.black,
          onPressed: () {
            setState(() => _controller.clear());
          },
        ),
      ],
    ),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return SingleChildScrollView(
      primary: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(padding30!)),
          color: colorTextWhite,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: sizeH20),
            SvgPicture.asset('assets/svgs/Indicator.svg'),
            SizedBox(height: sizeH20),
            CustomTextView(
              txt: "Add Signature",
              textStyle: textStyleNormal()
                  ?.copyWith(fontSize: fontSize18, color: colorBlack),
            ),
            SizedBox(height: sizeH14),
            Signature(
              controller: _controller,
              height: 230,
              backgroundColor: colorUnSelectedWidget,
            ),
            SizedBox(height: sizeH10),
            signatureControllerWidget,
            SizedBox(height: sizeH10),
            // PrimaryButton(
            //     textButton: txtADD.tr,
            //     isLoading: false,
            //     colorBtn: _controller.isEmpty ? colorHint:colorPrimary,
            //     onClicked:_controller.isEmpty? (){}: (){
            //       widget.onSignatureCallBack!(_controller);
            //     },
            //     isExpanded: true),
          ],
        ),
      ),
    );
  }

  //this for view the signature in other screen
  void onCheckBtnClick() async {
    if (_controller.isNotEmpty) {
      final Uint8List? data =
      await _controller.toPngBytes();
      if (data != null) {
       SignatureBottomSheet.homeViewModel.signatureOutput = data;
        await SignatureBottomSheet.homeViewModel.uploadCustomerSignature(isFingerPrint: false);
        SignatureBottomSheet.homeViewModel.update();
        Get.back();
        // await Navigator.of(context).push(
        //   MaterialPageRoute<void>(
        //     builder: (BuildContext context) {
        //       return Scaffold(
        //         appBar: AppBar(),
        //         body: Center(
        //           child: Container(
        //             color: colorUnSelectedWidget,
        //             child: Image.memory(data ,
        //               height: (MediaQuery.of(context).size.height / 2),
        //               width: (MediaQuery.of(context).size.width),),
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // );
      }
    }
  }
}
