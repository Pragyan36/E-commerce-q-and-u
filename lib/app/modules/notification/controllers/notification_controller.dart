// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';

import '../../../data/services/product_service.dart';
import '../views/oder_detail_noti.dart';

class NotificationController extends GetxController {
  final count = 0.obs;
  var orderDetailFromNotificationDetails = NotificaitonOrderDetailsData().obs;
  var loading = false.obs;

  @override
  void onInit() {
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

  fetchOrderDetailsForNotification(orderID) async {
    loading(true);
    var data = await ProductService().oderdetailsFromNotification(orderID);

    if (data != null) {
      loading(false);
      orderDetailFromNotificationDetails.value =
          NotificaitonOrderDetailsData.fromJson(data['data']);
    }
  }
}
