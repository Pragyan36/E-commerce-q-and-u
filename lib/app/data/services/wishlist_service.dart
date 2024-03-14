import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../constants/constants.dart';

class WishListService {
  Future getWishList(token) async {
    log("WishListService:getWishList:token:$token");
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var response =
          await http.get(Uri.parse("$baseUrl/wishlist"), headers: header);
      // log("WishListService:getWishList:response:${response.body}");
      // if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
      // }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future addToWishList(productid, token) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var body = {
        "product_id": "$productid",
      };

      var response = await http.post(Uri.parse("$baseUrl/add-to-wishlist"),
          body: body, headers: header);
      print(response);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future removeFromWishList(productid, token) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var body = {"product_id": "$productid"};
      var response = await http.post(Uri.parse("$baseUrl/remove-from-wishlist"),
          body: body, headers: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future deleteWishlistProducts(token) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var response = await http.get(Uri.parse("$baseUrl/clear-user-wishlist"),
          headers: header);
      // if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
      // }
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
