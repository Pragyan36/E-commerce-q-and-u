import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/modules/home/components/sliver_grid.dart';
import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/views/login_view.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/views/product_detail_view.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:q_and_u_furniture/app/widgets/no_product_widget.dart';
import 'package:q_and_u_furniture/app/widgets/product_card.dart';
import 'package:q_and_u_furniture/app/widgets/toast.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({super.key});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  final LandingController landingController = Get.put(
    LandingController(),
  );
  final WishlistController wishlistController = Get.put(
    WishlistController(),
  );
  final LoginController loginController = Get.put(
    LoginController(),
  );

  @override
  void initState() {
    landingController.fetchRecommendedProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Most Desired Products",
      ),
      body: Obx(
        () {
          return landingController.recommendedProductsLoading.isTrue
              ? GridView.builder(
                  itemCount: 6,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    height: 190,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
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
                )
              : landingController.recommendedProductsList.isEmpty
                  ? const NoProductWidget()
                  : GridView.builder(
                      itemCount:
                          landingController.recommendedProductsList.length,
                      physics: const BouncingScrollPhysics(),
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
                        return Column(
                          children: [
                            CategoryCard(
                              productImg: (landingController
                                      .recommendedProductsList[index]
                                      .images?[0]
                                      .image) ??
                                  "",
                              price:
                                  "${(landingController.recommendedProductsList[index].stocks?[0].price) ?? ""}",
                              productName: (landingController
                                      .recommendedProductsList[index].name) ??
                                  "",
                              rating: (landingController
                                      .recommendedProductsList[index].rating) ??
                                  "",
                              specialprice:
                                  "${(landingController.recommendedProductsList[index].stocks?[0].specialPrice) ?? (landingController.recommendedProductsList[index].stocks?[0].price)}",
                              ontap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ProductDetailView(
                                        productid: landingController
                                                .recommendedProductsList[index]
                                                .id ??
                                            0,
                                        productname: landingController
                                                .recommendedProductsList[index]
                                                .name ??
                                            "N/A",
                                        productprice:
                                            "${(landingController.recommendedProductsList[index].stocks?[0].price) ?? 0}",
                                        slug: landingController
                                            .recommendedProductsList[index]
                                            .slug,
                                      );
                                    },
                                  ),
                                );
                              },
                              isFav:
                                  wishlistController.wishListIdArray.contains(
                                landingController
                                    .recommendedProductsList[index].id,
                              ),
                              ontapFavorite: () {
                                if (AppStorage.readIsLoggedIn != true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return LoginView();
                                      },
                                    ),
                                  );
                                } else {
                                  if (loginController.logindata.value
                                          .read("USERID") !=
                                      null) {
                                    if (wishlistController.wishListIdArray
                                        .contains(
                                      landingController
                                          .recommendedProductsList[index].id,
                                    )) {
                                      wishlistController.removeFromWishList(
                                        landingController
                                            .recommendedProductsList[index].id,
                                      );
                                    } else {
                                      wishlistController.addToWishList(
                                        landingController
                                            .recommendedProductsList[index].id,
                                      );
                                      wishlistController.fetchWishlist();
                                    }
                                  } else {
                                    toastMsg(
                                      message:
                                          "Please login to add this product to your wishlist.",
                                    );
                                  }
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
        },
      ),
    );
  }
}
