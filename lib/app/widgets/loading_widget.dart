import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: LoadingAnimationWidget.discreteCircle(
          color: AppColor.kalaAppMainColor,
          size: 40,
        ),
      ),
    );
  }
}
