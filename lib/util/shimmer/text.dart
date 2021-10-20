import 'package:flutter/material.dart';
import '../app_color.dart';
import '../shimmer/shimmer_loading.dart';
import '../../util/app_shaerd_data.dart';
class ShimmerText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return ShimmerLoading(
      child: Container(
        width: double.infinity,
        height: 24,
        decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
