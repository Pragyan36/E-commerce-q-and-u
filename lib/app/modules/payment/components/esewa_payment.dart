import 'dart:developer';
import 'dart:ui';

import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/widgets/custom_buttons.dart';

import '../../../widgets/loading_widget.dart';
import '../../../widgets/snackbar.dart';
import '../../../widgets/toast.dart';
import '../../landing/controllers/landing_controller.dart';
import '../../shipping/views/purchase_view.dart';
import '../controllers/payment_controller.dart';

class EsewaPaymentUI extends StatefulWidget {
  const EsewaPaymentUI({
    Key? key,
    required this.shippingId,
    required this.billingId,
    required this.same,
    this.couponCode,
    this.couponDiscountAmt,
    this.shippingcharge,
  }) : super(key: key);

  final int shippingId;
  final int billingId;
  final bool same;
  final String? couponCode;
  final String? couponDiscountAmt;
  final int? shippingcharge;

  @override
  State<EsewaPaymentUI> createState() => _EsewaPaymentUIState();
}

class _EsewaPaymentUIState extends State<EsewaPaymentUI> {
  late EsewaConfig _config;
  final paymentController = Get.put(PaymentController());
  final landingcontroller = Get.put(LandingController());
  final String TAG = "EsewaPaymentUI";

  @override
  void initState() {
    _config = EsewaConfig(
        clientId: "MB8RBQBTOAofEVMxEgIbBQoVChQcTQ8GBwk=",
        secretId: "WBYWEhYSRRAVEQEEWRIcDRE=",
        environment: Environment.live);
    super.initState();
  }

  // esewa() {
  //   try {
  //     EsewaFlutterSdk.initPayment(
  //       esewaConfig: _config,
  //       esewaPayment: EsewaPayment(
  //         productId:
  //             paymentController.orderDetail.value.data!.billId.toString(),
  //         productName:
  //             "Zhigu-${paymentController.orderDetail.value.data!.billId}",
  //         productPrice: paymentController.total_price.toString(),
  //         // "10",
  //         callbackUrl: "www.test-url.com",
  //       ),
  //       onPaymentSuccess: (EsewaPaymentSuccessResult data) async {
  //         await paymentController.verifyEsewaPayment(
  //             data.productId,
  //             data.productName,
  //             data.totalAmount,
  //             data.environment,
  //             data.code,
  //             data.merchantName,
  //             data.message,
  //             data.status,
  //             data.refId,
  //             widget.couponCode,
  //             widget.couponDiscountAmt,
  //             widget.shippingId,
  //             widget.billingId,
  //             widget.same);
  //         if (paymentController.isEsewaPaymentVerified.value) {
  //           Get.off(PurchaseView(
  //             shippingcharge: widget.shippingcharge!.toInt(),
  //             couponDiscountPrice: widget.couponDiscountAmt ?? "0",
  //             refId: paymentController.refId.toString(),
  //           ));
  //         } else {
  //           getSnackbar(
  //             message: "Esewa Payment couldn't be verified !!!",
  //             bgColor: Colors.red,
  //             error: true,
  //           );
  //         }
  //       },
  //       onPaymentFailure: (data) {},
  //       onPaymentCancellation: (data) {
  //         getSnackbar(bgColor: Colors.red, message: data, error: true);
  //       },
  //     );
  //   } on Exception catch (e) {
  //     debugPrint("EXCEPTION : ${e.toString()}");
  //   }
  // }

  var addressData = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return CustomButtons(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        label: 'Pay With FonePay',
        btnClr: Colors.red.shade600,
        txtClr: Colors.white,
        ontap: () async {
          paymentController.esewaLoading.value = true;
          paymentController.isEsewaPaymentVerified.value
              ? null
              : await paymentController.fetchOrderDetail();
          paymentController.esewaLoading.value = false;
          // print(paymentController.orderDetail.value.data?.billId);

          // ignore: use_build_context_synchronously

          Get.defaultDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.symmetric(horizontal: 20),
            title: '',
            content: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: Wrap(
                children: [
                  Stack(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        margin: const EdgeInsets.only(top: 50),
                        padding:
                            const EdgeInsets.only(top: 50, left: 20, right: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Center(
                                  child: Text(
                                      'Please provide your name and order id in the remarks section *',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: const Color.fromARGB(
                                                  255, 200, 2, 51))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Image(
                                    image:
                                        AssetImage("assets/images/qrBank.jpg"),
                                    // height: 100,
                                    // width: 50,
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(height: buttonHeight ?? 20),

                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomButtons(
                                      width: 100,
                                      label: 'Cancel',
                                      btnClr: AppColor.kalaAppMainColor,
                                      txtClr: Colors.white,
                                      ontap: () {
                                        const cancelsnackBar = SnackBar(
                                          content: Text('Payment Cancelled'),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(cancelsnackBar);
                                        Get.back();
                                      },
                                    ),
                                    CustomButtons(
                                      width: 100,
                                      label: 'Ok',
                                      btnClr: const Color(0xff5D3AC1),
                                      txtClr: Colors.white,
                                      ontap: () async {
                                        Get.close(1);
                                        toastMsg(message: "Esewa payment");
                                        // esewa();
                                        // (shippingId, billingId, same, couponCode, couponDiscountAmt
                                        await paymentController.payByFonepay(
                                            addressData[0].value,
                                            addressData[1].value,
                                            addressData[2].value,
                                            paymentController
                                                            .couponTextController
                                                            .text ==
                                                        "" ||
                                                    paymentController
                                                            .couponResponse
                                                            .value
                                                            .data
                                                            ?.discountAmount ==
                                                        null
                                                ? ""
                                                : paymentController
                                                    .couponTextController.text,
                                            paymentController.couponResponse
                                                .value.data?.discountAmount);
                                        Get.defaultDialog(
                                            title: 'Loading',
                                            content: const LoadingWidget(),
                                            barrierDismissible: false);

                                        //to close dialog loading
                                        Get.back();
                                        if (paymentController
                                                .isCashPaymentConfirmed.value ==
                                            true) {
                                          log("kasto${paymentController.refId}");
                                          // log("lalalala");
                                          Get.to(PurchaseView(
                                            downloadUrl: paymentController
                                                .dowloadUrls
                                                .toString(),
                                            refId: paymentController.refId
                                                .toString(),
                                            shippingcharge: addressData[3],
                                            couponDiscountPrice:
                                                "${paymentController.couponResponse.value.data?.discountAmount != null ? paymentController.couponResponse.value.data!.discountAmount!.toInt() : landingcontroller.shippingchargedefaultvalue.value}",
                                          ));
                                        } else {
                                          getSnackbar(
                                              message:
                                                  "Oops! Something went wrong",
                                              error: true,
                                              bgColor: Colors.red);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                      //For displaying the emoji
                    ],
                  ),
                ],
              ),
            ),
          );

          // Get.defaultDialog(
          //     title: "Order Generated !!!",
          //     content: Text(
          //       paymentController.billId,
          //       style: const TextStyle(
          //           color: Colors.red, fontWeight: FontWeight.bold),
          //     ),
          //     onConfirm: () {
          //       Get.close(1);
          //       toastMsg(message: "Esewa payment");
          //       esewa();
          //     },
          //     onCancel: () {
          //       Get.close(1);
          //       toastMsg(message: "Cancelled");
          //     });

          // paymentController.verifyEsewaPayment(
          //     "productId",
          //     "productName",
          //     "totalAmount",
          //     "environment",
          //     "code",
          //     "merchantName",
          //     "message",
          //     "date",
          //     "status",
          //     "refId",
          //     "shippingAddressId",
          //     "billingAddressId",
          //     "same");
        });
  }
}
