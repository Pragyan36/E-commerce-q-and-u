import 'package:flutter/material.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';

class CustomNoImageWidget extends StatelessWidget {
  const CustomNoImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: AppColor.kalaAppMainColor,
        ),
        SizedBox(
          height: 5,
        ),
        Text("Oops! No Image"),
      ],
    );
  }
}
