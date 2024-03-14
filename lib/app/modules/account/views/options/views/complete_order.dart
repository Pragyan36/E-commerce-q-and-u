import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:q_and_u_furniture/app/model/return_order.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/order_controller.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/delivery_review.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/views/return_policy_view.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/views/terms_view.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_button.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:q_and_u_furniture/app/widgets/nodata.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CompleteOrderScreen extends StatefulWidget {
  const CompleteOrderScreen({super.key});

  @override
  State<CompleteOrderScreen> createState() => _CompleteOrderScreenState();
}

class _CompleteOrderScreenState extends State<CompleteOrderScreen> {
  final completeOrderKey = GlobalKey<FormState>();
  var additionalTextEditingController = TextEditingController();
  var noOfItemTextEditingController = TextEditingController();
  var additionalInfoTextEditingController = TextEditingController();
  int _value = 0;
  bool valuefirst = false;

  @override
  void initState() {
    noOfItemTextEditingController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      OrderController(),
    );
    controller.getReviewList();

    return Material(
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Complete Order',
          trailing: const SizedBox(),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.getCompleteOrder();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () => controller.loading.isTrue
                      ? ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CustomShimmer(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              widget: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
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
                          },
                        )
                      : (controller.getReturnOrder.isNotEmpty)
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.getReturnOrder.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var data = controller.getReturnOrder[index];

                                DateTime currentTime = data.createdAt != null
                                    ? DateTime.parse(data.createdAt.toString())
                                    : DateTime.now();

                                return Card(
                                  elevation: 1,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal: 05,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            data.image != null
                                                ? CircleAvatar(
                                                    radius: 40,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            data.image!),
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
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Price ${data.price.toString()} - Qty ${data.qty.toString()}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    DateFormat.yMMMMd()
                                                        .format(currentTime),
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Column(
                                                    children: [
                                                      data.statusData == true
                                                          ? Row(
                                                              // mainAxisAlignment:
                                                              //     MainAxisAlignment
                                                              //         .spaceAround, // mainAxisAlignment:
                                                              //     MainAxisAlignment
                                                              //         .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    height: 5.h,
                                                                    width: 30.w,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: Colors
                                                                          .green,
                                                                    ),
                                                                    // Set the background color for the first child
                                                                    child:
                                                                        Center(
                                                                      child: _reviewRow(
                                                                          data,
                                                                          context,
                                                                          controller),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    width: 30.w,
                                                                    height: 5.h,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: Colors
                                                                          .red,
                                                                    ), // Set the background color for the second child
                                                                    child: _returnRow(
                                                                        data,
                                                                        context,
                                                                        controller),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Center(
                                                              child: Container(
                                                                height: 5.h,
                                                                width: 30.w,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color: Colors
                                                                      .orange,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            5),
                                                                  ),
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8),
                                                                child: Center(
                                                                  child: Text(
                                                                    "Awaiting delivery",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            14.sp),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : const NoDataView(
                              text: "You haven't complete order anything yet."),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _returnRow(ReturnOrderHeadingModel data, BuildContext context,
      OrderController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        data.statusData == true
            ? GestureDetector(
                onTap: () {
                  noOfItemTextEditingController.text = '';
                  additionalTextEditingController.text = '';
                  additionalInfoTextEditingController.text = '';
                  valuefirst = false;

                  Get.bottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Form(
                            key: completeOrderKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Please enter the number of items to be returned:',
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        if (_value <= 0) {
                                          getSnackbar(
                                              message:
                                                  'Order quantity cannot be negative',
                                              bgColor: Colors.red,
                                              error: true);
                                        } else {
                                          _value--;
                                          noOfItemTextEditingController.text =
                                              _value.toString();
                                        }
                                      },
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller:
                                            noOfItemTextEditingController,
                                        keyboardType: TextInputType.number,
                                        // validator: (e) {

                                        //   if (e!.isEmpty) {
                                        //     return 'This Field is required';
                                        //   }
                                        //   return null;
                                        // },
                                        decoration: const InputDecoration(
                                          // hintText: data.qty == 1 ? data.qty.toString() : '0',
                                          border: OutlineInputBorder(),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.lightBlueAccent,
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.lightBlueAccent,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            _value = int.tryParse(value) ?? 0;
                                          });
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        setState(
                                          () {
                                            if (_value <= data.qty! - 1) {
                                              _value++;
                                              noOfItemTextEditingController
                                                  .text = _value.toString();
                                            } else {
                                              getSnackbar(
                                                message:
                                                    'User cannot add more than the ordered quantity!',
                                                bgColor: Colors.red,
                                                error: true,
                                              );
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                // Padding(
                                //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                //   child: TextFormField(
                                //     maxLines: 8,
                                //     minLines: 1,
                                //     controller: noOfItemTextEditingController,
                                //     validator: (value) {
                                //       // ignore: prefer_typing_uninitialized_variables
                                //       var e;
                                //       if (e > datas.qty) {
                                //         return 'no of product shouldnot be greater than $e';
                                //       }
                                //       return null;
                                //     },
                                //     decoration: const InputDecoration(
                                //       border: OutlineInputBorder(),
                                //       enabledBorder: OutlineInputBorder(
                                //         borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                                //         borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                //       ),
                                //       focusedBorder: OutlineInputBorder(
                                //         borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                                //         borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Why do you want to return the product?',
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: TextFormField(
                                    maxLines: 8,
                                    minLines: 1,
                                    controller: additionalTextEditingController,
                                    validator: (e) {
                                      if (e == null || e.isEmpty) {
                                        return 'Please add information';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.lightBlueAccent,
                                            width: 1.0),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.lightBlueAccent,
                                            width: 2.0),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Please add further reasons',
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: TextFormField(
                                    maxLines: 8,
                                    minLines: 1,
                                    controller:
                                        additionalInfoTextEditingController,
                                    validator: (e) {
                                      if (e == null || e.isEmpty) {
                                        return 'Please add more information';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.lightBlueAccent,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.lightBlueAccent,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    StatefulBuilder(
                                      builder: ((context, setState) {
                                        return Checkbox(
                                          checkColor: Colors.white,
                                          activeColor: Colors.blue,
                                          value: valuefirst,
                                          onChanged: (value) {
                                            setState(() {
                                              valuefirst = value!;
                                            });
                                          },
                                        );
                                      }),
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text:
                                                  'I have read and agree to the ',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "company's policy, ",
                                              style: const TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.blue,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Get.to(
                                                    const ReturnPolicyView(),
                                                  );
                                                },
                                            ),
                                            TextSpan(
                                              text: 'terms and conditions, ',
                                              style: const TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.blue,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Get.to(
                                                    const TermsView(),
                                                  );
                                                },
                                            ),
                                            const TextSpan(
                                              text: '&',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'product warranty policy',
                                              style: const TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.blue,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Get.defaultDialog(
                                                      title: 'Warranty Policy',
                                                      middleText: data.product!
                                                          .warrantyPolicy
                                                          .toString());
                                                },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomButton(
                                  width: double.infinity,
                                  label: 'Return Now',
                                  btnClr: Colors.red,
                                  txtClr: Colors.white,
                                  ontap: () {
                                    if (valuefirst == false) {
                                      getSnackbar(
                                        message:
                                            'please check the privacy policy',
                                        error: true,
                                        bgColor: Colors.red,
                                      );
                                    } else if (noOfItemTextEditingController
                                            .text
                                            .trim() ==
                                        '0') {
                                      getSnackbar(
                                        message:
                                            'please add no of item to be return',
                                        error: true,
                                        bgColor: Colors.red,
                                      );
                                    } else if (completeOrderKey.currentState!
                                        .validate()) {
                                      controller
                                          .returnOrderProduct(
                                        data.id.toString(),
                                        noOfItemTextEditingController.text,
                                        additionalTextEditingController.text,
                                        additionalInfoTextEditingController
                                            .text,
                                        valuefirst ? '1' : '0',
                                      )
                                          .then((value) {
                                        noOfItemTextEditingController.text = '';
                                        additionalTextEditingController.text =
                                            '';
                                        additionalInfoTextEditingController
                                            .text = '';
                                      }).then((value) =>
                                              Navigator.pop(context));
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Text(
                  'Return',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }

  _reviewRow(ReturnOrderHeadingModel data, BuildContext context,
      OrderController controller) {
    return data.statusData == true
        ? GestureDetector(
            onTap: () {
              Get.to(() => DeliveryReviewView(
                    orderId: data.orderId!,
                  ));
            },

            // decoration: BoxDecoration(
            //     // color: Colors.green,
            //     borderRadius: BorderRadius.circular(10)),
            child: Text(
              'Feedback to Delivery',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          )
        : const SizedBox();
  }
}
