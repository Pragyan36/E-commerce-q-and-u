// ignore_for_file: unnecessary_overrides, prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:q_and_u_furniture/app/data/models/coupon_response_model.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/account_controller.dart';
import 'package:q_and_u_furniture/app/widgets/loading_widget.dart';
import 'package:q_and_u_furniture/app/widgets/toast.dart';

import '../../../data/models/order_detail_model.dart';
import '../../../data/models/payment_response_model.dart';
import '../../../data/services/payment_service.dart';
import '../../../database/app_storage.dart';
import '../../../widgets/snackbar.dart';
import '../../cart/controllers/cart_controller.dart';

class PaymentController extends GetxController {
  final count = 0.obs;
  var select = "3";
  var selected = 0.obs;

  var loadingRef = false.obs;
  var couponTextController = TextEditingController();

  // final logcon = Get.put(LoginController());
  var orderDetail = OrderDetailModel().obs;
  var paymentResponse = PaymentResponseModel().obs;
  var accountController = AccountController().obs;
  var couponResponse = CouponResponseModel().obs;
  final cartController = Get.put(CartController());
  var isEsewaPaymentVerified = false.obs;
  var esewaLoading = false.obs;
  var khaltiLoading = false.obs;
  var isKhaltiPaymentVerified = false.obs;
  var isCashPaymentConfirmed = false.obs;
  var isCouponApplied = false.obs;
  final String TAG = "PaymentController";
  var total_price = 0.obs;
  var discount = 0.obs;
  var refId = '';
  var dowloadUrls = ''.obs;
  var billId = "";
  var khaltiResponse = KhaltiPaymentModel().obs;
  var khaltiData = KhaltiPaymentModel().obs;
  var khaltiPayment = PaymentVerification().obs;

  setSelectedRadio(val) {
    select = val;
    update();
  }

  //  int? couponDiscountPrice =
  //     couponResponse.value.data?.discountAmount != null
  //         ? couponResponse!.value!.data!.discountAmount!.toInt()
  //         : 100;

  @override
  void onInit() {
    total_price.value = cartController.cartDataList.isNotEmpty
        ? cartController.cartDataList.first.totalPrice!.toInt()
        : 0;
    //fetchOrderDetail();

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

  Future fetchOrderDetail() async {
    isEsewaPaymentVerified.value = true;
    isKhaltiPaymentVerified.value = true;
    var data = await PaymentService().createOrder(
      token: AppStorage.readAccessToken,
    );

    if (data != null) {
      await Future.delayed(const Duration(seconds: 2), () {});
      isEsewaPaymentVerified.value = false;
      isKhaltiPaymentVerified.value = false;
      if (data['error'] == false) {
        orderDetail.value = OrderDetailModel.fromJson(data);
        billId = orderDetail.value.data!.billId!;
        // getSnackbar(
        //     message: data['msg'] +
        //         " with bill id: ${orderDetail.value.data!.billId}",
        //     bgColor: Colors.green);
      } else if (data['error'] == true) {
        getSnackbar(message: data['msg'], bgColor: Colors.red, error: true);
      }
    } else {}
  }

  verifyEsewaPayment(
      productId,
      productName,
      totalAmount,
      environment,
      code,
      merchantName,
      message,
      status,
      refId,
      couponCode,
      couponDiscountAmt,
      shippingAddressId,
      billingAddressId,
      same) async {
    var data = await PaymentService().verifyEsewa(
        AppStorage.readAccessToken,
        productId,
        productName,
        totalAmount,
        environment,
        code,
        merchantName,
        message,
        status,
        refId,
        couponCode,
        couponDiscountAmt,
        shippingAddressId,
        billingAddressId,
        same == true ? 1 : 0);

    print('dataasdsadas$data');

    if (data != null) {
      if (data['error'] == false) {
        isEsewaPaymentVerified.value = true;
        paymentResponse.value = PaymentResponseModel.fromJson(data);
        refId = paymentResponse.value.data!.orderDetails!.refId.toString();
      } else {
        getSnackbar(message: data['msg'], bgColor: Colors.red, error: true);
      }
    }
  }

  verifyKhaltiPayment(
      idx,
      amount,
      mobile,
      productIdentity,
      productName,
      token,
      status,
      totalAmount,
      couponCode,
      couponDiscountAmt,
      shippingAddressId,
      billingAddressId,
      same) async {
    Get.defaultDialog(
        title: 'Please wait, verifying payment',
        content: const LoadingWidget(),
        barrierDismissible: false);

    var data = await PaymentService().verifyKhalti(
        AppStorage.readAccessToken,
        idx,
        amount,
        mobile,
        productIdentity,
        productName,
        token,
        status,
        totalAmount,
        couponCode,
        couponDiscountAmt,
        shippingAddressId,
        same == true ? "" : billingAddressId,
        same == true ? 1 : 0);
    Get.defaultDialog(
        title: 'Loading',
        content: const LoadingWidget(),
        barrierDismissible: false);
    Get.back();
    if (data != null) {
      isKhaltiPaymentVerified.value = false;
      if (data['error'] == false) {
        // isKhaltiPaymentVerified.value = true;
        paymentResponse.value = PaymentResponseModel.fromJson(data);
      } else {
        getSnackbar(message: data['msg'], bgColor: Colors.red, error: true);
      }
    } else {
      toastMsg(message: data['msg']);
    }
  }

  verifyCouponCode(coupon, int shippingCharge) async {
    log('the verify coupon is $coupon');
    var data = await PaymentService()
        .verifyCoupon(AppStorage.readAccessToken, coupon, shippingCharge);

    print(data.toString());
    if (data != null) {
      couponResponse.value = CouponResponseModel.fromJson(data);

      if (couponResponse.value.error == false) {
        getSnackbar(
          message: data['msg'],
        );
        isCouponApplied.value = true;
        discount.value = couponResponse.value.data!.discountAmount!.toInt();
        total_price.value =
            couponResponse.value.data!.totalCartAmountAfterDiscount!.toInt();
      } else {
        isCouponApplied.value = false;
        total_price.value =
            //  couponResponse.value.data!.totalCartAmount!.toInt();
            cartController.cartDataList.first.totalPrice!.toInt();
        discount.value = 0;
        //toast(data['msg']);
        getSnackbar(
          message: data['msg'] ?? data['message']['coupon'][0],
        );
      }
    } else {}
  }

  payByCash(shippingId, billingId, same, couponCode, couponDiscountAmt) async {
    isCashPaymentConfirmed.value = true;
    log("Cash ma gako value is "
        "$shippingId,$billingId,$same,$couponCode, $couponDiscountAmt");
    var data = await PaymentService().cashPayment(AppStorage.readAccessToken,
        shippingId, billingId, same, couponCode, couponDiscountAmt);

    // log("PaymentController:payByCash:$data");

    if (data != null) {

      if (data['error'] == false) {

        paymentResponse.value = PaymentResponseModel.fromJson(data);
        refId = paymentResponse.value.data!.orderDetails!.refId.toString();
        loadingRef.value = false;
        // log("totalPrice:${paymentResponse.value.data?.orderDetails?.totalPrice}");
        // log(refId.value+"jatho");
        log("totalPrice:${paymentResponse.value.data?.orderDetails?.totalPrice}");
        log("ref:${paymentResponse.value.data?.orderDetails?.refId}");
        log("ref:$refId");
        var dowloadUrl = paymentResponse.value.data!.pdfUrl.toString();
        print("download url is $dowloadUrl");
        dowloadUrls.value = dowloadUrl;
        isCashPaymentConfirmed.value = true;
        isCashPaymentConfirmed.value = true;

        log("PaymentController:payByCash:Order Confirmed:${isCashPaymentConfirmed.value}");

        // getSnackbar(message: data['msg'], bgColor: Colors.green);
      } else {
        loadingRef.value = false;
        isCashPaymentConfirmed.value = false;
        log("PaymentController:payByCash:Order Not Confirmed");
        // toastMsg(message: data['msg']);
      }
    } else {
      loadingRef.value = false;

      isCashPaymentConfirmed.value = false;
      log("PaymentController:payByCash:data is null");
      toastMsg(message: data['msg']);
      // getSnackbar(message: "Oops! Something went wrong", bgColor: Colors.red);
    }
    loadingRef.value = false;
    // isCashPaymentConfirmed.value = false;
    log("PaymentController:payByCash:END");
  }

  payByFonepay(
      shippingId, billingId, same, couponCode, couponDiscountAmt) async {
    isCashPaymentConfirmed.value = true;
    log("Cash ma gako value is "
        "$shippingId,$billingId,$same,$couponCode, $couponDiscountAmt");
    var data = await PaymentService().cashPaymentFromFonepay(
        AppStorage.readAccessToken,
        shippingId,
        billingId,
        same,
        couponCode,
        couponDiscountAmt);

    // log("PaymentController:payByCash:$data");
    if (data != null) {
      isCashPaymentConfirmed.value = false;
      if (data['error'] == false) {
        log("Mukunda Dhungana is the boss");
        paymentResponse.value = PaymentResponseModel.fromJson(data);
        refId = paymentResponse.value.data!.orderDetails!.refId.toString();
        loadingRef.value = false;
        // log("totalPrice:${paymentResponse.value.data?.orderDetails?.totalPrice}");
        // log(refId.value+"jatho");
        log("totalPrice:${paymentResponse.value.data?.orderDetails?.totalPrice}");
        log("ref:${paymentResponse.value.data?.orderDetails?.refId}");
        log("ref:$refId");
        var dowloadUrl = paymentResponse.value.data!.pdfUrl.toString();
        print("download url is $dowloadUrl");
        dowloadUrls.value = dowloadUrl;
        isCashPaymentConfirmed.value = true;
        isCashPaymentConfirmed.value = true;

        log("PaymentController:payByCash:Order Confirmed:${isCashPaymentConfirmed.value}");

        // getSnackbar(message: data['msg'], bgColor: Colors.green);
      } else {
        loadingRef.value = false;
        isCashPaymentConfirmed.value = false;
        log("PaymentController:payByCash:Order Not Confirmed");
        // toastMsg(message: data['msg']);
      }
    } else {
      loadingRef.value = false;

      isCashPaymentConfirmed.value = false;
      log("PaymentController:payByCash:data is null");
      toastMsg(message: data['msg']);
      // getSnackbar(message: "Oops! Something went wrong", bgColor: Colors.red);
    }
    loadingRef.value = false;
    // isCashPaymentConfirmed.value = false;
    log("PaymentController:payByCash:END");
  }

  Future newKhalti(
    amount,
    purchaseorderid,
    purchaseordername,
  ) async {
    var data = await PaymentService()
        .newKhalti(
      amount,
      purchaseorderid,
      purchaseordername,
    )
        .then((value) async {
      if (value['payment_url'] != null) {
        launchCaller(value['payment_url']).then((e) {
          paymentVerficationKhalti(value['pidx']);
        });
      }
    });

    if (data != null) {
      isKhaltiPaymentVerified.value = false;
      if (data['error'] == false) {
        // isKhaltiPaymentVerified.value = true;
        khaltiResponse.value = KhaltiPaymentModel.fromJson(data);
      } else {
        getSnackbar(
            message: 'Payment Cancel', bgColor: Colors.red, error: true);
      }
    } else {
      // toastMsg(message: 'Payment Cancel');
    }
  }

  Future paymentVerficationKhalti(
    pidx,
  ) async {
    var data = await PaymentService().paymentVerificationKhalti(pidx);

    if (data != null) {
      isKhaltiPaymentVerified.value = false;
      if (data['error'] == false) {
        // isKhaltiPaymentVerified.value = true;
        khaltiPayment.value = PaymentVerification.fromJson(data);
      } else {
        getSnackbar(
            message: 'Payment Cancel', bgColor: Colors.red, error: true);
      }
    } else {
      // toastMsg(message: 'Payment Cancel');
    }
  }

  Future launchCaller(String paymenturl) async {
    if (!await canLaunchUrl(Uri.parse(paymenturl))) {
      await launchUrl(Uri.parse(paymenturl));
    } else {
      throw 'Could not launch $paymenturl';
    }
  }
}
