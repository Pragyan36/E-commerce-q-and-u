// ignore_for_file: unused_element, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/modules/payment/components/esewa_payment.dart';
import 'package:q_and_u_furniture/app/modules/payment/components/khalti_payment.dart';
import 'package:q_and_u_furniture/app/modules/payment/controllers/payment_controller.dart';
import 'package:q_and_u_furniture/app/modules/shipping/controllers/shipping_controller.dart';
import 'package:q_and_u_furniture/app/modules/shipping/views/purchase_view.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_buttons.dart';
import 'package:q_and_u_furniture/app/widgets/inputfield.dart';
import 'package:q_and_u_furniture/app/widgets/loading_widget.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';

class PaymentView extends GetView<PaymentController> {
  PaymentView({Key? key}) : super(key: key);

  @override
  final loginController = Get.put(PaymentController());
  var formatter = NumberFormat('#,###');
  final paymentResponse = Get.put(PaymentController());
  final cartController = Get.put(CartController());

  final controllerShipping = Get.put(ShippingController());
  final List<Map> paymentTypes = [
    {
      'name': 'Cash',
      'id': 3,
      'icon': const AssetImage("assets/images/payment-method.png"),
      'subtitle': 'Pay by Debit Cash on Delivery'
    },
    // {
    //   'name': 'FonePay',
    //   'id': 2,
    //   'icon': const AssetImage("assets/images/fonepay.png"),
    //   'subtitle': 'Pay online by Fonepay'
    // },
    // {
    //   'name': 'Khalti',
    //   'id': 1,
    //   'icon': const AssetImage("assets/images/Khalti.png"),
    //   'subtitle': 'Pay online by Khalti'
    // },
  ];

  var addressData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    int shippingCharge = addressData[3];
    log("PaymentView:ReceivedArguments:$addressData");
    return Scaffold(
      appBar: CustomAppbar(title: 'Payment'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...List.generate(
              paymentTypes.length,
              (index) => GetBuilder<PaymentController>(
                builder: (_) {
                  return RadioListTile(
                    title: Text(
                      paymentTypes[index]['name'],
                      style: titleStyle,
                    ),
                    subtitle: Text(
                      paymentTypes[index]['subtitle'],
                      style: subtitleStyle.copyWith(color: Colors.grey),
                    ),
                    secondary: Image(
                      image: paymentTypes[index]['icon'],
                      height: 50,
                      width: 50,
                    ),
                    value: paymentTypes[index]['id'].toString(),
                    groupValue: loginController.select,
                    onChanged: (val) {
                      debugPrint(val.toString());
                      loginController.setSelectedRadio(val);
                      loginController.selected.value =
                          int.parse(val.toString());
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            /*TextButton(
                onPressed: () {},
                child: Text(
                  '+ Add new card',
                  style: titleStyle,
                )),*/
            /*Row(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: MyInputField(
                    hint: 'Email',
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_right_alt_sharp)),
                ),
              ],
            ),*/
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Add Coupon Code',
                  style: subtitleStyle,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ListTile(
              horizontalTitleGap: 0.0,
              title: MyInputField(
                labelText: "Check Coupon Code",
                controller: loginController.couponTextController,
              ),
              trailing: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(
                      color: const Color.fromRGBO(0, 0, 0, 0.1), width: 0.0),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: IconButton(
                  onPressed: () async {
                    // debugPrint(couponTextController.text);
                    await loginController.verifyCouponCode(
                        loginController.couponTextController.text,
                        shippingCharge);
                    loginController.total_price.value = loginController
                            .couponResponse
                            .value
                            .data!
                            .totalCartAmountAfterDiscount!
                            .toInt() +
                        shippingCharge;
                  },
                  icon: const Icon(Icons.arrow_circle_right),
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => _buildTotal(context),
            )
          ],
        ),
      ),
    );
  }

  _buildRadioListtile(title, subtitle, icon, int val, grpval, onchange) {
    return RadioListTile(
        title: Text(
          title,
          style: titleStyle,
        ),
        subtitle: Text(
          subtitle,
          style: subtitleStyle.copyWith(color: Colors.grey),
        ),
        secondary: Icon(icon),
        value: val,
        groupValue: grpval,
        onChanged: onchange);
  }

  _buildAmountTile(title, total) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(vertical: -3),
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

  _buildTotal(context) {
    //for sub total
    int? totalPrice = cartController.cartSummary.value.totalAmount ?? 0;
    int? totalDiscount = cartController.cartDataList.first.totalDiscount ?? 0;
    int subtotal = totalPrice + totalDiscount;

    //for total price
    int? couponDiscountPrice =
        loginController.couponResponse.value.data?.discountAmount != null
            ? loginController.couponResponse.value.data!.discountAmount!.toInt()
            : 0;

    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildAmountTile(
            'Sub-total',
            'Rs. ${formatter.format(subtotal)}',
          ),
          _buildAmountTile(
            'Vat(%)',
            formatter.format(cartController.cartSummary.value.vat ?? 0),
          ),
          _buildAmountTile(
            'Shipping charge',
            'Rs.${formatter.format(addressData[3])}',
          ),
          _buildAmountTile(
            'Material Change',
            'Rs. ${formatter.format(int.parse(cartController.cartSummary.value.materialPrice ?? "0"))}',
          ),
          Obx(
            () => _buildAmountTile(
              'Discount',
              'Rs. ${formatter.format(cartController.cartDataList.first.totalDiscount)}',
            ),
          ),
          Obx(
            () => loginController.couponResponse.value.data?.discountAmount !=
                    null
                ? _buildAmountTile(
                    'Discount from Coupon',
                    'Rs. ${formatter.format(loginController.couponResponse.value.data?.discountAmount)}',
                  )
                : const SizedBox(),
          ),
          const Divider(
            thickness: 1.5,
            indent: 20,
            endIndent: 20,
          ),
          Obx(
            () => _buildAmountTile(
              'Total',
              'Rs. ${formatter.format((cartController.cartSummary.value.grandTotal! + controllerShipping.charge.value + int.parse(cartController.cartSummary.value.materialPrice ?? "0")) - couponDiscountPrice)}',
            ),
          ),
          // Obx(
          //   () => _buildAmountTile(
          //     'Total',
          //     'Rs. ${(controller.couponResponse.value.data?.totalCartAmountAfterDiscount != null ? controller.couponResponse.value.data!.totalCartAmountAfterDiscount! + addressData[3] : controller.total_price + addressData[3])}',
          //     //  ${controller.total_price + addressData[3]}',
          //   ),
          // ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            (() => loginController.selected.value == 1
                ? KhaltiPayment(
                    shippingId: addressData[0].value,
                    billingId: addressData[1].value,
                    same: addressData[2].value,
                    couponCode:
                        loginController.couponTextController.text == "" ||
                                loginController.couponResponse.value.data
                                        ?.discountAmount ==
                                    null
                            ? ""
                            : loginController.couponTextController.text,
                    couponDiscountAmt: loginController
                        .couponResponse.value.data?.discountAmount
                        .toString(),
                    shippingcharge: addressData[3],
                  )
                : loginController.selected.value == 2
                    ? EsewaPaymentUI(
                        shippingId: addressData[0].value,
                        billingId: addressData[1].value,
                        same: addressData[2].value,
                        couponCode:
                            loginController.couponTextController.text == "" ||
                                    loginController.couponResponse.value.data
                                            ?.discountAmount ==
                                        null
                                ? ""
                                : loginController.couponTextController.text,
                        couponDiscountAmt: loginController
                            .couponResponse.value.data?.discountAmount
                            .toString(),
                        shippingcharge: addressData[3],
                      )
                    : loginController.selected.value == 3
                        ? CustomButtons(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            width: double.infinity,
                            label: 'Cash on delivery',
                            btnClr: AppColor.kalaAppMainColor,
                            txtClr: Colors.white,
                            ontap: () async {
                              loginController.isCashPaymentConfirmed.value
                                  ? null
                                  : await loginController.payByCash(
                                      addressData[0].value,
                                      addressData[1].value,
                                      addressData[2].value,
                                      loginController.couponTextController
                                                      .text ==
                                                  "" ||
                                              loginController
                                                      .couponResponse
                                                      .value
                                                      .data
                                                      ?.discountAmount ==
                                                  null
                                          ? ""
                                          : loginController
                                              .couponTextController.text,
                                      loginController.couponResponse.value.data
                                          ?.discountAmount);
                              Get.defaultDialog(
                                  title: 'Loading',
                                  content: const LoadingWidget(),
                                  barrierDismissible: false);

                              //to close dialog loading
                              Get.back();
                              if (loginController
                                      .isCashPaymentConfirmed.value ==
                                  true) {
                                log("kasto${loginController.refId}");
                                Get.to(PurchaseView(
                                  downloadUrl:
                                      paymentResponse.dowloadUrls.toString(),
                                  refId: loginController.refId.toString(),
                                  shippingcharge: addressData[3],
                                  couponDiscountPrice:
                                      couponDiscountPrice.toString(),
                                ));
                              } else {
                                getSnackbar(
                                    message: "Oops! Something went wrong",
                                    error: true,
                                    bgColor: Colors.red);
                              }
                            })
                        : CustomButtons(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            label: /*'Visa'*/ 'Pay',
                            btnClr: AppColor.kalaAppMainColor,
                            txtClr: Colors.white,
                            ontap: () async {
                              loginController.isCashPaymentConfirmed.value
                                  ? null
                                  : await loginController.payByCash(
                                      addressData[0].value,
                                      addressData[1].value,
                                      addressData[2].value,
                                      loginController.couponTextController
                                                      .text ==
                                                  "" ||
                                              loginController
                                                      .couponResponse
                                                      .value
                                                      .data
                                                      ?.discountAmount ==
                                                  null
                                          ? ""
                                          : loginController
                                              .couponTextController.text,
                                      loginController.couponResponse.value.data
                                          ?.discountAmount);
                              Get.defaultDialog(
                                  title: 'Loading',
                                  content: const LoadingWidget(),
                                  barrierDismissible: false);

                              //to close dialog loading
                              Get.back();
                              if (loginController
                                      .isCashPaymentConfirmed.value ==
                                  true) {
                                Get.offAll(PurchaseView(
                                  downloadUrl:
                                      paymentResponse.dowloadUrls.toString(),
                                  refId: loginController.refId.toString(),
                                  shippingcharge: addressData[3],
                                  couponDiscountPrice:
                                      couponDiscountPrice.toString(),
                                ));
                              } else {
                                getSnackbar(
                                  message: "Oops! Something went wrong",
                                  error: true,
                                  bgColor: Colors.red,
                                );
                              }
                            },
                          )),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
