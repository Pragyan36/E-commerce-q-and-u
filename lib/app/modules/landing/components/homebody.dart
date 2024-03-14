import 'package:connectivity_plus/connectivity_plus.dart';
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
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:q_and_u_furniture/app/widgets/no_product_widget.dart';
import 'package:q_and_u_furniture/app/widgets/product_card.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';
import 'package:q_and_u_furniture/app/widgets/toast.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final controller = Get.put(LandingController());
  final wishlistcontroller = Get.put(WishlistController());
  final logcon = Get.put(LoginController());
  final cartController = Get.put(CartController());
  final landingcon = Get.put(LandingController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.jfyLoading.isTrue
          ? SizedBox(
              height: 750,
              child: GridView.builder(
                itemCount: controller.justForYouProductsList.length,
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
            )
          : controller.justForYouProductsList
                  .where((data) => data.productTag!
                      .toLowerCase()
                      .contains(landingcon.selectedSlug.value))
                  .toList()
                  .isEmpty
              ? const SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: NoProductWidget(),
                  ),
                )
              : GridView.builder(
                  itemCount: controller.justForYouProductsList
                      .where(
                        (data) => data.productTag!.toLowerCase().contains(
                              landingcon.selectedSlug.value,
                            ),
                      )
                      .toList()
                      .length,
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
                    var filteredProducts = controller.justForYouProductsList
                        .where(
                          (data) => data.productTag!.toLowerCase().contains(
                                landingcon.selectedSlug.value,
                              ),
                        )
                        .toList();
                    var data = filteredProducts[index];

                    return Obx(
                      () => Column(
                        children: [
                          CategoryCard(
                            price: data.price ?? "N/A",
                            productImg: data.image
                                    ?.replaceAll(
                                      RegExp(r'http://127.0.0.1:8000'),
                                      url,
                                    )
                                    .toString() ??
                                "",
                            productName: data.name,
                            rating: data.rating.toString(),
                            specialprice: data.orginalPrice == 0
                                ? data.price.toString()
                                : data.orginalPrice.toString(),
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
                                Get.to(
                                  () => LoginView(),
                                );
                              } else {
                                if (logcon.logindata.value.read('USERID') !=
                                    null) {
                                  if (wishlistcontroller.wishListIdArray
                                      .contains(data.id)) {
                                    wishlistcontroller
                                        .removeFromWishList(data.id);
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
                                  data.price,
                                  '1',
                                  data.varient,
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
                ),
    );
  }
}
