import 'package:flutter/material.dart';
import '../app_color.dart';
import '../shimmer/shimmer_loading.dart';
import '../../util/app_shaerd_data.dart';
class ShimmerLargeRoundedImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return ShimmerLoading(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://flutter'
              '.dev/docs/cookbook/img-files/effects/split-check/Food1.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
