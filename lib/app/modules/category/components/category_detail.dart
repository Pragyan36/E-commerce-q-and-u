import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:q_and_u_furniture/app/data/models/child_category_model.dart';
import 'package:q_and_u_furniture/app/widgets/circular_icons.dart';
import 'package:q_and_u_furniture/app/widgets/loading_widget.dart';
import 'package:q_and_u_furniture/app/widgets/nodata.dart';

import '../../../constants/constants.dart';
import '../../../widgets/category_product_card.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/product_tile.dart';
import '../../../widgets/custom_searchbar.dart';
import '../../../widgets/toast.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../login/controllers/login_controller.dart';
import '../../product_detail/views/product_detail_view.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import '../controllers/category_controller.dart';

class CategoryDetail extends StatefulWidget {
  const CategoryDetail({Key? key, required this.data}) : super(key: key);

  final Category data;

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  final controller = Get.put(CategoryController());

  final cartcontroller = Get.put(CartController());

  final wishlistcontroller = Get.put(WishlistController());

  final logcon = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: Obx(
        () => controller.sortTapped == true
            ? SortedData(sortedData: controller.sortProducts.value)
            : widget.data.products?.length != null
                ? Obx(() => controller.isListview.value
                    ?
                    // Text(data.products!.length.toString())
                    ListView.builder(
                        itemCount: widget.data.products?.length,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var product = widget.data.products?[index];
                          return
                              //  Text(product!.name.toString());
                              Obx(
                            () => ProductTile(
                              bestseller: false,
                              price: product?.price.toString(),
                              specialprice: product?.specialPrice.toString(),
                              productImg:
                                  '${product?.image?.replaceAll(RegExp(r'http://127.0.0.1:8000'), url)}',
                              productName: product?.name,
                              rating: product?.rating.toString(),
                              onTap: () {
                                Get.to(() => ProductDetailView(
                                      productid: product?.id,
                                      slug: product?.slug,
                                    ));
                              },
                              onTapCart: () {
                                // var data = products[index];
                                cartcontroller.addToCart(product?.id,
                                    product?.price, '1', product?.varientId);
                                //toastMsg(message: 'Added to cart');
                              },
                              isFav: wishlistcontroller.wishListIdArray
                                      .contains(product?.id)
                                  ? true
                                  : false,
                              onTapFavorite: () {
                                if (logcon.logindata.value.read('USERID') !=
                                    null) {
                                  if (wishlistcontroller.wishListIdArray
                                      .contains(product?.id)) {
                                    //toastMsg(message: "remove");
                                    wishlistcontroller
                                        .removeFromWishList(product?.id);
                                    wishlistcontroller.fetchWishlist();
                                  } else {
                                    //toastMsg(message: "add");
                                    wishlistcontroller
                                        .addToWishList(product?.id);
                                    wishlistcontroller.fetchWishlist();
                                  }
                                } else {
                                  toastMsg(
                                      message:
                                          "Please Login to add to wishlist");
                                }
                              },
                            ),
                          );
                        })
                    : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio:
                              Device.orientation == Orientation.portrait
                                  ? 3 / 5
                                  : 1.4,
                        ),
                        itemCount: widget.data.products?.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CategoryProductCard(
                            data: widget.data.products![index],

                            // position: controller.selectedImg.value.toDouble(),
                          );
                        },
                      ))
                : const NoDataView(text: 'No data'),
      ),
    );
  }

  _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            Get.back();
            controller.sortTapped(false);
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
                  // Text(
                  //   widget.data.products?.length == null
                  //       ? '0 Results'
                  //       : "${widget.data.products?.length} Results",
                  //   style: titleStyle,
                  // ),
                  const Spacer(),
                  widget.data.products?.length != null
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(
                              () => _buildbutton(
                                  icon: controller.isListview.value
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
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            // _buildbutton(
                            //     icon: Icons.filter_list,
                            //     title: 'Filter',
                            //     ontap: () {
                            //       _buildFilterBottomSheet();
                            //     }),
                          ],
                        )
                      : const SizedBox(),
                ],
              ))),
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
                controller.isListview(true);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.grid_view_outlined),
              title: const Text('Grid View'),
              onTap: () {
                controller.isListview(false);
                Get.back();
              },
            ),
            const SizedBox(
              height: 50,
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
              Obx(
                () => ListTile(
                  title: Text(
                    'Default',
                    style: subtitleStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: controller.selectedSortingItem.value == "1"
                            ? Colors.green
                            : Colors.black45),
                  ),
                  leading: const Icon(
                    Icons.arrow_upward_outlined,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Get.back();
                    controller.sortTapped(false);
                    controller.selectedSortingItem.value = "1";
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: Text(
                  'Price Low to High',
                  style: TextStyle(
                      color: controller.selectedSortingItem.value == "2"
                          ? Colors.green
                          : Colors.black45),
                ),
                leading: const Icon(
                  Icons.arrow_upward_outlined,
                  color: Colors.black,
                ),
                onTap: () {
                  controller.sortTapped(false);
                  controller.fetchSortProduct(widget.data.id, 'low');
                  controller.selectedSortingItem.value = "2";
                  Get.back();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: Text(
                  'Price High to Low',
                  style: TextStyle(
                      color: controller.selectedSortingItem.value == "3"
                          ? Colors.green
                          : Colors.black45),
                ),
                leading: const Icon(
                  Icons.arrow_downward_outlined,
                  color: Colors.black,
                ),
                onTap: () {
                  controller.sortTapped(false);
                  controller.fetchSortProduct(widget.data.id, 'high');
                  controller.selectedSortingItem.value = "3";
                  Get.back();
                },
              ),
              const SizedBox(
                height: 50,
              ),
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

class SortedData extends StatefulWidget {
  const SortedData({super.key, required this.sortedData});

  final Category sortedData;

  @override
  State<SortedData> createState() => _SortedDataState();
}

class _SortedDataState extends State<SortedData> {
  final controller = Get.put(CategoryController());

  final cartcontroller = Get.put(CartController());

  final wishlistcontroller = Get.put(WishlistController());

  final logcon = Get.put(LoginController());

  @override
  void initState() {
    print("xiryo 12345");
    print("xiryo 12345");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading == true
          ? const Center(
              child: LoadingWidget(),
            )
          : widget.sortedData.products?.length != null
              ? Obx(() => controller.isListview.value
                  ?
                  // Text(data.products!.length.toString())
                  ListView.builder(
                      itemCount: widget.sortedData.products?.length,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var product = widget.sortedData.products?[index];
                        return
                            //  Text(product!.name.toString());
                            Obx(
                          () => ProductTile(
                            bestseller: false,
                            price: product?.price.toString(),
                            specialprice: product?.specialPrice.toString(),
                            productImg:
                                '${product?.image?.replaceAll(RegExp(r'http://127.0.0.1:8000'), url)}',
                            productName: product?.name,
                            rating: product?.rating.toString(),
                            onTap: () {
                              Get.to(() => ProductDetailView(
                                    // productname:
                                    //     products[index]['product_name'].toString(),
                                    // productprice:
                                    //     products[index]['product_price'].toString(),
                                    productid: product?.id,
                                    slug: product?.slug,
                                  ));
                            },
                            onTapCart: () {
                              // var data = products[index];
                              cartcontroller.addToCart(
                                product?.id,
                                product?.price,
                                '1',
                                '1',
                              );
                              //toastMsg(message: 'Added to cart');
                            },
                            isFav: wishlistcontroller.wishListIdArray
                                    .contains(product?.id)
                                ? true
                                : false,
                            onTapFavorite: () {
                              if (logcon.logindata.value.read('USERID') !=
                                  null) {
                                if (wishlistcontroller.wishListIdArray
                                    .contains(product?.id)) {
                                  //toastMsg(message: "remove");
                                  wishlistcontroller
                                      .removeFromWishList(product?.id);
                                  wishlistcontroller.fetchWishlist();
                                } else {
                                  //toastMsg(message: "add");
                                  wishlistcontroller.addToWishList(product?.id);
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio:
                            Device.orientation == Orientation.portrait
                                ? 3 / 5
                                : 1.4,
                      ),
                      itemCount: widget.sortedData.products?.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CategoryProductCard(
                          data: widget.sortedData.products![index],

                          // position: controller.selectedImg.value.toDouble(),
                        );
                      },
                    ))
              : const NoDataView(text: 'No data'),
    );
  }
}
