// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/modules/payment/controllers/payment_controller.dart';
import 'package:q_and_u_furniture/app/modules/shipping/controllers/shipping_controller.dart';
import 'package:q_and_u_furniture/app/modules/shipping/views/purchase_view.dart';
import 'package:q_and_u_furniture/app/widgets/custom_buttons.dart';
import 'package:q_and_u_furniture/app/widgets/custom_dialog.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';
import 'package:q_and_u_furniture/app/widgets/toast.dart';

class KhaltiPayment extends StatefulWidget {
  const KhaltiPayment(
      {Key? key,
      required this.shippingId,
      required this.billingId,
      required this.same,
      this.couponCode,
      this.couponDiscountAmt,
      this.shippingcharge})
      : super(key: key);
  final int shippingId;
  final int billingId;
  final bool same;
  final String? couponCode;
  final String? couponDiscountAmt;
  final int? shippingcharge;

  @override
  State<KhaltiPayment> createState() => _KhaltiPaymentState();
}

class _KhaltiPaymentState extends State<KhaltiPayment> {
  final paymentController = Get.put(PaymentController());
  final String TAG = "KhaltiPayment";
  final controller = Get.put(ShippingController());
  final cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomButtons(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        label: "Pay With Khalti",
        btnClr: Colors.purple,
        txtClr: Colors.white,
        ontap: () async {
          paymentController.khaltiLoading.value = true;
          await paymentController.fetchOrderDetail();
          paymentController.khaltiLoading.value = false;
          CustomDialog().showDialog(
            context: context,
            title:
                'Your order successfully placed. Now proceed for payment !!!',
            // subtitle: paymentController.billId,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButtons(
                    width: 100,
                    label: 'Cancel',
                    btnClr: Colors.red,
                    txtClr: Colors.white,
                    ontap: () async {
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
                      toastMsg(message: "Khalti payment");
                      await paymentController.fetchOrderDetail();
                      KhaltiScope.of(context).pay(
                        config: PaymentConfig(
                          amount:
                              // 10 * 100,
                              (cartController.cartDataList.first.totalPrice!
                                          .toInt() +
                                      controller.charge.value) *
                                  100,
                          productIdentity: paymentController
                              .orderDetail.value.data!.billId
                              .toString(),
                          productName:
                              'Zhigu-${paymentController.orderDetail.value.data!.billId}',
                        ),
                        preferences: [
                          PaymentPreference.khalti,
                        ],
                        onSuccess: (data) async {
                          log("amount:${data.amount}");
                          getSnackbar(
                              message: "Payment Successful",
                              bgColor: Colors.green);
                          await paymentController.verifyKhaltiPayment(
                              data.idx,
                              data.amount / 100,
                              data.mobile,
                              data.productIdentity,
                              data.productName,
                              data.token,
                              "COMPLETE",
                              data.amount,
                              widget.couponCode,
                              widget.couponDiscountAmt,
                              widget.shippingId,
                              widget.billingId,
                              widget.same);
                          if (paymentController.isKhaltiPaymentVerified.value) {
                            Get.off(PurchaseView(
                              shippingcharge: widget.shippingcharge!.toInt(),
                              couponDiscountPrice: widget.couponDiscountAmt,
                            ));
                          } else {
                            getSnackbar(
                                message:
                                    "Khalti Payment couldn't be verified !!!",
                                bgColor: Colors.red);
                          }
                        },
                        onFailure: (fa) {
                          const failedsnackBar = SnackBar(
                            content: Text('Payment Failed'),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(failedsnackBar);
                        },
                        onCancel: () {
                          const cancelsnackBar = SnackBar(
                            content: Text('Payment Cancelled'),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(cancelsnackBar);
                        },
                      );

                      // KhaltiScope.of(context).pay(
                      //   config: PaymentConfig(
                      //     amount:
                      //         // 10 * 100,
                      //         paymentController.total_price.toInt() * 100,
                      //     productIdentity: paymentController
                      //         .orderDetail.value.data!.billId
                      //         .toString(),
                      //     productName:
                      //         'Zhigu-${paymentController.orderDetail.value.data!.billId}',
                      //     returnUrl: paymentController.khaltiData.value.paymentUrl,
                      //   ),
                      //   preferences: [
                      //     PaymentPreference.khalti,
                      //     PaymentPreference.connectIPS,
                      //     PaymentPreference.eBanking,
                      //     PaymentPreference.mobileBanking,
                      //   ],
                      //   onSuccess: (data) async {
                      //     log("amount:${data.amount}");

                      //     getSnackbar(
                      //         message: "Payment Successful", bgColor: Colors.green);

                      //     // await paymentController.newKhalti(

                      //     // );
                      //     if (paymentController.isKhaltiPaymentVerified.value) {
                      //       Get.off(PurchaseView(
                      //         shippingcharge: widget.shippingcharge!.toInt(),
                      //       ));
                      //     } else {
                      //       getSnackbar(
                      //         message: "Khalti Payment couldn't be verified !!!",
                      //         bgColor: Colors.red,
                      //         error: true,
                      //       );
                      //     }
                      //   },
                      //   onFailure: (fa) {
                      //     const failedsnackBar = SnackBar(
                      //       content: Text('Payment Failed'),
                      //     );
                      //     ScaffoldMessenger.of(context)
                      //         .showSnackBar(failedsnackBar);
                      //   },
                      //   // onCancel: () {
                      //   //   const cancelsnackBar = SnackBar(
                      //   //     content: Text('Payment Cancelled'),
                      //   //   );
                      //   //   ScaffoldMessenger.of(context)
                      //   //       .showSnackBar(cancelsnackBar);
                      //   // },
                      // );
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
          );
        });
    //     KhaltiButton(
    //   config: PaymentConfig(
    //     amount: 10 * 100 /*paymentController.total_price.toInt()*100*/,
    //     productIdentity: 'sa',
    //     // paymentController.orderDetail.value.data!.billId.toString(),
    //     productName: 'as',
    //     // 'Zhigu-${paymentController.orderDetail.value.data!.billId}',
    //   ),
    //   onSuccess: (data) async {
    //     debugPrint(":::SUCCESS::: => $data");
    //     await paymentController.verifyKhaltiPayment(
    //         data.idx,
    //         data.amount,
    //         data.mobile,
    //         data.productIdentity,
    //         data.productName,
    //         data.token,
    //         "COMPLETE");
    //     log("$TAG->onSuccess-> after getting isKhaltiPaymentVerified true");
    //     if (paymentController.isKhaltiPaymentVerified.value) {
    //       Get.off(PurchaseView());
    //     } else {
    //       log("$TAG->onSuccess-> after getting isKhaltiPaymentVerified false");
    //       getSnackbar(
    //           message: "Khalti Payment couldn't be verified !!!",
    //           bgColor: Colors.red);
    //     }
    //   },
    //   onFailure: (failureModel) {
    //     // What to do on failure?
    //   },
    //   onCancel: () {
    //     // User manually cancelled the transaction
    //   },
    // );
  }
}
