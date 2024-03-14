import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 200,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.box_remove,
              size: 30.sp,
              color: AppColor.kalaAppMainColor,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              text,
              style: titleStyle,
            ),
          ],
        ),
      ),
    );
  }
}
