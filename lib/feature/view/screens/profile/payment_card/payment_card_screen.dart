import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/screens/payment/payment_screen.dart';
import 'package:inbox_clients/feature/view/screens/profile/payment_card/widgets/payment_card_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:get/get.dart';

class PaymentCardScreen extends StatelessWidget {
  const PaymentCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleWidget: Text(
          tr.payment_card,
          style: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
      ),
      body: GetBuilder<ProfileViewModle>(
          init: ProfileViewModle(),
          initState: (state) {
            WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
              state.controller?.getCards();
            });
          },
          builder: (logic) {
            if (logic.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
              return Padding(
              padding: EdgeInsets.symmetric(horizontal: padding20!),
              child: Stack(
                children: [
                  if (logic.isLoading)...[
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ]else if(!logic.isLoading && logic.cardsData?.cards == null)...[
                    Center(child: Text("${tr.no_cards_yet}"))
                  ]
                  else if(logic.cardsData?.cards != null && logic.cardsData!.cards!.isNotEmpty)...[
                  Container(
                    margin: EdgeInsets.only(bottom: sizeH100!),
                    child: ListView.builder(
                      shrinkWrap: false,
                      itemCount: logic.cardsData?.cards?.length,
                      itemBuilder: (context , index){
                        return PaymentCardWidget(card:logic.cardsData!.cards![index]);
                      },
                      // children: [
                      //   SizedBox(
                      //     height: sizeH10,
                      //   ),
                      //   PaymentCardWidget(),
                      //   SizedBox(
                      //     height: sizeH10,
                      //   ),
                      //   PaymentCardWidget(),
                      //   SizedBox(
                      //     height: sizeH10,
                      //   ),
                      //   PaymentCardWidget(),
                      //   SizedBox(
                      //     height: sizeH10,
                      //   ),
                      // ],
                    ),
                  ),

                  ],
                  PositionedDirectional(
                      bottom: padding32,
                      start: padding20,
                      end: padding20,
                      child: PrimaryButton(
                        isExpanded: true,
                        isLoading: logic.isLoading,
                        textButton: tr.add_new_card,
                        onClicked: () => _onAddCardClick(logic),
                      ))
                ],
              ),
            );

          }),
    );
  }

  _onAddCardClick(ProfileViewModle logic) {
    logic.addCard();
  }
}
