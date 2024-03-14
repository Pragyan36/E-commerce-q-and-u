import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/modules/category/controllers/category_controller.dart';
import 'package:q_and_u_furniture/app/modules/home/components/sliver_grid.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/views/login_view.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/views/product_detail_view.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:q_and_u_furniture/app/widgets/no_product_widget.dart';
import 'package:q_and_u_furniture/app/widgets/product_card.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';
import 'package:q_and_u_furniture/app/widgets/toast.dart';

class SubCategoryList extends GetView<CategoryController> {
  SubCategoryList({
    required this.indexWidget,
    required this.title,
    super.key,
  });

  final int indexWidget;
  final String title;
  final wishlistcontroller = Get.put(WishlistController());
  final logcon = Get.put(LoginController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          title: title,
        ),
        body: _buildBody()
        // Text(controller.topOffersProductData.length.toString())
        // _buildBody(),
        );
  }

  _buildBody() {
    return Obx(
      () {
        if (controller.loading.isTrue) {
          // If data is still loading
          return controller.childcategoryList[indexWidget].products == null
              ? Text("Loading...")
              : SizedBox(
                  height: 750,
                  child: GridView.builder(
                    itemCount: controller
                            .childcategoryList[indexWidget].products?.length ??
                        0,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      height: 190.0,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CustomShimmer(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          widget: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            height: 750,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
        } else {
          // If data has finished loading
          if (controller.childcategoryList[indexWidget].products == null) {
            // If data is null
            return NoProductWidget();
          } else if (controller
              .childcategoryList[indexWidget].products!.isEmpty) {
            // If data is empty
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: NoProductWidget(),
              ),
            );
          } else {
            // If data is available
            return GridView.builder(
              itemCount:
                  controller.childcategoryList[indexWidget].products!.length,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                height: 270,
              ),
              itemBuilder: (context, index) {
                var filteredProducts =
                    controller.childcategoryList[indexWidget].products!;
                var data = filteredProducts[index];
                return Obx(
                  () => Column(
                    children: [
                      CategoryCard(
                        price: data.price ?? "N/A",
                        productImg: data.image
                                ?.replaceAll(
                                    RegExp(r'http://127.0.0.1:8000'), url)
                                .toString() ??
                            "",
                        productName: data.name,
                        rating: data.rating.toString(),
                        specialprice: data.price.toString(),
                        ontap: () async {
                          if (await Connectivity().checkConnectivity() ==
                              ConnectivityResult.none) {
                            getSnackbar(
                              message: "No Internet Connection",
                              error: true,
                              bgColor: Colors.red,
                            );
                          }
                          Get.to(
                            () => ProductDetailView(
                              productname: data.name,
                              productprice: data.id.toString(),
                              slug: data.slug,
                              productid: data.id,
                            ),
                          );
                        },
                        isFav: wishlistcontroller.wishListIdArray
                            .contains(data.id),
                        ontapFavorite: () {
                          if (AppStorage.readIsLoggedIn != true) {
                            Get.to(() => LoginView());
                          } else {
                            if (logcon.logindata.value.read('USERID') != null) {
                              if (wishlistcontroller.wishListIdArray
                                  .contains(data.id)) {
                                wishlistcontroller.removeFromWishList(data.id);
                                wishlistcontroller.fetchWishlist();
                              } else {
                                wishlistcontroller.addToWishList(data.id);
                                wishlistcontroller.fetchWishlist();
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
                            Get.to(() => LoginView());
                          } else {
                            cartController.addToCart(
                              data.id,
                              data.price,
                              '1',
                              0,
                            );
                          }
                        },
                        percent: data.percent == null
                            ? const SizedBox()
                            : Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(06),
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
                    ],
                  ),
                );
              },
            );
          }
        }
      },
    );
  }
}
