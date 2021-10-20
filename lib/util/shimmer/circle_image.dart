import 'package:flutter/material.dart';
import '../app_color.dart';
import '../shimmer/shimmer_loading.dart';
import '../../util/app_shaerd_data.dart';
class ShimmerCircleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return ShimmerLoading(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Container(
          width: 54,
          height: 54,
          decoration:  BoxDecoration(
            color: colorBackground,
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.network(
              'https://flutter'
                  '.dev/docs/cookbook/img-files/effects/split-check/Avatar1.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
