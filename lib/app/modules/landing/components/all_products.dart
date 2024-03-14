import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/modules/home/components/sliver_grid.dart';
import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/views/login_view.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/views/product_detail_view.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:q_and_u_furniture/app/widgets/loading_widget.dart';
import 'package:q_and_u_furniture/app/widgets/product_card.dart';
import 'package:q_and_u_furniture/app/widgets/toast.dart';

class AllProducts extends StatefulWidget {
  final ScrollController? scrollController;

  const AllProducts({
    super.key,
    this.scrollController,
  });

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final LandingController controller = Get.put(
    LandingController(),
  );
  final WishlistController wishlistcontroller = Get.put(
    WishlistController(),
  );
  final LoginController logcon = Get.put(
    LoginController(),
  );
  final CartController cartController = Get.put(
    CartController(),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Obx(
            () => GridView.builder(
              itemCount: controller.productsList.length,
              addAutomaticKeepAlives: true,
              shrinkWrap: true,
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
                height: 270.0,
              ),
              itemBuilder: (context, index) {
                var data = controller.productsList[index];
                return Obx(
                  () => CategoryCard(
                    price: data.getPrice!.price.toString(),
                    productImg: '${data.images?[0].image?.replaceAll(
                      RegExp(r'http://127.0.0.1:8000'),
                      url,
                    )}',
                    productName: data.name,
                    rating: data.rating.toString(),
                    specialprice: data.getPrice?.specialPrice.toString(),
                    ontap: () {
                      Get.to(
                        () => ProductDetailView(
                          productname: data.name,
                          productprice: data.id.toString(),
                          slug: data.slug,
                          productid: data.id,
                        ),
                      );
                    },
                    isFav: wishlistcontroller.wishListIdArray.contains(data.id)
                        ? true
                        : false,
                    ontapFavorite: () {
                      if (AppStorage.readIsLoggedIn != true) {
                        Get.to(
                          () => LoginView(),
                        );
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
                        Get.to(
                          () => LoginView(),
                        );
                      } else {
                        cartController.addToCart(
                          data.id,
                          data.getPrice?.price,
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
                  ),
                );
              },
            ),
          ),
          controller.loadingmore.value
              ? const LoadingWidget()
              : const SizedBox(),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
