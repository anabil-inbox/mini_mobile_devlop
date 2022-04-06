import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/signature_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

class ContractSignature extends StatelessWidget {
  const ContractSignature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    screenUtil(context);
    return Container(
            padding:
                EdgeInsets.symmetric(horizontal: sizeW5!, vertical: sizeH13!),
            height: sizeH50,
            decoration: BoxDecoration(
              color: colorTextWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
              onTap: () {
                SignatureBottomSheet.showSignatureBottomSheet();
              },
              child: Row(
                children: <Widget>[
                  Container(
                    height: sizeH30,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: colorBtnGray),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20,
                        child: Container(
                            decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorRed,
                        )),
                        // backgroundColor: colorRed,
                      ),
                    ),
                  ),
                  SizedBox(width: sizeW5),
                  CustomTextView(
                    txt: tr.contract_signature,
                    textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                  ),
                ],
              ),
            ),
          );
        
  }
}
