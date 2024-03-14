// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/data/services/wishlist_service.dart';

import '../../../data/models/wishlist_model.dart';
import '../../../database/app_storage.dart';
import '../../../widgets/snackbar.dart';
import '../../login/controllers/login_controller.dart';

class WishlistController extends GetxController {
  var wishlistitems = <GetProduct>[].obs;
  var wishListIdArray = [].obs;
  var isLoading = false.obs;
  final logcon = Get.put(LoginController());

  // var token = '';

  @override
  void onInit() {
    // token = logcon.logindata.value.read("TOKEN");
    fetchWishlist();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /*addToWishList(
    id,
    img,
    price,
    name,
  ) {
    wishlistitems.add(Products(
      id: id,
      productImage: img,
      productPrice: price,
      productname: name,
    ));
    update();
  }*/

  deleteWishlistitem(int index) {
    wishlistitems.removeAt(index);
    update();
  }

  fetchWishlist() async {
    isLoading(true);
    var data = await WishListService()
        .getWishList(AppStorage.readAccessToken.toString());
    log("WishListController:AccessToken:${AppStorage.readAccessToken}");
    // log('WishListController:fetchWishlist:$data');
    if (data != null) {
      isLoading(false);
      if (data['error'] == false) {
        wishlistitems.clear();
        data['data']['get_product']
            .forEach((v) => wishlistitems.add(GetProduct.fromJson(v)));
        print("123456 $data");
      } else if (data['error'] == true) {
        wishlistitems.clear();

        // getSnackbar(message: data['msg']);
      }

      wishListIdArray.clear();
      if (wishlistitems.isNotEmpty) {
        for (var element in wishlistitems) {
          wishListIdArray.add(element.id);
        }
      }
    }
    wishListIdArray.clear();
    if (wishlistitems.isNotEmpty) {
      for (var element in wishlistitems) {
        wishListIdArray.add(element.id);
      }
    }
    return data;
  }

  addToWishList(productid) async {
    if (logcon.logindata.value.read('USERID') != null) {
      var data = await WishListService().addToWishList(
        productid,
        AppStorage.readAccessToken,
      );

      if (data != null) {
        if (data['error'] == false) {
          getSnackbar(message: '${data['msg']}');
          fetchWishlist();
        } else if (data['error'] == true) {
          getSnackbar(message: data['msg'], bgColor: Colors.red, error: true);
        }
      }
    } else {
      getSnackbar(
          message: "Please Login to add to Wishlist",
          bgColor: Colors.red,
          error: true);
    }
  }

  removeFromWishList(productid) async {
    var data = await WishListService().removeFromWishList(
      productid,
      AppStorage.readAccessToken,
    );

    if (data != null) {
      if (data['error'] == false) {
        fetchWishlist();
        getSnackbar(message: 'Removed from wishlist');
      } else if (data['error'] == true) {
        getSnackbar(message: data['msg'], bgColor: Colors.red, error: true);
      }
    }
  }

  deleteAllWishlsit() async {
    var data = await WishListService().deleteWishlistProducts(
      AppStorage.readAccessToken,
    );
    print(data.toString());

    if (data != null) {
      if (data['error'] == false) {
        getSnackbar(message: data['msg']);
        fetchWishlist();
      } else {
        // print(count);
        fetchWishlist();

        getSnackbar(message: data['msg'], bgColor: Colors.red, error: true);
      }
    }
  }
}
