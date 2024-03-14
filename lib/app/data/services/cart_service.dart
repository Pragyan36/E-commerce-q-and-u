import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/data/models/options_model.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';

class CartService {
  Future addToCart({
    productid,
    qty,
    token,
    price,
    colorid,
    varientid,
    dataList,
  }) async {
    log("CartService--> token:$token");
    List<Options> json = dataList.toJson();
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var body = {
        "product_id": "$productid",
        "qty": "$qty",
        "varient_id": "$varientid",
        // "price": "$price",
        // "color_id": "$colorid"
        "options": jsonEncode(json)
      };
      debugPrint("this is body $body}");
      var response = await http.post(Uri.parse("$baseUrl/add-to-cart"),
          body: body, headers: header);
      // debugPrint("body123 ${body}");
      log("CartService:addToCart:data:${response.body}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        log("CartService:addToCart:data:$data");
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future addItems({
    required String productId,
    required int variantId,
    required String quantity,
    required List<Map<String, dynamic>> options,
  }) async {
    String userToken = AppStorage.readAccessToken ?? "N/A";
    log(userToken.toString(), name: "User Token");
    log(productId.toString(), name: "Product Id");
    log(variantId.toString(), name: "Variant Id");
    log(quantity.toString(), name: "Quantity");
    log(options.toString(), name: "Options");

    String addToCartUrl = "$baseUrl/add-to-cart";
    log(addToCartUrl.toString(), name: "Add to Cart URL");

    try {
      var header = {
        "Accept": "application/json",
       'Content-Type': 'application/json',
        "Authorization": "Bearer $userToken",
      };
      var body = {
        "product_id": productId,
        "qty": quantity,
        "varient_id": variantId.toString(),
        "options": jsonEncode(options),
      };
      print("this is body cart $jsonEncode(body)");
      print("this is body cart $body");
      log(body.toString(), name: "Request Body");
      var response = await http.post(
        Uri.parse(addToCartUrl),
        body: jsonEncode(body),
        headers: header,
      );
      log(response.body.toString(), name: "Response Body");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        log(data.toString(), name: "Add to Cart Response");
        return data;
      }
    } catch (e) {
      log(e.toString(), name: "Add Items API Call Exception");
    }
  }

  Future getCart({token}) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };

      var response =
          await http.get(Uri.parse("$baseUrl/cart-item"), headers: header);
      // log("cartService:getCart->response:${response.body}");
      if (response.statusCode == 200) {
        // log("cartService:getCart->response code is 200");
        var data = jsonDecode(response.body);
        // log("cartService:getCart->returned data is:$data");
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future removeFromCart({productid, token}) async {
    debugPrint('TOKEN from CartService: (removeFromCart):$token');
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var body = {
        "id": "$productid",
      };
      var response = await http.post(Uri.parse("$baseUrl/remove-from-cart"),
          body: body, headers: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future updateCart({token, productid, qty}) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var body = {"id": "$productid", "qty": "$qty"};
      var response = await http.post(Uri.parse("$baseUrl/update-from-cart"),
          body: body, headers: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future deleteCartProducts(token) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var response = await http.get(Uri.parse("$baseUrl/clear-user-cart"),
          headers: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
