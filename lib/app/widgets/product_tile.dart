import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/constants.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    Key? key,
    required this.productImg,
    this.rating,
    this.productName,
    this.price,
    this.specialprice,
    this.onTapCart,
    this.onTapFavorite,
    this.onTap,
    this.bestseller = false,
    this.isFav = false,
    this.isLoading = false,
    this.percent,
  }) : super(key: key);
  final String productImg;
  final String? rating;
  final String? productName;
  final String? price;
  final String? specialprice;
  final VoidCallback? onTapFavorite;
  final VoidCallback? onTapCart;
  final VoidCallback? onTap;
  final bool? bestseller;
  final bool? isFav;
  final bool isLoading;
  final Widget? percent;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        padding: const EdgeInsets.symmetric(vertical: 10),
        // height: 100,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: productImg.toString(),
                        placeholder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset("assets/images/Placeholder.png"),
                          );
                        },
                        errorWidget: (context, a, s) {
                          return const Icon(Icons.error);
                        },
                      ),
                    ),
                    bestseller == true
                        ? Transform.rotate(
                            angle: -0.5,
                            child: Image.asset(
                              AppImages.bestSeller,
                              height: 30,
                            ),
                          )
                        : Container()
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50.sp,
                      child: Text(
                        productName!,
                        style: subtitleStyle,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          price == 'null' ? '' : price.toString(),
                          style: titleStyle.copyWith(
                            color: specialprice == "null"
                                ? Colors.black
                                : AppColor.kalaAppMainColor,
                            decoration: specialprice != 'null'
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          specialprice == 'null' ? '' : specialprice.toString(),
                          style: titleStyle.copyWith(
                            color: price != 'null'
                                ? Colors.black
                                : AppColor.kalaAppMainColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        Text(
                          rating.toString(),
                          style: subtitleStyle,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            percent ?? const SizedBox(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: onTapFavorite,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 18,
                    child: Icon(
                      Icons.favorite,
                      size: 18,
                      color: isFav == true ? Colors.green : Colors.grey,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onTapCart,
                  icon: const Icon(
                    Iconsax.shopping_cart,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
