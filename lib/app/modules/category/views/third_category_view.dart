import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/category/controllers/category_controller.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/modules/landing/components/sub_category_view.dart';
import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';

class ThirdCategoryView extends StatefulWidget {
  final int childImex;
  final String title;
  final String element;

  const ThirdCategoryView(
      {super.key,
      required this.childImex,
      required this.title,
      required this.element});

  @override
  State<ThirdCategoryView> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ThirdCategoryView> {
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
    controller.fetchChildCategory(widget.element);
    // controller.fetchChildCategory(controller.childcategoryList[widget.childImex].slug);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Obx(
    //       () => controller.childcategoryList[controller.selectedindex.value] == null
    //       ? const NoProductWidget()
    //       :
    return Scaffold(
      appBar: CustomAppbar(title: widget.title),
      body: Obx(
        () {
          return controller.childcategoryList == null
              ? const Text("No data found. ")
              // : GridView.builder(
              //     itemCount: 10,
              //     physics: const BouncingScrollPhysics(),
              //     shrinkWrap: true,
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 3,
              //       childAspectRatio: 1,
              //       crossAxisSpacing: 5,
              //       mainAxisSpacing: 5,
              //     ),
              //     itemBuilder: (context, index) {
              //       return Padding(
              //         padding: const EdgeInsets.all(8),
              //         child: CustomShimmer(
              //           baseColor: Colors.grey.shade300,
              //           highlightColor: Colors.grey.shade100,
              //           widget: Container(
              //             margin: const EdgeInsets.symmetric(horizontal: 8),
              //             padding: const EdgeInsets.symmetric(
              //               horizontal: 8,
              //             ),
              //             height: 750,
              //             width: 150,
              //             decoration: BoxDecoration(
              //               color: Colors.grey,
              //               borderRadius: BorderRadius.circular(5),
              //             ),
              //           ),
              //         ),
              //       );
              //     },
              //   )
              : Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                    ),
                    itemCount: controller.childcategoryList!.length ?? 0,
                    itemBuilder: (context, index) {
                      // var data = controller
                      //     .parentcategoryList[controller.selectedindex.value]
                      //     .subcat![index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.selectedSortingItem.value = "1";
                              Get.to(
                                () => SubCategoryList(
                                  indexWidget: index ?? 0,
                                  title:
                                      '${controller.childcategoryList[index].title}',
                                ),
                              );
                            },
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${controller.childcategoryList[index].image?.replaceAll(
                                  RegExp(r'http://127.0.0.1:8000'),
                                  url,
                                )}',
                              ),
                            ),
                            // CircleAvatar(
                            // radius: 30,
                            // backgroundImage: CachedNetworkImageProvider(
                            // '${controller.childcategoryList[index].image?.replaceAll(
                            // RegExp(r'http://127.0.0.1:8000'),
                            // url,
                            // )}',
                            // ),
                            // ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            controller.childcategoryList[index].title
                                .toString(),
                            textAlign: TextAlign.center,
                            style: subtitleStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )
                        ],
                      );
                    },
                  ),
                );
          // : Container();
        },
      ),
    );
  }
}
