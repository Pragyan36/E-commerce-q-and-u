import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:q_and_u_furniture/app/widgets/circular_icons.dart';
import 'package:q_and_u_furniture/app/widgets/product_card.dart';

import '../../../constants/constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/product_tile.dart';
import '../../../widgets/custom_searchbar.dart';
import '../../../widgets/toast.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../category/controllers/category_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../login/controllers/login_controller.dart';
import '../../product_detail/views/product_detail_view.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import '../controllers/view_all_controller.dart';

class ViewAllView extends GetView<ViewAllController> {
  ViewAllView({Key? key}) : super(key: key);
  final categoryController = Get.put(CategoryController());
  final cartcontroller = Get.put(CartController());
  final wishlistcontroller = Get.put(WishlistController());
  final logcon = Get.put(LoginController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var data = homeController.specificFeaturedProductData.value.first;
    log("abc: ${data.isNull}");
    return Scaffold(
        appBar: _buildAppbar(),
        body: Obx(
          () => categoryController.isListview.value
              ? ListView.builder(
                  itemCount: /*data.featuredProducts?.length*/ 10,
                  itemBuilder: (context, index) {
                    //var product = data.featuredProducts?[index];
                    return Obx(
                      () => ProductTile(
                        bestseller: false,
                        price: /*product?.getPrice?.price.toString()*/ "100",
                        specialprice:
                            /*product?.getPrice?.specialPrice.toString()*/ "110",
                        productImg:
                            /*'${product?.images![index].image?.replaceAll(RegExp(r'http://127.0.0.1:8000'), url)}'*/ "",
                        productName: /*product?.name*/ "Samsung A13",
                        rating: /*product?.rating.toString()*/ "3.5",
                        onTap: () {
                          Get.to(() => const ProductDetailView(
                                // productname:
                                //     products[index]['product_name'].toString(),
                                // productprice:
                                //     products[index]['product_price'].toString(),
                                productid: /*product?.id*/ 1,
                                slug: /*product?.slug*/ "",
                              ));
                        },
                        onTapCart: () {
                          // var data = products[index];
                          cartcontroller.addToCart(
                            /*product?.id*/ 1,
                            /*product?.getPrice?.price*/ 100,
                            '1',
                            '1',
                          );
                          //toastMsg(message: 'Added to cart');
                        },
                        isFav: wishlistcontroller.wishListIdArray
                                .contains(/*product?.id*/ 1)
                            ? true
                            : false,
                        onTapFavorite: () {
                          if (logcon.logindata.value.read('USERID') != null) {
                            if (wishlistcontroller.wishListIdArray
                                .contains(/*product?.id*/ 1)) {
                              //toastMsg(message: "remove");
                              wishlistcontroller
                                  .removeFromWishList(/*product?.id*/ 1);
                              wishlistcontroller.fetchWishlist();
                            } else {
                              //toastMsg(message: "add");
                              wishlistcontroller
                                  .addToWishList(/*product?.id*/ 1);
                              wishlistcontroller.fetchWishlist();
                            }
                          } else {
                            toastMsg(
                                message: "Please Login to add to wishlist");
                          }
                        },
                      ),
                    );
                  })
              : GridView.builder(
                  physics: const ClampingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: Device.orientation == Orientation.portrait
                        ? 3 / 5
                        : 1.4,
                  ),
                  itemCount: /*data.featuredProducts?.length*/ 10,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const CategoryCard(productImg: "");
                    /*return CategoryProductCard(
              data: data.products![index],
              // position: controller.selectedImg.value.toDouble(),
            );*/
                  },
                ),
        ));
  }

  _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          padding: const EdgeInsets.only(right: 10),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
            size: 20,
          )),
      title: Container(
        width: 80.w,
        padding: const EdgeInsets.only(top: 10, right: 20),
        child: const CustomSearchBar(),
      ),
      bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "22 Results",
                  style: titleStyle,
                ),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => _buildbutton(
                          icon: categoryController.isListview.value
                              ? Icons.list
                              : Icons.grid_view_outlined,
                          title: 'View',
                          ontap: () {
                            _buildCategoryFilter();
                          }),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildbutton(
                        icon: Icons.sort,
                        title: 'Sort',
                        ontap: () {
                          _buildSortBottomSheet();
                        }),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildbutton(
                        icon: Icons.filter_list,
                        title: 'Filter',
                        ontap: () {
                          _buildFilterBottomSheet();
                        }),
                  ],
                )
              ],
            ),
          )),
    );
  }

  _buildbutton({icon, title, ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black54,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: subtitleStyle,
          )
        ],
      ),
    );
  }

  void _buildCategoryFilter() {
    Get.bottomSheet(
      isScrollControlled: true,
      ignoreSafeArea: false,
      Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomCircularIcon(),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('List View'),
              onTap: () {
                categoryController.isListview(true);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.grid_view_outlined),
              title: const Text('Grid View'),
              onTap: () {
                categoryController.isListview(false);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _buildSortBottomSheet() {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomCircularIcon(),
              ListTile(
                title: Text(
                  'Price Low to High',
                  style: subtitleStyle,
                ),
                leading: const Icon(
                  Icons.arrow_upward_outlined,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: Text(
                  'Price High to Low',
                  style: subtitleStyle,
                ),
                leading: const Icon(
                  Icons.arrow_downward_outlined,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  void _buildFilterBottomSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      ignoreSafeArea: false,
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomCircularIcon(),
              Text(
                'Filter by',
                style: titleStyle,
              ),
              ExpansionTile(
                title: Text(
                  'Delivery Type',
                  style: titleStyle,
                ),
              ),
              ExpansionTile(
                title: Text(
                  'Category',
                  style: titleStyle,
                ),
              ),
              ExpansionTile(
                title: Text(
                  'Brand',
                  style: titleStyle,
                ),
              ),
              CustomButton(
                  label: 'Apply',
                  btnClr: AppColor.kalaAppMainColor,
                  txtClr: Colors.white,
                  ontap: () {})
            ],
          ),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
