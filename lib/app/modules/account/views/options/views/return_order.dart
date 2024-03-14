import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/order_controller.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/views/apply_refund.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:q_and_u_furniture/app/widgets/nodata.dart';

class ReturnOrderScreen extends StatelessWidget {
  const ReturnOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Return Order',
        trailing: Container(),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.returnOrders();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => controller.loadingReturnOrder.isTrue
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
                  : (controller.returnOrder.isNotEmpty)
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.returnOrder.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var data = controller.returnOrder[index];
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 60,
                                          width: 60,
                                          child: CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage(
                                                data.image.toString()),
                                          ),
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
                                                data.productname.toString(),
                                              ),
                                              Text(
                                                  'Price ${data.amount.toString()} - Qty ${data.qty.toString()}'),
                                              Text(DateFormat.yMMMMd()
                                                  .format(currentTime)),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  data.applyRefund == true
                                                      ? Column(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {},
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .green,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                child: Text(
                                                                  data.returnStatus
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          17),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 05,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Get.to(
                                                                    ApplyRefundScreen(
                                                                  returnOrderViewHeadingModel:
                                                                      data,
                                                                ));
                                                              },
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                child: data.returnStatus ==
                                                                        'RECEIVED'
                                                                    ? Text(
                                                                        'Apply Refund'
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 17),
                                                                      )
                                                                    : Text(
                                                                        data.refundShowStatus
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 17),
                                                                      ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : GestureDetector(
                                                          onTap: () {
                                                            data.status == '4'
                                                                ? controller
                                                                    .getOrderedRejectedReasons(
                                                                        data.id
                                                                            .toString(),
                                                                        context)
                                                                : null;
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                                decoration: BoxDecoration(
                                                                    color: data.refundShowStatus == null
                                                                        ? data.returnStatus == 'RETURNED'
                                                                            ? Colors.yellow
                                                                            : Colors.red
                                                                        : Colors.green,
                                                                    borderRadius: BorderRadius.circular(10)),
                                                                child: Text(
                                                                  data.returnStatus
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: data.returnStatus ==
                                                                              'RETURNED'
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .white,
                                                                      fontSize:
                                                                          13.sp),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 05,
                                                              ),
                                                              data.refundShowStatus ==
                                                                      null
                                                                  ? const SizedBox()
                                                                  : GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        data.refundShowStatus ==
                                                                                'Refund Rejected'
                                                                            ? showDialog(
                                                                                context: context,
                                                                                builder: (ctx) => AlertDialog(
                                                                                  content: Text(data.refundMessageValue.toString()),
                                                                                ),
                                                                              )
                                                                            : const SizedBox();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                10),
                                                                        decoration: BoxDecoration(
                                                                            color: data.refundShowStatus == 'Refund Rejected'
                                                                                ? Colors.red
                                                                                : Colors.red,
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                        child:
                                                                            Container(
                                                                          child:
                                                                              Text(
                                                                            data.refundShowStatus.toString(),
                                                                            style:
                                                                                TextStyle(color: data.refundShowStatus == 'Refund Rejected' ? Colors.white : Colors.white, fontSize: 13.sp),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
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
                      : const NoDataView(
                          text: "You haven't return order anything yet.")),
            ],
          ),
        ),
      ),
    );
  }
}
