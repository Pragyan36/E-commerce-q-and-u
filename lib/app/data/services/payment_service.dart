import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants/constants.dart';

class PaymentService {
  final String TAG = "PaymentService";

  Future createOrder({token}) async {
    debugPrint("token is $token");
    try {
      var header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      var response =
          await http.get(Uri.parse("$baseUrl/get-refid"), headers: header);
      var data = jsonDecode(response.body);
      debugPrint("order ref$data");
      return data;
      /*if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
      else{
      }*/
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  /*Future verifyEsewa({token}) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var response = await http.get(Uri.parse("$base/esewa-confirmation"),
          headers: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }*/

  Future verifyEsewa(
      token,
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
    log("$TAG->verifyEsewa");
    var header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    var body = jsonEncode({
      "productId": productId,
      "productName": productName,
      "totalAmount": totalAmount,
      "environment": environment,
      "code": code,
      "merchantName": merchantName,
      "message": message,
      "status": status,
      "refId": refId,
      "coupon_code": couponCode,
      "coupon_discount_amount": couponDiscountAmt,
      "shipping_address": shippingAddressId,
      "billing_address": billingAddressId == 0 ? "" : billingAddressId,
      "same": same
    });
    debugPrint("verification body is$body");

    var response = await http.post(Uri.parse("$baseUrl/esewa-payment"),
        body: body, headers: header);
    return jsonDecode(response.body);
  }

  Future verifyKhalti(
      userToken,
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
    var url = "$PaymentService:verifyKhalti:body-> userToken:$userToken,"
        " idx:$idx, amount:$amount, mobile:$mobile, productIdentity:$productIdentity, "
        "productName:$productName, token:$token, status:$status, totalAmount:$totalAmount, "
        "shippingAddressId:$shippingAddressId, billingAddressId:$billingAddressId , same:$same ";

    log(url);
    log("PaymentService:verifyKhalti:body-> userToken:$userToken,"
        " idx:$idx, amount:$amount, mobile:$mobile, productIdentity:$productIdentity, "
        "productName:$productName, token:$token, status:$status, totalAmount:$totalAmount, "
        "shippingAddressId:$shippingAddressId, billingAddressId:$billingAddressId , same:$same");
    try {
      var header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "live_secret_key_28c3653d1899474790859e2dc02a67a6"
      };
      var body = jsonEncode({
        "idx": "$idx",
        "amount": "$amount",
        "mobile": "$mobile",
        "productIdentity": "$productIdentity",
        "productName": "$productName",
        "token": "$token",
        "status": "$status",
        "totalAmount": totalAmount,
        "coupon_code": couponCode,
        "coupon_discount_amount": couponDiscountAmt,
        "shipping_address": shippingAddressId,
        "billing_address": billingAddressId,
        "same": same
      });
      var response = await http.post(Uri.parse("$baseUrl/khalti-payment"),
          body: body, headers: header);
      log("PaymentService:verifyKhalti:response:${response.body}");
      return jsonDecode(response.body);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future newKhalti(
    amount,
    purchaseorderid,
    purchaseordername,
  ) async {
    log("  amount:$amount, "
        "purchaseorderid:$purchaseorderid, purchaseordername:$purchaseordername,");
    try {
      var header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Key live_secret_key_28c3653d1899474790859e2dc02a67a6"
      };
      var body = jsonEncode({
        "return_url": 'https://jhigu.store/api/khalti-response',
        "website_url": 'https://example.com/',
        "amount": 13 * 100,
        "purchase_order_id": purchaseorderid,
        "purchase_order_name": purchaseordername,
      });
      var response = await http.post(
          Uri.parse("$khaltiurl/v2/epayment/initiate/"),
          body: body,
          headers: header);
      log("PaymentService:verifyKhalti:response:${response.body}");
      return jsonDecode(response.body);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future paymentVerificationKhalti(
    pidx,
  ) async {
    log(" pidx:$pidx,");
    try {
      var header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Key live_secret_key_28c3653d1899474790859e2dc02a67a6"
      };
      var body = jsonEncode({
        "pidx": pidx,
      });
      var response = await http.post(
          Uri.parse("$khaltiurl/v2/epayment/lookup/"),
          body: body,
          headers: header);
      log("PaymentService:verifyKhalti:response:${response.body}");
      return jsonDecode(response.body);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future verifyCoupon(userToken, coupon, int shippingCharge) async {
    try {
      var header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken"
      };
      var body = {"coupon": "$coupon", "shipping_charge": shippingCharge};
      debugPrint("body of  verify coupon$body");
      var response = await http.post(Uri.parse("$baseUrl/verify_coupon"),
          body: jsonEncode(body), headers: header);
      // if (response.statusCode == 200) {
      return jsonDecode(response.body);
      // } else {
      //   return jsonDecode(response.body);
      // }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future cashPayment(userToken, shippingId, billingId, same, couponCode,
      couponDiscountAmt) async {
    log("PaymentService:cashPayment:token:$userToken,couponCode:$couponCode, couponDiscountAmt:$couponDiscountAmt");
    try {
      var header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken"
      };
      var url =
          "$baseUrl/cash-payment?coupon_code=$couponCode&coupon_discount_amount=$couponDiscountAmt&shipping_address=$shippingId&billing_address=${billingId == 0 ? "" : billingId}&same=${same == true ? 1 : 0}";
      log(url);
      var response = await http.post(Uri.parse(url), headers: header);
      // if (response.statusCode == 200) {
      log("PaymentService:anish:${response.body}");
      return jsonDecode(response.body);

      // } else {
      //   return jsonDecode(response.body);
      // }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future cashPaymentFromFonepay(userToken, shippingId, billingId, same,
      couponCode, couponDiscountAmt) async {
    log("PaymentService:cashPayment:token:$userToken,couponCode:$couponCode, couponDiscountAmt:$couponDiscountAmt");
    try {
      var header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken"
      };
      var url =
          "$baseUrl/fonepay-payment?coupon_code=$couponCode&coupon_discount_amount=$couponDiscountAmt&shipping_address=$shippingId&billing_address=${billingId == 0 ? "" : billingId}&same=${same == true ? 1 : 0}";
      log(url);
      var response = await http.post(Uri.parse(url), headers: header);
      // if (response.statusCode == 200) {
      log("PaymentService:anish:${response.body}");
      return jsonDecode(response.body);

      // } else {
      //   return jsonDecode(response.body);
      // }
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
