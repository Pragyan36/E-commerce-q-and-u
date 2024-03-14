import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TestTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar? tabBar;
  final landingcon = Get.put(
    LandingController(),
  );

  TestTabBarDelegate({
    this.tabBar,
  });

  @override
  double get minExtent => 100;

  @override
  double get maxExtent => 100;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Obx(
      () {
        return Container(
          color: Colors.white,
          child: DefaultTabController(
            length: landingcon.justForYouTagsList.length,
            child: Obx(
              () => landingcon.tagsLoading.isTrue
                  ? DefaultTabController(
                      length: 4,
                      child: TabBar(
                        labelColor: AppColor.kalaAppSecondaryColor,
                        indicatorColor: AppColor.kalaAppSecondaryColor,
                        tabs: [
                          CustomShimmer(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            widget: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          CustomShimmer(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            widget: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          CustomShimmer(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            widget: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          CustomShimmer(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            widget: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : TabBar(

                      key: const PageStorageKey<Type>(TabBar),
                      labelColor: AppColor.kalaAppSecondaryColor,
                      indicatorColor: AppColor.kalaAppSecondaryColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: subtitleStyle.copyWith(fontSize: 12.sp),
                      unselectedLabelColor: Colors.grey,
                      splashBorderRadius: BorderRadius.circular(50),
                      isScrollable: true,
                      padding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      onTap: (value) async {
                        if (await Connectivity().checkConnectivity() ==
                            ConnectivityResult.none) {
                          getSnackbar(
                            message: "No Internet Connection",
                            error: true,
                            bgColor: Colors.red,
                          );
                          return;
                        }
                        landingcon.selectedSlug.value =
                            landingcon.justForYouTagsList[value].slug.toString();
                      },
                      tabs: [
                        ...List.generate(
                          landingcon.justForYouTagsList.length,
                          (index) => SizedBox(
                            height: 100,
                            width: 100,
                            child: Tab(
                              iconMargin: const EdgeInsets.only(right: 40),
                              icon: Column(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: landingcon
                                        .justForYouTagsList[index].image
                                        .toString(),
                                    height: 68,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          scale: 2,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.shade300,
                                        ),
                                        padding: const EdgeInsets.all(100),
                                        child: Image.asset(
                                          "assets/images/Placeholder.png",
                                          height: 20,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      "assets/images/Placeholder.png",
                                      height: 20,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    height: 02,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      landingcon.justForYouTagsList[index].title
                                          .toString(),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: subtitleStyle.copyWith(
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool shouldRebuild(covariant TestTabBarDelegate oldDelegate) {
    return false;
  }
}
