import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/order_controller.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/views/add_review.dart';

import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:intl/intl.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:q_and_u_furniture/app/widgets/nodata.dart';

class MyReviewView extends StatefulWidget {
  const MyReviewView({Key? key}) : super(key: key);

  @override
  State<MyReviewView> createState() => _MyReviewViewState();
}

class _MyReviewViewState extends State<MyReviewView> {
  // final homecontroller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    controller.getReviewList();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppbar(
          title: 'My Reviews',
          trailing: Container(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => controller.loading.isTrue
                  ? ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CustomShimmer(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          widget: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        );
                      })
                  : controller.getReview.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.getReview.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var data = controller.getReview[index];
                            DateTime currentTime = data.createdAt != null
                                ? DateTime.parse(data.createdAt.toString())
                                : DateTime.now();
                            return Card(
                              elevation: 10,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 05),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        data.image != null
                                            ? CircleAvatar(
                                                radius: 40,
                                                backgroundImage:
                                                    NetworkImage(data.image!),
                                              )
                                            : const CircleAvatar(
                                                radius: 40,
                                              ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.productName.toString(),
                                              ),
                                              Text(
                                                  'Price ${data.price.toString()} - Qty ${data.qty.toString()}'),
                                              Text(DateFormat.yMMMMd()
                                                  .format(currentTime)),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.to(AddReviewScreen(
                                                        productId:
                                                            data.productId!,
                                                      ));
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 10),
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: const Text(
                                                        'Review',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 17),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                      : const NoDataView(text: "No data available"))
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
