import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/data/models/child_category_model.dart';
import 'package:q_and_u_furniture/app/modules/category/controllers/category_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:q_and_u_furniture/app/widgets/product_card.dart';
import 'package:q_and_u_furniture/app/widgets/product_tile.dart';
import 'package:q_and_u_furniture/app/widgets/custom_searchbar.dart';

import '../../../widgets/toast.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../login/controllers/login_controller.dart';
import '../../product_detail/views/product_detail_view.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import '../controllers/department_controller.dart';

class DepartmentView extends GetView<DepartmentController> {
  DepartmentView({this.slug, this.title, Key? key}) : super(key: key);

  final String? slug;
  final String? title;

  @override
  final loginController = Get.put(DepartmentController());

  /*--*/
  final categoryController = Get.put(CategoryController());
  final wishlistcontroller = Get.put(WishlistController());
  final cartController = Get.put(CartController());
  final logcon = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    loginController.fetchChildCategory(slug);

    return Scaffold(
      appBar: CustomAppbar(
        title: title!,
      ),
      body: RefreshIndicator(
        color: AppColor.kalaAppMainColor,
        onRefresh: () async {
          loginController.fetchChildCategory(slug);
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomSearchBar(),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => loginController.loading.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListView.builder(
                            itemCount: 8,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return CustomShimmer(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                widget: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              );
                            }),
                      )
                    : Column(
                        children: [
                          /*For Type Slider*/
                          _buildSubCategories(),
                          _buildTotalResultText(),
                          // _setIndex0Data(),
                          /*For Products Body*/
                          Column(
                            children: [
                              loginController.isListview.value
                                  ? Column(
                                      children: [
                                        ...List.generate(
                                          loginController.products.length,
                                          (index) => loginController
                                                  .loading.value
                                              ? SizedBox(
                                                  height: 100,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10),
                                                    child: ListView.builder(
                                                        itemCount: 5,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return CustomShimmer(
                                                            baseColor: Colors
                                                                .grey.shade300,
                                                            highlightColor:
                                                                Colors.grey
                                                                    .shade100,
                                                            widget: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 8,
                                                              ),
                                                              height: 100,
                                                              width: double
                                                                  .infinity,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                )
                                              : ProductTile(
                                                  price: loginController
                                                      .products[index].price
                                                      .toString(),
                                                  specialprice: loginController
                                                              .products[index]
                                                              .price ==
                                                          'null'
                                                      ? ''
                                                      : loginController
                                                          .products[index]
                                                          .specialPrice
                                                          .toString(),
                                                  productImg:
                                                      '${loginController.products[index].image?.replaceAll(RegExp(r'http://127.0.0.1:8000'), url)}',
                                                  productName: loginController
                                                      .products[index].name,
                                                  rating: loginController
                                                      .products[index].rating,
                                                  onTap: () {
                                                    Get.to(() =>
                                                        ProductDetailView(
                                                          productname:
                                                              loginController
                                                                  .products[
                                                                      index]
                                                                  .name,
                                                          productprice:
                                                              loginController
                                                                  .products[
                                                                      index]
                                                                  .price
                                                                  .toString(),
                                                          slug: loginController
                                                              .products[index]
                                                              .slug,
                                                          productid:
                                                              loginController
                                                                  .products[
                                                                      index]
                                                                  .id,
                                                        ));
                                                  },
                                                  onTapCart: () {
                                                    cartController.addToCart(
                                                      loginController
                                                          .products[index].id,
                                                      loginController
                                                          .products[index].price
                                                          .toString(),
                                                      '1',
                                                      loginController
                                                          .products[index]
                                                          .varientId,
                                                    );
                                                  },
                                                  isFav: wishlistcontroller
                                                          .wishListIdArray
                                                          .contains(
                                                              loginController
                                                                  .products[
                                                                      index]
                                                                  .id)
                                                      ? true
                                                      : false,
                                                  isLoading: true,
                                                  onTapFavorite: () {
                                                    if (logcon.logindata.value
                                                            .read('USERID') !=
                                                        null) {
                                                      if (wishlistcontroller
                                                          .wishListIdArray
                                                          .contains(
                                                              loginController
                                                                  .products[
                                                                      index]
                                                                  .id)) {
                                                        //toastMsg(message: "remove");
                                                        wishlistcontroller
                                                            .removeFromWishList(
                                                                loginController
                                                                    .products[
                                                                        index]
                                                                    .id);
                                                        wishlistcontroller
                                                            .fetchWishlist();
                                                      } else {
                                                        //toastMsg(message: "add");
                                                        wishlistcontroller
                                                            .addToWishList(
                                                                loginController
                                                                    .products[
                                                                        index]
                                                                    .id);
                                                        wishlistcontroller
                                                            .fetchWishlist();
                                                      }
                                                    } else {
                                                      toastMsg(
                                                          message:
                                                              "Please Login to add to wishlist");
                                                    }
                                                  },
                                                ),
                                        ),
                                      ],
                                    )
                                  : GridView.count(
                                      crossAxisCount: 2,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      mainAxisSpacing: 15,
                                      childAspectRatio: Device.orientation ==
                                              Orientation.portrait
                                          ? 0.55
                                          : 1.4,
                                      crossAxisSpacing: 20,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      children: [
                                        ...List.generate(
                                          loginController.products.length,
                                          (index) => Obx(
                                            () => CategoryCard(
                                              ontap: () {
                                                Get.to(() => ProductDetailView(
                                                      productname:
                                                          loginController
                                                              .products[index]
                                                              .name,
                                                      productprice:
                                                          loginController
                                                              .products[index]
                                                              .price
                                                              .toString(),
                                                      slug: loginController
                                                          .products[index].slug,
                                                    ));
                                              },
                                              ontapCart: () {
                                                cartController.addToCart(
                                                  loginController
                                                      .products[index].id,
                                                  loginController
                                                      .products[index].price
                                                      .toString(),
                                                  '1',
                                                  loginController
                                                      .products[index]
                                                      .varientId,
                                                );
                                              },
                                              price: loginController
                                                  .products[index].price
                                                  .toString(),
                                              productImg:
                                                  '${loginController.products[index].image?.replaceAll(RegExp(r'http://127.0.0.1:8000'), url)}',
                                              productName: loginController
                                                  .products[index].name,
                                              rating: loginController
                                                  .products[index].rating,
                                              specialprice: loginController
                                                  .products[index].specialPrice
                                                  .toString(),
                                              isFav: wishlistcontroller
                                                      .wishListIdArray
                                                      .contains(loginController
                                                          .products[index].id)
                                                  ? true
                                                  : false,
                                              ontapFavorite: () {
                                                if (logcon.logindata.value
                                                        .read('USERID') !=
                                                    null) {
                                                  if (wishlistcontroller
                                                      .wishListIdArray
                                                      .contains(loginController
                                                          .products[index]
                                                          .id)) {
                                                    //toastMsg(message: "remove");
                                                    wishlistcontroller
                                                        .removeFromWishList(
                                                            loginController
                                                                .products[index]
                                                                .id);
                                                    wishlistcontroller
                                                        .fetchWishlist();
                                                  } else {
                                                    //toastMsg(message: "add");
                                                    wishlistcontroller
                                                        .addToWishList(
                                                            loginController
                                                                .products[index]
                                                                .id);
                                                    wishlistcontroller
                                                        .fetchWishlist();
                                                  }
                                                } else {
                                                  toastMsg(
                                                      message:
                                                          "Please Login to add to wishlist");
                                                }
                                              },
                                              percent: loginController
                                                          .products[index]
                                                          .percent ==
                                                      null
                                                  ? const SizedBox()
                                                  : Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 10),
                                                      child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 30,
                                                            width: 40,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            06)),
                                                            child: Text(
                                                              '${loginController.products[index].percent}%',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )),
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                            ],
                          )
                        ],
                      ),
              ),
              // _buildTypeSlider(),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              // _buildBody(),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _buildTotalResultText() {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // RichText(
              //     text: TextSpan(children: <TextSpan>[
              //   TextSpan(
              //       text: "${controller.products.length} ",
              //       style: titleStyle.copyWith(
              //           fontSize: 20.sp, fontWeight: FontWeight.bold)),
              //   TextSpan(
              //       text: 'Results Found',
              //       style: titleStyle.copyWith(color: Colors.white))
              // ])),
              IconButton(
                  onPressed: () {
                    loginController.isListview.value =
                        !loginController.isListview.value;
                  },
                  icon: Icon(
                    loginController.isListview.value
                        ? Icons.grid_view_outlined
                        : Icons.format_list_bulleted_outlined,
                    size: 22.sp,
                  )),
            ],
          ),
        ));
  }

  /*void _buildFilterBottomSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      ignoreSafeArea: false,
      Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Filter Product',
                style: titleStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Price Range',
                style: subtitleStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 40.w, child: const MyInputField(hint: 'From')),
                  const Icon(Icons.remove),
                  SizedBox(
                    width: 40.w,
                    child: const MyInputField(hint: 'To'),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Color Family',
                style: subtitleStyle,
              ),
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: [
                  ...List.generate(
                    size.length,
                    (index) => Obx(
                      () => _buildFilterButton(
                        btnClr:
                            controller.selectedSize.value == size[index]['id']
                                ? AppColor.orange
                                : Colors.grey.shade300,
                        txtClr:
                            controller.selectedSize.value == size[index]['id']
                                ? Colors.white
                                : Colors.black,
                        label: size[index]['size'].toString(),
                        ontap: () {
                          controller.selectedSize.value = size[index]['id'];
                        },
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Size',
                style: subtitleStyle,
              ),
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: [
                  ...List.generate(
                    colors.length,
                    (index) => Obx(
                      () => _buildFilterButton(
                        btnClr:
                            controller.selectedColor.value == size[index]['id']
                                ? AppColor.orange
                                : Colors.grey.shade300,
                        txtClr:
                            controller.selectedColor.value == size[index]['id']
                                ? Colors.white
                                : Colors.black,
                        label: size[index]['size'].toString(),
                        ontap: () {
                          controller.selectedColor.value = size[index]['id'];
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Rating',
                style: subtitleStyle,
              ),
              const SizedBox(
                height: 5,
              ),
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: [
                  ...List.generate(
                      5,
                      (index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                  label: 'Apply',
                  btnClr: AppColor.orange,
                  txtClr: Colors.white,
                  ontap: () {})
            ],
          ),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }*/

  /*_buildFilterButton({label, btnClr, txtClr, ontap}) {
    return MaterialButton(
        color: btnClr,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: ontap,
        child: Text(
          label,
          style: subtitleStyle.copyWith(color: txtClr),
        ));
  }*/

  /*void _buildSortBottomSheet() {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
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
  }*/

  _buildSubCategories() {
    /*  controller.products.clear();
    controller.childCategoryData[0]['products']
        .forEach((v) => controller.products.add(Products.fromJson(v)));*/
    return Obx(() => SizedBox(
          height: 40,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: loginController.childCategoryList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Obx(
                    () => MaterialButton(
                        color: loginController.selectedIndex.value == index
                            ? AppColor.kalaAppMainColor
                            : Colors.white,
                        height: 40,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color:
                                    loginController.selectedIndex.value == index
                                        ? AppColor.kalaAppMainColor
                                        : Colors.grey.shade300,
                                width: 1)),
                        child: Text(
                          loginController.childCategoryList[index].title
                              .toString(),
                          style: subtitleStyle.copyWith(
                              color:
                                  loginController.selectedIndex.value == index
                                      ? Colors.white
                                      : Colors.grey.shade600),
                        ),
                        onPressed: () async {
                          loginController.products.clear();
                          /*log("After Products Clear. Products.Length:${controller.products.length}");
                          log("Products::1${jsonEncode(controller.childCategoryList[index].products)}");
                          log("Products::2${jsonEncode(controller.childCategoryData[index]['products'])}");*/

                          loginController.selectedIndex.value = index;
                          if (loginController
                                  .childCategoryList[
                                      loginController.selectedIndex.value]
                                  .products !=
                              null) {
                            loginController.childCategoryData[index]['products']
                                .forEach((v) => loginController.products
                                    .add(Products.fromJson(v)));
                            // controller.products.value =
                            //     controller.childCategoryList[index].products!;
                          }
                          log("END:Products Contained:length:${loginController.products.length}");
                        }),
                  ),
                );
              }),
        ));
  }

/*_setIndex0Data() {
    controller.childCategoryData[0]['products']
        .forEach((v) => controller.products.add(Products.fromJson(v)));
  }*/
}
