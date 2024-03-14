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

class SpecialOffersViewAll extends StatefulWidget {
  const SpecialOffersViewAll({super.key});

  @override
  State<SpecialOffersViewAll> createState() => _SpecialOffersViewAllState();
}

class _SpecialOffersViewAllState extends State<SpecialOffersViewAll> {
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
    landingController.fetchSpecialProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Special Offers",
      ),
      body: Obx(
        () {
          return landingController.specialProductsLoading.isTrue
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
              : landingController.specialProductsList.isEmpty
                  ? const NoProductWidget()
                  : GridView.builder(
                      itemCount: landingController.specialProductsList.length,
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
                        return Column(
                          children: [
                            CategoryCard(
                              productImg: (landingController
                                      .specialProductsList[index]
                                      .images?[index]
                                      .image) ??
                                  "",
                              price:
                                  "${(landingController.specialProductsList[index].stocks?[index].specialPrice) ?? ""}",
                              productName: (landingController
                                      .specialProductsList[index].name) ??
                                  "",
                              rating: (landingController
                                      .specialProductsList[index].rating) ??
                                  "",
                              specialprice:
                                  "${(landingController.specialProductsList[index].stocks?[index].price) ?? ""}",
                              ontap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ProductDetailView(
                                        productid: landingController
                                                .specialProductsList[index]
                                                .id ??
                                            0,
                                        productname: landingController
                                                .specialProductsList[index]
                                                .name ??
                                            "N/A",
                                        productprice:
                                            "${(landingController.specialProductsList[index].stocks?[index].price) ?? 0}",
                                        slug: landingController
                                            .specialProductsList[index].slug,
                                      );
                                    },
                                  ),
                                );
                              },
                              isFav:
                                  wishlistController.wishListIdArray.contains(
                                landingController.specialProductsList[index].id,
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
                                          .specialProductsList[index].id,
                                    )) {
                                      wishlistController.removeFromWishList(
                                        landingController
                                            .specialProductsList[index].id,
                                      );
                                    } else {
                                      wishlistController.addToWishList(
                                        landingController
                                            .specialProductsList[index].id,
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
