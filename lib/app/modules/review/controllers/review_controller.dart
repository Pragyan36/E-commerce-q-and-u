// ignore_for_file: unnecessary_overrides

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  final count = 0.obs;
  final selectedindex = 0.obs;
  final selectedEmojiindex = 0.obs;
  final commentCon = TextEditingController();
  @override
  void onInit() {
    selectedindex.value = 0;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
