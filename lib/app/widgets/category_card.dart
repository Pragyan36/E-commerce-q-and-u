import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CategoryCard extends GetView<LandingController> {
  const CategoryCard({
    Key? key,
    required this.categoryImg,
    this.categoryName,
    this.price,
    this.ontapCart,
    this.ontap,
  }) : super(key: key);

  final String categoryImg;
  final String? categoryName;
  final String? price;
  final VoidCallback? ontapCart;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: const RoundedRectangleBorder(
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(20),
            //   bottomRight: Radius.circular(20),
            // ),
            // side: BorderSide(
            //   width: 0.5,
            //   color: AppColor.kalaAppAccentColor,
            // ),
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
                        imageUrl: categoryImg,
                        placeholder: (context, url) => Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                          ),
                          // padding: const EdgeInsets.all(50),
                          child: Image.asset(
                            AppImages.logo,
                          ),
                        ),
                        errorWidget: (context, a, s) {
                          return Image.asset(
                            AppImages.logo,
                            // "assets/images/Placeholder.png",
                            // height: 50,
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
                      SizedBox(
                        height: 34,
                        width: 120,
                        child: Text(
                          categoryName ?? "N/A",
                          style: subtitleStyle.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: Device.orientation == Orientation.portrait
                              ? 2
                              : 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                      // PRICE AND FAVORITES SECTION
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
