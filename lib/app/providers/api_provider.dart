// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiProvider {
  Future getProducts(int limit) async {
    var url = Uri.parse('https://fakestoreapi.com/products?limit=$limit');

    var response = await http.get(url);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    }
  }
}
