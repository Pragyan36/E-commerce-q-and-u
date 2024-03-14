import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';

class CustomCircularIcon extends StatelessWidget {
  const CustomCircularIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: const CircleAvatar(
          backgroundColor: AppColor.kalaAppAccentColor,
          radius: 20,
          child: Icon(
            Icons.close,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
