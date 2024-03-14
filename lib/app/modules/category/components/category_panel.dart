import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/modules/category/components/category_item_panel.dart';
import 'package:q_and_u_furniture/app/modules/category/controllers/category_controller.dart';
import 'package:q_and_u_furniture/app/modules/home/components/sliver_grid.dart';
import 'package:q_and_u_furniture/app/modules/landing/components/sub_category_view.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/views/login_view.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/views/product_detail_view.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:q_and_u_furniture/app/widgets/loading_widget.dart';
import 'package:q_and_u_furniture/app/widgets/no_product_widget.dart';
import 'package:q_and_u_furniture/app/widgets/product_card.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';
import 'package:q_and_u_furniture/app/widgets/toast.dart';

class CategoryPanel extends StatefulWidget {
  const CategoryPanel({Key? key}) : super(key: key);

  @override
  State<CategoryPanel> createState() => _CategoryPanelState();
}

class _CategoryPanelState extends State<CategoryPanel> {
  final CategoryController controller = Get.put(CategoryController());

  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        // Adjust the border radius as needed
        child: Obx(
          () => ListView.builder(
            primary: false,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.parentcategoryList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final bool isExpanded = _expandedIndex == index;

              return ExpansionPanelList(
                //
                expansionCallback: (int panelIndex, bool isExpanded) {
                  setState(() {
                    _expandedIndex = _expandedIndex == index ? null : index;
                    print("this is index $index");
                    controller.selectedindex.value = index;
                  });
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      // var imageUrl = controller.parentcategoryList[index].image;
                      // print("Image URL: $imageUrl");
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          onTap: () {
                            controller.childcategoryList.value.clear();
                            controller.fetchChildCategory(
                                "${controller.parentcategoryList[index].slug}");

                            Get.to(
                              MainCategoryList(
                                title: controller
                                    .parentcategoryList[index].title
                                    .toString(),
                                indexValue: 0,
                              ),
                            );
                          },
                          leading:
                              controller.parentcategoryList[index].image == null
                                  ? SizedBox(
                                      height: 35,
                                      width: 35,
                                        child: Image.asset(
                                          AppImages.nocategory,
                                          // width: 100,
                                        ),

                                    )
                                  : Image.network(
                                      "${controller.parentcategoryList[index].image}",
                                      height: 35,
                                      width: 35,

                                    ),
                          title: Text(
                            controller.parentcategoryList[index].title
                                .toString(),
                            style: subtitleStyle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                    body: isExpanded
                        ? const CategoryItemsPanel()
                        : const SizedBox(),
                    isExpanded: isExpanded,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class MainCategoryList extends GetView<CategoryController> {
  MainCategoryList({
    required this.indexValue,
    required this.title,
    super.key,
  });

  final int indexValue;
  final String title;
  final wishlistcontroller = Get.put(WishlistController());
  final logcon = Get.put(LoginController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: title),
      body: Obx(
        () {
          return controller.childcategoryList.value == null
              ? Container()
              : controller.loading.value == true
                  ? const LoadingWidget()
                  : controller.childcategoryList![indexValue].products!.isEmpty
                      ? const NoProductWidget()
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
                            itemCount: controller.childcategoryList![indexValue]
                                    .products!.length ??
                                0,
                            itemBuilder: (context, index) {
                              // var data = controller
                              //     .parentcategoryList[controller.selectedindex.value]
                              //     .subcat![index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.selectedSortingItem.value =
                                          "1";
                                      Get.to(
                                        () => SubCategoryList(
                                          indexWidget: index ?? 0,
                                          title:
                                              '${controller.childcategoryList![indexValue].products![index].name}',
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            '${controller.childcategoryList![indexValue].products![index].image?.replaceAll(
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
                                    controller.childcategoryList![indexValue]
                                        .products![index].name
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
