import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/modules/home/components/sliver_grid.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/loading_widget.dart';

import '../../../constants/constants.dart';
import '../../../database/app_storage.dart';
import '../../../widgets/product_card.dart';
import '../../../widgets/toast.dart';
import '../../login/views/login_view.dart';
import '../../product_detail/views/product_detail_view.dart';

class FeaturedDeatilsView extends StatefulWidget {
  const FeaturedDeatilsView({super.key, required this.id, required this.title});

  final int id;
  final String title;

  @override
  State<FeaturedDeatilsView> createState() => _FeaturedDeatilsViewState();
}

class _FeaturedDeatilsViewState extends State<FeaturedDeatilsView> {
  final controller = Get.put(HomeController());
  final cartController = Get.put(CartController());
  final wishlistcontroller = Get.put(WishlistController());
  final logcon = Get.put(LoginController());

  // @override
  // void initState() {
  //   controller.fetchSpecificFeaturedProducts(widget.id);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    controller.fetchSpecificFeaturedProducts(widget.id);

    return Scaffold(
        appBar: CustomAppbar(title: widget.title),
        body: Obx(
          () =>
              // controller.loading.isFalse
              //     ?
              controller.loading.isFalse
                  ? GridView.builder(
                      itemCount: controller.specificfeaturedList.length,
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
                        var data = controller.specificfeaturedList[index];

                        return Obx(
                          () => CategoryCard(
                            price: data.getPrice?.price.toString(),
                            productImg:
                                '${data.images?[0].image?.replaceAll(RegExp(r'http://127.0.0.1:8000'), url)}',
                            productName: data.name,
                            rating: data.rating.toString(),
                            specialprice:
                                data.getPrice?.specialPrice.toString(),
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
                              if (AppStorage.isloggedin != true) {
                                Get.to(() => LoginView());
                              } else {
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
                                    wishlistcontroller.addToWishList(data.id);
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
                              if (AppStorage.isloggedin != true) {
                                Get.to(() => LoginView());
                              } else {
                                cartController.addToCart(
                                  data.id,
                                  data.getPrice?.price,
                                  '1',
                                  '1',
                                );
                              }
                            },
                          ),
                        );
                      })
                  // : NoDataView(text: 'No products')
                  : const Center(child: LoadingWidget()),
        ));
  }
}
