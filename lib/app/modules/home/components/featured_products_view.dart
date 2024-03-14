import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/modules/home/components/featured_details_view.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/views/login_view.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';

import '../../../constants/constants.dart';
import '../../../widgets/product_card.dart';
import '../../../widgets/toast.dart';
import '../../product_detail/views/product_detail_view.dart';

class FeaturedProductsView extends StatelessWidget {
  FeaturedProductsView({Key? key}) : super(key: key);

  final controller = Get.put(HomeController());
  final cartcontroller = Get.put(CartController());
  final logcon = Get.put(LoginController());
  final wishlistcontroller = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.loading.isFalse
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.featuredList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  buildHeadertxt(controller.featuredList[index].title,
                      () async {
                    print(controller.featuredList[index].id!.toInt());

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => FeaturedDeatilsView(
                    //               id: controller.featuredList[index].id!
                    //                   .toInt(),
                    //               title: controller.featuredList[index].title
                    //                   .toString(),
                    //             )));

                    Get.to(() => FeaturedDeatilsView(
                          id: controller.featuredList[index].id!.toInt(),
                          title:
                              controller.featuredList[index].title.toString(),
                        ));
                  }, true),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                              controller.featuredList[index].featuredProducts!
                                  .length, (i) {
                            var product = controller
                                .featuredList[index].featuredProducts![i];
                            return Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SizedBox(
                                width: 150,
                                child: Obx(
                                  () => CategoryCard(
                                    price: product.getPrice?.price.toString(),
                                    specialprice: product.getPrice?.specialPrice
                                        .toString(),
                                    productImg:
                                        '${product.images?[0].image?.replaceAll(RegExp(r'http://127.0.0.1:8000'), url)}',
                                    productName: product.name,
                                    rating: product.rating,
                                    bestseller: true,
                                    ontap: () {
                                      Get.to(() => ProductDetailView(
                                            // productname:
                                            //     products[index]['product_name'].toString(),
                                            // productprice:
                                            //     products[index]['product_price'].toString(),
                                            productid: product.id,
                                            slug: product.slug,
                                          ));
                                    },
                                    ontapCart: () {
                                      // var data = products[index];
                                      print(product.varientId.toString());
                                      if (AppStorage.readIsLoggedIn != true) {
                                        Get.to(() => LoginView());
                                      } else {
                                        cartcontroller.addToCart(
                                          product.id,
                                          product.getPrice?.price,
                                          '1',
                                          product.varientId,
                                        );
                                      }

                                      //toastMsg(message: 'Added to cart');
                                    },
                                    isFav: wishlistcontroller.wishListIdArray
                                            .contains(product.id)
                                        ? true
                                        : false,
                                    ontapFavorite: () {
                                      if (AppStorage.readIsLoggedIn != true) {
                                        Get.to(() => LoginView());
                                      }
                                      {
                                        if (logcon.logindata.value
                                                .read('USERID') !=
                                            null) {
                                          if (wishlistcontroller.wishListIdArray
                                              .contains(product.id)) {
                                            //toastMsg(message: "remove");
                                            wishlistcontroller
                                                .removeFromWishList(product.id);
                                            wishlistcontroller.fetchWishlist();
                                          } else {
                                            //toastMsg(message: "add");
                                            wishlistcontroller
                                                .addToWishList(product.id);
                                            wishlistcontroller.fetchWishlist();
                                          }
                                        } else {
                                          toastMsg(
                                              message:
                                                  "Please Login to add to wishlist");
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          )
        : Container());
  }

  buildHeadertxt(title, ontap, viewall) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: titleStyle.copyWith(fontWeight: FontWeight.bold),
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
}
