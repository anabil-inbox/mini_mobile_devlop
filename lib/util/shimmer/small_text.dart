import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_color.dart';
import '../shimmer/shimmer_loading.dart';
import '../../util/app_shaerd_data.dart';
class ShimmerSmallText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return ShimmerLoading(
      child: Container(
        width: 250.w,
        height: 18.h,
        decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
