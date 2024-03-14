import 'dart:isolate';
import 'dart:ui';

import 'package:q_and_u_furniture/app/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/account_controller.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/order_controller.dart';

import 'package:intl/intl.dart';

import '../../../../widgets/custom_appbar.dart';

class OrderDetailsViewStaff extends StatefulWidget {
  OrderDetailsViewStaff({super.key, required this.taskDetail});

  Tasks taskDetail;

  @override
  State<OrderDetailsViewStaff> createState() => _OrderDetailsViewStaffState();
}

class _OrderDetailsViewStaffState extends State<OrderDetailsViewStaff> {
  final controller = Get.put(OrderController());
  double progress = 0.0;
  ReceivePort recievePort = ReceivePort();
  int progressPercent = 0;

  @override
  void initState() {
    // widget.data.pdf_url;
    IsolateNameServer.registerPortWithName(
        (recievePort.sendPort), "Downloading");
    recievePort.listen((message) {
      setState(() {
        progress = message;
      });
    });
    FlutterDownloader.registerCallback(downloadCallBack);
    super.initState();
  }

  static downloadCallBack(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName('downloading');
    sendPort!.send(progress);
  }

  @override
  Widget build(BuildContext context) {
    final accountController = Get.put(AccountController());
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Order Details',
        trailing: Container(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _buildOrderDetailsViewStaffCard(context),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     GestureDetector(
              //       onTap: () async {
              //         await controller
              //             .getLocationTrack(
              //                 accountController.email.value.text.trim(),
              //                 widget.taskDetail.order!.refId)
              //             .then((value) => Get.to(OrderDetailsViewStaffView()));
              //       },
              //       child: Padding(
              //         padding: const EdgeInsets.all(15.0),
              //         child: Container(
              //           child: Row(
              //             children: const [
              //               Icon(
              //                 Icons.location_on_outlined,
              //                 color: Colors.grey,
              //               ),
              //               Text(
              //                 'Track Order',
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
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
                            "Order# ${widget.taskDetail.order!.refId.toString()}",
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
                            widget.taskDetail.order!.paymentStatus == 1
                                ? 'Paid'
                                : "Unpaid",
                            style: subtitleStyle,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Shipping Method',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Home Delivery',
                                style: subtitleStyle,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Payment Method',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                              Text(
                                widget.taskDetail.order!.paymentWith.toString(),
                                style: subtitleStyle,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Delivery Status',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              // Text(
                              //   widget.taskDetail.order!.statusvalue == null
                              //       ? ''
                              //       : widget.data.statusvalue.toString(),
                              //   style: const TextStyle(
                              //       fontWeight: FontWeight.w400, fontSize: 12),
                              // ),
                              // widget.taskDetail.order!..cancelReasonStatus == true
                              //     ? GestureDetector(
                              //         onTap: () {
                              //           controller
                              //               .cancelReason(
                              //                   widget.data.id, context)
                              //               .then((value) {});
                              //         },
                              //         child: Container(
                              //           padding: const EdgeInsets.symmetric(
                              //               horizontal: 15, vertical: 10),
                              //           decoration: BoxDecoration(
                              //               borderRadius:
                              //                   BorderRadius.circular(05),
                              //               color: Colors.green),
                              //           child: const Text(
                              //             'View',
                              //             style: TextStyle(
                              //               color: Colors.white,
                              //             ),
                              //           ),
                              //         ),
                              //       )
                              //     : const SizedBox(),
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
                                "Total Price: ${thousandSepretor.format(widget.taskDetail.order!.totalPrice)}",
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

              // todo: hello
              // if (widget.data.statusvalue != "DELIVERED")
              //   widget.data.statusvalue != "CANCELED"
              //       ? GestureDetector(
              //           onTap: () async {
              //             downloadPDF();
              //             // download(widget.downloadUrl.toString(), "order_detail.pdf");
              //           },
              //           child: Container(
              //             height: 50,
              //             width: double.infinity,
              //             margin: const EdgeInsets.symmetric(
              //                 horizontal: 10, vertical: 10),
              //             padding: const EdgeInsets.symmetric(
              //                 horizontal: 10, vertical: 10),
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               color: AppColor.orange,
              //             ),
              //             child: Center(
              //               child: const Text(
              //                 'Download Invoice',
              //                 style: TextStyle(color: Colors.white),
              //               ),
              //             ),
              //           ),
              //         )
              //       : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  _buildOrderDetailsViewStaffCard(BuildContext context) {
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
              '${widget.taskDetail.order!.name}\n${widget.taskDetail.order!.phone}',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              '${widget.taskDetail.order!.province}, ${widget.taskDetail.order!.district}, ${widget.taskDetail.order!.area}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 30,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.taskDetail.order!.orderAssets?.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var items = widget.taskDetail.order!.orderAssets?[index];
                  return ListTile(
                    leading: items!.product != null &&
                            items.image != null &&
                            items.image!.isNotEmpty &&
                            items.image != null
                        ? Image.network(
                            items.image!.replaceAll(
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
                "Ordered on  ${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.taskDetail.order!.createdAt.toString()))}",
                style: subtitleStyle,
              ),
              // trailing: Text(
              //   widget.taskDetail.order!.statusvalue == null
              //       ? ''
              //       : widget.taskDetail.order!.statusvalue.toString(),
              //   style:
              //       const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
              // ),
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

class OrderDetailsViewStaffView {}
