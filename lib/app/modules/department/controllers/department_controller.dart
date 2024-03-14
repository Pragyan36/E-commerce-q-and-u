// ignore_for_file: unnecessary_overrides';

import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/data/models/child_category_model.dart';
import 'package:q_and_u_furniture/app/data/services/category_service.dart';

class DepartmentController extends GetxController {
  final count = 0.obs;

  var selectedColor = 0.obs;
  var selectedSize = 0.obs;

  var loading = false.obs;
  var childCategoryList = <Category>[].obs;
  var isListview = true.obs;
  var selectedIndex = 0.obs;
  var products = <Products>[].obs;
  var childCategoryData;

  @override
  void onInit() {
    // fetchChildCategory(childCategoryList);
    super.onInit();
  }



  void increment() => count.value++;

  fetchChildCategory(slug) async {
    loading.value = true;
    var data = await CategoryService().getChildCategory(slug);
    // log("DepartmentController:fetchChildCategory:${data['category']}");

    if (data != null) {
      await Future.delayed(const Duration(seconds: 2));
      loading.value = false;
      childCategoryList.clear();
      products.clear();

      childCategoryData = data['category'];
      data['category']
          .forEach((v) => childCategoryList.add(Category.fromJson(v)));
      childCategoryData[0]['products']
          .forEach((v) => products.add(Products.fromJson(v)));
    }
  }
}
