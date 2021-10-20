import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shimmer/shimmer.dart';
class ShimmerLoading  extends StatelessWidget {
  final Widget? child;

  const ShimmerLoading({Key? key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Shimmer.fromColors( highlightColor:Color(0xFFF4F4F4) ,baseColor: Color(0xFFEBEBF4),child: child!);
  }
}
