import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';

class CustomerCareScreen extends GetView {
  const CustomerCareScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(
      HomeController(),
    );
    var aboutUsPolicy = homeController.privacyPolicy
        .map((e) => e.data!.where((ee) => ee.slug == 'customer-care'))
        .toList();

    homeController.fetchPrivacyPolicy();

    return Scaffold(
      appBar: CustomAppbar(
        title: "Customer Care",
        trailing: const SizedBox(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: aboutUsPolicy.length,
                      itemBuilder: (context, index) {
                        var data = aboutUsPolicy[index].toList();
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
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
            ),
          ],
        ),
      ),
    );
  }
}
