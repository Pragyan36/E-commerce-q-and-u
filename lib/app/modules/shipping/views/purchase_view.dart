// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/account_controller.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/order_controller.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/my_order.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/myordertest_view.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/views/TestOrder.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/modules/home/views/home_view.dart';
import 'package:q_and_u_furniture/app/modules/payment/controllers/payment_controller.dart';
import 'package:q_and_u_furniture/app/modules/shipping/controllers/shipping_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_button.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PurchaseView extends StatefulWidget {
  final int shippingcharge;
  String? refId;
  String? couponDiscountPrice;
  String? downloadUrl;

  PurchaseView({
    Key? key,
    required this.shippingcharge,
    this.refId,
    required this.couponDiscountPrice,
    this.downloadUrl,
  }) : super(key: key);

  @override
  State<PurchaseView> createState() => _PurchaseViewState();
}

class _PurchaseViewState extends State<PurchaseView> {
  final paymentController = Get.put(PaymentController());
  var formatter = NumberFormat('#,###');
  final cartController = Get.put(CartController());
  final orderController = Get.put(OrderController());
  final controllerShipping = Get.put(ShippingController());
  final homeController = Get.put(HomeController());
  final controller = Get.put(AccountController());
  late Future<http.Response> response;
  String? refId;
  double progress = 0.0;
  ReceivePort recievePort = ReceivePort();
  int progressPercent = 0;

  @override
  void initState() {
    paymentController.dowloadUrls.value;

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
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          Get.offAll(
            () => const HomeView(),
          );
        },
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.kalaAppMainColor,
                    radius: 21.sp,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 22.sp,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Hey ${controller.userdata.value.name ?? '...'},',
                    style: titleStyle,
                  ),
                  Text(
                    'Thanks for your purchase',
                    style: titleStyle,
                  ),
                  summary(),
                ],
              ),
            ),
          ),
          // ),
        ));
  }

  _buildAmountTile(title, total) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(vertical: -3),
      contentPadding: const EdgeInsets.symmetric(horizontal: 40),
      title: Text(
        title,
        style: subtitleStyle.copyWith(color: Colors.grey),
      ),
      trailing: Text(
        total,
        style: subtitleStyle.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }

  summary() {
    int finalPrice = int.parse(widget.couponDiscountPrice!);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildAmountTile(
          'Sub-Total',
          'Rs.${formatter.format(cartController.cartDataList.first.totalPrice)}',
        ),
        _buildAmountTile(
          'Vat(%)',
          formatter.format(cartController.cartSummary.value.vat),
        ),
        _buildAmountTile(
          'Shipping Change',
          'Rs.${formatter.format(widget.shippingcharge)}',
        ),
        _buildAmountTile(
          'Material Change',
          'Rs. ${formatter.format(int.parse(cartController.cartSummary.value.materialPrice ?? "0"))}',
        ),
        widget.couponDiscountPrice != null
            ? _buildAmountTile(
                'Discount from Coupon',
                'Rs. ${widget.couponDiscountPrice.toString()}',
              )
            : const SizedBox(),
        const Divider(
          thickness: 1.5,
          indent: 20,
          endIndent: 20,
        ),
        _buildAmountTile(
          'Total',
          'Rs. ${formatter.format((cartController.cartDataList.first.totalPrice!.toInt() + controllerShipping.charge.value + int.parse(cartController.cartSummary.value.materialPrice ?? "0")) - finalPrice)}',
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            CustomButton(
              label: "Track Order",
              btnClr: AppColor.kalaAppMainColor,
              txtClr: Colors.white,
              ontap: () {
                Get.to(
                  () => const MyOrderTestView(
                    isFromPurchaseView: true,
                  ),
                );
              },
            ),
            CustomButton(
              label: "Continue Shopping",
              btnClr: AppColor.kalaAppMainColor,
              txtClr: Colors.white,
              ontap: () {
                Get.offAll(
                  const HomeView(),
                );
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () async {
            downloadPDF();
            debugPrint("url is ${widget.downloadUrl}");
            // download(widget.downloadUrl.toString(), "order_detail.pdf");
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.kalaAppMainColor,
            ),
            child: const Text(
              'Download Invoice',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> downloadPDF() async {
    // var storagePermissionStatus = await Permission.storage.request();
    // if (storagePermissionStatus.isDenied) {
    // Get the application's external storage directory
    final directory = await getExternalStorageDirectory();
    // // Create the save directory if it doesn't exist
    // await Directory(saveDirectory).create(recursive: true);

    // Start the download process
    await FlutterDownloader.enqueue(
      url: widget.downloadUrl.toString(),
      savedDir: directory!.path,
      fileName: "order_details_${widget.refId}.pdf",
      showNotification: true,
      saveInPublicStorage: true,
      openFileFromNotification: true,
    );
    getSnackbar(
        message: "Invoice has been downloaded successfully!",
        // bgColor: Colors.red,
        error: false);
    // } else {
    //   debugPrint("No permission");
    //   getSnackbar(
    //       message: "No Permission of Storage",
    //       bgColor: Colors.red,
    //       error: true);
    // }
  }
}
