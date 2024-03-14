import 'package:q_and_u_furniture/app/modules/staffdashboard/controllers/dashboard_controller.dart';
import 'package:get/get.dart';

class StaffDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaffDashboardController>(
      () => StaffDashboardController(),
    );
  }
}
