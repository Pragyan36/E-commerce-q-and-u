import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/controllers/product_detail_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ImagePreview extends StatefulWidget {
  final String imageUrl;
  const ImagePreview({
    super.key,
    required this.imageUrl,
  });

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  final ProductDetailController controller = Get.put(
    ProductDetailController(),
  );
  final PageController pageController = PageController();

  buildProductImagesCard({
    required String imageUrl,
    required Color borderClr,
    required void Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          width: 40,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderClr,
              width: 1.5,
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
            errorWidget: (context, url, error) {
              return const Icon(Icons.error);
            },
            placeholder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset("assets/images/Placeholder.png"),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).viewPadding.top,
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Obx(
              () => controller.productdetail.value.images != null
                  ? SingleChildScrollView(
                      child: SizedBox(
                        height: Device.orientation == Orientation.portrait
                            ? MediaQuery.of(context).size.height / 1.2
                            : MediaQuery.of(context).size.height / 2,
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).viewPadding.top,
                            ),
                            Expanded(
                              child: PageView.builder(
                                controller: pageController,
                                // physics: const NeverScrollableScrollPhysics(),
                                onPageChanged: (value) {
                                  controller.selectedimg.value = value;
                                },
                                itemCount: controller
                                        .productdetail.value.images?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  return PhotoView(
                                    imageProvider: NetworkImage(
                                      (controller.productdetail.value
                                              .images?[index].image ??
                                          ""),
                                    ),
                                    minScale: PhotoViewComputedScale.contained,
                                    backgroundDecoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ...List.generate(
                                    controller.productdetail.value.images
                                            ?.length ??
                                        0,
                                    (index) {
                                      return buildProductImagesCard(
                                        imageUrl: controller.productdetail.value
                                                .images?[index].image ??
                                            "",
                                        borderClr:
                                            controller.selectedimg.value ==
                                                    index
                                                ? AppColor.kalaAppMainColor
                                                : Colors.transparent,
                                        onTap: () {
                                          controller.selectedimg.value = index;
                                          pageController.animateToPage(
                                            index,
                                            duration: const Duration(
                                              milliseconds: 500,
                                            ),
                                            curve: Curves.easeInOutCubic,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
