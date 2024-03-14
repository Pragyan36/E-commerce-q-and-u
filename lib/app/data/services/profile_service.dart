// ignore_for_file: unused_local_variable, depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/account_controller.dart';

class ProfileService extends GetConnect {
  Future getUser(userid) async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/user/$userid"));
      log("ProfileService:getUser:response:${response.body}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        debugPrint("data user is$data");
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getUserStaff(userid) async {
    // try {
    var response = await http.get(Uri.parse("$baseUrl/get-staff/$userid"));
    log("ProfileService:getUser:response:${response.body}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      debugPrint("data user is$data");
      return data;
    }
    // } on Exception catch (e) {
    //   log(e.toString());
    // }
  }

  Future getMyDetails(userid) async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/my-detail/$userid"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getReward(String? readAccessToken) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $readAccessToken",
    };
    try {
      var response =
          await http.get(Uri.parse("$baseUrl/user-reward"), headers: headers);
      log("Reward:getUser:response:${response.body}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        debugPrint("reward is$data");
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future siteDetail() async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/site-detail"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future updateUser(token, name, phone, address, area, country, File photo,
      shippingaddress) async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var body = {
      "name": "$name",
      "phone": "$phone",
      "address": "$address",
      "area": "$area",
      "country": "$country",
      // "photo": MultipartFile(photo, filename: '$photo.png'),
      "shipping_address": "$shippingaddress",
    };
    var response = await http.post(Uri.parse('$baseUrl/updateProfile'),
        body: jsonEncode(body), headers: header);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }

  Future updateProfile(token, Map<String, String> body, filepath) async {
    if (filepath != null && filepath != "") {
      String addimageUrl = '$baseUrl/updateProfile';
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        "Authorization": "Bearer $token",
      };
      final controller = Get.put(AccountController());
      var imageFile = File(
          controller.selectedImagePath.value); // Replace with your image path
      var imageStream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var request = http.MultipartRequest('POST', Uri.parse(addimageUrl))
        ..fields.addAll(body)
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('photo', filepath));
      var response = await request.send();

      var data = await http.Response.fromStream(response);
      return jsonDecode(data.body);
    } else {
      Map<String, String> header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var response = await http.post(Uri.parse('$baseUrl/updateProfile'),
          body: jsonEncode(body), headers: header);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    }
  }

  Future uploadImg(
    token,
    File photo,
  ) async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var form = FormData({
      "photo": MultipartFile(photo, filename: '$photo.png'),
    });
    var response = await post('$baseUrl/updateProfile', form, headers: header);

    debugPrint(response.toString());
  }

  Future sendMsg(fullname, phone, email, title, issue) async {
    var body = {
      "full_name": fullname,
      "email": email,
      "phone_num": phone,
      "message": title,
      "issue": issue,
    };
    var response =
        await http.post(Uri.parse("$baseUrl/contact-us"), body: body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }
}
