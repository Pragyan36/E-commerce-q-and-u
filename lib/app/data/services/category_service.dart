// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../constants/constants.dart';

class CategoryService {
  Future getParentCategory() async {
    try {
      Map<String, String> header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      var response =
          await http.get(Uri.parse("$baseUrl/category"), headers: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception {}
  }

  Future getChildCategory(slug) async {
    // try {
      Map<String, String> header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      var url = '$baseUrl/child-category/$slug';
      log(url);
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // return response.body;
        return data;
      }
    // } finally {}
  }
}
