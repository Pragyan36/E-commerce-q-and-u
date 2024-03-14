import 'package:flutter/material.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final bool isCircle;

  const CustomLoadingIndicator({
    super.key,
    required this.isCircle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isCircle
          ? const CircularProgressIndicator(
              backgroundColor: AppColor.kalaAppSecondaryColor,
              valueColor: AlwaysStoppedAnimation(
                AppColor.kalaAppMainColor,
              ),
            )
          : const LinearProgressIndicator(
              backgroundColor: AppColor.kalaAppSecondaryColor,
              valueColor: AlwaysStoppedAnimation(
                AppColor.kalaAppMainColor,
              ),
            ),
    );
  }
}
