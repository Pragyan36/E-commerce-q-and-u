import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/modules/category/components/category_panel.dart';
import 'package:q_and_u_furniture/app/modules/category/controllers/category_controller.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_searchbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:q_and_u_furniture/app/widgets/no_internet.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
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
      body: Obx(
        () => hasInternet.value
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.top,
                      ),
                      const CustomSearchBar(),
                      const SizedBox(
                        height: 5,
                      ),
                      Obx(
                        () => controller.parentLoading.isTrue
                            ? ListView.builder(
                                itemCount: 5,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return CustomShimmer(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    widget: Container(
                                      // margin: const EdgeInsets.symmetric(
                                      //   horizontal: 8,
                                      //   vertical: 10,
                                      // ),
                                      // padding: const EdgeInsets.symmetric(
                                      //   horizontal: 8,
                                      // ),
                                      height: 100,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CategoryPanel(),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  // CategoryItemsPanel()
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              )
            : const NoInternetLayout(),
      ),
    );
  }
}
