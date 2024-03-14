import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/category/controllers/category_controller.dart';
import 'package:q_and_u_furniture/app/modules/category/views/third_category_view.dart';
import 'package:q_and_u_furniture/app/modules/home/components/sliver_grid.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:q_and_u_furniture/app/widgets/category_card.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_section_header.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:q_and_u_furniture/app/widgets/no_product_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SecondCategoryView extends StatefulWidget {
  final int subIndex;

  const SecondCategoryView({super.key, required this.subIndex});

  @override
  State<SecondCategoryView> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<SecondCategoryView> {
  final controller = Get.put(CategoryController());
  final homecon = Get.put(HomeController());

  var hasInternet = false.obs;

  void checkInternet() async {
    if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
      hasInternet.value = false;
    } else {
      hasInternet.value = true;
    }
  }

  final LandingController landingController = Get.put(
    LandingController(),
  );
  final WishlistController wishlistController = Get.put(
    WishlistController(),
  );
  final LoginController loginController = Get.put(
    LoginController(),
  );

  @override
  void initState() {
    controller.childcategoryList.value.clear();
    controller.fetchChildCategory(
        controller.parentcategoryList[widget.subIndex].slug);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "${controller.parentcategoryList[widget.subIndex].title}",
      ),
      body: Obx(
        () {
          return SingleChildScrollView(
            child: Column(
              children: [
                _banner(),
                CustomSectionHeader(
                  headerName:
                      "${controller.parentcategoryList[widget.subIndex].title} Categories",
                  onViewAllTapped: () {},
                  shouldViewAll: false,
                ),
                loginController.loading.value == true
                    ? _loading()
                    : controller.childcategoryList == null
                        ? const SizedBox()
                        : controller
                                    .parentcategoryList[
                                        controller.selectedindex.value]
                                    .subcat ==
                                null
                            ? const NoProductWidget()

                            // : controller.childcategoryList.length == 1
                            //     ? const NoProductWidget()// Show when list is empty
                            : _viewCategories(),
              ],
            ),
          );
        },
      ),
    );
  }

  _banner() {
    return Obx(
      () => SizedBox(
        height: 25.h,
        width: 100.w,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: GestureDetector(
              onTap: () {
                // if (data.id == 7) {
                //   homeController.makeUrl(data.link.toString());
                // } else {
                //   var splitData = data.link.toString();
                //   var split = splitData.split('/').last;
                //   if (kDebugMode) {
                //     print(split);
                //   }
                //   Get.to(() => ProductDetailView(
                //         productname: data.title,
                //         productprice: data.id.toString(),
                //         slug: split,
                //         productid: data.id,
                //       ));
                // }
              },
              child: CachedNetworkImage(
                imageUrl: landingController.sliderlist[0].altImage != null
                    ? landingController.sliderlist[0].altImage!
                        .replaceAll(RegExp(r'http://127.0.0.1:8000'), url)
                    : '',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                placeholder: (context, url) => SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey.shade300),
                      padding: const EdgeInsets.all(50),
                      child: Image.asset("assets/images/Placeholder.png"),
                    )),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/images/Placeholder.png",
                  height: 70,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _loading() {
    return GridView.builder(
      itemCount: controller.childcategoryList.length ?? 0,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        height: 190,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: CustomShimmer(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            widget: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 750,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        );
      },
    );
  }

  _viewCategories() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: controller.parentcategoryList[widget.subIndex].subcat!.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        height: 230,
      ),
      itemBuilder: (context, index) {
        var data =
            controller.parentcategoryList[widget.subIndex].subcat![index];
        return Column(
          children: [
            CategoryCard(
              categoryImg:
                  '${data.image?.replaceAll(RegExp(r'http://127.0.0.1:8000'), url)}',
              categoryName: '${data.title}',
              ontap: () {
                var element = controller
                    .parentcategoryList[controller.selectedindex.value]
                    .subcat![index];

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ThirdCategoryView(
                        childImex: index,
                        title: data.title ?? "",
                        element: '${element.slug}',
                      );
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
