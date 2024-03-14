import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/constants.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/loading_widget.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../category/components/category_details_sub_total.dart';
import '../../category/controllers/category_controller.dart';
import '../../login/controllers/login_controller.dart';
import '../../wishlist/controllers/wishlist_controller.dart';

class CategoryList extends GetView<CategoryController> {
  CategoryList({
    required this.slug,
    required this.title,
    super.key,
  });

  final String slug;
  final String title;
  final wishlistcontroller = Get.put(WishlistController());
  final logcon = Get.put(LoginController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    controller.fetchChildCategory(slug);
    return Scaffold(
      appBar: CustomAppbar(
        title: title,
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return RefreshIndicator(
      color: AppColor.mainClr,
      onRefresh: () async {
        controller.fetchChildCategory(slug);
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Obx(
              () => controller.loading.isFalse
                  ? controller.parentcategoryList[controller.selectedindex.value].subcat != null
                      ? Column(
                          children: [
                            Obx(
                              () => controller.parentcategoryList[controller.selectedindex.value].subcat == null
                                  ? const Center(child: Text("No Data Found."))
                                  : GridView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                      ),
                                      itemCount: controller.parentcategoryList[controller.selectedindex.value].subcat!.length,
                                      itemBuilder: (context, index) {
                                        var element = controller.parentcategoryList[controller.selectedindex.value].subcat![index];
                                        return GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              SecondCategory(
                                                title: element.title,
                                                slug: element.slug,
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: Image.network(
                                                    "${element.image}",
                                                    fit: BoxFit.fill,
                                                    errorBuilder: (
                                                      BuildContext context,
                                                      Object error,
                                                      StackTrace? stackTrace,
                                                    ) {
                                                      return Container(
                                                        width: 40,
                                                        height: 40,
                                                        color: Colors.red,
                                                        child: const Center(
                                                          child: Icon(
                                                            Icons.error,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(15.0),
                                                  child: Text(
                                                    element.title.toString(),
                                                    style: subtitleStyle.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                            const SizedBox(height: 10), // Add some space below the GridView
                            Divider(), // Add a divider below the GridView
                          ],
                        )
                      : const Text('no data')
                  : SizedBox(height: 100.sp, child: const LoadingWidget()),
            ),
          ],
        ),
      ),
    );
  }
}
