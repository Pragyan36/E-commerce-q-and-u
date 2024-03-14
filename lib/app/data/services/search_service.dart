import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:q_and_u_furniture/app/constants/constants.dart';

class SearchService {
  Future getSearch(name) async {
    // var body = {
    //   "Content-Type": "application/json",
    // };
    print("product name is $name");
    var response = await http.get(Uri.parse('$baseUrl/search/$name'));
    print("thi sis response searcha ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {}
  }
}
