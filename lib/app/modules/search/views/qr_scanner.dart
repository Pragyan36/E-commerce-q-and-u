import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:q_and_u_furniture/app/modules/search/views/search_items.dart';

import '../controllers/search_controller.dart';

class QrScannerVIew extends StatefulWidget {
  const QrScannerVIew({Key? key}) : super(key: key);

  @override
  State<QrScannerVIew> createState() => _QrScannerVIewState();
}

class _QrScannerVIewState extends State<QrScannerVIew> {
  QRViewController? controller;
  Barcode? result;
  bool? firstTime = true;
  final controllerSearch = Get.put(CustomSearchController());

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        controllerSearch.qr(result);
        setState(() {
          Get.off(() => const SearchItems());
          controllerSearch.fetchSearch();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  QRView(
                    key: qrKey,
                    overlay: QrScannerOverlayShape(
                      borderColor:
                          result == null ? Colors.orange : Colors.greenAccent,
                      borderWidth: 10,
                    ),
                    onQRViewCreated: _onQRViewCreated,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 50, right: 20),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            color: AppColor.kalaAppMainColor,
                            onPressed: () {
                              setState(() {
                                controller?.toggleFlash();
                              });
                            },
                            icon: Icon(
                              Icons.flash_on,
                              color: AppColor.kalaAppMainColor,
                              size: 20.sp,
                            )),
                      ))
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Center(
                  child: Text(result != null
                      ? result!.code.toString()
                      : 'You can Scan any product which are from Q & U Hongkong Furniture.')),
            )
          ],
        ),
      ),
    );
  }
}
