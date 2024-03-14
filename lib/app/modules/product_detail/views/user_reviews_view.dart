import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/controllers/product_detail_controller.dart';
import 'package:q_and_u_furniture/app/widgets/nodata.dart';

import '../../../constants/constants.dart';

class UserReviewView extends StatefulWidget {
  const UserReviewView({Key? key, required this.productId}) : super(key: key);
  final int productId;

  @override
  State<UserReviewView> createState() => _UserReviewViewState();
}

class _UserReviewViewState extends State<UserReviewView> {
  final controller = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    controller.fetchReviews(widget.productId);

    log(controller.reviewList.length.toString());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Obx(() => controller.loadingReview.isTrue
                ? const Center(child: CircularProgressIndicator())
                : controller.reviewList.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.reviewList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var data = controller.reviewList[index];
                          DateTime currentTime =
                              DateTime.parse(data.createdAt.toString());
                          // DateTime admintime = DateTime.parse(data.answer != null
                          //     ? data.answer![index].createdAt.toString()
                          //     : '');
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                margin: const EdgeInsets.all(10),
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              data.user!.photo != null
                                                  ? CircleAvatar(
                                                      radius: 30,
                                                      backgroundImage:
                                                          NetworkImage(data
                                                              .user!.photo
                                                              .toString()),
                                                    )
                                                  : const CircleAvatar(
                                                      radius: 30,
                                                      backgroundImage: NetworkImage(
                                                          'https://jhigu.store/storage/photos/Royal-Black.png'),
                                                    ),
                                              const SizedBox(
                                                width: 05,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          data.user!.name
                                                              .toString(),
                                                          style: subtitleStyle
                                                              .copyWith(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          DateFormat.yMMMMd()
                                                              .format(
                                                                  currentTime),
                                                          style: subtitleStyle,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: List.generate(
                                                          data.rating!,
                                                          (index) {
                                                        return Icon(
                                                          index < 5
                                                              ? Icons.star
                                                              : Icons
                                                                  .star_border,
                                                          color: Colors.yellow,
                                                        );
                                                      }),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      data.message.toString(),
                                                      style: subtitleStyle,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 50,
                                                width: 200,
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        data.image!.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Image.network(
                                                              data.image![
                                                                  index],
                                                              height: 50,
                                                              width: 50,
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                        itemCount: data.answer!.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          var datas = data.answer![index];
                                          DateTime currentTime = DateTime.parse(
                                              datas.createdAt.toString());
                                          return Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        const CircleAvatar(
                                                          radius: 30,
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  'https://jhigu.store/storage/photos/Royal-Black.png'),
                                                        ),
                                                        const SizedBox(
                                                          width: 05,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    'Respond From ${DateFormat.yMMMMd().format(currentTime)} ',
                                                                    style:
                                                                        subtitleStyle,
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                datas.reply
                                                                    .toString(),
                                                                style:
                                                                    subtitleStyle,
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        })
                                  ],
                                ),
                              ),
                            ],
                          );
                        })
                    : const NoDataView(text: "No Review Found"))
          ],
        ),
      ),
    );
  }
}
