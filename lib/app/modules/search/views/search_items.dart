import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';
import 'package:q_and_u_furniture/app/modules/search/components/brand_products.dart';
import 'package:q_and_u_furniture/app/modules/search/components/search_result.dart';
import 'package:q_and_u_furniture/app/modules/search/controllers/search_controller.dart';
import 'package:q_and_u_furniture/app/modules/search/views/qr_scanner.dart';
import 'package:q_and_u_furniture/app/widgets/nodata.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchItems extends StatefulWidget {
  const SearchItems({Key? key}) : super(key: key);

  @override
  State<SearchItems> createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  late ScrollController scrollcontroller;

  final controller = Get.put(CustomSearchController());
  final landingcontroller = Get.put(LandingController());

  @override
  void initState() {
    controller.searchtxt.clear();
    scrollcontroller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (scrollcontroller.position.pixels ==
        (scrollcontroller.position.maxScrollExtent)) {
      print("sceoll${scrollcontroller.position.pixels}");
      landingcontroller.loadMore();
    }
    // if (scrollcontroller.position.extentAfter > 2300) {
    //   print('min scroll extent');
    //   controller.tapdown(true);
    // } else if (scrollcontroller.position.extentAfter < 2300) {
    //   controller.tapdown(false);
    // }
  }

  @override
  void dispose() {
    landingcontroller.page.value = 1;
    scrollcontroller.dispose();
    Get.delete<CustomSearchController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchAttributes();
    return WillPopScope(
        onWillPop: () async {
          Get.back();
          Get.back();
          controller.searchtxt.clear();
          return true;
        },
        child: Scaffold(
          body: SingleChildScrollView(
            controller: scrollcontroller,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                          Get.back();
                          controller.searchtxt.clear();
                        },
                        borderRadius: BorderRadius.circular(50),
                        child: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.black45,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 80.w,
                        height: 40,
                        child: Obx(
                          () => TextField(
                            controller: controller.searchtxt,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (val) {
                              controller.searchList.clear();
                              controller.fetchSearch();
                            },
                            autofocus: true,
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 12,
                              ),
                              hintText: 'Search...',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: AppColor.kalaAppMainColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      Get.to(
                                        () => const QrScannerVIew(),
                                      );
                                    },
                                    icon: const Icon(
                                      Iconsax.scan_barcode,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      controller.listen();
                                    },
                                    icon: Icon(
                                      controller.isListening.value
                                          ? Icons.settings_voice_outlined
                                          : Icons.keyboard_voice_outlined,
                                      color: controller.isListening.value
                                          ? Colors.red
                                          : Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Obx(
                        () => DropdownButton(
                          value: controller.dropDownVal.value,
                          items: controller.items
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            controller.searchList.clear();
                            controller.dropDownVal.value = newValue!;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      // Obx(
                      //   () => DropdownButton(
                      //     value: controller.dropDownVal1.value,
                      //     items: controller.sort
                      //         .map<DropdownMenuItem<String>>((String value) {
                      //       return DropdownMenuItem<String>(
                      //         value: value,
                      //         child: Text(value),
                      //       );
                      //     }).toList(),
                      //     onChanged: (String? newValue) {
                      //       controller.dropDownVal1.value = newValue!;
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                  Obx(() => controller.searchList.isNotEmpty
                      ? SearchResultList()
                      : Obx(() => controller.dropDownVal.value == 'Brands'
                          ? GridView.count(
                              crossAxisCount: 2,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              mainAxisSpacing: 15,
                              childAspectRatio:
                                  Device.orientation == Orientation.portrait
                                      ? 1.2
                                      : 1.4,
                              crossAxisSpacing: 20,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              children: List.generate(
                                  controller.brandList.length, (index) {
                                var data = controller.brandList[index];
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // await controller.fetchBrandById(data.id);
                                        Get.to(() => BrandProducts(
                                              id: data.id!.toInt(),
                                              title: data.name.toString(),
                                            ));
                                      },
                                      child: Container(
                                          height: 100,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: CachedNetworkImage(
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                    'assets/images/Placeholder.png',
                                                    height: 100,
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                              imageUrl: data.logo
                                                  .toString()
                                                  .replaceAll(
                                                      RegExp(
                                                          r'http://127.0.0.1:8000'),
                                                      url))),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      data.name.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    )
                                  ],
                                );
                              }))
                          : const NoDataView(text: "Product Not Found"))),

                  // Obx(
                  //   () => controller.searchList.isNotEmpty
                  //       ? SearchResultList()
                  //       : Padding(
                  //           padding: const EdgeInsets.symmetric(horizontal: 20),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Text(
                  //                     'Recent Searches',
                  //                     style: titleStyle,
                  //                   ),
                  //                   TextButton(
                  //                     onPressed: () {
                  //                       controller.box.value.remove('recent');
                  //                       // controller.refresh();
                  //                       print(controller.box.value
                  //                           .read('recent')
                  //                           .toString());
                  //                     },
                  //                     child: Text(
                  //                       'Clear',
                  //                       style: titleStyle.copyWith(
                  //                           color: AppColor.orange),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               // controller.box.value.read('recent').isEmpty ||
                  //               controller.box.value.read('recent') == null
                  //                   ? Text(
                  //                       '',
                  //                       style: subtitleStyle,
                  //                       textAlign: TextAlign.center,
                  //                     )
                  //                   : ListView.builder(
                  //                       shrinkWrap: true,
                  //                       padding: EdgeInsets.zero,
                  //                       itemCount: controller.box.value
                  //                                   .read('recent')
                  //                                   .length >
                  //                               3
                  //                           ? 3
                  //                           : controller.box.value
                  //                               .read('recent')
                  //                               .length,
                  //                       itemBuilder: (ctx, index) {
                  //                         return _buildRecentSearch(controller
                  //                             .box.value
                  //                             .read('recent')[index]);
                  //                       }),
                  //               Obx(
                  //                 () => Text(controller.box.value
                  //                     .read('recent')
                  //                     .length
                  //                     .toString()),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  // ),
                ],
              ),
            ),
          ),
        ));
  }

  _buildRecentSearch(txt) {
    return ListTile(
      leading: const Icon(Icons.youtube_searched_for_outlined),
      dense: true,
      title: Text(
        txt,
        style: subtitleStyle,
      ),
      minLeadingWidth: 5,
      contentPadding: EdgeInsets.zero,
      onTap: (() => controller.searchtxt.text = txt),
    );
  }
}
