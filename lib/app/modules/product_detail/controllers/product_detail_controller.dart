import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/data/models/product_detail_model.dart';
import 'package:q_and_u_furniture/app/data/models/question_ans_model.dart';
import 'package:q_and_u_furniture/app/data/models/review_model.dart';
import 'package:q_and_u_furniture/app/data/services/product_service.dart';
import 'package:q_and_u_furniture/app/data/services/review_service.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';

class ProductDetailController extends GetxController {
  final count = 1.obs;
  var selectedindex = 0.obs;
  var selectedimg = 1.obs;

  // var selectedRam = "".obs;
  var selectedVarientId = 0.obs;
  var selectedColor = 0.obs;
  var selectedVariantQty = 0.obs;
  var specialPrice = 0.obs;
  var price = 0.obs;
  var sellerName = ''.obs;

  // var specialPrice = 0.obs;
  var loading = false.obs;
  var loadingReview = false.obs;

  var productId = 0.obs;
  var showLongDesc = false.obs;

  var ignorePointer = false.obs;
  final String TAG = "ProductDetailController";

  var productdetail = ProductDetailData().obs;
  RxInt? priceDifference = 0.obs;
  RxInt originalPrice = 0.obs;
  var tabIndex = "1".obs;

  // var stockwise = <StockWise>[].obs;
  var reviewList = <ReviewHeadingModel>[].obs;
  var questionAnsList = <QuestionAnswerData>[].obs;

  final logInCon = Get.put(LoginController());

  final qna = TextEditingController();

  var myData;

  var dummyColor = [
    {'id': 0, 'color': const Color(0xFFE8EAF6)},
    {'id': 1, 'color': const Color(0xFF7E57C2)},
    {'id': 2, 'color': const Color(0xFF26C6DA)}
  ];

  @override
  void onInit() {
    selectedindex.value == 0;
    selectedimg.value == 0;
    super.onInit();
  }

  @override
  void onClose() {
    qna.dispose();
    super.onClose();
  }

  void increment() {
    if (count > 0 && count < selectedVariantQty.value) {
      count.value++;
    }
  }

  void decrement() {
    if (count > 1) {
      count.value--;
    }
  }

  var selectedColorCode = ''.obs;
  String? selectedValue;
  var selectedValues = [].obs;
  var listOfTitle = [].obs;
  var listOfId = [].obs;
  RxInt selectedStockIndex = 0.obs;
  var selectedAttributes = [].obs; //

  RxList<String> selectedValues1 = <String>[].obs;

  // List<String> selectedValues = [];

  var selectedStockId = 0.obs;

  void setSelectedStockId(int stockId) {
    selectedStockId.value = stockId;
  }

  getFilteredAttributes(attributes) {
    if (selectedStockId.value == 0) {
      return attributes;
    } else {
      return attributes
          .where((attribute) => attribute.stockId == selectedStockId.value)
          .toList();
    }
  }

  List? nestedData;
  RxInt updatedSpecialPrice = 0.obs;
  RxInt updatedOriginalPrice = 0.obs;
  RxInt updatedDiscount = 0.obs;

  fetchProductDetail(slug) async {
    loading(true);
    print("this is slug $slug");
    var data = await ProductService().getProductDetail(slug);
    // myData = data;
    // log("SKT:withJsonDecode:insideController:$data");
    // log(data.toString());
    print("this is data ${data}");

    if (data != null) {
      productdetail.value = ProductDetailData.fromJson(data['data']);
      productId.value = productdetail.value.id!.toInt();

      selectedColorValue.value = productdetail.value.colors![0].id!;
      loading(false);
      //will be used to fetch other color variants
      // List check = productdetail.value.productDetailsAttribute!.entries
      //     .map((e) => e.value)
      //     .toList();
      // nestedData = check;
      // debugPrint("check data is $nestedData");

      selectedVarientId.value = productdetail.value.selectedData![0].id!;
      selectedVariantQty.value = productdetail.value.selectedData![0].quantity!;

      //this count variable is used to show the value in quantity increment and decrement
      count.value = selectedVariantQty.value > 0 ? 1 : 0;

      price.value = productdetail.value.selectedData![0].price!;
      // sellerName.value = productdetail.value.sellerName!;
      if (productdetail.value.selectedData![0].specialPrice != null) {
        specialPrice.value = productdetail.value.selectedData![0].specialPrice!;
      }

      log(productdetail.value.price.toString(), name: "Product Price");
      var testPrice = productdetail.value.price ?? 0;
      originalPrice.value = testPrice;
      log(originalPrice.toString(), name: "Price Original");
      /*
        NEW DATA FROM DATABASE
      */
      // updatedOriginalPrice.value =
      //     productdetail.value.selectedAttributes?[0].stock?.price ?? 0;
      // updatedSpecialPrice.value =
      //     productdetail.value.selectedData?[0].specialPrice ?? 0;

      // if (productdetail.value.selectedAttributes![0].stock!.price != null &&
      //     productdetail.value.selectedAttributes![0].stock!.specialPrice !=
      //         null) {
      //   var differenceInPrice =
      //       productdetail.value.selectedAttributes![0].stock!.price! -
      //           productdetail.value.selectedAttributes![0].stock!.specialPrice;
      //   // log(differenceInPrice.toString(), name: "Difference in Price");
      //   priceDifference!.value = differenceInPrice.toInt();
      //   // log(priceDifference.toString(), name: "Price Difference");
      // }
      if (productdetail.value.price != null &&
          productdetail.value.specialPrice != null) {
        var differenceInPrice =
            productdetail.value.price! - productdetail.value.specialPrice!;
        priceDifference!.value = differenceInPrice;
        log(priceDifference.toString(), name: "Price Difference");
      }
    }
  }

  var productattributesData;

  // = <SelectedData>[].obs;
  var productAttributeLoading = false.obs;
  var hasData = false.obs;

  fetchProductAttribute(colorId, productId) async {
    productAttributeLoading(true);

    log("ProductDetailController:fetchProductAttribute:colorId:$colorId, productId:$productId");
    var data = await ProductService().getProductAttribute(
        {"color_id": "$colorId", "product_id": "$productId"});
    if (data != null) {
      hasData(true);
      productAttributeLoading(false);

      productattributesData = data;
    }

    selectedVarientId.value =
        int.parse(productattributesData['data'][0]['id'].toString());
    selectedVariantQty.value =
        int.parse(productattributesData['data'][0]['quantity'].toString());

    price.value =
        int.parse(productattributesData['data'][0]['price'].toString());
    sellerName.value = productdetail.value.sellerName!;
    if (productattributesData['data'][0]['special_price'] != null) {
      specialPrice.value = int.parse(
          productattributesData['data'][0]['special_price'].toString());
    }
  }

  fetchReviews(int? productid) async {
    loadingReview.value = true;
    var data = await ReviewService().getReviews(productid);

    try {
      if (data != null) {
        loadingReview.value = false;
        if (kDebugMode) {
          debugPrint(data.toString());
        }
        reviewList.clear();
        data['data']
            .forEach((v) => reviewList.add(ReviewHeadingModel.fromJson(v)));
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    } finally {
      loadingReview.value = false;
    }
  }

  fetchQuesAns(productid) async {
    log("fetchQuesAns:productid:$productId");

    if (AppStorage.readIsLoggedIn == true) {
      log("LOGGED IN");
      log("LOGGED IN:fetchQuesAns:productid:$productId");
      var data = await ProductService()
          .getUserQuesAns(AppStorage.readAccessToken, productid);
      if (data != null) {
        if (data['error'] == false) {
          questionAnsList.clear();
          data['data'].forEach(
              (v) => questionAnsList.add(QuestionAnswerData.fromJson(v)));
        }
        log("questionAnsList.length2: ${questionAnsList.length}");
      }
    } else {
      log("!LOGGED IN");
      var data = await ProductService().getQuesAns(productid);
      if (data != null) {
        if (data['error'] == false) {
          questionAnsList.clear();
          data['data'].forEach(
              (v) => questionAnsList.add(QuestionAnswerData.fromJson(v)));
        }
      }
      log("questionAnsList.length3: ${questionAnsList.length}");
    }
  }

  postQues(productid) async {
    var data = await ProductService()
        .postQues(AppStorage.readAccessToken, productid, qna.text);
    debugPrint(data.toString());

    if (data != null) {
      if (data['error'] == false) {
        getSnackbar(message: 'Question added');
        Get.back();
      }
    }
  }

  RxInt selectedColorIndex = 0.obs;
  RxString selectedColorString = "".obs;
  RxInt selectedColorValue = 0.obs;

  RxInt tapedIndexOutside = 0.obs;
}
