import 'dart:convert';

import '../../constants/constants.dart';
import 'package:http/http.dart' as http;

class FilterService {
  Future getAttributes() async {
    try {
      var header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      var response =
          await http.get(Uri.parse("$baseUrl/attributes"), headers: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception {}
  }

  Future getBrandbyId(id) async {
    try {
      var header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      var response = await http.get(Uri.parse("$baseUrl/attributes/brand/$id"),
          headers: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception {}
  }

  Future sortProduct(catId, val) async {
    try {
      var header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      print("sorting is $baseUrl/sort?cat_id=$catId&value=$val");
      var response = await http.get(
          Uri.parse("$baseUrl/sort?cat_id=$catId&value=$val"),
          headers: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception {}
  }
}
