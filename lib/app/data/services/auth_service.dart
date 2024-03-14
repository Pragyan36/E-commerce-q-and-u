// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';

class AuthService {
  Future register({
    name,
    email,
    password,
    confirmPassword,
    phone,
    address,
    photo,
    province,
    district,
    area,
    zip,
    referalCode,
  }) async {
    log("AuthService:register");
    var body = {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword,
      "phone": phone
    };
    log("AuthService:before url hit");
    var response =
        await http.post(Uri.parse("$baseUrl/register"), body: body, headers: {
      'Accept': 'application/json',
    });
    log("AuthService:after url hit:${response.body}");
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      debugPrint("Error response: ${response.body}");
      if (data['msg'] != null && data['msg']['referal_code'] != null) {
        debugPrint("Error message: ${data['msg']['referal_code'][0]}");
      }
      getSnackbar(message: data['msg']);
    }
  }

  Future login({
    required String emailOrphone,
    required String password,
  }) async {
    var body = {
      "email_or_phone": emailOrphone,
      "password": password,
      "verify_from": "email"
    };

    var response = await http.post(
      Uri.parse("$baseUrl/login"),
      body: body,
    );

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    }
    return data;
  }

  Future logindelivery({emailOrphone, password}) async {
    var body = {
      "email": emailOrphone,
      "password": password,
    };

    var response =
        await http.post(Uri.parse("$baseUrl/system/login"), body: body);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    }
    return data;
  }

  Future sociallogin({
    name,
    email,
    provider,
    socialprovider,
    avatar,
    accesstoken,
  }) async {
    var body = {
      "name": name,
      "email": email,
      "provider": provider,
      "social_provider": socialprovider,
      "avatar": avatar,
      "access_token": accesstoken,
    };
    debugPrint("social login is$body");

    var response =
        await http.post(Uri.parse("$baseUrl/social/login"), body: body);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    }
    return data;
  }

  //Verify registered user section

  Future verifyRegisteredUser({emailorphone, otp}) async {
    var body = {
      "email_or_phone": emailorphone,
      "otp": otp,
      "verify_from": "phone"
    };
    var response =
        await http.post(Uri.parse("$baseUrl/verify-register-user"), body: body);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    }

    return data;
  }

  Future resendOtpRegisteredUser({emailorphone}) async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await http.get(
        Uri.parse(
            "$baseUrl/resendregisterotp?email_or_phone=$emailorphone&verify_from=phone"),
        headers: header);
    var data = jsonDecode(response.body);
    // if (response.statusCode == 200) {
    //   return data;
    // }

    return data;
  }

  ///Reset Password section
  Future sendOtp({email}) async {
    var body = {"email": email};
    var response = await http.post(Uri.parse("$baseUrl/sendotp"), body: body);
    var data = jsonDecode(response.body);
    // debugPrint(data['msg']);
    if (response.statusCode == 200) {
      return data;
    }

    return data;
  }

  Future getOtp({email, otp}) async {
    var body = {"email": email, "otp": otp};
    var response = await http.post(Uri.parse("$baseUrl/getotp"), body: body);
    var data = jsonDecode(response.body);
    // debugPrint(data['msg']);
    if (response.statusCode == 200) {
      return data;
    }
    return data;
  }

  Future resetPassword(
      {email, resettoken, password, passwordconfirmation}) async {
    var body = {
      "email": email,
      "reset_token": resettoken,
      "password": password,
      "password_confirmation": passwordconfirmation
    };
    var response =
        await http.post(Uri.parse("$baseUrl/reset-password"), body: body);

    String responseBody = jsonEncode(jsonDecode(response.body));
    debugPrint(responseBody);
    return jsonDecode(response.body);
  }

  Future getAddresses() async {
    try {
      var header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      var response = await http.get(Uri.parse("$baseUrl/shipping-address"),
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
