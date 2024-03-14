import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/modules/category/controllers/category_controller.dart';
import 'package:q_and_u_furniture/app/modules/category/views/second_category_view.dart';
import 'package:q_and_u_furniture/app/modules/home/components/sliver_grid.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:q_and_u_furniture/app/widgets/category_card.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:q_and_u_furniture/app/widgets/no_product_widget.dart';

class LatestCategoryViewAllScreen extends StatefulWidget {
  const LatestCategoryViewAllScreen({super.key});

  @override
  State<LatestCategoryViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<LatestCategoryViewAllScreen> {
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
  void dispose() {
    controller.selected.value = controller.parentcategoryList[0].id!.toInt();
    super.dispose();
  }

  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Categories",
      ),
      body: Obx(
        () {
          return !hasInternet.value
              ? GridView.builder(
                  itemCount: 6,
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
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
                )
              : controller.parentcategoryList == null
                  ? const NoProductWidget()
                  : GridView.builder(
                      itemCount: 5,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        height: 270,
                      ),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CategoryCard(
                              categoryImg: (controller
                                      .parentcategoryList[index].image) ??
                                  "",
                              categoryName: (controller
                                  .parentcategoryList[index].title
                                  .toString()),
                              ontap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SecondCategoryView(
                                        subIndex: index,
                                      );
                                    },
                                  ),
                                );
                                // Get.to(
                                //   () => SubCategoryList(
                                //     indexWidget: index,
                                //     title:
                                //         '${controller.parentcategoryList[controller.selectedindex.value].subcat![index].title}',
                                //   ),
                                // );
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) {
                                //       return SubCategoryViewAllScreen(
                                //         subIndex: index,
                                //       );
                                //     },
                                //   ),
                                // );
                              },
                            ),
                          ],
                        );
                      },
                    );
        },
      ),
    );
  }
}
