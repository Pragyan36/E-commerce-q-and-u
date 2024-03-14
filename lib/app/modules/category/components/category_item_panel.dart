import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/data/models/parent_category_model.dart';
import 'package:q_and_u_furniture/app/modules/category/components/category_details_sub_total.dart';
import 'package:q_and_u_furniture/app/modules/category/controllers/category_controller.dart';
import 'package:q_and_u_furniture/app/modules/landing/components/sub_category_view.dart';
import 'package:q_and_u_furniture/app/widgets/no_product_widget.dart';

class CategoryItemsPanel extends StatefulWidget {
  final Subcat? data;

  const CategoryItemsPanel({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  State<CategoryItemsPanel> createState() => _CategoryItemsPanelState();
}

class _CategoryItemsPanelState extends State<CategoryItemsPanel> {
  final controller = Get.put(
    CategoryController(),
  );

  @override
  void initState() {
    // controller.selectedindex.value = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Obx(
            () => controller.parentcategoryList[controller.selectedindex.value]
                        .subcat ==
                    null
                ? const NoProductWidget()
                : ExpansionPanelList(
                    animationDuration: const Duration(
                      milliseconds: 500,
                    ),
                    elevation: 1,
                    expandIconColor: Colors.green,
                    expandedHeaderPadding: EdgeInsets.zero,
                    children: controller
                        .parentcategoryList[controller.selectedindex.value]
                        .subcat!
                        .asMap()
                        .entries
                        .map<ExpansionPanel>(
                      (entry) {
                        final index = entry.key;
                        final element = entry.value;
                        return ExpansionPanel(
                          headerBuilder: (
                            BuildContext context,
                            bool isExpanded,
                          ) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                leading: SizedBox(
                                  height: 35,
                                  width: 35,
                                  child: Image.network(
                                    "${element.image}",
                                    fit: BoxFit.fill,
                                    errorBuilder: (
                                      BuildContext context,
                                      Object error,
                                      StackTrace? stackTrace,
                                    ) {
                                      return Container(
                                        height: 35,
                                        width: 35,
                                        // color: Colors.red,
                                        child: Center(
                                          child: Image.asset(
                                            AppImages.nocategory,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Text(
                                    element.title.toString(),
                                    style: subtitleStyle.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                // trailing: IconButton(
                                //   onPressed: () async {
                                //     final element = controller
                                //         .parentcategoryList[
                                //             controller.selectedindex.value]
                                //         .subcat![index];
                                //     await controller
                                //         .fetchChildCategory(element.slug);
                                //     // await controller.fetchChildCategory(element.slug);
                                //     setState(() {
                                //       if (controller.selectedExpand.value ==
                                //           index) {
                                //         controller.selectedExpand.value = -1;
                                //       } else {
                                //         controller.selectedExpand.value = index;
                                //       }
                                //     });
                                //   },
                                //   icon: Icon(
                                //     isExpanded ? Icons.remove : Icons.add,
                                //     color: Colors.black,
                                //   ),
                                // ),
                                onTap: () {
                                  Get.to(
                                    SecondCategory(
                                      title: element.title,
                                      slug: element.slug,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          body: controller.selectedExpand.value == index
                              ? controller.childcategoryList == null
                                  ? const Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: NoProductWidget(),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 1,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5,
                                        ),
                                        itemCount: controller
                                                .childcategoryList.length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          var data = controller
                                              .childcategoryList[index];
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  controller.selectedSortingItem
                                                      .value = "1";
                                                  Get.to(
                                                    () => SubCategoryList(
                                                      indexWidget: index,
                                                      title: '${data.title}',
                                                    ),
                                                  );
                                                },
                                                child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(
                                                    '${controller.childcategoryList[index].image?.replaceAll(
                                                      RegExp(
                                                          r'http://127.0.0.1:8000'),
                                                      url,
                                                    )}',
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                controller
                                                    .childcategoryList![index]
                                                    .title
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
                                    )
                              : Container(),
                          canTapOnHeader: false,
                          isExpanded: controller.selectedExpand.value == index,
                        );
                      },
                    ).toList(),
                    expansionCallback: (
                      int index,
                      bool isExpanded,
                    ) async {
                      final element = controller
                          .parentcategoryList[controller.selectedindex.value]
                          .subcat![index];
                      await controller.fetchChildCategory(element.slug);
                      // await controller.fetchChildCategory(element.slug);
                      setState(() {
                        if (controller.selectedExpand.value == index) {
                          controller.selectedExpand.value = -1;
                        } else {
                          controller.selectedExpand.value = index;
                        }
                      });
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
