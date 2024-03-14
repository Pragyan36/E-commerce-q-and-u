// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/model/recommended_products.dart';
import 'package:q_and_u_furniture/app/model/site_details_model.dart';
import 'package:q_and_u_furniture/app/model/special_offer_products.dart';

class HomeService {
  Future getSlider() async {
    var response = await http.get(Uri.parse("$baseUrl/slider"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    }
  }

  Future getTopRanked() async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/top-ranked"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getFeaturedProducts() async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/featured-product"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getAllProducts(int page) async {
    try {
      var url = "$baseUrl/products?per_page=6&page=$page";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getshippingcharge() async {
    try {
      var url = "$baseUrl/default-shipping-charge";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getAllFeaturedSpecific(id) async {
    try {
      var response =
          await http.post(Uri.parse("$baseUrl/specific-featured-product/$id"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future location(shippingaddress, userid) async {
    try {
      var body = {
        "shipping_address": "$shippingaddress",
        "user_id": "$userid",
      };
      var response =
          await http.post(Uri.parse("$baseUrl/updateProfile"), body: body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getAds() async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/ads"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getSkipAds() async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/skip-ad"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getTiming() async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/today-order-timing"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getSpecificFeatured(id) async {
    try {
      var response =
          await http.get(Uri.parse("$baseUrl/specific-featured-product/$id"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  ///new home data
  Future getHome() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        debugPrint("data is $data");
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

//Top oFfers
  Future getTopOffers() async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/top-offer"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getTopOffersProducts(slug) async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/top-offer/$slug"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getJustForYou(String location) async {
    try {
      // debugPrint("Current location ${location}");
      var response =
          await http.get(Uri.parse("$baseUrl/just-for-you?city=$location"));
      // log("HomeService:getJustForYou:response:${response.body}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getJustForYouBySlug(slug) async {
    try {
      var response = await http.get(
        Uri.parse("$baseUrl/just-for-you/$slug"),
      );
      var url = '$baseUrl/just-for-you/$slug';
      log(url);
      log('HomService:getJustForYouBySlug:${response.body}');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        debugPrint("data is $data");
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getSocialIcon() async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/social-site"));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getCustomCare() async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/customercare"));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getPrivacyPolicy() async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/menu"));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future callRecommendedProducts() async {
    String recommendedProductsUrl = "$baseUrl/recommendation/product";

    try {
      var response = await http.get(
        Uri.parse(recommendedProductsUrl),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        RecommendedProducts recommendedProducts =
            RecommendedProducts.fromJson(jsonResponse);
        return recommendedProducts;
      } else {
        log(
          response.statusCode.toString(),
          name: "Recommended Products Error Code",
        );
        log(
          response.body.toString(),
          name: "Recommended Products Error Body",
        );
      }
    } catch (e) {
      log(e.toString(), name: "Recommended Products Error");
    }
  }

  Future callLatestProducts() async {
    String latestProductsUrl = "$baseUrl/latest/products";

    try {
      var response = await http.get(
        Uri.parse(latestProductsUrl),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        RecommendedProducts latestProducts =
            RecommendedProducts.fromJson(jsonResponse);
        return latestProducts;
      } else {
        log(
          response.statusCode.toString(),
          name: "Latest Products Error Code",
        );
        log(
          response.body.toString(),
          name: "Latest Products Error Body",
        );
      }
    } catch (e) {
      log(e.toString(), name: "Latest Products Error");
    }
  }

  Future callSpecialProducts() async {
    String specialProductsUrl = "$baseUrl/special/offer/product";

    try {
      var response = await http.get(
        Uri.parse(specialProductsUrl),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        SpecialProducts specialProducts =
            SpecialProducts.fromJson(jsonResponse);
        return specialProducts;
      } else {
        log(
          response.statusCode.toString(),
          name: "Special Products Error Code",
        );
        log(
          response.body.toString(),
          name: "Special Products Error Body",
        );
      }
    } catch (e) {
      log(e.toString(), name: "Special Products Error");
    }
  }

  Future getSiteDetails() async {
    String siteDetailsUrl = "$baseUrl/site-detail";

    try {
      var response = await http.get(
        Uri.parse(siteDetailsUrl),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        SiteDetail siteDetail = SiteDetail.fromJson(jsonResponse);
        return siteDetail;
      } else {
        log(
          response.statusCode.toString(),
          name: "Site Details Error Code",
        );
        log(
          response.body.toString(),
          name: "Site Details Error Body",
        );
      }
    } catch (e) {
      log(e.toString(), name: "Site Detail Exception");
    }
  }
}
