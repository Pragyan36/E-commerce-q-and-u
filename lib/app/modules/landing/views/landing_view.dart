import 'dart:async';

import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/modules/category/controllers/category_controller.dart';
import 'package:q_and_u_furniture/app/modules/department/views/department_view.dart';
import 'package:q_and_u_furniture/app/modules/home/components/map_view.dart';
import 'package:q_and_u_furniture/app/modules/home/components/sliver_grid.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/map_controller.dart';
import 'package:q_and_u_furniture/app/modules/landing/components/all_products.dart';
import 'package:q_and_u_furniture/app/modules/landing/components/categories_widget.dart';
import 'package:q_and_u_furniture/app/modules/landing/components/product_display_widget.dart';
import 'package:q_and_u_furniture/app/modules/landing/components/special_product_display_widget.dart';
import 'package:q_and_u_furniture/app/modules/landing/components/top_offers_screen.dart';
import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';
import 'package:q_and_u_furniture/app/modules/landing/views/slider.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/views/login_view.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/components/latest_products_view_all.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/components/special_offers_view_all.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/components/view_all_screen.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/views/product_detail_view.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:q_and_u_furniture/app/routes/app_pages.dart';
import 'package:q_and_u_furniture/app/widgets/custom_searchbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_section_header.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:q_and_u_furniture/app/widgets/loading_widget.dart';
import 'package:q_and_u_furniture/app/widgets/no_internet.dart';
import 'package:q_and_u_furniture/app/widgets/no_product_widget.dart';
import 'package:q_and_u_furniture/app/widgets/product_card.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';
import 'package:q_and_u_furniture/app/widgets/toast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingView extends StatefulWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  final LandingController landingController = Get.put(LandingController());
  final HomeController homeController = Get.put(HomeController());
  final WishlistController wishlistController = Get.put(WishlistController());
  final CartController cartController = Get.put(CartController());
  final LoginController loginController = Get.put(LoginController());
  final MapViewController mapController = Get.put(MapViewController());
  final CategoryController categoryController = Get.put(CategoryController());
  int _imageCurrentIndex = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  var hasInternet = false.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      checkInternet();
      scrollController.addListener(
        () {
          if (scrollController.hasClients) {
            if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
              landingController.loadMore();
            }
          }
        },
      );
      await loginController.fetchSiteDetails();
      landingController.fetchHome();
      landingController.fetchTopOffers();
      mapController.getPlaceName();
      landingController.fetchJustForYou(
        mapController.currentAddress.value,
      );
      landingController.fetchRecommendedProducts();
      landingController.fetchLatestProducts();
      landingController.fetchSpecialProducts();
      landingController.fetchTiming();
      landingController.onInit();
      categoryController.onInit();
      Timer.periodic(
        const Duration(milliseconds: 500),
        (Timer timer) {
          if (_imageCurrentIndex < landingController.adlist.length - 1) {
            _imageCurrentIndex++;
          } else {
            _imageCurrentIndex = 0;
          }
          _pageController.animateToPage(
            _imageCurrentIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
      );
      super.initState();
    });
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<LandingController>();
    Get.delete<HomeController>();
    Get.delete<MapViewController>();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Obx(
        () => hasInternet.value
            ? RefreshIndicator(
                backgroundColor: Colors.white,
                color: AppColor.kalaAppMainColor,
                onRefresh: () async {
                  await Future.delayed(
                    const Duration(seconds: 2),
                  );
                  landingController.fetchHome();
                  landingController.fetchTopOffers();
                  landingController.fetchRecommendedProducts();
                  landingController.fetchSpecialProducts();
                  landingController.fetchJustForYou(
                    mapController.currentAddress.value,
                  );
                  landingController.fetchTiming();
                  landingController.onInit();
                  categoryController.onInit();
                },
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.top,
                      ),
                      _buildHomeTop(),
                      SizedBox(
                        height: 180,
                        child: Obx(
                          () => landingController.loadingslider.isFalse
                              ? ImageSliderWidget(
                                  sliderImage: landingController.sliderlist,
                                )
                              : CustomShimmer(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  widget: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 0,
                                    ),
                                    height: 160,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // LOCATION BAR
                      _buildLocation(),
                      const SizedBox(
                        height: 10,
                      ),
                      // ORDER TIMING BAR
                      // _timimgOrder(),
                      // CustomSectionHeader(
                      //   headerName: "Tags",
                      //   onViewAllTapped: () {},
                      //   shouldViewAll: false,
                      // ),
                      // Obx(
                      //   () => SizedBox(
                      //     height: 200,
                      //     child: GridView.builder(
                      //       shrinkWrap: true,
                      //       scrollDirection: Axis.horizontal,
                      //       itemCount: controller.justForYouTagsList.length,
                      //       gridDelegate:
                      //           const SliverGridDelegateWithFixedCrossAxisCount(
                      //         crossAxisCount: 2,
                      //         crossAxisSpacing: 5,
                      //       ),
                      //       itemBuilder: (BuildContext context, index) {
                      //         return GestureDetector(
                      //           onTap: () async {
                      //             if (await Connectivity()
                      //                     .checkConnectivity() ==
                      //                 ConnectivityResult.none) {
                      //               getSnackbar(
                      //                 message: "No Internet Connection",
                      //                 error: true,
                      //                 bgColor: Colors.red,
                      //               );
                      //               return;
                      //             }
                      //             controller.selectedSlug.value = controller
                      //                 .justForYouTagsList[index].slug
                      //                 .toString();
                      //             controller.fetchJustForYouBySlug(controller
                      //                 .justForYouTagsList[index].slug);

                      //             Get.to(
                      //               () => TagProducts(
                      //                 name:
                      //                     "${controller.justForYouTagsList[index].title}",
                      //               ),
                      //             );
                      //           },
                      //           child: Column(
                      //             mainAxisAlignment: MainAxisAlignment.end,
                      //             crossAxisAlignment: CrossAxisAlignment.center,
                      //             children: [
                      //               Container(
                      //                 height: 80,
                      //                 width: 90,
                      //                 decoration: BoxDecoration(
                      //                   image: DecorationImage(
                      //                     image: NetworkImage(
                      //                       "${controller.justForYouTagsList[index].image}",
                      //                     ),
                      //                     fit: BoxFit.cover,
                      //                   ),
                      //                   borderRadius: BorderRadius.circular(5),
                      //                   // color: Colors.red
                      //                 ),
                      //               ),
                      //               Padding(
                      //                 padding: const EdgeInsets.symmetric(
                      //                   horizontal: 4.0,
                      //                 ),
                      //                 child: Text(
                      //                   controller
                      //                       .justForYouTagsList[index].title
                      //                       .toString(),
                      //                   style: subtitleStyle,
                      //                   textAlign: TextAlign.center,
                      //                   maxLines: 1,
                      //                   overflow: TextOverflow.ellipsis,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      /*
                        ADVERTISEMENT SECTION
                      */
                      Obx(
                        () => landingController.adlist.isNotEmpty
                            ? _buildAdvertisement()
                            : const SizedBox(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      /*
                        MOST DESIRED PRODUCTS SECTION
                      */
                      CustomSectionHeader(
                        headerName: "Most Desired Products",
                        onViewAllTapped: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ViewAllScreen();
                              },
                            ),
                          );
                        },
                        shouldViewAll: true,
                      ),
                      Container(
                        color: Colors.grey.shade50,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        height: 500,
                        child: MediaQuery.removePadding(
                          context: context,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.4,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                            ),
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: landingController
                                .recommendedProductsList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ProductDetailView(
                                          productid: landingController
                                              .recommendedProductsList[index]
                                              .id,
                                          productname: landingController
                                                  .recommendedProductsList[
                                                      index]
                                                  .name ??
                                              "N/A",
                                          productprice:
                                              "${(landingController.recommendedProductsList[index].stocks?[0].price) ?? "0"}",
                                          slug: landingController
                                              .recommendedProductsList[index]
                                              .slug,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: ProductDisplayWidget(
                                  controller: landingController,
                                  index: index,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      /*
                        SPECIAL PRODUCTS SECTION
                      */
                      landingController.specialProductsList.isEmpty
                          ? const SizedBox()
                          : Obx(
                              () {
                                return Column(
                                  children: [
                                    CustomSectionHeader(
                                      headerName: "Special Offers",
                                      onViewAllTapped: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return const SpecialOffersViewAll();
                                            },
                                          ),
                                        );
                                      },
                                      shouldViewAll: true,
                                    ),
                                    landingController
                                            .specialProductsList.isNotEmpty
                                        ? MediaQuery.removePadding(
                                            context: context,
                                            removeBottom: true,
                                            removeTop: true,
                                            child: GridView.builder(
                                              itemCount: landingController
                                                  .itemCount.value,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 0.85,
                                                crossAxisSpacing: 2,
                                                mainAxisSpacing: 2,
                                              ),
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return ProductDetailView(
                                                            productid:
                                                                landingController
                                                                        .specialProductsList[
                                                                            index]
                                                                        .id ??
                                                                    0,
                                                            productname:
                                                                landingController
                                                                        .specialProductsList[
                                                                            index]
                                                                        .name ??
                                                                    "N/A",
                                                            productprice:
                                                                "${(landingController.specialProductsList[index].stocks?[index].price) ?? 0}",
                                                            slug: landingController
                                                                .specialProductsList[
                                                                    index]
                                                                .slug,
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  child:
                                                      SpecialOffersDisplayWidget(
                                                    controller:
                                                        landingController,
                                                    index: index,
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 8.0,
                                            ),
                                            child: NoProductWidget(),
                                          ),
                                  ],
                                );
                              },
                            ),
                      /*
                        LATEST PRODUCTS SECTION
                      */
                      CustomSectionHeader(
                        headerName: "Our Latest Products",
                        onViewAllTapped: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const LatestProductsViewAllScreen();
                              },
                            ),
                          );
                        },
                        shouldViewAll: true,
                      ),
                      MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        removeBottom: true,
                        child: GridView.builder(
                          itemCount:
                              landingController.latestProductsList.length,
                          addAutomaticKeepAlives: true,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            height: 270.0,
                          ),
                          itemBuilder: (context, index) {
                            var data =
                                landingController.latestProductsList[index];
                            return Obx(
                              () => CategoryCard(
                                price: landingController
                                    .latestProductsList[index].stocks?[0].price
                                    .toString(),
                                productImg:
                                    "${(landingController.latestProductsList[index].images?[0].image)}",
                                productName: landingController
                                        .latestProductsList[index].name ??
                                    "N/A",
                                rating: landingController
                                    .latestProductsList[index].rating
                                    .toString(),
                                specialprice: landingController
                                    .latestProductsList[index]
                                    .stocks?[0]
                                    .specialPrice
                                    .toString(),
                                ontap: () {
                                  Get.to(
                                    () => ProductDetailView(
                                      productname: landingController
                                          .latestProductsList[index].name,
                                      productprice: landingController
                                          .latestProductsList[index]
                                          .stocks?[0]
                                          .price
                                          .toString(),
                                      slug: landingController
                                          .latestProductsList[index].slug,
                                      productid: landingController
                                          .latestProductsList[index].id,
                                    ),
                                  );
                                },
                                isFav: wishlistController.wishListIdArray
                                        .contains(landingController
                                            .latestProductsList[index].id)
                                    ? true
                                    : false,
                                ontapFavorite: () {
                                  if (AppStorage.readIsLoggedIn != true) {
                                    Get.to(
                                      () => LoginView(),
                                    );
                                  } else {
                                    if (loginController.logindata.value
                                            .read('USERID') !=
                                        null) {
                                      if (wishlistController.wishListIdArray
                                          .contains(landingController
                                              .latestProductsList[index].id)) {
                                        wishlistController.removeFromWishList(
                                            landingController
                                                .latestProductsList[index].id);
                                        wishlistController.fetchWishlist();
                                      } else {
                                        wishlistController.addToWishList(
                                            landingController
                                                .latestProductsList[index].id);
                                        wishlistController.fetchWishlist();
                                      }
                                    } else {
                                      toastMsg(
                                        message:
                                            "Please login to add to this product to wishlist",
                                      );
                                    }
                                  }
                                },
                                ontapCart: () {
                                  if (AppStorage.readIsLoggedIn != true) {
                                    Get.to(
                                      () => LoginView(),
                                    );
                                  } else {
                                    cartController.addToCart(
                                      data.id,
                                      data.stocks?[index].price,
                                      '1',
                                      data.varientId,
                                    );
                                  }
                                },
                                percent: data.percent == null
                                    ? const SizedBox()
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 10,
                                        ),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(06),
                                            ),
                                            child: Text(
                                              '${data.percent}%',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Container(
                      //   color: Colors.grey.shade50,
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 8,
                      //     vertical: 8,
                      //   ),
                      //   height: 490,
                      //   child: MediaQuery.removePadding(
                      //     context: context,
                      //     child: GridView.builder(
                      //       gridDelegate:
                      //           const SliverGridDelegateWithFixedCrossAxisCount(
                      //         crossAxisCount: 2,
                      //         mainAxisSpacing: 5,
                      //         crossAxisSpacing: 5,
                      //       ),
                      //       physics: const BouncingScrollPhysics(),
                      //       shrinkWrap: true,
                      //       scrollDirection: Axis.horizontal,
                      //       itemCount:
                      //           controller.recommendedProductsList.length,
                      //       itemBuilder: (context, index) {
                      //         return GestureDetector(
                      //           onTap: () {
                      //             Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                 builder: (context) {
                      //                   return ProductDetailView(
                      //                     productid: controller
                      //                             .recommendedProductsList[
                      //                                 index]
                      //                             .id ??
                      //                         0,
                      //                     productname: controller
                      //                             .recommendedProductsList[
                      //                                 index]
                      //                             .name ??
                      //                         "N/A",
                      //                     productprice:
                      //                         "${(controller.recommendedProductsList[index].stocks[0].price) ?? "0"}",
                      //                     slug: controller
                      //                         .recommendedProductsList[index]
                      //                         .slug,
                      //                   );
                      //                 },
                      //               ),
                      //             );
                      //           },
                      //           child: ProductCard(
                      //             productImg: controller
                      //                 .recommendedProductsList[index]
                      //                 .images[0]
                      //                 .image,
                      //           ),
                      //           // ProductDisplayWidget(
                      //           //   controller: controller,
                      //           //   index: index,
                      //           // ),
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => landingController.adlist.isNotEmpty
                            ? _buildAdvertisement()
                            : const SizedBox(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      categoryController.parentLoading.isTrue
                          ? CustomShimmer(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              widget: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 5,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                ),
                                height: 160,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            )
                          : CategoriesWidget(
                              categoryController: categoryController,
                            ),
                      const AllProducts(),
                    ],
                  ),
                ),
              )
            : const NoInternetLayout(),
      ),
    );
  }

  // _timimgOrder() {
  //   return Column(
  //     children: [
  //       Obx(
  //         () => controller.loading.isFalse
  //             ? Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Center(
  //                   child: Container(
  //                     width: double.infinity,
  //                     decoration: BoxDecoration(
  //                       color: AppColor.kalaAppMainColor,
  //                       borderRadius: BorderRadius.circular(10),
  //                       border: Border.all(
  //                         color: AppColor.kalaAppSecondaryColor,
  //                       ),
  //                       boxShadow: [
  //                         BoxShadow(
  //                           color: Colors.grey.withOpacity(0.5),
  //                           spreadRadius: 2,
  //                           blurRadius: 5,
  //                           offset: const Offset(
  //                             0,
  //                             3,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Column(
  //                         children: [
  //                           RichText(
  //                             text: TextSpan(
  //                               children: [
  //                                 TextSpan(
  //                                   text:
  //                                       "${controller.timingData.value.message} ",
  //                                   style: const TextStyle(
  //                                     fontSize: 14,
  //                                     color: Colors.white,
  //                                   ),
  //                                 ),
  //                                 const TextSpan(
  //                                   text: "on ",
  //                                   style: TextStyle(
  //                                     fontSize: 14,
  //                                     color: Colors.white,
  //                                   ),
  //                                 ),
  //                                 TextSpan(
  //                                   text:
  //                                       "${controller.timingData.value.data?.day ?? ""},",
  //                                   style: const TextStyle(
  //                                     fontSize: 14,
  //                                     fontWeight: FontWeight.w800,
  //                                     color: Colors.white,
  //                                   ),
  //                                 ),
  //                                 const TextSpan(
  //                                   text: " from ",
  //                                   style: TextStyle(
  //                                     fontSize: 14,
  //                                     color: Colors.white,
  //                                   ),
  //                                 ),
  //                                 TextSpan(
  //                                   text:
  //                                       "${controller.timingData.value.data?.startTime ?? ""},",
  //                                   style: const TextStyle(
  //                                     fontSize: 14,
  //                                     fontWeight: FontWeight.w800,
  //                                     color: Colors.white,
  //                                   ),
  //                                 ),
  //                                 const TextSpan(
  //                                   text: "to ",
  //                                   style: TextStyle(
  //                                     fontSize: 14,
  //                                     color: Colors.white,
  //                                   ),
  //                                 ),
  //                                 TextSpan(
  //                                   text:
  //                                       "${controller.timingData.value.data?.endTime ?? ""}.",
  //                                   style: const TextStyle(
  //                                     fontSize: 14,
  //                                     fontWeight: FontWeight.w800,
  //                                     color: Colors.white,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               )
  //             : const SizedBox(),
  //       ),
  //     ],
  //   );
  // }

  _buildHomeTop() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 40,
            child: loginController.siteDetailLoading.value
                ? SizedBox(
                    child: CustomShimmer(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      widget: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  )
                : CachedNetworkImage(
                    imageUrl: Uri.encodeFull(
                      loginController.siteDetailList[0].value ?? "",
                    ),
                    width: 80,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) {
                      return Container(
                        width: 40,
                        height: 40,
                        color: Colors.red,
                        child: const Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(
            width: 5,
          ),
          const Flexible(
            child: Hero(
              tag: "searchBar",
              child: CustomSearchBar(),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          CircleAvatar(
            backgroundColor: AppColor.kalaAppAccentColor,
            radius: 18,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 17,
              child: Center(
                child: Obx(
                  () => badges.Badge(
                    showBadge:
                        homeController.notifications.isEmpty ? false : true,
                    position: badges.BadgePosition.topEnd(
                      end: 5,
                      top: 5,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.NOTIFICATION);
                      },
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Iconsax.notification,
                        color: Colors.black,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  _buildLocation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColor.kalaAppAccentColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: TextButton(
          onPressed: () async {
            LocationPermission permission;
            permission = await Geolocator.checkPermission();
            if (permission == LocationPermission.denied ||
                permission == LocationPermission.deniedForever) {
              await Geolocator.openLocationSettings();
              mapController.getPlaceName();
            } else if (permission == LocationPermission.always ||
                permission == LocationPermission.whileInUse) {
              // Get.back();
              Get.to(
                () => const MapView(),
              );
            }
          },
          child: Row(
            children: [
              Icon(
                Iconsax.location,
                size: 16.sp,
                color: Colors.black,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Obx(
                  () => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      mapController.currentAddress.value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: subtitleStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildAdvertisement() {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      removeTop: true,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
        ),
        itemCount: 2,
        itemBuilder: (context, index) {
          final adItem = landingController.adlist[index];
          if (adItem.ads == null) {
            return const SizedBox();
          }
          return GestureDetector(
            onTap: () {
              if (adItem.ads?.url != null) {
                launchUrl(
                  Uri.parse(
                    adItem.ads?.url ?? "",
                  ),
                );
              }
            },
            child: Image.network(
              "${adItem.ads!.mobileImage}",
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < landingController.sliderlist.length; i++) {
      list.add(i == _imageCurrentIndex ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget sliderImageContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildPageIndicator(),
    );
  }

  Widget _indicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: isActive ? AppColor.mainClr : AppColor.kalaAppMainColor,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  buildAdCard() {
    return Container(
      width: Device.orientation == Orientation.portrait ? double.infinity : 500,
      height: 180,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColor.mainClr,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '60% ',
                        style: headingStyle.copyWith(
                          color: Colors.amber,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      TextSpan(
                        text: 'OFF',
                        style: headingStyle.copyWith(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'EVERYTHING',
                  style: headingStyle.copyWith(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  color: AppColor.kalaAppMainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Explore',
                    style: subtitleStyle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Image.asset(
            AppImages.shoes,
            height: 150,
          )
        ],
      ),
    );
  }

  buildHeadertxt(title, ontap, viewall) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: titleStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          viewall
              ? TextButton(
                  onPressed: ontap,
                  child: Text(
                    'View all',
                    style: subtitleStyle,
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  buildDepartmentScroll() {
    return Obx(
      () => categoryController.parentLoading.isTrue
          ? SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CustomShimmer(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      widget: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          : Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                      landingController.departmentlist.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (await Connectivity().checkConnectivity() ==
                                    ConnectivityResult.none) {
                                  getSnackbar(
                                      message: "No Internet Connection",
                                      error: true,
                                      bgColor: Colors.red);
                                  return;
                                }
                                Get.to(
                                  () => DepartmentView(
                                    title: landingController
                                        .departmentlist[index].title,
                                    slug: landingController
                                        .departmentlist[index].slug,
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey.shade300,
                                backgroundImage: CachedNetworkImageProvider(
                                  '${landingController.departmentlist[index].image?.replaceAll(
                                    RegExp(r'http://127.0.0.1:8000'),
                                    url,
                                  )}',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 80,
                              child: Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  landingController.departmentlist[index].title
                                      .toString(),
                                  style: subtitleStyle.copyWith(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  buildTopOffersSlider() {
    return Obx(
      () => landingController.topOffersLoading.isTrue
          ? const SizedBox(
              height: 80,
              child: LoadingWidget(),
            )
          : landingController.topOffersData.isNotEmpty
              ? SingleChildScrollView(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, childAspectRatio: 0.8
                            // mainAxisSpacing: 10,
                            // crossAxisSpacing: 10,
                            ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    itemCount: landingController.topOffersData.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (await Connectivity().checkConnectivity() ==
                                  ConnectivityResult.none) {
                                getSnackbar(
                                    message: "No Internet Connection",
                                    error: true,
                                    bgColor: Colors.red);
                                return;
                              }
                              landingController.slug = landingController
                                  .topOffersData[index].slug
                                  .toString();
                              Get.to(
                                () => TopOffersScreen(
                                  title: landingController
                                      .topOffersData[index].title
                                      .toString(),
                                  slug: landingController
                                      .topOffersData[index].slug
                                      .toString(),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.grey.shade300,
                              child: CachedNetworkImage(
                                imageUrl: landingController
                                    .topOffersData[index].image
                                    .toString(),
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(100),
                                    child: Image.asset(
                                      "assets/images/Placeholder.png",
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "assets/images/Placeholder.png",
                                  height: 40,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            landingController.topOffersData[index].title
                                .toString(),
                            style: subtitleStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )
                        ],
                      );
                    },
                  ),
                )
              : Container(),
    );
  }

  void checkInternet() async {
    if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
      hasInternet.value = false;
    } else {
      hasInternet.value = true;
    }
  }
}
