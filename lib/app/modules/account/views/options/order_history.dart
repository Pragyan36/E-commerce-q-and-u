import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/account_controller.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/order_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';

class OrderHistoryView extends StatelessWidget {
  OrderHistoryView({
    super.key,
  });

  final controller = Get.put(AccountController());
  final orderController = Get.put(OrderController());

  final List<Map> orderStatus = [
    {'icon': Icons.check_box_outlined, 'label': 'Order Confirmed', 'id': 0},
    {'icon': Icons.local_shipping_outlined, 'label': 'Order Shipment', 'id': 1},
    {'icon': Iconsax.gift, 'label': 'Package Arrived', 'id': 2},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Order Details'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Thanks for shopping with us.',
                style: titleStyle.copyWith(
                  color: AppColor.kalaAppMainColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'We are happy to serve you. Thank you for shopping with us. Please leave your review after receiving your products.',
                style: subtitleStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: orderController.locationTrack.length,
                        itemBuilder: (context, index) {
                          var data = orderController.locationTrack[index];
                          DateTime currentTime = DateTime.parse(
                            data.createdAt.toString(),
                          );

                          return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          DateFormat.yMMMMd()
                                              .format(currentTime),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${data.time.toString()} | ${data.statusValue}",
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      const Icon(Icons.shopping_cart),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${data.items.toString()} Items",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              //order confirmed
              // Obx(
              //   () => controller.selectedStatus.value == 0
              //       ? ListView.builder(
              //           shrinkWrap: true,
              //           itemCount: orderController.orderList.length,
              //           itemBuilder: (context, index) {
              //             var data = orderController.orderList[index];
              //             return data.pending == '1'
              //                 ? _buildOrderTile(data)
              //                 : Container();
              //           })
              //       : Container(),
              // ),

              // //shipped
              // Obx(
              //   () => controller.selectedStatus.value == 1
              //       ? ListView.builder(
              //           shrinkWrap: true,
              //           itemCount: orderController.orderList.length,
              //           itemBuilder: (context, index) {
              //             var data = orderController.orderList[index];
              //             return data.shipped == '1'
              //                 ? _buildOrderTile(data)
              //                 : Container();
              //           })
              //       : Container(),
              // ),

              // //deliverd
              // Obx(
              //   () => controller.selectedStatus.value == 2
              //       ? ListView.builder(
              //           shrinkWrap: true,
              //           itemCount: orderController.orderList.length,
              //           itemBuilder: (context, index) {
              //             var data = orderController.orderList[index];
              //             return data.delivered == '1'
              //                 ? _buildOrderTile(data)
              //                 : Container();
              //           })
              //       : Container(),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // _buildbutton({
  //   Color? iconClr,
  //   Color? bckClr,
  //   IconData? icon,
  //   label,
  //   ontap,
  // }) {
  //   return Column(
  //     children: [
  //       GestureDetector(
  //         onTap: ontap,
  //         child: CircleAvatar(
  //           radius: 30,
  //           backgroundColor: bckClr,
  //           child: Icon(
  //             icon,
  //             color: iconClr,
  //           ),
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 10,
  //       ),
  //       Text(
  //         label,
  //         style: subtitleStyle.copyWith(
  //           fontWeight: FontWeight.bold,
  //         ),
  //       )
  //     ],
  //   );
  // }

  // _buildOrderTile(data) {
  //   return ListTile(
  //     contentPadding: EdgeInsets.zero,
  //     leading: const Icon(Iconsax.chart_success),
  //     // Image.asset(AppImages.shoes),
  //     title: Text(
  //       data.refId.toString(),
  //       style: titleStyle,
  //     ),
  //     subtitle: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "Total price : Rs. ${data.totalPrice}",
  //           style: subtitleStyle,
  //         ),
  //         Text(
  //           "Payment Status : ${data.paymentStatus == '1' ? 'Paid' : 'Unpaid'}",
  //           style: subtitleStyle,
  //         ),
  //       ],
  //     ),
  //     onTap: () {
  //       Get.to(() => OrderDetails(userOrderData: data));
  //     },
  //   );
  // }
}
