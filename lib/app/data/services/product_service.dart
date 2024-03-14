// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';

class ProductService {
  Future getProducts() async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/products"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getProductDetail(slug) async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/product-detail/$slug"));
      debugPrint("slug value  $baseUrl/product-detail/$slug");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        debugPrint('new product details is$data');
        
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future oderdetailsFromNotification(orderID) async {
    debugPrint(orderID);
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppStorage.readAccessToken}',
    };
    try {
      var response = await http.get(
          Uri.parse("$baseUrl/user-detail-order/$orderID"),
          headers: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        debugPrint('notification data is$data');
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getProductAttribute(Map<String, String> body) async {
    try {
      var response =
          await http.post(Uri.parse("$baseUrl/product-attribute"), body: body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  //for not logged in users
  Future getQuesAns(productid) async {
    try {
      var header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      var response = await http
          .get(Uri.parse("$baseUrl/questionlist/$productid"), headers: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  //for logged in users
  Future getUserQuesAns(token, productid) async {
    try {
      var header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var response = await http.get(
          Uri.parse("$baseUrl/userquestionlist/$productid"),
          headers: header);
      log("ProductService:getUserQuesAns:productid:$productid");
      log("ProductService:getUserQuesAns:token:$token");
      log("ProductService:getUserQuesAns:response:${response.body}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        log("ProductService:getUserQuesAns:response:${response.body}");
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future postQues(token, productid, qna) async {
    try {
      var header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var body = {
        "product_id": productid,
        "question_answer": qna,
      };
      var response = await http.post(Uri.parse("$baseUrl/question"),
          body: jsonEncode(body), headers: header);
      debugPrint(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
