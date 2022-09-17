// import 'dart:io';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get/get.dart';
// import 'package:inbox_clients/fcm/app_fcm.dart';
// import 'package:inbox_clients/main.dart';
// import 'package:inbox_clients/network/api/dio_manager/dio_manage_class.dart';
// import 'package:inbox_clients/network/firebase/firebase_utils.dart';
// import 'package:inbox_clients/util/app_shaerd_data.dart';
// import 'package:inbox_clients/util/sh_util.dart';
// import 'package:inbox_clients/feature/view/screens/auth/auth_company/register/register_company.dart';
// import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
// import 'package:inbox_clients/util/app_style.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// void main() async{
//   TestWidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await SharedPref.instance.init();
//   await AppFcm.fcmInstance.init();
//   var bool = await FirebaseUtils.instance.isHideWallet();
//   await SharedPref.instance.setIsHideSubscriptions(bool);
//   portraitOrientation();
//   HttpOverrides.global = MyHttpOverrides();
//   DioManagerClass.getInstance.init();
//   loginWidgetTest();
// }
//
// void loginWidgetTest() {
//
//   testWidgets("test login page", (WidgetTester tester) async {
//     ///Arrange
//     await getLocalizations(tester);
//     await tester.pumpWidget(GetMaterialApp(
//       locale: Locale(SharedPref.instance.getAppLanguageMain().split("_")[0]),
//       localizationsDelegates: [
//          AppLocalizations.delegate,
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
//           return RegisterCompanyScreen();
//         }),
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