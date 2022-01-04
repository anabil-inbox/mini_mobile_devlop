import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/tasks_widgets/VAS_item.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class VASWidget extends StatelessWidget {
  const VASWidget({Key? key, required this.vas}) : super(key: key);

  final List<VAS> vas;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizeH20!, vertical: sizeW15!),
      decoration: BoxDecoration(
          border: Border.all(color: colorContainerGray),
          borderRadius: BorderRadius.circular(padding6!)),
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: vas.map((e) =>
         VASItem(vas: e)).toList(),
      ),
    );
  }
}
