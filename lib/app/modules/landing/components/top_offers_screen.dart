import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/views/login_view.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/views/product_detail_view.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/loading_widget.dart';
import 'package:q_and_u_furniture/app/widgets/product_card.dart';
import 'package:q_and_u_furniture/app/widgets/product_tile.dart';
import 'package:q_and_u_furniture/app/widgets/toast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TopOffersScreen extends GetView<LandingController> {
  TopOffersScreen({
    required this.slug,
    required this.title,
    super.key,
  });

  final String slug;
  final String title;
  final wishlistcontroller = Get.put(WishlistController());
  final logcon = Get.put(LoginController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    controller.fetchTopOffersProduct();
    return Scaffold(
      appBar: CustomAppbar(
        title: title,
      ),
      body:
          // Text(controller.topOffersProductData.length.toString())
          _buildBody(),
    );
  }

  _buildBody() {
    return RefreshIndicator(
      color: AppColor.kalaAppMainColor,
      onRefresh: () async {
        controller.fetchTopOffers();
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Obx(
              () => Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.isListview.value =
                            !controller.isListview.value;
                        debugPrint(controller.isListview.value.toString());
                      },
                      child: Icon(
                        controller.isListview.value
                            ? Icons.list
                            : Icons.grid_view_outlined,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      controller.isListview.value ? 'Listview' : 'Gridview',
                      style: titleStyle,
                    )
                  ],
                ),
              ),
            ),
            Obx(
              () => controller.topOffersProductsLoading.isFalse
                  ? controller.topOffersProductData.isNotEmpty
                      ? controller.isListview.value
                          ? ListView.builder(
                              itemCount: controller.topOffersProductData.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var data =
                                    controller.topOffersProductData[index];

                                return ProductTile(
                                  price: data.stocks?[0].price.toString(),
                                  specialprice:
                                      data.stocks?[0].specialPrice.toString(),
                                  productImg:
                                      '${data.productImages?[0].image?.replaceAll(RegExp(r'http://127.0.0.1:8000'), url)}',
                                  productName: data.name,
                                  rating: data.rating,
                                  onTap: () {
                                    Get.to(() => ProductDetailView(
                                          productname: data.name,
                                          productprice: "Rs 1000",
                                          slug: data.slug,
                                        ));
                                  },
                                  onTapCart: () {
                                    if (AppStorage.readIsLoggedIn != true) {
                                      Get.offAll(() => LoginView());
                                    } else {
                                      cartController.addToCart(
                                        data.id,
                                        data.stocks?[0].specialPrice.toString(),
                                        '1',
                                        data.varientId,
                                      );
                                    }
                                  },
                                  isFav: wishlistcontroller.wishListIdArray
                                          .contains(data.id)
                                      ? true
                                      : false,
                                  onTapFavorite: () {
                                    if (logcon.logindata.value.read('USERID') !=
                                        null) {
                                      if (wishlistcontroller.wishListIdArray
                                          .contains(data.id)) {
                                        //toastMsg(message: "remove");
                                        wishlistcontroller
                                            .removeFromWishList(data.id);
                                        wishlistcontroller.fetchWishlist();
                                      } else {
                                        //toastMsg(message: "add");
                                        wishlistcontroller
                                            .addToWishList(data.id);
                                        wishlistcontroller.fetchWishlist();
                                      }
                                    } else {
                                      toastMsg(
                                          message:
                                              "Please Login to add to wishlist");
                                    }
                                  },
                                );
                              },
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio:
                                    Device.orientation == Orientation.portrait
                                        ? 3 / 5.3
                                        : 1.4,
                              ),
                              itemCount: controller.topOffersProductData.length,
                              //  data.products?.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var data =
                                    controller.topOffersProductData[index];
                                return Obx(
                                  () => CategoryCard(
                                    productImg:
                                        '${data.productImages?[0].image?.replaceAll(RegExp(r'http://127.0.0.1:8000'), url)}',
                                    productName: data.name,
                                    rating: data.rating.toString(),
                                    price: data.stocks?[0].price.toString(),
                                    specialprice:
                                        data.stocks?[0].specialPrice.toString(),
                                    ontap: () {
                                      Get.to(() => ProductDetailView(
                                            productname: data.name,
                                            productprice: data.id.toString(),
                                            slug: data.slug,
                                            productid: data.id,
                                          ));
                                    },
                                    isFav: wishlistcontroller.wishListIdArray
                                            .contains(data.id)
                                        ? true
                                        : false,
                                    ontapFavorite: () {
                                      if (AppStorage.readIsLoggedIn != true) {
                                        Get.to(() => LoginView());
                                      } else {
                                        if (logcon.logindata.value
                                                .read('USERID') !=
                                            null) {
                                          if (wishlistcontroller.wishListIdArray
                                              .contains(data.id)) {
                                            //toastMsg(message: "remove");
                                            wishlistcontroller
                                                .removeFromWishList(data.id);
                                            wishlistcontroller.fetchWishlist();
                                          } else {
                                            //toastMsg(message: "add");
                                            wishlistcontroller
                                                .addToWishList(data.id);
                                            wishlistcontroller.fetchWishlist();
                                          }
                                        } else {
                                          toastMsg(
                                              message:
                                                  "Please Login to add to wishlist");
                                        }
                                      }
                                    },
                                    ontapCart: () {
                                      if (AppStorage.readIsLoggedIn != true) {
                                        Get.to(() => LoginView());
                                      } else {
                                        cartController.addToCart(
                                          data.id,
                                          data.stocks?[0].specialPrice
                                              .toString(),
                                          '1',
                                          data.varientId,
                                        );
                                      }
                                    },
                                  ),
                                );
                                // CategoryProductCard(
                                //   data: data.products![index],
                                //   // position: controller.selectedImg.value.toDouble(),
                                // );
                              },
                            )
                      : const Text('no data')
                  : SizedBox(height: 100.sp, child: const LoadingWidget()),
            ),
          ],
        ),
      ),
    );
  }
}
