// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/data/models/user_review_model.dart';

class ReviewService {
  Future getReviews(productid) async {
    var response = await http.get(Uri.parse("$baseUrl/review/$productid"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    }
  }

  Future<UserReviewModel> getMyReviews(token) async {
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response =
        await http.get(Uri.parse("$baseUrl/reviews/user"), headers: header);
    // if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return UserReviewModel.fromJson(data);
    // }
  }
}
