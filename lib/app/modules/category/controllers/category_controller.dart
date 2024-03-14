// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/data/models/child_category_model.dart';
import 'package:q_and_u_furniture/app/data/models/parent_category_model.dart';
import 'package:q_and_u_furniture/app/data/services/category_service.dart';
import 'package:q_and_u_furniture/app/data/services/filter_service.dart';

class CategoryController extends GetxController {
  final categoryTap = false.obs;
  final isListview = false.obs;
  var parentcategoryList = <Parent>[].obs;
  var childcategoryList = <Category>[].obs;
  var childcategoryList1 = <Category>[].obs;
  final selected = 0.obs;
  final selectedindex = 0.obs;
  final childselected = 0.obs;
  final slug = ''.obs;
  final childSlug = ''.obs;

  final first = ''.obs;
  final selectedSortingItem = "1".obs;
  var loading = false.obs;
  var selectedImg = 0.obs;

  var selectedExpand = 7.obs;

  // late List<bool> _isOpen;
  var isOpened = <bool>[].obs;

  get topOffersProductData => null;

  @override
  void onInit() {
    debugPrint("child slug is$childSlug");
    fetchParentCategory();
    fetchChildCategory(first.value);
    selected.value = 0;
    selectedSortingItem.value = "1";
    debugPrint('object');
    super.onInit();
  }

  // @override
  // void dispose() {
  //   CategoryController().dispose();
  //   super.dispose();
  // }
  var parentLoading = false.obs;

  fetchParentCategory() async {
    parentLoading(true);

    var data = await CategoryService().getParentCategory();
    if (data != null) {
      parentLoading(false);

      parentcategoryList.clear();
      data['parent'].forEach(
        (v) => parentcategoryList.add(
          Parent.fromJson(v),
        ),
      );
    }
  }

  fetchChildCategory(slug) async {
    loading(true);
    var data = await CategoryService().getChildCategory(slug);
    log("CategoryController:fetchChildCategory:dataReceived");
    if (data != null) {
      loading(false);

      childcategoryList.clear();
      data['category']
          .forEach((v) => childcategoryList.add(Category.fromJson(v)));
    }
  }

  fetchChildCategory1(slug) async {
    loading(true);

    var data = await CategoryService().getChildCategory(slug);
    // log(data['category'].toString());
    if (data != null) {
      loading(false);

      childcategoryList1.clear();
      data['category']
          .forEach((v) => childcategoryList1.add(Category.fromJson(v)));
      // childcategoryList.removeAt(0);
    }
  }

  var sortProducts = Category().obs;
  var sortTapped = false.obs;

  fetchSortProduct(catId, val) async {
    loading(true);
    var data = await FilterService().sortProduct(catId, val);
    debugPrint(data['data']);

    if (data != null) {
      loading(false);
      if (data['error'] == false) {
        sortTapped.value = !sortTapped.value;
        // sortProducts.clear();
        // data['data']['products']
        //     .forEach((v) => sortProducts.add(Products.fromJson(v)));
        sortProducts.value = Category.fromJson(data['data']);
      }
    }
  }
}
