import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/account_controller.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/order_controller.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/order_history.dart';
import 'package:intl/intl.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import '../controllers/notification_controller.dart';

class NotificationDetailPage extends StatefulWidget {
  String orderID;

  NotificationDetailPage({
    super.key,
    required this.orderID,
  });

  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  final notificationController = Get.put(NotificationController());
  final controller = Get.put(OrderController());

  @override
  void initState() {
    notificationController.fetchOrderDetailsForNotification(widget.orderID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final accountController = Get.put(AccountController());
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Order Details',
        trailing: Container(),
      ),
      body: Obx(
        () => notificationController.loading.value == false
            ? Column(
                children: [
                  _buildOrderDetailsCard(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await controller
                              .getLocationTrack(
                                  accountController.email.value.text.trim(),
                                  notificationController
                                      .orderDetailFromNotificationDetails
                                      .value
                                      .refId)
                              .then((value) => Get.to(OrderHistoryView()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.grey,
                                ),
                                Text(
                                  'Track Order',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Order# ${notificationController.orderDetailFromNotificationDetails.value.refId ?? 0}",
                                style: titleStyle.copyWith(
                                    color: AppColor.mainClr,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notificationController
                                            .orderDetailFromNotificationDetails
                                            .value
                                            .paymentStatus ==
                                        1
                                    ? 'Paid'
                                    : "Unpaid",
                                style: subtitleStyle,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Shipping Method',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Home Delivery',
                                    style: subtitleStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text('Payment Method',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  Text(
                                    notificationController
                                        .orderDetailFromNotificationDetails
                                        .value
                                        .paymentWith
                                        .toString(),
                                    style: subtitleStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Delivery Status',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    notificationController
                                                .orderDetailFromNotificationDetails
                                                .value
                                                .statusValue ==
                                            null
                                        ? ''
                                        : notificationController
                                            .orderDetailFromNotificationDetails
                                            .value
                                            .statusValue
                                            .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                  notificationController
                                              .orderDetailFromNotificationDetails
                                              .value
                                              .cancelReasonStatus ==
                                          true
                                      ? GestureDetector(
                                          onTap: () {
                                            controller
                                                .cancelReason(
                                                    notificationController
                                                        .orderDetailFromNotificationDetails
                                                        .value
                                                        .id,
                                                    context)
                                                .then((value) {});
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(05),
                                                color: Colors.green),
                                            child: const Text(
                                              'View',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Row(
                                    children: [],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Total Price: ${thousandSepretor.format(notificationController.orderDetailFromNotificationDetails.value.totalPrice)}",
                                    style: titleStyle.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  _buildOrderDetailsCard(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ship and bill to:',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${notificationController.orderDetailFromNotificationDetails.value.name}\n${notificationController.orderDetailFromNotificationDetails.value.phone}',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              '${notificationController.orderDetailFromNotificationDetails.value.province}, ${notificationController.orderDetailFromNotificationDetails.value.district}, ${notificationController.orderDetailFromNotificationDetails.value.area}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 30,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: notificationController
                    .orderDetailFromNotificationDetails
                    .value
                    .orderAssets!
                    .length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var items = notificationController
                      .orderDetailFromNotificationDetails
                      .value
                      .orderAssets?[index];
                  return ListTile(
                    leading: items!.product != null &&
                            items.product!.images != null &&
                            items.product!.images!.isNotEmpty &&
                            items.product!.images!.first.image != null
                        ? Image.network(
                            items.product!.images!.first.image!.replaceAll(
                              RegExp(r'http://127.0.0.1:8000'),
                              url,
                            ),
                            height: 70,
                            width: 90,
                          )
                        : Image.asset(AppImages.placeHolder),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(items.productName.toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Rs. ${thousandSepretor.format(items.price)}",
                          style: titleStyle.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    subtitle: Text("${items.qty} X items"),
                  );
                }),
            ListTile(
              leading: const Icon(Icons.card_giftcard),
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Package",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
              subtitle: Text(
                "Ordered on  ${DateFormat('dd/MM/yyyy').format(DateTime.parse(notificationController.orderDetailFromNotificationDetails.value.createdAt.toString()))}",
                style: subtitleStyle,
              ),
              trailing: Text(
                notificationController.orderDetailFromNotificationDetails.value
                            .statusValue ==
                        null
                    ? ''
                    : notificationController
                        .orderDetailFromNotificationDetails.value.statusValue
                        .toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ],
    );
  }
}
