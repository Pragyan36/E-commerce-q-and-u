import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:q_and_u_furniture/app/constants/constants.dart';

class ShippingService {
  Future getAddressSelector() async {
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

  Future getUserShippingAddress(token) async {
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var response = await http.get(Uri.parse('$baseUrl/user-shipping-address'),
          headers: header);
      // log("fetchUserShippingAddress1:${response.body}");
      if (response.statusCode == 200) {
        log("getUserShippingAddressService: ${response.body}");
        return jsonDecode(response.body);
      } else {}
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future addShippingAddress(token, body) async {
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    print("addShippingAddress$body");
    try {
      var response = await http.post(Uri.parse('$baseUrl/add-shipping-address'),
          headers: header, body: jsonEncode(body));

      if (response.statusCode == 200) {
        log("updateShippingAddressService: ${response.body}");
        return jsonDecode(response.body);
      } else {}
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getUserBillingAddress(token) async {
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var response = await http.get(Uri.parse('$baseUrl/user-billing-address'),
          headers: header);
      if (response.statusCode == 200) {
        return (jsonDecode(response.body));
      } else {}
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future addBillingAddress(token, body) async {
    log("addBillingAddress");
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    print("addBillingAddress$body");

    try {
      var response = await http.post(Uri.parse('$baseUrl/add-billing-address'),
          headers: header, body: jsonEncode(body));
      log("Shipping Service: addBillingAddress:response: ${response.body}");

      if (response.statusCode == 200) {
        log("addBillingAddress: ${response.body}");
        return jsonDecode(response.body);
      } else {}
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future updateShippingAddress(token, body, {required int id}) async {
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      var response = await http.post(
          Uri.parse('$baseUrl/update-shipping-address/$id'),
          headers: header,
          body: jsonEncode(body));
      log(response.body);
      if (response.statusCode == 200) {
        log("addBillingAddress: ${response.body}");
        return jsonDecode(response.body);
      } else {}
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future updateBillingAddress(token, body, {required int id}) async {
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      var response = await http.post(
          Uri.parse('$baseUrl/update-billing-address/$id'),
          headers: header,
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        log("addBillingAddress: ${response.body}");
        return jsonDecode(response.body);
      } else {}
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future deleteShippingAddressbyId(token, {required int id}) async {
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var response = await http.get(
          Uri.parse('$baseUrl/delete-shipping-address/$id'),
          headers: header);
      return (jsonDecode(response.body));
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future deleteBillingAddressbyId(token, {required int id}) async {
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var response = await http.get(
          Uri.parse('$baseUrl/delete-billing-address/$id'),
          headers: header);
      return (jsonDecode(response.body));
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getShippingCharge(token, {required String id}) async {
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var response = await http.get(Uri.parse('$baseUrl/area-charge/$id'),
          headers: header);
      print(response);
      return (jsonDecode(response.body));
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
