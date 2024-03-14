// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/data/models/customer_care.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomerServiceView extends GetView {
  const CustomerServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(
      HomeController(),
    );
    homeController.fetchCustomerCare();

    return Scaffold(
      appBar: CustomAppbar(
        title: "Customer Service",
        trailing: const SizedBox(),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 20,
              right: 20,
            ),
            child: homeController.customerCareLoading.isTrue
                ? CustomShimmer(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    widget: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                : homeController.customCare.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "How can we help you?",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: homeController.customCare.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3.0,
                                    color: const Color(0xFFFFFFFF),
                                  ),
                                ),
                                child: ExpandablePanel(
                                  header: Obx(
                                    () => Text(
                                      homeController
                                          .customCare[index].data![index].title
                                          .toString(),
                                      style: titleStyle,
                                    ),
                                  ),
                                  collapsed: Container(),
                                  expanded: Column(
                                    children: [
                                      Html(
                                        data: homeController.customCare[index]
                                            .data![index].content
                                            .toString(),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset(
                              AppImages.noproductImage,
                              width: 100,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Oops! We could not retrieve data at the moment!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        ),
      ),
    );
  }

  Future<CustomerCareModel> fetchCustomerService() async {
    final response = await http.get(
      Uri.parse('https://www.celermart.nectar.com.np/api/customercare'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(
        response.body.toString(),
      );
      return CustomerCareModel.fromJson(data);
    } else {
      throw Exception('Failed to load social media links');
    }
  }
}
