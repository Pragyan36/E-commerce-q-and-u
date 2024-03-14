import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/account_controller.dart';
import 'package:q_and_u_furniture/app/modules/payment/controllers/payment_controller.dart';

class CustomButtons extends GetView<AccountController> {
  final String label;
  final Color btnClr;
  final Color txtClr;
  final VoidCallback ontap;
  final EdgeInsets? margin;
  final double? width;

  const CustomButtons({
    Key? key,
    required this.label,
    required this.btnClr,
    required this.txtClr,
    required this.ontap,
    this.margin,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentController = Get.put(PaymentController());

    return SizedBox(
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
            child: paymentController.isCashPaymentConfirmed == true ||
                    paymentController.esewaLoading.value == true ||
                    paymentController.khaltiLoading.value == true
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
