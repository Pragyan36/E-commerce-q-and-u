import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/data/models/user_model.dart';
import 'package:q_and_u_furniture/app/data/models/userorder_model.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/account_controller.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/order_controller.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/order_history.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({
    super.key,
    required this.userOrderData,
    this.userData,
  });

  final UserOrderData userOrderData;
  final UserData? userData;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final OrderController controller = Get.put(
    OrderController(),
  );
  // final CartController cartController = Get.put(
  //   CartController(),
  // );
  // final ShippingController loginController = Get.put(
  //   ShippingController(),
  // );

  double progress = 0.0;
  ReceivePort recievePort = ReceivePort();
  int progressPercent = 0;
  // final NumberFormat formatter = NumberFormat('#,###');

  @override
  void initState() {
    widget.userOrderData.pdf_url;
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

  static downloadCallBack(
    id,
    status,
    progress,
  ) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName('downloading');
    sendPort!.send(progress);
  }

  @override
  Widget build(BuildContext context) {
    final AccountController accountController = Get.put(
      AccountController(),
    );

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
              _buildOrderDetailsCard(context),
              /*
                TRACK ORDER SECTION
              */
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await controller
                          .getLocationTrack(
                              accountController.email.value.text.trim(),
                              widget.userOrderData.refId)
                          .then(
                            (value) => Get.to(
                              OrderHistoryView(),
                            ),
                          );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
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
                ],
              ),
              /*
                ORDER SUMMARY SECTION
              */
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
                            "Order# ${widget.userOrderData.refId.toString()}",
                            style: titleStyle.copyWith(
                              color: AppColor.mainClr,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userOrderData.paymentStatus == 1
                                ? 'Paid'
                                : "Unpaid",
                            style: subtitleStyle,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Shipping Method',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Home Delivery',
                                style: subtitleStyle,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Payment Method',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                widget.userOrderData.paymentWith.toString(),
                                style: subtitleStyle,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Delivery Status',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                widget.userOrderData.statusvalue == null
                                    ? ''
                                    : widget.userOrderData.statusvalue
                                        .toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              widget.userOrderData.cancelReasonStatus == true
                                  ? GestureDetector(
                                      onTap: () {
                                        controller
                                            .cancelReason(
                                                widget.userOrderData.id,
                                                context)
                                            .then((value) {});
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(05),
                                          color: Colors.green,
                                        ),
                                        child: const Text(
                                          'View',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Total Price: ${thousandSepretor.format(widget.userOrderData.totalPrice)}",
                                style: titleStyle.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
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
              if (widget.userOrderData.statusvalue != "DELIVERED")
                widget.userOrderData.statusvalue != "CANCELED"
                    ? GestureDetector(
                        onTap: () async {
                          downloadPDF();
                          // download(widget.downloadUrl.toString(), "order_detail.pdf");
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.kalaAppMainColor,
                          ),
                          child: const Center(
                            child: Text(
                              'Download Invoice',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> downloadPDF() async {
    // var storagePermissionStatus = await Permission.storage.request();
    // if (storagePermissionStatus.isGranted) {
    // Get the application's external storage directory
    final directory = await getExternalStorageDirectory();
    // // Create the save directory if it doesn't exist
    // await Directory(saveDirectory).create(recursive: true);

    // Start the download process
    final taskId = await FlutterDownloader.enqueue(
      url: widget.userOrderData.pdf_url.toString(),
      savedDir: directory!.path,
      fileName: "order_details_${widget.userOrderData.refId}.pdf",
      showNotification: true,
      saveInPublicStorage: true,
      openFileFromNotification: true,
    );
    // } else {
    //   print("No permission");
    //   getSnackbar(
    //       message: "No Permission of Storage",
    //       bgColor: Colors.red,
    //       error: true);
    // }
  }

  _buildOrderDetailsCard(
    BuildContext context,
  ) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ship and bill to:',
              style: TextStyle(
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${widget.userOrderData.name}\n${widget.userOrderData.phone}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${widget.userOrderData.province}, ${widget.userOrderData.district}, ${widget.userOrderData.area}',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.userOrderData.orderAssets?.length ?? 0,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var items = widget.userOrderData.orderAssets?[index];
                int payableAmount = items!.price! - items.discount!;

                return ListTile(
                  leading: items.product != null &&
                          items.product!.images != null &&
                          items.product!.images!.isNotEmpty &&
                          items.product!.images!.first.image != null
                      ? SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            items.product!.images!.first.image!.replaceAll(
                              RegExp(r'http://127.0.0.1:8000'),
                              url,
                            ),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(AppImages.placeHolder),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        items.productName.toString(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rs. ${thousandSepretor.format(payableAmount)}",
                        style: titleStyle.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text("${items.qty} X items"),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.card_giftcard),
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Package",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                "Ordered on  ${DateFormat('dd/MM/yyyy').format(
                  DateTime.parse(
                    widget.userOrderData.createdAt.toString(),
                  ),
                )}",
                style: subtitleStyle,
              ),
              trailing: Text(
                widget.userOrderData.statusvalue == null
                    ? ''
                    : widget.userOrderData.statusvalue.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
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
