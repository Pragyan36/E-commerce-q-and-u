// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:q_and_u_furniture/app/database/app_storage.dart';
// import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
// import 'package:q_and_u_furniture/app/modules/landing/components/featured_details_view.dart';
// import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';
// import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
// import 'package:q_and_u_furniture/app/modules/login/views/login_view.dart';
// import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';

// import '../../../constants/constants.dart';
// import '../../../widgets/product_card.dart';
// import '../../../widgets/snackbar.dart';
// import '../../../widgets/toast.dart';
// import '../../product_detail/views/product_detail_view.dart';

// class FeaturedProductsView extends StatelessWidget {
//   FeaturedProductsView({Key? key}) : super(key: key);

//   final controller = Get.put(LandingController());
//   final cartcontroller = Get.put(CartController());
//   final logcon = Get.put(LoginController());
//   final wishlistcontroller = Get.put(WishlistController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => controller.loading.isFalse
//         ? ListView.builder(
//             physics: const BouncingScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: controller.featuredlist.length,
//             itemBuilder: (context, index) {
//               return Column(
//                 children: [
//                   controller.featuredlist[index].product?.length != null
//                       ? buildHeadertxt(controller.featuredlist[index].title,
//                           () async {
//                           print(controller.featuredlist[index].id?.toInt());
//                           controller.specificId.value =
//                               controller.featuredlist[index].id!.toInt();
//                           await controller.fetchSpecificFeaturedProducts(
//                               controller.featuredlist[index].id!.toInt());
//                           Get.to(() => FeaturedDeatilsView(
//                                 id: controller.featuredlist[index].id!.toInt(),
//                                 title: controller.featuredlist[index].title
//                                     .toString(),
//                               ));
//                         }, true)
//                       : Container(),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: [
//                           ...List.generate(
//                               controller.featuredlist[index].product!.length,
//                               (i) {
//                             var product =
//                                 controller.featuredlist[index].product![i];
//                             return Padding(
//                               padding: const EdgeInsets.only(left: 10),
//                               child: SizedBox(
//                                 width: 150,
//                                 child: Obx(
//                                   () => ProductCard(
//                                     price: product.price.toString(),
//                                     specialprice:
//                                         product.specialPrice.toString(),
//                                     productImg:
//                                         '${product.image?.replaceAll(RegExp(r'http://127.0.0.1:8000'), url)}',
//                                     productName: product.name,
//                                     rating: product.rating,
//                                     bestseller: true,
//                                     ontap: () async {
//                                       if (await Connectivity()
//                                               .checkConnectivity() ==
//                                           ConnectivityResult.none) {
//                                         getSnackbar(
//                                             message: "No Internet Connection",
//                                             error: true,
//                                             bgColor: Colors.red);
//                                         return;
//                                       }
//                                       Get.to(() => ProductDetailView(
//                                             // productname:
//                                             //     products[index]['product_name'].toString(),
//                                             // productprice:
//                                             //     products[index]['product_price'].toString(),
//                                             productid: product.id,
//                                             slug: product.slug,
//                                           ));
//                                     },
//                                     ontapCart: () {
//                                       // var data = products[index];
//                                       print(product.varientId.toString());
//                                       if (AppStorage.readIsLoggedIn != true) {
//                                         Get.to(() => LoginView());
//                                       } else {
//                                         cartcontroller.addToCart(
//                                           product.id,
//                                           product.price,
//                                           '1',
//                                           product.varientId,
//                                         );
//                                       }

//                                       //toastMsg(message: 'Added to cart');
//                                     },
//                                     isFav: wishlistcontroller.wishListIdArray
//                                             .contains(product.id)
//                                         ? true
//                                         : false,
//                                     ontapFavorite: () {
//                                       if (AppStorage.readIsLoggedIn != true) {
//                                         Get.to(() => LoginView());
//                                       }
//                                       {
//                                         if (logcon.logindata.value
//                                                 .read('USERID') !=
//                                             null) {
//                                           if (wishlistcontroller.wishListIdArray
//                                               .contains(product.id)) {
//                                             //toastMsg(message: "remove");
//                                             wishlistcontroller
//                                                 .removeFromWishList(product.id);
//                                             wishlistcontroller.fetchWishlist();
//                                           } else {
//                                             //toastMsg(message: "add");
//                                             wishlistcontroller
//                                                 .addToWishList(product.id);
//                                             wishlistcontroller.fetchWishlist();
//                                           }
//                                         } else {
//                                           toastMsg(
//                                               message:
//                                                   "Please Login to add to wishlist");
//                                         }
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             );
//                           })
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               );
//             },
//           )
//         : Container());
//   }

//   buildHeadertxt(title, ontap, viewall) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: titleStyle.copyWith(fontWeight: FontWeight.bold),
//           ),
//           viewall
//               ? TextButton(
//                   onPressed: ontap,
//                   child: Text(
//                     'View all',
//                     style: subtitleStyle,
//                   ),
//                 )
//               : Container()
//         ],
//       ),
//     );
//   }
// }
