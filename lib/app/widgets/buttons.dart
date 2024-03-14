import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/account_controller.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';

import '../constants/constants.dart';

class CustomButtonss extends GetView<AccountController> {
  const CustomButtonss({
    Key? key,
    required this.label,
    required this.btnClr,
    required this.txtClr,
    required this.ontap,
    this.margin,
    this.width,
  }) : super(key: key);

  final String label;
  final Color btnClr;
  final Color txtClr;
  final VoidCallback ontap;
  final EdgeInsets? margin;

  final double? width;

  @override
  Widget build(BuildContext context) {
    final cartControllerLoading = Get.put(CartController());

    return SizedBox(
      height: 50,
      width: width ?? 200,
      child: Container(
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 0),
        padding: const EdgeInsets.symmetric(horizontal: 0),
        decoration: const BoxDecoration(boxShadow: []),
        child: Obx(
          () => MaterialButton(
            onPressed: ontap,
            elevation: 5,
            color: btnClr,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: cartControllerLoading.addCartLoading.value
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ))
                : Text(
                    label,
                    style: titleStyle.copyWith(color: txtClr),
                  ),
          ),
        ),
      ),
    );
  }
}
