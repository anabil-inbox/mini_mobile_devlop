// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:grouped_list/grouped_list.dart';
// import 'package:inbox_clients/feature/model/home/Box_modle.dart';
// import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/btn_action_widget.dart';
// import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/items_widget.dart';
// import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/text_with_contanier_widget.dart';
// import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
// import 'package:inbox_clients/feature/view/widgets/custom_text_filed.dart';
// import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
// import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
// import 'package:inbox_clients/util/app_color.dart';
// import 'package:inbox_clients/util/app_dimen.dart';
// import 'package:inbox_clients/util/app_shaerd_data.dart';
// import 'package:inbox_clients/util/app_style.dart';
// import 'package:inbox_clients/util/constance.dart';

// // ignore: must_be_immutable
// class FilterStorageNameView extends StatelessWidget {
//   FilterStorageNameView({Key? key}) : super(key: key);

//   static ItemViewModle itemViewModle = Get.find<ItemViewModle>();

//   List<String> list = [
//     "A firsItem",
//     "B Second Item",
//     "A firtItem",
//     "B Secund Item",
//     "A fistItem",
//     "B Seound Item",
//     "A frstItem",
//     "B Scound Item",
//   ];

//   //todo this for appbar
//   PreferredSizeWidget get appBar => CustomAppBarWidget(
//         isCenterTitle: true,
//         titleWidget: CustomTextView(
//           txt: "${tr.filter_by_name}",
//           textStyle: textStyleNormal()?.copyWith(color: colorBlack),
//           maxLine: Constance.maxLineOne,
//         ),
//         actionsWidgets: [
//           GetBuilder<ItemViewModle>(
//               init: ItemViewModle(),
//               builder: (logic) {
//                 return TextButton(
//                   onPressed: () {
//                     logic.updateSelectBtn();
//                   },
//                   child: logic.isSelectBtnClick!
//                       ? SizedBox(
//                           width: sizeW40,
//                           child: TextButton(
//                             onPressed: () {
//                               logic.updateSelectAll(list);
//                             },
//                             child: logic.isSelectAllClick
//                                 ? SvgPicture.asset(
//                                     "assets/svgs/storage_check_active.svg")
//                                 : SvgPicture.asset(
//                                     "assets/svgs/storage_check_deactive.svg"),
//                           ),
//                         )
//                       : CustomTextView(
//                           txt: "${tr.select}",
//                           textStyle:
//                               textStyleNormal()?.copyWith(color: colorRed),
//                           maxLine: Constance.maxLineOne,
//                         ),
//                 );
//               }),
//         ],
//       );

//   //todo this for search
//   Widget get searchWidget => CustomTextFormFiled(
//         iconSize: sizeRadius20,
//         maxLine: Constance.maxLineOne,
//         icon: Icons.search,
//         iconColor: colorBlack,
//         textInputAction: TextInputAction.search,
//         keyboardType: TextInputType.text,
//         onSubmitted: (_) {},
//         onChange: (_) {},
//         isSmallPadding: false,
//         isSmallPaddingWidth: true,
//         fillColor: colorBackground,
//         isFill: true,
//         isBorder: true,
//         label: tr.search,
//       );

//   Widget get btnActionsWidget => BtnActionWidget();

//   @override
//   Widget build(BuildContext context) {
//     screenUtil(context);
//     return Scaffold(
//       appBar: appBar,
//       body: GetBuilder<ItemViewModle>(
//           init: ItemViewModle(),
//           builder: (logic) {
//             return Column(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                         top: sizeH20!, left: sizeW20!, right: sizeW20!),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         searchWidget,
//                         SizedBox(
//                           height: sizeH20,
//                         ),
//                         Expanded(
//                           child: GroupedListView<BoxItem, String>(
//                             elements: itemViewModle.operationsBox!.items!,
//                             groupBy: (element) => element.itemName![0],
//                             groupSeparatorBuilder: (String groupByValue) =>
//                                 Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   height: sizeH10,
//                                 ),
//                                 SizedBox(
//                                   width: sizeW30,
//                                   height: sizeH31,
//                                   child: TextContainerWidget(
//                                     colorBackground: colorRedTrans,
//                                     txt: groupByValue,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: sizeH10,
//                                 ),
//                               ],
//                             ) /*, Text(groupByValue , textAlign: TextAlign.start,)*/,
//                             itemBuilder: (context, BoxItem element) =>
//                             ItemsWidget(
//                               box: itemViewModle.operationsBox!,
//                               boxItem: element,
//                               isSelectedBtnClick: logic.isSelectBtnClick,
//                               onCheckItem: () {
//                                 logic.addIndexToList(element.itemName.toString());
//                               },
//                             ),
//                             itemComparator: (item1, item2) {
//                              return item1.itemName![0].compareTo(item2.itemName![0]);
//                             },
//                             // optional
//                             useStickyGroupSeparators: false,
//                             // optional
//                             floatingHeader: false,
//                             // optional
//                             order: GroupedListOrder.ASC,
//                             // optional
//                             physics: customScrollViewIOS(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 btnActionsWidget,
//                 SizedBox(
//                   height: Platform.isIOS ? sizeH20 : sizeH10,
//                 ),
//               ],
//             );
//           }),
//     );
//   }
// }
