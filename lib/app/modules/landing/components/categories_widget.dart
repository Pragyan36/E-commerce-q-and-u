import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/category/controllers/category_controller.dart';
import 'package:q_and_u_furniture/app/modules/category/views/category_dashboard.dart';
import 'package:q_and_u_furniture/app/modules/category/views/second_category_view.dart';
import 'package:q_and_u_furniture/app/widgets/custom_section_header.dart';

class CategoriesWidget extends StatefulWidget {
  final CategoryController categoryController;

  const CategoriesWidget({
    super.key,
    required this.categoryController,
  });

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.categoryController.parentcategoryList.length > 3) {
      itemCount = 3;
    } else {
      itemCount = widget.categoryController.parentcategoryList.length;
    }

    return widget.categoryController.parentcategoryList.isNotEmpty
        ? Column(
            children: [
              CustomSectionHeader(
                headerName: "Check out these categories",
                onViewAllTapped: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LatestCategoryViewAllScreen();
                      },
                    ),
                  );
                },
                shouldViewAll: true,
              ),
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                removeBottom: true,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        // await widget.categoryController.fetchChildCategory(
                        //   widget.categoryController.parentcategoryList[index]
                        //       .slug,
                        // );
                        widget.categoryController.selected.value = widget
                            .categoryController.parentcategoryList[index].id!
                            .toInt();
                        widget.categoryController.selectedindex.value =
                            index.toInt();
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

                        // Get.to(() =>
                        //     //  CategoryList(
                        //     //   slug:
                        //     //       "${widget.categoryController.parentcategoryList[index].slug}",
                        //     //   title:
                        //     //       '${widget.categoryController.parentcategoryList[index].title}',
                        //     // ),
                        //     ChildCategoryViewAllScreen(
                        //       childImex: index,
                        //       title:
                        //           '${widget.categoryController.parentcategoryList[index].title} ',
                        //       element:
                        //           '${widget.categoryController.parentcategoryList[index].slug}',
                        //     ));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 170,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Image.network(
                                        widget
                                                .categoryController
                                                .parentcategoryList[index]
                                                .image ??
                                            "",
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.error,
                                                color:
                                                    AppColor.kalaAppMainColor,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text("Oops! No Image"),
                                            ],
                                          );
                                        },
                                        fit: BoxFit.cover,
                                        height: 170,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: Container(
                                        height: 170,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.black.withOpacity(0.01),
                                              Colors.black.withOpacity(0.5),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          widget
                                                  .categoryController
                                                  .parentcategoryList[index]
                                                  .title ??
                                              "N/A",
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 5,
                    );
                  },
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}
