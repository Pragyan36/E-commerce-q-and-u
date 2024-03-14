import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/controllers/product_detail_controller.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/views/product_detail_view.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:q_and_u_furniture/app/widgets/nodata.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WishlistView extends GetView<WishlistController> {
  WishlistView({Key? key}) : super(key: key);

  final ProductDetailController productController = Get.put(
    ProductDetailController(),
  );
  @override
  final WishlistController loginController = Get.put(WishlistController());
  final CartController cartcontroller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    loginController.fetchWishlist();
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbar(
          leading: Container(),
          title: 'Wishlist (${loginController.wishlistitems.length})',
          trailing: TextButton(
            onPressed: () {
              loginController.deleteAllWishlsit();
            },
            child: Text(
              'Delete All',
              style: subtitleStyle.copyWith(
                color: AppColor.kalaAppMainColor,
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          color: AppColor.kalaAppMainColor,
          onRefresh: () async {
            await Future.delayed(
              const Duration(
                seconds: 1,
              ),
            );
            loginController.fetchWishlist();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(
                () => loginController.isLoading.isFalse
                    ? loginController.wishlistitems.isNotEmpty
                        ? Column(
                            children: [
                              ...List.generate(
                                loginController.wishlistitems.length,
                                (index) {
                                  // var listData = productController.productdetail
                                  //             .value.productDetailsAttribute?[
                                  //         "${productController.selectedColorValue.value}"]
                                  //     [productController
                                  //         .tapedIndexOutside.value];
                                  var data =
                                      loginController.wishlistitems[index];
                                  List<Map<String, dynamic>> options = [];
                                  // for (int i = 0; i < listData.length; i++) {
                                  //   Map<String, dynamic> item = {
                                  //     "id": listData[i]["variant_id"],
                                  //     "title": listData[i]["title"],
                                  //     "value": listData[i]["value"],
                                  //   };
                                  //   options.add(item);
                                  // }
                                  return _buildWishlistTile(
                                    index: index,
                                    slug: data.slug.toString(),
                                    id: data.id!,
                                    img: '${data.images![0].image?.replaceAll(
                                      RegExp(r'http://127.0.0.1:8000'),
                                      url,
                                    )}',
                                    name: data.name.toString(),
                                    price: data.getPrice?.specialPrice ??
                                        data.getPrice?.price ??
                                        0,
                                    rating: data.rating.toString(),
                                    varientId: data.varientId,
                                    quantity: "1",
                                    options: options,
                                  );
                                },
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          )
                        : const NoDataView(text: 'Empty Wishlist')
                    : ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CustomShimmer(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            widget: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 10,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildWishlistTile({
    required int index,
    required int id,
    required String slug,
    required String img,
    required String name,
    required int price,
    required String rating,
    varientId,
    quantity,
    options,
  }) {
    return ListTile(
      onTap: () {
        Get.to(() => ProductDetailView(
              productname: name,
              productprice: price.toString(),
              slug: slug,
            ));
      },
      visualDensity: const VisualDensity(vertical: 4),
      contentPadding: const EdgeInsets.only(bottom: 10),
      leading: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: CachedNetworkImage(
          imageUrl: img,
          fit: BoxFit.contain,
          height: 120,
          width: 100,
          placeholder: (ctx, t) {
            return Image.asset(
              'assets/images/Placeholder.png',
              fit: BoxFit.contain,
            );
          },
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 40.w,
            child: Text(
              name.toString(),
              style: subtitleStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          IconButton(
            onPressed: () async {
              await loginController.removeFromWishList(
                id.toString(),
              );
              loginController.wishlistitems.removeAt(index);
              loginController.fetchWishlist();
            },
            icon: const Icon(
              Icons.close,
            ),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                "Rs.$price",
                style: subtitleStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              Text(
                rating,
                style: subtitleStyle,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              // cartcontroller.addToCart(
              //   id,
              //   price,
              //   '1',
              //   varientId,
              // );
              cartcontroller.addItems(
                productId: id.toString(),
                variantId: varientId,
                quantity: quantity,
                options: options,
              );
            },
            icon: Icon(
              Iconsax.shopping_cart,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}
