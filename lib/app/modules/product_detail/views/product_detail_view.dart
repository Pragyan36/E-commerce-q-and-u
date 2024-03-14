import 'dart:developer';

import 'package:badges/badges.dart' as bag;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/modules/cart/views/cart_view.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/views/login_view.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/controllers/product_detail_controller.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/views/product_details_tab.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/views/review_tab.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/views/user_reviews_view.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:q_and_u_furniture/app/utils/custom_image_preview.dart';
import 'package:q_and_u_furniture/app/widgets/custom_buttons.dart';
import 'package:q_and_u_furniture/app/widgets/custom_product_detail_card.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({
    super.key,
    this.productname,
    this.productprice,
    this.slug,
    this.productid,
  });

  final String? productname;
  final String? productprice;
  final int? productid;
  final String? slug;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView>
    with SingleTickerProviderStateMixin {
  final CarouselController buttonCarouselController = CarouselController();
  final ProductDetailController controller = Get.put(
    ProductDetailController(),
  );
  final CartController cartcontroller = Get.put(
    CartController(),
  );
  final WishlistController wishcontroller = Get.put(
    WishlistController(),
  );
  final LoginController logcon = Get.put(
    LoginController(),
  );
  late int colorcode;
  List<List<int>> selectedIndices = [];
  int selectedIndex = 0;

  fetchAll() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.fetchProductDetail(widget.slug);
      await controller.fetchQuesAns(controller.productdetail.value.id);
      await controller.fetchReviews(
        controller.productdetail.value.id?.toInt(),
      );
      controller.selectedColorCode.value = "#92eebb";
    });
  }

  buildDetailsTop({
    required BuildContext context,
  }) {
    return Stack(
      children: [
        Obx(
          () => controller.productdetail.value.images != null
              ? SizedBox(
                  height: Device.orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.height / 2 - 100
                      : MediaQuery.of(context).size.height / 2,
                  width: double.infinity,
                  child: CarouselSlider.builder(
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      viewportFraction: 1,
                      initialPage: controller.selectedimg.value,
                      autoPlay: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      height: Device.orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height / 2 - 100
                          : MediaQuery.of(context).size.height / 2,
                      onPageChanged: (index, reason) {
                        controller.selectedimg.value = index;
                      },
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ImagePreview(
                                  imageUrl:
                                      '${controller.productdetail.value.images![index].image}',
                                );
                              },
                            ),
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl:
                              '${controller.productdetail.value.images![index].image}',
                          errorWidget: (context, url, error) {
                            return const Center(
                              child: Icon(
                                Icons.error,
                              ),
                            );
                          },
                          placeholder: (context, url) {
                            return Image.asset(
                              "assets/images/Placeholder.png",
                              fit: BoxFit.fill,
                            );
                          },
                        ),
                      );
                    },
                    itemCount:
                        controller.productdetail.value.images?.length ?? 0,
                  ),
                )
              : const SizedBox(),
        ),
        // FAVORITES BUTTON
        Positioned(
          top: 10,
          right: 50,
          child: MaterialButton(
            clipBehavior: Clip.hardEdge,
            enableFeedback: false,
            shape: const CircleBorder(
              side: BorderSide(
                color: AppColor.kalaAppLightAccentColor,
              ),
            ),
            color: Colors.white,
            height: 45,
            child: Icon(
              Icons.favorite,
              size: 22,
              color: wishcontroller.wishListIdArray.contains(
                controller.productdetail.value.id,
              )
                  ? Colors.red
                  : Colors.grey,
            ),
            onPressed: () {
              if (AppStorage.readIsLoggedIn != true) {
                Get.to(
                  () => LoginView(),
                );
              } else {
                if (logcon.logindata.value.read('USERID') != null) {
                  if (wishcontroller.wishListIdArray
                      .contains(controller.productdetail.value.id)) {
                    wishcontroller
                        .removeFromWishList(controller.productdetail.value.id);
                    wishcontroller.fetchWishlist();
                  } else {
                    wishcontroller
                        .addToWishList(controller.productdetail.value.id);
                    wishcontroller.fetchWishlist();
                  }
                } else {
                  getSnackbar(
                    message: "Please login to add this product to wishlist",
                  );
                }
              }
            },
          ),
        ),
        // BACK AND ADD TO CART BUTTONS
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                shape: const CircleBorder(
                  side: BorderSide(
                    color: AppColor.kalaAppLightAccentColor,
                  ),
                ),
                color: Colors.white,
                height: 45,
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16,
                  color: Colors.black,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              const Spacer(),
              Obx(
                () => MaterialButton(
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: AppColor.kalaAppLightAccentColor,
                    ),
                  ),
                  color: Colors.white,
                  height: 45,
                  onPressed: () {
                    Future.delayed(
                      const Duration(seconds: 2),
                      () {
                        Get.to(
                          CartView(),
                        );
                      },
                    );
                  },
                  child: bag.Badge(
                    badgeContent: Text(
                      '${cartcontroller.cartAssetsList.length}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    badgeAnimation: const bag.BadgeAnimation.slide(),
                    child: const Icon(
                      Icons.shopping_cart,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  buildRatingReviewtile() {
    return Row(
      children: [
        const Icon(
          Iconsax.star1,
          color: Colors.amber,
        ),
        const SizedBox(
          width: 2,
        ),
        Obx(
          () => Text(
            controller.productdetail.value.rating.toString(),
            style: subtitleStyle,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Obx(
          () => controller.reviewList.isEmpty
              ? const SizedBox()
              : Row(
                  children: [
                    Text(
                      controller.reviewList.length.toString(),
                      style: subtitleStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(
                          () => UserReviewView(
                            productId:
                                controller.productdetail.value.id!.toInt(),
                          ),
                        );
                      },
                      child: Text(
                        'reviews',
                        style: subtitleStyle.copyWith(
                          color: AppColor.kalaAppMainColor,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
        const Spacer(),
        Obx(
          () => Text(
            controller.productdetail.value.quantity!.toInt() > 0
                ? "${controller.productdetail.value.quantity} in stock!"
                : "Out of stock!",
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  buildincdecButton({
    required IconData icon,
    required void Function()? ontap,
  }) {
    return SizedBox(
      width: 40,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: AppColor.kalaAppAccentColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: ontap,
        onLongPress: ontap,
        padding: const EdgeInsets.all(5),
        color: AppColor.kalaAppSecondaryColor2,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  buildImageCard() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(
        () => controller.productdetail.value.images != null
            ? Row(
                children: [
                  ...List.generate(
                    controller.productdetail.value.images!.length,
                    (index) => buildProductImagesCard(
                      img: controller.productdetail.value.images?[index].image
                          ?.replaceAll(
                        RegExp(r'http://127.0.0.1:8000'),
                        url,
                      ),
                      borderClr: controller.selectedimg.value == index
                          ? AppColor.kalaAppMainColor
                          : Colors.transparent,
                      ontap: () {
                        controller.selectedimg.value = index;
                        buttonCarouselController.jumpToPage(index);
                      },
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      ),
    );
  }

  buildProductImagesCard({
    img,
    required Color borderClr,
    ontap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: 40,
          width: 40,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderClr,
              width: 1.5,
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: img,
            fit: BoxFit.contain,
            errorWidget: (context, url, error) {
              return const Icon(Icons.error);
            },
            placeholder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset("assets/images/Placeholder.png"),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildMainBody() {
    var formatter = NumberFormat('#,###');
    var specialPrice = thousandSepretor
        .format(controller.productdetail.value.specialPrice ?? 0);
    // var price = formatter.format(controller.productdetail.value.price ?? 0);
    // var uniqueTitles = controller.productdetail.value.selectedAttributes
    //         ?.map((attribute) => attribute.getOption!.title)
    //         .toSet()
    //         .toList() ??
    //     [];
    // int? priceDifference;
    // if (controller.productdetail.value.price != null &&
    //     controller.productdetail.value.specialPrice != null) {
    //   priceDifference = controller.productdetail.value.price! -
    //       controller.productdetail.value.specialPrice!;
    // }

    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*
            FIRST CARD
          */
          CustomProductDetailCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                /*
                  PRODUCT NAME SECTION
                */
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    child: Text(
                      controller.productdetail.value.name?.toString() ?? "N/A",
                      style: titleStyle.copyWith(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                /*
                  PRODUCT PRICE SECTION
                */
                Obx(
                  () => RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: controller.updatedSpecialPrice.value != 0
                              ? "Rs. ${formatter.format(controller.updatedSpecialPrice.value)}"
                              : "Rs. ${controller.productdetail.value.specialPrice == 0 || controller.productdetail.value.specialPrice == null ? controller.updatedOriginalPrice.value != 0 ? controller.updatedOriginalPrice : controller.price : specialPrice}",
                          style: titleStyle.copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //specialPrice=0, means there's no specialPrice
                const SizedBox(
                  height: 5,
                ),
                Obx(
                  () => controller.specialPrice.value == 0 ||
                          controller.specialPrice.value ==
                              controller.price.value
                      ? const SizedBox()
                      : RichText(
                          text: TextSpan(
                            text: "Original Price ",
                            style: const TextStyle(
                              color: AppColor.kalaAppSecondaryColor,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                // text: "${controller.updatedOriginalPrice}",
                                text:
                                    "Rs. ${formatter.format(controller.originalPrice.value)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 2,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                (controller.priceDifference != null &&
                        controller.priceDifference != controller.originalPrice)
                    ? RichText(
                        text: TextSpan(
                          text: "You saved ",
                          style: const TextStyle(
                            color: AppColor.kalaAppMainColor,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  "Rs. ${formatter.format(controller.priceDifference!.value)}!",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                /*
                  FULFILLED SECTION
                */
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${(controller.productdetail.value.vat)}",
                        style: titleStyle.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'Fulfilled by: ',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          controller.sellerName.value == ""
                              ? "Q and U Furniture"
                              : controller.sellerName.value,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                /*
                  RATING SECTION
                */
                buildRatingReviewtile(),
              ],
            ),
          ),
          /*
            SECOND CARD
          */
          /*
            COLOR SELECTION SECTION
          */
          CustomProductDetailCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.productdetail.value.colors!.isNotEmpty
                    ? Obx(
                        () => SizedBox(
                          height: 40,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                controller.productdetail.value.colors?.length ??
                                    0,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Obx(
                                  () => GestureDetector(
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        color: hexToColor(controller
                                                .productdetail
                                                .value
                                                .colors![index]
                                                .code ??
                                            ""),
                                        border: Border.all(
                                          color: controller.selectedColorIndex
                                                      .value ==
                                                  index
                                              ? AppColor.kalaAppMainColor
                                              : Colors.grey.shade300,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      controller.selectedColorIndex.value =
                                          index;
                                      controller.selectedColorValue.value =
                                          controller.productdetail.value
                                              .colors![index].id!;

                                      int selectedColorId = controller
                                          .productdetail
                                          .value
                                          .colors![index]
                                          .id!;
                                      if (controller.productdetail.value
                                              .selectedAttributes !=
                                          null) {
                                        for (var attribute in controller
                                            .productdetail
                                            .value
                                            .selectedAttributes!) {
                                          if (attribute.stock!.colorId ==
                                              selectedColorId) {
                                            controller.updatedOriginalPrice
                                                    .value =
                                                attribute.stock?.price ?? 0;
                                            controller
                                                    .updatedSpecialPrice.value =
                                                attribute.stock?.specialPrice ??
                                                    0;
                                          }
                                        }
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                // Text("${jsonEncode(controller.productdetail.value.productDetailsAttribute!['4'])}"),
                // DropdownButton<dynamic>(
                //   value: controller
                //           .productdetail
                //           .value
                //           .productDetailsAttribute![
                //               "${controller.selectedColorValue.value}"]
                //           .isNotEmpty
                //       ? controller.productdetail.value.productDetailsAttribute![
                //           "${controller.selectedColorValue.value}"][0]
                //       : null,
                //   onChanged: (newValue) {
                //     // Implement your logic when the dropdown value changes
                //   },
                //   items: controller
                //       .productdetail
                //       .value
                //       .productDetailsAttribute![
                //           "${controller.selectedColorValue.value}"]
                //       .map((dynamic value) {
                //     return DropdownMenuItem<dynamic>(
                //       value: value,
                //       child: Text("hello"),
                //     );
                //   }).toList(),
                // ),
                // Text(
                //   "${controller.productdetail.value.productDetailsAttribute!["${controller.selectedColorValue.value}"][0][0]['title']}",
                //   style: const TextStyle(
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // Column(
                //   children: List.generate(
                //     controller
                //         .productdetail
                //         .value
                //         .productDetailsAttribute![
                //             "${controller.selectedColorValue.value}"][0]
                //         .length,
                //     (index) {
                //       var value = controller
                //                   .productdetail.value.productDetailsAttribute![
                //               "${controller.selectedColorValue.value}"][0]
                //           [index]['value'];
                //       return Text(
                //         value,
                //         style: const TextStyle(
                //           fontWeight: FontWeight.bold,
                //         ),
                //       );
                //     },
                //   ),
                // ),
                // Text(
                //   "${controller.productdetail.value.productDetailsAttribute!["${controller.selectedColorValue.value}"][0][0]['value']}",
                //   style: const TextStyle(
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                Obx(
                  () => controller
                          .productdetail.value.productDetailsAttribute!.isEmpty
                      ? const SizedBox()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller
                              .productdetail
                              .value
                              .productDetailsAttribute![
                                  "${controller.selectedColorValue.value}"]
                              .length,
                          itemBuilder: (context, indexOutSide) {
                            return Container(
                              decoration: BoxDecoration(
                                color: controller.tapedIndexOutside.value ==
                                        indexOutSide
                                    ? AppColor.kalaAppAccentColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      controller.tapedIndexOutside.value =
                                          indexOutSide;

                                      controller
                                          .updatedSpecialPrice.value = controller
                                                  .productdetail
                                                  .value
                                                  .productDetailsAttribute![
                                              "${controller.selectedColorValue.value}"]
                                          [indexOutSide][0]['special_price'];
                                      controller
                                          .originalPrice.value = controller
                                                  .productdetail
                                                  .value
                                                  .productDetailsAttribute![
                                              "${controller.selectedColorValue.value}"]
                                          [indexOutSide][0]['price'];
                                    });
                                  },
                                  child: MediaQuery.removePadding(
                                    context: context,
                                    removeRight: true,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),

                                      // scrollDirection: Axis.horizontal,
                                      itemCount: controller
                                          .productdetail
                                          .value
                                          .productDetailsAttribute![
                                              "${controller.selectedColorValue.value}"]
                                              [indexOutSide]
                                          .length,
                                      // separatorBuilder: (context, index) {
                                      //   return const SizedBox(
                                      //     height: 10,
                                      //   );
                                      // },
                                      itemBuilder: (context, index) {
                                        var data = controller.productdetail.value
                                                    .productDetailsAttribute![
                                                "${controller.selectedColorValue.value}"]
                                            [indexOutSide][index];

                                        return Text(
                                            "${data['title']}:  ${data['value']}");
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),

          //  ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: controller.productdetail.value.productDetailsAttribute!["${controller.selectedColorValue.value}"][0].length,
          //   itemBuilder: (context, index){
          //     var data = controller.productdetail.value.productDetailsAttribute!["${controller.selectedColorValue.value}"][0][index];
          //   return Text("${data['value']}");
          // }),
          // uniqueTitles.isEmpty
          //     ? const SizedBox()
          //     : CustomProductDetailCard(
          //         child: Obx(
          //           () {
          //             uniqueTitles = controller
          //                 .productdetail.value.selectedAttributes!
          //                 .map((attribute) => attribute.getOption!.title)
          //                 .toSet()
          //                 .toList();

          //             // for (final matchingAttr in matchingAttributes) {
          //             //   final value = matchingAttr.value;
          //             //   cartcontroller.selectedValues1.add(value!);
          //             // }

          //             return Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 controller.productdetail.value.colors!.isNotEmpty
          //                     ? SizedBox(
          //                         height: 40,
          //                         child: ListView.builder(
          //                           shrinkWrap: true,
          //                           scrollDirection: Axis.horizontal,
          //                           itemCount: controller.productdetail.value
          //                                   .colors?.length ??
          //                               0,
          //                           itemBuilder: (context, index) {
          //                             return Padding(
          //                               padding: const EdgeInsets.symmetric(
          //                                 horizontal: 10,
          //                               ),
          //                               child: Obx(
          //                                 () => GestureDetector(
          //                                   child: Container(
          //                                     height: 50,
          //                                     width: 50,
          //                                     decoration: BoxDecoration(
          //                                       borderRadius:
          //                                           const BorderRadius.all(
          //                                         Radius.circular(10),
          //                                       ),
          //                                       color: hexToColor(controller
          //                                               .productdetail
          //                                               .value
          //                                               .colors![index]
          //                                               .code ??
          //                                           ""),
          //                                       border: Border.all(
          //                                         color: controller
          //                                                     .selectedColorIndex
          //                                                     .value ==
          //                                                 index
          //                                             ? AppColor
          //                                                 .kalaAppMainColor
          //                                             : Colors.grey.shade300,
          //                                       ),
          //                                     ),
          //                                   ),
          //                                   onTap: () {
          //                                     controller.selectedColorIndex
          //                                         .value = index;
          //                                   },
          //                                 ),
          //                               ),
          //                             );
          //                           },
          //                         ),
          //                       )
          //                     : const SizedBox(),
          //                 const SizedBox(
          //                   height: 10,
          //                 ),
          //                 ListView.builder(
          //                   shrinkWrap: true,
          //                   padding: EdgeInsets.zero,
          //                   physics: const NeverScrollableScrollPhysics(),
          //                   itemCount: uniqueTitles.length,
          //                   itemBuilder: (context, index) {
          //                     // Filter attributes with the current unique title
          //                     var attributesWithSameTitle = controller
          //                         .productdetail.value.selectedAttributes!
          //                         .where((attribute) =>
          //                             attribute.getOption!.title ==
          //                             uniqueTitles[index])
          //                         .toList();

          //                     return Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Text(
          //                           "${uniqueTitles[index]}",
          //                           style: TextStyle(
          //                             fontWeight: FontWeight.bold,
          //                             fontSize: 16.sp,
          //                           ),
          //                         ),
          //                         SingleChildScrollView(
          //                           scrollDirection: Axis.horizontal,
          //                           child: Row(
          //                             children: attributesWithSameTitle
          //                                 .map((attribute) => attribute.value)
          //                                 .toSet()
          //                                 .map(
          //                               (uniqueValue) {
          //                                 return GestureDetector(
          //                                   onTap: () {
          //                                     cartcontroller.selectedValues1
          //                                         .clear();
          //                                     final selectedAttribute =
          //                                         controller.productdetail.value
          //                                             .selectedAttributes!
          //                                             .firstWhere(
          //                                       (attr) =>
          //                                           attr.value == uniqueValue,
          //                                     );

          //                                     final stockId =
          //                                         selectedAttribute.stockId;
          //                                     final newSpecialPrice =
          //                                         selectedAttribute
          //                                             .specialPrice;
          //                                     final newOriginalPrice =
          //                                         selectedAttribute.stockPrice;

          //                                     cartcontroller.selectedValue
          //                                         .value = stockId!;
          //                                     cartcontroller.selectedStockPrice
          //                                             .value =
          //                                         newSpecialPrice!.toString();
          //                                     controller.originalPrice.value =
          //                                         newOriginalPrice!;

          //                                     // Find all attributes with the same stockId
          //                                     final matchingAttributes =
          //                                         controller.productdetail.value
          //                                             .selectedAttributes!
          //                                             .where((attr) =>
          //                                                 attr.stockId ==
          //                                                 stockId)
          //                                             .toList();

          //                                     for (final matchingAttr
          //                                         in matchingAttributes) {
          //                                       final value =
          //                                           matchingAttr.value;
          //                                       cartcontroller.selectedValues1
          //                                           .add(value!);
          //                                     }
          //                                   },
          //                                   child: Obx(
          //                                     () => Padding(
          //                                       padding:
          //                                           const EdgeInsets.all(5.0),
          //                                       child: Container(
          //                                         margin: const EdgeInsets
          //                                             .symmetric(
          //                                           vertical: 4,
          //                                         ),
          //                                         decoration: BoxDecoration(
          //                                           color: cartcontroller
          //                                                   .selectedValues1
          //                                                   .contains(
          //                                                       uniqueValue)
          //                                               ? AppColor
          //                                                   .kalaAppLightAccentColor
          //                                               : Colors.white,
          //                                           border: Border.all(
          //                                             color: AppColor
          //                                                 .kalaAppMainColor,
          //                                           ),
          //                                           borderRadius:
          //                                               BorderRadius.circular(
          //                                             8.0,
          //                                           ),
          //                                         ),
          //                                         padding:
          //                                             const EdgeInsets.all(8.0),
          //                                         child: Text(
          //                                           "$uniqueValue",
          //                                           style: const TextStyle(
          //                                             fontSize: 14,
          //                                           ),
          //                                           textAlign: TextAlign.left,
          //                                         ),
          //                                       ),
          //                                     ),
          //                                   ),
          //                                 );
          //                               },
          //                             ).toList(),
          //                           ),
          //                         ),
          //                         const Divider(),
          //                       ],
          //                     );
          //                   },
          //                 ),
          //               ],
          //             );
          //           },
          //         ),
          //       ),

          /*
            PRODUCT DETAILS CARD
          */
          CustomProductDetailCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Product Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const ProductDetailsTab(),
              ],
            ),
          ),
          /*
            FOURTH CARD
          */
          // uniqueTitles.isEmpty
          //     ? const SizedBox()
          //     : CustomProductDetailCard(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Text(
          //               "Specifications",
          //               style: TextStyle(
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 16.sp,
          //               ),
          //             ),
          //             const SpecificationTab(),
          //           ],
          //         ),
          //       ),
          /*
            FIFTH CARD
          */
          CustomProductDetailCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Ratings and Reviews",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const ReviewTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  void initState() {
    cartcontroller.selectedStockPrice = "".obs;
    cartcontroller.selectedValues1 = <String>[].obs;
    fetchAll();
    super.initState();
    // print("printthevalue of  color${controller.selectedColorValue.value = controller.productdetail.value .colors![0].id}");
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchReviews(
      controller.productdetail.value.id?.toInt(),
    );

    return Obx(
      () => controller.loading.isTrue
          ? SafeArea(
              child: Container(
                height: 200,
                color: Colors.white,
                child: SizedBox(
                  height: 200,
                  child: CustomShimmer(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 10,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 10,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          height: 70,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 10,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).viewPadding.top,
                    ),
                    buildDetailsTop(
                      context: context,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          buildImageCard(),
                          const SizedBox(
                            height: 20,
                          ),
                          buildMainBody(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                color: AppColor.kalaAppLightAccentColor.withOpacity(0.3),
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewPadding.bottom,
                ),
                child: Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildincdecButton(
                          icon: Icons.remove,
                          ontap: () {
                            controller.decrement();
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          controller.count.value.toString(),
                          style: titleStyle,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        buildincdecButton(
                          icon: Icons.add,
                          ontap: () {
                            controller.increment();
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomButtons(
                          label: 'Add to Cart',
                          txtClr: Colors.white,
                          btnClr: AppColor.kalaAppMainColor,
                          ontap: () async {
                            // controller.listOfId.clear();
                            // controller.listOfTitle.clear();
                            // cartcontroller.options.clear();
                            if (AppStorage.readIsLoggedIn != true) {
                              Get.to(
                                () => LoginView(),
                              );
                              return;
                            } else {
                              var data = controller.productdetail.value
                                          .productDetailsAttribute![
                                      "${controller.selectedColorValue.value}"]
                                  [controller.tapedIndexOutside.value];
                              List<Map<String, dynamic>> options = [];
                              for (int i = 0; i < data.length; i++) {
                                Map<String, dynamic> item = {
                                  "id": data[i]["variant_id"],
                                  "title": data[i]["title"],
                                  "value": data[i]["value"],
                                };

                                options.add(item);
                              }
                              cartcontroller.addItems(
                                productId:
                                    "${controller.productdetail.value.id}",
                                variantId: data[0]["variant_id"],
                                quantity: "${controller.count}",
                                options: options,
                              );
                              // if (cartcontroller.selectedValues1.isEmpty) {
                              //   getSnackbar(
                              //     message: "Pleae select the required variant",
                              //     error: true,
                              //     bgColor: Colors.red,
                              //   );
                              // } else {
                              //   int selectedAttributesLength = controller
                              //       .productdetail
                              //       .value
                              //       .selectedAttributes!
                              //       .length;
                              //   for (int j = 0;
                              //       j < selectedAttributesLength;
                              //       j++) {
                              //     var attributeValue = controller.productdetail
                              //         .value.selectedAttributes![j].key;
                              //     if (!controller.listOfId
                              //         .contains(attributeValue)) {
                              //       controller.listOfId.add(attributeValue);
                              //     }
                              //   }
                              //   for (int j = 0;
                              //       j < selectedAttributesLength;
                              //       j++) {
                              //     var attributeValues = controller
                              //         .productdetail
                              //         .value
                              //         .selectedAttributes![j]
                              //         .getOption!
                              //         .title!;
                              //     if (!controller.listOfTitle
                              //         .contains(attributeValues)) {
                              //       controller.listOfTitle.add(attributeValues);
                              //     }
                              //   }
                              //   for (var i = 0;
                              //       i < controller.listOfId.length;
                              //       i++) {
                              //     cartcontroller.options.add(
                              //       Options(
                              //         id: controller.listOfId[i],
                              //         title: '${controller.listOfTitle[i]}',
                              //         value: cartcontroller.selectedValues1[i],
                              //       ),
                              //     );
                              //   }
                              //   cartcontroller.addCartLoading.value == true
                              //       ? null
                              //       : cartcontroller.addToCart(
                              //           controller.productdetail.value.id
                              //               .toString(),
                              //           controller
                              //               .productdetail
                              //               .value
                              //               .selectedAttributes![controller
                              //                   .selectedStockIndex.value]
                              //               .stock!
                              //               .id,
                              //           // controller.specialPrice.value == 0
                              //           //     ? controller
                              //           //         .productdetail.value.price
                              //           //     : controller.specialPrice
                              //           //         .toString(),
                              //           controller.count.toString(),
                              //           // controller.productdetail.value
                              //           //     .selectedData![0].id,
                              //           // controller.selectedVarientId.value,
                              //           [
                              //             {
                              //               "id": controller
                              //                   .productdetail
                              //                   .value
                              //                   .selectedAttributes![controller
                              //                       .selectedStockIndex.value]
                              //                   .stock!
                              //                   .id,
                              //               "title": controller
                              //                           .productdetail
                              //                           .value
                              //                           .productDetailsAttribute![
                              //                       "${controller.selectedColorValue.value}"][0]
                              //                   [controller.selectedStockIndex
                              //                       .value]["title"],
                              //               "value": controller
                              //                           .productdetail
                              //                           .value
                              //                           .productDetailsAttribute![
                              //                       "${controller.selectedColorValue.value}"][0]
                              //                   [controller.selectedStockIndex
                              //                       .value]["value"],
                              //             }
                              //           ],
                              //         );
                              // }
                              log("add to cart tapped");
                            }
                            if (await Connectivity().checkConnectivity() ==
                                ConnectivityResult.none) {
                              getSnackbar(
                                message: "No Internet Connection",
                                error: true,
                                bgColor: Colors.red,
                              );
                              return;
                            }
                            // if (controller.productdetail.value.selectedData!
                            //         .isNotEmpty &&
                            //     controller.selectedVarientId.value == 0) {
                            //   getSnackbar(
                            //     message: 'Please select a variant',
                            //   );

                            //   return;
                            // }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
