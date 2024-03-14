import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:q_and_u_furniture/app/data/models/child_category_model.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/widgets/loading_widget.dart';

import '../constants/constants.dart';
import '../modules/category/controllers/category_controller.dart';
import '../modules/product_detail/views/product_detail_view.dart';

class CategoryProductCard extends StatelessWidget {
  CategoryProductCard({Key? key, required this.data}) : super(key: key);

  final Products data;
  final cartcontroller = Get.put(CartController());

  final controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailView(
              slug: data.slug,
              productid: data.id,
            ));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12, width: 1)),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Center(
                    child: CachedNetworkImage(
                      imageUrl:
                          '${data.image?.replaceAll(RegExp(r'http://127.0.0.1:8000'), url)}',
                      fit: BoxFit.contain,
                      placeholder: (context, i) {
                        return const LoadingWidget();
                      },
                    ),
                  ),
                  data.percent == null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 05),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(05)),
                                child: Text(
                                  '${data.percent}%',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                  // SizedBox(
                  //   height: double.infinity,
                  //   width: double.infinity,
                  //   child: CarouselSlider(
                  //     items: [
                  //       ...List.generate(
                  //         data.images!.length,
                  //         (index) => Center(
                  //           child: CachedNetworkImage(
                  //             imageUrl:
                  //                 '${data.image?.replaceAll(RegExp(r'http://127.0.0.1:8000'), url)}',
                  //             fit: BoxFit.contain,
                  //             placeholder: (context, i) {
                  //               return const CircularProgressIndicator();
                  //             },
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //     options: CarouselOptions(
                  //         initialPage: controller.selectedImg.value,
                  //         viewportFraction: .9,
                  //         enableInfiniteScroll: true,
                  //         enlargeCenterPage: true,
                  //         aspectRatio: 0.5,
                  //         onPageChanged: (i, reason) {
                  //           controller.selectedImg.value = i;
                  //           print(controller.selectedImg.value);
                  //         }),
                  //   ),
                  // ),
                  // Align(
                  //     alignment: Alignment.bottomCenter,
                  //     child: Obx(
                  //       () => DotsIndicator(
                  //         dotsCount: data.images!.length,
                  //         position: controller.s,
                  //         decorator: const DotsDecorator(
                  //             activeColor: AppColor.orange,
                  //             activeSize: Size.square(7.5),
                  //             size: Size.square(7)),
                  //       ),
                  //     ))
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name.toString(),
                      style: subtitleStyle,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rs. ${data.price}',
                          style: titleStyle.copyWith(
                              color: data.specialPrice == "null"
                                  ? Colors.black
                                  : AppColor.orange,
                              decoration: data.specialPrice != 'null'
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        GestureDetector(
                            onTap: () {
                              cartcontroller.addToCart(
                                data.id,
                                data.price,
                                '1',
                                data.varientId,
                              );
                            },
                            child: const Icon(Iconsax.shopping_cart))
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        data.specialPrice.toString() == "null"
                            ? Container()
                            : Text(
                                'Rs.  ${data.specialPrice}',
                                style: subtitleStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              size: 18.sp,
                              color: Colors.amber,
                            ),
                            Text(
                              data.rating.toString(),
                              style: subtitleStyle,
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
