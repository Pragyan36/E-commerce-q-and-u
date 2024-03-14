import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    Key? key,
    required this.widget,
    this.baseColor,
    this.highlightColor,
  }) : super(key: key);

  final Widget widget;
  final Color? highlightColor;
  final Color? baseColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      // baseColor: Colors.grey.shade300,
      // highlightColor: Colors.grey.shade100,
      highlightColor: highlightColor ?? Colors.grey.shade200,
      baseColor: baseColor ?? Colors.white,
      child: widget,
    );
  }
}
