// ignore_for_file: subtype_of_sealed_class

import 'dart:io';

// import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_company/register/register_company.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

void main() async {


  // testWidgets('should return data when the call to remote source is succesful.' ,(WidgetTester tester) async {
  //
  //   final FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
  //   await fakeFirebaseFirestore.collection("condition").doc("condition").set({
  //     "hide":false
  //   });
  //   ///
  //   bool isHide = false;
  //
  //   ///
  //   // final FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
  //   final CollectionReference mockCollectionReference = fakeFirebaseFirestore.collection("condition");
  //   var documentSnapshot = await mockCollectionReference.doc("condition").get();
  //   var data = documentSnapshot.data();
  //   Logger().d((data as dynamic)?["hide"] /*?? false*/);
  //   Logger().d((data as dynamic));
  //
  //   ///
  //   expect((data as dynamic)?["hide"] /*?? false*/, isHide);
  // });

  // TestWidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await SharedPref.instance.init();
  // await AppFcm.fcmInstance.init();
  // var bool = await FirebaseUtils.instance.isHideWallet();
  // await SharedPref.instance.setIsHideSubscriptions(bool);
  // portraitOrientation();
  // HttpOverrides.global = MyHttpOverrides();
  // DioManagerClass.getInstance.init();
  // loginWidgetTest();
}

// void loginWidgetTest() {
//   testWidgets("test login page", (WidgetTester tester) async {
//     ///Arrange
//     await getLocalizations(tester);
//     await tester.pumpWidget(GetMaterialApp(
//       locale: Locale(SharedPref.instance.getAppLanguageMain().split("_")[0]),
//       localizationsDelegates: [
//         AppLocalizations.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: [
//         Locale('en', ''),
//         Locale('ar', ''),
//       ],
//       home: Localizations(
//         locale: Locale('en', ''),
//         delegates: [
//           AppLocalizations.delegate,
//           GlobalMaterialLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//           GlobalCupertinoLocalizations.delegate,
//         ],
//         child: GetBuilder<AuthViewModle>(
//             init: AuthViewModle(),
//             builder: (logic) {
//               return RegisterCompanyScreen();
//             }),
//       ),
//     ));
//
//     ///act
//     var tr = await getLocalizations(tester);
//     Finder finderText = find.text(tr.company_registration);
//
//     ///assert
//     expect(finderText, findsOneWidget);
//   });
// }
//
// Future<AppLocalizations> getLocalizations(WidgetTester t) async {
//   late AppLocalizations result;
//   await t.pumpWidget(
//     MaterialApp(
//       localizationsDelegates: AppLocalizations.localizationsDelegates,
//       supportedLocales: AppLocalizations.supportedLocales,
//       home: Material(
//         child: Builder(
//           builder: (BuildContext context) {
//             result = AppLocalizations.of(context)!;
//             return Container();
//           },
//         ),
//       ),
//     ),
//   );
//   return result;
// }
