import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.label,
      required this.btnClr,
      required this.txtClr,
      this.width,
      required this.ontap})
      : super(key: key);

  final String label;
  final Color btnClr;
  final Color txtClr;
  final VoidCallback ontap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width ?? 200,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(boxShadow: []),
        child: MaterialButton(
          onPressed: ontap,
          elevation: 5,
          color: btnClr,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(
            label,
            style: titleStyle.copyWith(color: txtClr),
          ),
        ),
      ),
    );
  }
}
