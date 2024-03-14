// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';

void getSnackbar({String? message, Color? bgColor, IconData? leadingIcon, bool error = false}) =>
    Get.showSnackbar(
      GetBar(
        onTap: (value) {
          Get.back();
        },
        duration: const Duration(milliseconds: 1600),
        message: message ?? "message",
        animationDuration: const Duration(milliseconds: 600),
        isDismissible: true,
        shouldIconPulse: false,
        snackPosition: SnackPosition.BOTTOM,
        dismissDirection: DismissDirection.endToStart,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        icon: Icon(
         error ?Icons.error: Icons.check_circle , //?? Icons.info_outline,
          color: Colors.white,
        ),
        backgroundColor: bgColor ?? AppColor.mainClr,
        borderRadius: 10,
      ),
    );
