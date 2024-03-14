import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/views/login_view.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_no_image_widget.dart';
import 'package:q_and_u_furniture/app/widgets/toast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductDisplayWidget extends StatefulWidget {
  final LandingController controller;
  final int index;

  const ProductDisplayWidget({
    super.key,
    required this.controller,
    required this.index,
  });

  @override
  State<ProductDisplayWidget> createState() => _ProductDisplayWidgetState();
}

class _ProductDisplayWidgetState extends State<ProductDisplayWidget> {
  final wishlistcontroller = Get.put(WishlistController());
  final cartController = Get.put(CartController());
  final logcon = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        height: 300,
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
              ),
              child: SizedBox(
                height: 150,
                width: 200,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                  ),
                  child: Image.network(
                    "${(widget.controller.recommendedProductsList[widget.index].images?[0].image)}",
                    errorBuilder: (context, error, stackTrace) {
                      return const CustomNoImageWidget();
                    },
                    fit: BoxFit.cover,
                    height: 150,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // PRODUCT NAME
                      Flexible(
                        child: SizedBox(
                          height: 34,
                          width: 120,
                          child: Text(
                            widget
                                    .controller
                                    .recommendedProductsList[widget.index]
                                    .name ??
                                "N/A",
                            style: subtitleStyle.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: Device.orientation == Orientation.portrait
                                ? 2
                                : 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      // RATING SECTION
                      if (widget.controller
                              .recommendedProductsList[widget.index].rating !=
                          null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              size: 18.sp,
                              color: Colors.amber,
                            ),
                            Text(
                              widget
                                      .controller
                                      .recommendedProductsList[widget.index]
                                      .rating ??
                                  "",
                              style: subtitleStyle,
                            ),
                          ],
                        ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Rs. ${widget.controller.recommendedProductsList[widget.index].stocks?[0].specialPrice ?? widget.controller.recommendedProductsList[widget.index].stocks?[0].price}",
                            style: subtitleStyle.copyWith(
                              color: AppColor.kalaAppMainColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          widget
                                          .controller
                                          .recommendedProductsList[widget.index]
                                          .stocks?[0]
                                          .specialPrice ==
                                      null ||
                                  widget
                                          .controller
                                          .recommendedProductsList[widget.index]
                                          .stocks?[0]
                                          .specialPrice ==
                                      widget
                                          .controller
                                          .recommendedProductsList[widget.index]
                                          .stocks?[0]
                                          .price
                              ? const SizedBox()
                              : Text(
                                  "Rs.${(widget.controller.recommendedProductsList[widget.index].stocks?[0].price) ?? "N/A"}",
                                  style: subtitleStyle.copyWith(
                                    color: Colors.grey.shade600,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          if (AppStorage.readIsLoggedIn != true) {
                            Get.to(
                              () => LoginView(),
                            );
                          } else {
                            if (logcon.logindata.value.read('USERID') != null) {
                              if (wishlistcontroller.wishListIdArray.contains(
                                  widget
                                      .controller
                                      .recommendedProductsList[widget.index]
                                      .id)) {
                                wishlistcontroller.removeFromWishList(widget
                                    .controller
                                    .recommendedProductsList[widget.index]
                                    .id);
                                wishlistcontroller.fetchWishlist();
                              } else {
                                wishlistcontroller.addToWishList(
                                  widget.controller
                                      .recommendedProductsList[widget.index].id,
                                );
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
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.favorite,
                          color: wishlistcontroller.wishListIdArray.contains(
                                  widget.controller
                                      .recommendedProductsList[widget.index].id)
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
