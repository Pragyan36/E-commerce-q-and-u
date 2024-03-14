import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';

class AboutUsView extends GetView {
  const AboutUsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(
      HomeController(),
    );
    final LoginController loginController = Get.put(
      LoginController(),
    );

    var aboutUsPolicy = homeController.privacyPolicy
        .map((e) => e.data!.where((ee) => ee.slug == 'about-us'))
        .toList();

    homeController.fetchPrivacyPolicy();
    loginController.fetchSiteDetails();

    return Scaffold(
      appBar: CustomAppbar(
        title: "About Us",
        trailing: const SizedBox(),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => homeController.loading.isTrue
                  ? CustomShimmer(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      widget: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 20,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: aboutUsPolicy.length,
                      itemBuilder: (context, index) {
                        var data = aboutUsPolicy[index].toList();
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Center(
                                child: CachedNetworkImage(
                                  imageUrl: Uri.encodeFull(
                                    loginController.siteDetailList[0].value ??
                                        "",
                                  ),
                                  height: 100,
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) {
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
                              Html(
                                data: data[index].content != null
                                    ? data[index].content.toString()
                                    : '',
                              )
                            ],
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
