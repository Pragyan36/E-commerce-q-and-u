import 'package:flutter/material.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';

class NoProductWidget extends StatelessWidget {
  const NoProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            AppImages.noproductImage,
            width: 100,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Oops! No products found!",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
