import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CategoryCard extends GetView<LandingController> {
  const CategoryCard({
    Key? key,
    required this.productImg,
    this.rating,
    this.productName,
    this.price,
    this.specialprice,
    this.ontapCart,
    this.ontapFavorite,
    this.ontap,
    this.bestseller = false,
    this.percent,
    this.isFav = false,
  }) : super(key: key);

  final String productImg;
  final String? rating;
  final String? productName;
  final String? price;
  final String? specialprice;
  final VoidCallback? ontapFavorite;
  final VoidCallback? ontapCart;
  final VoidCallback? ontap;
  final bool? bestseller;
  final bool? isFav;
  final Widget? percent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
        elevation: 1,
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          side: BorderSide(
            width: 0.5,
            color: AppColor.kalaAppAccentColor,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                // TAB DISPLAY IMAGE
                Center(
                  child: SizedBox(
                    height: 150,
                    width: 200,
                    child: Center(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 150,
                        width: 200,
                        imageUrl: productImg,
                        placeholder: (context, url) => Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                          ),
                          padding: const EdgeInsets.all(50),
                          child: Image.asset("assets/images/Placeholder.png"),
                        ),
                        errorWidget: (context, a, s) {
                          return Image.asset(
                            "assets/images/Placeholder.png",
                            height: 50,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                // TAB DISPLAY DESCRIPTIONS
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                productName ?? "N/A",
                                style: subtitleStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines:
                                    Device.orientation == Orientation.portrait
                                        ? 2
                                        : 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          // RATING SECTION
                          if (rating != null)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 18.sp,
                                  color: Colors.amber,
                                ),
                                Text(
                                  rating ?? "",
                                  style: subtitleStyle,
                                ),
                              ],
                            ),
                        ],
                      ),
                      // PRICE AND FAVORITES SECTION
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              //If specialPrice is null, show only Price
                              //Else if special price is not null,
                              // show special price in price and price in cut price
                              Text(
                                "Rs. ${specialprice == "null" ? price : specialprice}",
                                style: subtitleStyle.copyWith(
                                  color: AppColor.kalaAppMainColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              specialprice == "null" ||
                                      specialprice == price ||
                                      specialprice == "Rs.0"
                                  ? const SizedBox()
                                  : Text(
                                      "Rs.$price",
                                      style: subtitleStyle.copyWith(
                                        color: Colors.grey.shade600,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                            ],
                          ),
                          IconButton(
                            onPressed: ontapFavorite,
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.favorite,
                              color: isFav == true ? Colors.red : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            percent ?? const SizedBox(),
            bestseller == true
                ? Transform.rotate(
                    angle: -0.5,
                    child: Image.asset(
                      AppImages.bestSeller,
                      height: 50,
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
