import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/data/models/advertisment_model.dart';
import 'package:q_and_u_furniture/app/data/models/home_model.dart';
import 'package:q_and_u_furniture/app/data/models/justforyou_model.dart';
import 'package:q_and_u_furniture/app/data/models/specfic_featured_model.dart';
import 'package:q_and_u_furniture/app/data/models/timimg_model.dart';
import 'package:q_and_u_furniture/app/data/models/top_offer_product_model.dart';
import 'package:q_and_u_furniture/app/data/models/topoffers_model.dart';
import 'package:q_and_u_furniture/app/data/services/home_service.dart';
import 'package:q_and_u_furniture/app/model/product_model.dart';
import 'package:q_and_u_furniture/app/model/recommended_products.dart';
import 'package:q_and_u_furniture/app/model/special_offer_products.dart';

class LandingController extends GetxController {
  var homeData = HomeModelData().obs;
  var timingData = TimingModel().obs;
  var sliderlist = <Sliders>[].obs;
  var adlist = <AdsList>[].obs;
  var departmentlist = <FeaturedCategory>[].obs;
  var featuredlist = <FeaturedSection>[].obs;
  final productsList = <Data>[].obs;
  final specificfeaturedList = <FeaturedProductsList>[].obs;
  final selectedbanner = 0.obs;
  final loading = false.obs;
  final loadingslider = false.obs;
  final loadingAds = false.obs;
  var adIndex = 0.obs;
  var numberOfPostsPerRequest = 6.obs;
  var isListview = false.obs;
  //Just for you variables
  var justForYouTagsList = <JustForYouTags>[].obs;
  var tagsLoading = false.obs;

  var justForYouProductsList = <Products>[].obs;
  var selectedSlug = ''.obs;
  var jfyLoading = false.obs;
  var deparmentshop = false.obs;

  @override
  void onInit() {
    // fetchskipads();
    // fetchHome();
    fetchshippingcharge();
    fetchTiming();
    fetchslider();
    fetchads();
    fetchTopOffers();
    // mapcontroller.getAddressFromLatLong(position)

    fetchSpecificFeaturedProducts(specificId);
    fetchProducts();
    // fetchTopOffers();
    // fetchJustForYouBySlug('');
    super.onInit();
  }

  fetchHome() async {
    loading(true);
    var data = await HomeService().getHome();

    if (data != null) {
      loading(false);
      departmentlist.clear();
      featuredlist.clear();
      // sliderlist.clear();
      homeData.value = HomeModelData.fromJson(data['data']);

      // data['data']['sliders']
      //     .forEach((v) => sliderlist.add(Sliders.fromJson(v)));
      // data['data']['advertisements']
      //     .forEach((v) => adlist.add(Advertisements.fromJson(v)));
      data['data']['featured_category']
          .forEach((v) => departmentlist.add(FeaturedCategory.fromJson(v)));
      data['data']['featured_section']
          .forEach((v) => featuredlist.add(FeaturedSection.fromJson(v)));
      if (data['error'] == false) {}
    }
  }

  fetchslider() async {
    loadingslider(true);
    var data = await HomeService().getSlider();

    if (data != null) {
      loadingslider(false);
      // departmentlist.clear();
      // featuredlist.clear();
      sliderlist.clear();
      // homeData.value = HomeModelData.fromJson(data['data']);

      data['data'].forEach((v) => sliderlist.add(Sliders.fromJson(v)));
      // data['data']['advertisements']
      //     .forEach((v) => adlist.add(Advertisements.fromJson(v)));
      // data['data']['featured_category']
      //     .forEach((v) => departmentlist.add(FeaturedCategory.fromJson(v)));
      // data['data']['featured_section']
      //     .forEach((v) => featuredlist.add(FeaturedSection.fromJson(v)));
      if (data['error'] == false) {}
    }
  }

  fetchads() async {
    loadingAds(true);
    var data = await HomeService().getAds();
    debugPrint("dataads $data");

    if (data != null) {
      loadingAds(false);
      // departmentlist.clear();
      // featuredlist.clear();
      adlist.clear();
      // homeData.value = HomeModelData.fromJson(data['data']);

      // data['data'].forEach((v) => sliderlist.add(Sliders.fromJson(v)));
      data['data'].forEach((v) => adlist.add(AdsList.fromJson(v)));
      // data['data']['featured_category']
      //     .forEach((v) => departmentlist.add(FeaturedCategory.fromJson(v)));
      // data['data']['featured_section']
      //     .forEach((v) => featuredlist.add(FeaturedSection.fromJson(v)));
      if (data['error'] == false) {}
    }
  }

  fetchTiming() async {
    loading(true);
    var data = await HomeService().getTiming();
    debugPrint("timing $data");

    if (data != null && data is Map<String, dynamic>) {
      // Check if data is a Map
      loading(false);
      // departmentlist.clear();
      // featuredlist.clear();
      // skipadlist.clear();

      timingData.value = TimingModel.fromJson(data);
      // homeData.value = HomeModelData.fromJson(data['data']);

      // data['data'].forEach((v) => sliderlist.add(Sliders.fromJson(v)));
      // data['data'].forEach((v) => skipadlist.add(SkipAdslist.fromJson(v)));
      // data['data']['featured_category']
      //     .forEach((v) => departmentlist.add(FeaturedCategory.fromJson(v)));
      // data['data']['featured_section']
      //     .forEach((v) => featuredlist.add(FeaturedSection.fromJson(v)));
      if (data['status'] == false) {}
    }
  }

  var page = 1.obs;

  fetchProducts() async {
    loading(true);
    var data = await HomeService().getAllProducts(page.value);
    if (data != null) {
      loading(false);
      productsList.clear();
      data['data'].forEach((v) => productsList.add(Data.fromJson(v)));
    }
  }

  var shippingchargedefaultvalue = 0.obs;

  fetchshippingcharge() async {
    loading(true);
    var data = await HomeService().getshippingcharge();
    if (data != null) {
      loading(false);
      shippingchargedefaultvalue.value = int.parse(data['data']);
      debugPrint("shippingchargedefaultvalue $shippingchargedefaultvalue");
      // productsList.clear();
      // data['data'].forEach((v) => productsList.add(Data.fromJson(v)));
    }
  }

  RxBool loadingmore = false.obs;
  Rx<ScrollController> scrollcon = ScrollController().obs;

  loadMore() async {
    if (loading.isFalse && loadingmore.isFalse) {
      loadingmore(true);
      page.value += 1;
      var data = await HomeService().getAllProducts(page.value);
      if (data != null) {
        loadingmore(false);
        data['data'].forEach((v) => productsList.add(Data.fromJson(v)));
      } else {
        loadingmore(false);
      }
    }
  }

  RxBool loadMoreLoading = false.obs;

  void scrollListener() {
    if (scrollcon.value.position.pixels ==
        scrollcon.value.position.maxScrollExtent) {
      loadMore();
    }
  }

  RxBool specificloading = false.obs;
  RxInt specificId = 1.obs;

  fetchSpecificFeaturedProducts(id) async {
    specificloading(true);
    var data = await HomeService().getSpecificFeatured(id);
    // if (data != null) {
    specificloading(false);
    specificfeaturedList.clear();

    if (data['data'] != null) {
      data['data']['product'].forEach(
          (v) => specificfeaturedList.add(FeaturedProductsList.fromJson(v)));
      //  }
    }
  }

  var topOffersData = <TopOfferModelData>[];
  var topOffersLoading = false.obs;

  fetchTopOffers() async {
    topOffersLoading(true);
    var data = await HomeService().getTopOffers();
    if (data != null) {
      topOffersLoading(false);

      topOffersData.clear();
      data['data']
          .forEach((v) => topOffersData.add(TopOfferModelData.fromJson(v)));
    }
  }

  var topOffersProductData = <OfferProducts>[];
  var topOffersProductsLoading = false.obs;
  var slug = '';

  fetchTopOffersProduct() async {
    topOffersProductsLoading(true);
    var data = await HomeService().getTopOffersProducts(slug);
    if (data != null) {
      topOffersProductsLoading(false);

      topOffersProductData.clear();
      data['data']["offer_products"]
          .forEach((v) => topOffersProductData.add(OfferProducts.fromJson(v)));
    }
  }

  // fetchJustForYouBySlug(jfySlug) async {
  //   jfyLoading(true);
  //   var data = await HomeService()
  //       .getJustForYouBySlug(jfySlug ?? justForYouTagsList[0].slug.toString());

  //   // justForYouProductsList.clear();
  //   if (data != null) {
  //     jfyLoading(false);

  //     // data['data']['products'].forEach((v) => justForYouProductsList
  //     //     .add(JustForYouProductModelProducts.fromJson(v)));
  //   }
  // }
  // fetchJustForYouBySlug(justForYouTagsList[0].slug);

  fetchJustForYou(String location) async {
    tagsLoading(true);
    var data = await HomeService().getJustForYou(location);
    justForYouTagsList.clear();
    justForYouProductsList.clear();
    if (data != null) {
      tagsLoading(false);
      data['data']['tags'].forEach(
        (v) => justForYouTagsList.add(
          JustForYouTags.fromJson(v),
        ),
      );
      // data['data']['products'].forEach(
      //   (v) => justForYouProductsList.add(
      //     Products.fromJson(v),
      //   ),
      // );
    }
    fetchJustForYouBySlug(justForYouTagsList[0].slug);
    return data;
  }

  fetchJustForYouBySlug(jfySlug) async {
    jfyLoading(true);
    var data = await HomeService()
        .getJustForYouBySlug(jfySlug ?? justForYouTagsList[0].slug.toString());

    // justForYouProductsList.clear();
    if (data != null) {
      jfyLoading(false);

      data['data']['products'].forEach(
        (v) => justForYouProductsList.add(
          Products.fromJson(v),
        ),
      );
    }
    return data;
  }

  RxBool recommendedProductsLoading = false.obs;
  RxList<RecommendedProductsData> recommendedProductsList =
      <RecommendedProductsData>[].obs;
  RxInt itemCountRecommendedProducts = 0.obs;

  fetchRecommendedProducts() async {
    recommendedProductsLoading(true);
    RecommendedProducts? data = await HomeService().callRecommendedProducts();
    // recommendedProductsList.clear();
    if (data != null) {
      recommendedProductsLoading(false);
      recommendedProductsList.value = data.data!;
      if (recommendedProductsList.length > 8) {
        itemCountRecommendedProducts = 8.obs;
      } else {
        itemCountRecommendedProducts = recommendedProductsList.length.obs;
      }
    } else {
      recommendedProductsLoading(false);
      log("There was an issue fetching recommended products!");
    }
  }

  RxBool latestProductsLoading = false.obs;
  RxList<RecommendedProductsData> latestProductsList =
      <RecommendedProductsData>[].obs;
  RxInt itemCountLatestProducts = 0.obs;

  fetchLatestProducts() async {
    latestProductsLoading(true);
    RecommendedProducts? data = await HomeService().callLatestProducts();
    latestProductsList.clear();
    if (data != null) {
      latestProductsLoading(false);
      latestProductsList.value = data.data!;
      if (latestProductsList.length > 8) {
        itemCountLatestProducts = 8.obs;
      } else {
        itemCountLatestProducts = latestProductsList.length.obs;
      }
    } else {
      latestProductsLoading(false);
      log("There was an error fetching latest products!");
    }
  }

  RxBool specialProductsLoading = false.obs;
  RxList<SpecialProductsData> specialProductsList = <SpecialProductsData>[].obs;
  RxInt itemCount = 0.obs;

  fetchSpecialProducts() async {
    specialProductsLoading(true);
    SpecialProducts? data = await HomeService().callSpecialProducts();
    specialProductsList.clear();
    if (data != null) {
      specialProductsLoading(false);
      specialProductsList.value = data.data!;
      if (specialProductsList.length > 4) {
        itemCount = 4.obs;
      } else {
        itemCount = specialProductsList.length.obs;
      }
    } else {
      log("data is Null");
    }
  }

  // loadMoresubCategory(category) async {
  //   try {
  //     _loadingallproducts = true;
  //     currentPageofsubCategorylist++; // Increment the currentPage before fetching more products

  //     await getsubcatagory(currentPageofsubCategorylist, category)
  //         .then((allSubCategory) {
  //       _getSubCatagory = SubCategoryModel.fromJson(allSubCategory);
  //       final List<dynamic> _List =
  //           allSubCategory['featured_categories']['data'];
  //       final List<SubCategoryData> newDataList =
  //           _List.map((data) => SubCategoryData.fromJson(data)).toList();
  //       _getSubCatagory!.featuredCategories!.data!.addAll(newDataList);

  //       _loadingallproducts = false;
  //       notifyListeners();
  //     });
  //   } catch (e) {
  //     _loadingallproducts = false;
  //     notifyListeners();
  //     throw e;
  //   }
  // }

  // void _scrollListner() {
  //   if (scrollController.position.pixels ==
  //       scrollController.position.maxScrollExtent) {
  //     var state = Provider.of<LoaderState>(context, listen: false);

  //     // state.loadMore(page);
  //     state.loadingallproducts == true
  //         ? const Center(
  //             child: CircularProgressIndicator(),
  //           )
  //         : state.loadMoresubCategory(widget.category);
  //   } else {
  //     const Center(
  //       child: CircularProgressIndicator(),
  //     );
  //   }
  // }
}
