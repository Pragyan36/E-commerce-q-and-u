import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/views/login_view.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/views/product_detail_view.dart';
import 'package:q_and_u_furniture/app/modules/search/controllers/search_controller.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:q_and_u_furniture/app/widgets/product_card.dart';
import 'package:q_and_u_furniture/app/widgets/product_tile.dart';
import 'package:q_and_u_furniture/app/widgets/toast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchResultList extends StatelessWidget {
  SearchResultList({Key? key}) : super(key: key);

  // final Category product;

  final controller = Get.put(CustomSearchController());
  final wishlistcontroller = Get.put(WishlistController());
  final logcon = Get.put(LoginController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isListview.value
          ? ListView.builder(
              itemCount: controller.searchList.length,
              itemBuilder: (context, index) {
                return const ProductTile(
                  bestseller: false,
                  price: '100',
                  productImg:
                      'https://assets.adidas.com/images/w_600,f_auto,q_auto/ce8a6f3aa6294de988d7abce00c4e459_9366/Breaknet_Shoes_White_FX8707_01_standard.jpg',
                  productName: 'Addidas',
                  rating: '2',
                );
              },
            )
          : GridView.builder(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio:
                    Device.orientation == Orientation.portrait ? 2.87 / 5 : 1.4,
              ),
              itemCount: controller.searchList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var data = controller.searchList[index];
                return Obx(
                  () => CategoryCard(
                    productImg:
                        '${data.images?[0].image?.replaceAll(RegExp(r'http://127.0.0.1:8000'), url)}',
                    productName: data.name,
                    bestseller: false,
                    price: data.getPrice?.price.toString(),
                    rating: data.rating,
                    specialprice: data.getPrice?.specialPrice.toString(),
                    ontap: () {
                      Get.to(
                        () => ProductDetailView(
                          productname: data.name,
                          productprice: data.id.toString(),
                          productid: data.id,
                          slug: data.slug,
                        ),
                      );
                    },
                    isFav: wishlistcontroller.wishListIdArray.contains(data.id)
                        ? true
                        : false,
                    ontapFavorite: () {
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
                        toastMsg(message: "Please Login to add to wishlist");
                      }
                    },
                    ontapCart: () {
                      if (AppStorage.readIsLoggedIn != true) {
                        Get.off(
                          () => LoginView(),
                        );
                      } else {
                        cartController.addToCart(
                          data.id,
                          data.getPrice!.price,
                          '1',
                          data.varientId,
                        );
                      }
                    },
                    percent: data.percent == null
                        ? Container()
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
    );
  }
}
