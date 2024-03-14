import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/modules/search/controllers/search_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/loading_widget.dart';
import 'package:q_and_u_furniture/app/widgets/nodata.dart';

import '../../../constants/constants.dart';
import '../../../database/app_storage.dart';
import '../../../widgets/product_card.dart';
import '../../../widgets/toast.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../home/components/sliver_grid.dart';
import '../../login/controllers/login_controller.dart';
import '../../login/views/login_view.dart';
import '../../product_detail/views/product_detail_view.dart';
import '../../wishlist/controllers/wishlist_controller.dart';

class BrandProducts extends StatelessWidget {
  BrandProducts({super.key, required this.id, required this.title});
  final int id;
  final String title;
  final controller = Get.put(CustomSearchController());
  final wishlistcontroller = Get.put(WishlistController());
  final logcon = Get.put(LoginController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    controller.fetchBrandById(id);
    return Scaffold(
      appBar: CustomAppbar(title: title),
      body: Obx(
        () => controller.isLoading.isTrue
            ? const Center(child: LoadingWidget())
            : controller.brandproductList.isEmpty
                ? const NoDataView(text: 'No Products')
                : GridView.builder(
                    itemCount: controller.brandproductList.length,
                    addAutomaticKeepAlives: true,
                    // key: PageStorageKey<int>(index),

                    // controller: scrollcontroller,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      height: 270.0,
                    ),
                    // SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 2,
                    //   childAspectRatio:
                    //       Device.orientation == Orientation.portrait ? 1 / 1.7 : 1.4,
                    //   crossAxisSpacing: 10,
                    //   mainAxisSpacing: 15,
                    // ),
                    /*This is tabs product  gridview*/
                    itemBuilder: (context, index) {
                      return Obx(
                        () => CategoryCard(
                          price: controller.brandproductList[index].price
                              .toString(),
                          productImg:
                              '${controller.brandproductList[index].image?.replaceAll(RegExp(r'http://127.0.0.1:8000'), url)}',
                          productName: controller.brandproductList[index].name,
                          rating: controller.brandproductList[index].rating
                              .toString(),
                          specialprice: controller
                              .brandproductList[index].specialPrice
                              .toString(),
                          ontap: () {
                            Get.to(() => ProductDetailView(
                                  productname:
                                      controller.brandproductList[index].name,
                                  productprice: controller
                                      .brandproductList[index].id
                                      .toString(),
                                  slug: controller.brandproductList[index].slug,
                                  productid:
                                      controller.brandproductList[index].id,
                                ));
                          },
                          isFav: wishlistcontroller.wishListIdArray.contains(
                                  controller.brandproductList[index].id)
                              ? true
                              : false,
                          ontapFavorite: () {
                            if (AppStorage.readIsLoggedIn != true) {
                              Get.to(() => LoginView());
                            } else {
                              if (logcon.logindata.value.read('USERID') !=
                                  null) {
                                if (wishlistcontroller.wishListIdArray.contains(
                                    controller.brandproductList[index].id)) {
                                  //toastMsg(message: "remove");
                                  wishlistcontroller.removeFromWishList(
                                      controller.brandproductList[index].id);
                                  wishlistcontroller.fetchWishlist();
                                } else {
                                  //toastMsg(message: "add");
                                  wishlistcontroller.addToWishList(
                                      controller.brandproductList[index].id);
                                  wishlistcontroller.fetchWishlist();
                                }
                              } else {
                                toastMsg(
                                    message: "Please Login to add to wishlist");
                              }
                            }
                          },
                          ontapCart: () {
                            if (AppStorage.readIsLoggedIn != true) {
                              Get.to(() => LoginView());
                            } else {
                              cartController.addToCart(
                                controller.brandproductList[index].id,
                                controller.brandproductList[index].price,
                                '1',
                                controller.brandproductList[index].varientId,
                              );
                            }
                          },
                        ),
                      );
                    }),
      ),
    );
  }
}
