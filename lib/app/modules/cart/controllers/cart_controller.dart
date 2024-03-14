// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/data/models/cart_model.dart';
import 'package:q_and_u_furniture/app/data/models/options_model.dart';
import 'package:q_and_u_furniture/app/data/products.dart';
import 'package:q_and_u_furniture/app/data/services/cart_service.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';

class CartController extends GetxController {
  var cartProductsList = <Products>[].obs;
  var cartAssetsList = <CartAssets>[].obs;
  @override
  void onInit() {
    fetchCart();
    super.onInit();
  }

  // @override
  // void onReady() {
  //   log("Cart Controller: onReady");
  //   super.onReady();
  // }

  @override
  void onClose() {
    super.onClose();
  }

  // addToCart(
  //   id,
  //   img,
  //   price,
  //   name,
  // ) {
  //   cartProductsList.add(Products(
  //     id: id,
  //     productImage: img,
  //     productPrice: price,
  //     productname: name,
  //   ));
  //   update();
  // }

  // deleteCartitem(int index) {
  //   cartProductsList.removeAt(index);
  //   update();
  // }

  // final _products = {}.obs;
  // void addProduct(Products product) {
  //   if (_products.containsKey(product)) {
  //     _products[product] += 1;
  //   } else {
  //     _products[product] = 1;
  //   }
  // }

  // get products => _products;

  final logcon = Get.put(LoginController());

  var cartDataList = <CartModelData>[].obs;
  var cartdata = CartModel().obs;
  var cartSummary = CartModel().obs;
  var cartLoading = false.obs;
  var addCartLoading = false.obs;
  var test = false.obs;
  Rx<int> count = 1.obs;
  RxNum defaultval = RxNum(1);

  void increment() {
    if (count >= 0) {
      count.value++;
    }
  }

  void decrement() {
    if (count >= 1) {
      count.value--;
    }
  }

  RxList<Options> options = <Options>[].obs;
  // RxList<Options>  selectedValues1 = <Options>[].obs;
  RxList<String> selectedValues1 = <String>[].obs;
  RxInt selectedValue = 0.obs;
  RxString selectedStockPrice = "".obs;

  addToCart(
    productid,
    variantId,
    qty,
    optionList,
  ) async {
    // List<Map<String, dynamic>> options = [
    //   {"id": 4, "title": "Flavour", "value": "PEANUT BUTTER"},
    //   {"id": 5, "title": "Texture", "value": "Smooth Fudgy"},
    //   {"id": 32, "title": "Packing", "value": "Soft paper"},
    //   {"id": 45, "title": "Sweetness", "value": "Sugar Added"},
    //   {"id": 50, "title": "Container", "value": "100ml"},
    // ];
    log("cart data $productid , total $optionList . qnt $qty ,$variantId,   $options");
    log(optionList.toString(), name: "Option List");

    try {
      addCartLoading.value = true;

      var data = await CartService().addToCart(
        token: AppStorage.readAccessToken,
        productid: productid,
        price: optionList,
        qty: qty,
        // colorid: variantId,
        varientid: variantId, //selectedValue == 0 ? colorid : selectedValue,
        dataList: optionList,
      );
      debugPrint(data.toString());

      if (data != null) {
        addCartLoading.value = false;
        if (kDebugMode) {
          debugPrint(data.toString());
        }
        if (data['error'] == false) {
          getSnackbar(message: 'Added to cart');
          // cartlist.clear();
          // data['data'].forEach((v) => cartlist.add(CartData.fromJson(v)));
          fetchCart();
        } else if (data['error'] == true) {
          debugPrint("object123456");
          getSnackbar(message: data['msg'], bgColor: Colors.red, error: true);
        }
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'getLocationTrack Error');
    } finally {
      addCartLoading(false);
    }
  }

  RxBool addItemsLoading = false.obs;

  void addItems({
    required String productId,
    required int variantId,
    required String quantity,
    required List<Map<String, dynamic>> options,
  }) async {
    log(productId.toString(), name: "productId");
    log(variantId.toString(), name: "variantId");
    log(quantity.toString(), name: "quantity");
    log(options.toString(), name: "options");

    try {
      addItemsLoading(true);
      var addItemsData = await CartService().addItems(
        productId: productId,
        variantId: variantId,
        quantity: quantity,
        options: options,
      );
      log(addItemsData.toString(), name: "Add Items Data");
      if (addItemsData != null) {
        addItemsLoading(false);
        if (addItemsData["error"] == false) {
          getSnackbar(message: "Item successfully added to cart!");
          fetchCart();
        } else if (addItemsData["error"] == true) {
          getSnackbar(
            message: addItemsData["msg"],
            bgColor: Colors.red,
            error: true,
          );
        }
      }
    } catch (e) {
      log(e.toString(), name: "Add Items Exception");
    }
  }

  fetchCart() async {
    cartLoading(true);
    // debugPrint("totla_price: ${cartdata.value.data?[0].totalPrice}");
    var data = await CartService().getCart(
      token: AppStorage.readAccessToken,
    );
    cartAssetsList.clear();
    cartDataList.clear();
    if (data != null) {
      if (data['error'] == false) {
        cartAssetsList.clear();
        cartDataList.clear();
        cartSummary.value = CartModel.fromJson(data);
        data['data']
            .forEach((v) => cartDataList.add(CartModelData.fromJson(v)));

        data['data'][0]['cart_assets']
            .forEach((v) => cartAssetsList.add(CartAssets.fromJson(v)));

        // getSnackbar(message: 'fetch cart data successfull');
      } else if (data['error'] == true) {
        getSnackbar(message: data['msg'], bgColor: Colors.red, error: true);
      }
    } else {
      log("cartController:fetchCart-> data is null");
    }
    cartLoading(false);
  }

  removeCartitem(productid) async {
    var data = await CartService().removeFromCart(
      productid: productid,
      token: AppStorage.readAccessToken,
    );
    if (data != null) {
      if (data['error'] == false) {
        getSnackbar(message: 'Item removed');
        fetchCart();
      } else {
        getSnackbar(
            message: 'Error removing item', bgColor: Colors.red, error: true);
      }
    }
  }

  updateCartitem(productid, qty) async {
    var data = await CartService().updateCart(
      productid: productid,
      qty: qty,
      token: AppStorage.readAccessToken,
    );
    debugPrint(qty);
    if (data != null) {
      if (data['error'] == false) {
        // getSnackbar(message: data['msg']);
        fetchCart();
        getSnackbar(message: 'Cart Updated !!', bgColor: Colors.green);
      } else {
        fetchCart();
        // debugPrint(count);
        getSnackbar(message: 'Out of Stock', bgColor: Colors.red, error: true);
      }
    }
  }

  deleteAllCart() async {
    var data = await CartService().deleteCartProducts(
      AppStorage.readAccessToken,
    );
    if (data != null) {
      if (data['error'] == false) {
        getSnackbar(message: data['msg'], error: false);
        fetchCart();
      } else {
        // debugPrint(count);
        getSnackbar(
            message: 'Sorry !! No Item in Cart',
            bgColor: Colors.red,
            error: true);
      }
    }
  }
}
