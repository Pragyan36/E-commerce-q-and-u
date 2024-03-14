import 'package:get/get.dart';

import '../controllers/view_all_controller.dart';

class ViewAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewAllController>(
      () => ViewAllController(),
    );
  }
}
