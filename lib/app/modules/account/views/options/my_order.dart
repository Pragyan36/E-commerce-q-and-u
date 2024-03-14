import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/data/models/userorder_model.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/order_controller.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/views/order_details._view.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/views/refund_order.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_buttons.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:q_and_u_furniture/app/widgets/nodata.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyOrderView extends StatefulWidget {
  final bool isFromPurchaseView;

  const MyOrderView({
    super.key,
    required this.isFromPurchaseView,
  });

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {
  final OrderController orderController = Get.put(
    OrderController(),
  );

  Future<void> _refresh() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    orderController.getuserOrders();
  }

  @override
  Widget build(BuildContext context) {
    orderController.getuserOrders();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar(
        title: 'My Orders',
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.sp,
              color: Colors.black,
            )),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: Obx(() => orderController.loadingOrderList.isFalse
              ? orderController.orderList.isNotEmpty
                  ? ListView.builder(
                      itemCount: orderController.orderList.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data = orderController.orderList[index];
                        return _buildOrderItemTile(
                          name: data.orderAssets!,
                          orderId: data.refId,
                          paymentstatus: data.paymentStatus,
                          deliveryStatus: data.delivered,
                          totalprice: data.totalPrice,
                          data: data,
                          cancelOrder: data.cancelStatus,
                          cancelOrderId: data.id.toString(),
                        );
                      },
                    )
                  : const NoDataView(text: "You haven't ordered anything yet.")
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
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
                      }),
                )),
        ),
      ),
    );
  }

  String dropdownvalue = '--Please Select reason--';

  var items = [
    '--Please Select reason--',
    'Change of Delivery Address',
    'Change of Payment Method',
    'Change/Combine order',
    'Delivery Time is too long',
    'Duplicate Order',
    'forget to user voucher',
    'found cheaper elsewhere',
    'Other Reason'
  ];
  bool valuefirst = false;
  final orderkey = GlobalKey<FormState>();
  var additionalTextEditingController = TextEditingController();

  _buildOrderItemTile({
    required List<OrderAssets> name,
    orderId,
    paymentstatus,
    deliveryStatus,
    totalprice,
    data,
    cancelOrder,
    cancelOrderId,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order $orderId',
                  style: subtitleStyle.copyWith(color: AppColor.mainClr),
                ),
                Text(
                  data.paymentWith == "COD"
                      ? data.statusvalue == 'DELIVERED'
                          ? "Paid"
                          : "Unpaid"
                      : data.paymentStatus == 1
                          ? 'Paid'
                          : "Unpaid",
                  style: subtitleStyle.copyWith(color: Colors.grey),
                ),

                // Text(
                //   'In Transit',
                //   style: subtitleStyle.copyWith(color: AppColor.mainClr),
                // ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: data.orderAssets?.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var items = data.orderAssets?[index];
                  return ListTile(
                    leading: items.product != null &&
                            items.product.images != null &&
                            items.product.images.isNotEmpty &&
                            items.product.images.first.image != null
                        ? CachedNetworkImage(
                            imageUrl:
                                items.product.images.first.image!.replaceAll(
                              RegExp(r'http://127.0.0.1:8000'),
                              url,
                            ),
                            height: 100,
                            width: 90,
                            placeholder: (context, url) =>
                                Image.asset(AppImages.placeHolder),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )

                        // Image.network(
                        //     items.product.images.first.image!.replaceAll(
                        //       RegExp(r'http://127.0.0.1:8000'),
                        //       url,
                        //     ),
                        //     height: 100,
                        //     width: 90,
                        //   )
                        : Image.asset(AppImages.placeHolder),
                  );
                }),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    data.refundStatus == true
                        ? GestureDetector(
                            onTap: () {
                              Get.to(() => RefundOrder(
                                    orderId: cancelOrderId,
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.green),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 7),
                                child: Text(
                                  "Apply Refund",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      width: 10,
                    ),
                    data.refundStatusValue != null
                        ? GestureDetector(
                            onTap: () {
                              final snackBar = SnackBar(
                                  content:
                                      Text(data.refundRejectReason.toString()));
                              data.refundRejectReason != null
                                  ? ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar)
                                  : const SizedBox();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: data.refundStatusValue == "REJECTED"
                                      ? Colors.red
                                      : Colors.green),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 7),
                                child: Text(
                                  "Refund Status: ${data.refundStatusValue}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: data.statusvalue == "PENDING"
                              ? Colors.orange
                              : data.statusvalue == "DELIVERED"
                                  ? Colors.green
                                  : data.statusvalue == "CANCELED"
                                      ? Colors.red
                                      : Colors.blue),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 7),
                        child: Text(
                          data.statusvalue == null
                              ? ''
                              : data.statusvalue.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            data.cancelStatus == true && data.statusvalue != "SHPIED"
                ? GestureDetector(
                    onTap: () {
                      additionalTextEditingController.clear();
                      String dropdownvalue = '--Please Select reason--';
                      bool valuefirst = false;

                      Get.bottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Form(
                                key: orderkey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                        'Why Did You Want to Cancel The Order ?'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    DropdownButtonFormField2(
                                      // Initial Value
                                      value: dropdownvalue,

                                      // Down Arrow Icon
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),

                                      // Array list of items
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text('Add Your Additional Reason.'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: TextFormField(
                                        maxLines: 8,
                                        minLines: 1,
                                        controller:
                                            additionalTextEditingController,
                                        validator: (e) {
                                          if (e == null || e.isEmpty) {
                                            return 'Please Enter additional information';
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
                                                Radius.circular(5.0)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.lightBlueAccent,
                                                width: 2.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
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
                                        const Expanded(
                                          child: Text(
                                              'I am read and aggre to the cancellation policy.'),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CustomButtons(
                                        width: double.infinity,
                                        label: 'Cancel',
                                        btnClr: Colors.red,
                                        txtClr: Colors.white,
                                        ontap: () {
                                          if (orderkey.currentState!
                                              .validate()) {
                                            orderController
                                                .cancelOrder(
                                                    cancelOrderId,
                                                    dropdownvalue.trim(),
                                                    additionalTextEditingController
                                                        .text
                                                        .trim(),
                                                    valuefirst ? '1' : '0')
                                                .then((value) {
                                              additionalTextEditingController
                                                      .text ==
                                                  '';
                                              Navigator.pop(context);
                                            });
                                          }
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ));
                    },
                    child: Text("Cancel",
                        style: subtitleStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        )
                        // style: TextStyle(color: Colors.black),
                        ), //canel
                  )
                : const SizedBox(),
            const SizedBox(
              height: 50,
            ),
            Text('Total: ${thousandSepretor.format(totalprice)}',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black)),

            // MaterialButton(
            //   onPressed: () {},
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(10),
            //     side: const BorderSide(color: Colors.grey, width: 1),
            //   ),
            //   child: Text(
            //     'Track',
            //     style: subtitleStyle,
            //   ),
            // )
          ],
        ),
        onTap: () {
          Get.to(() => OrderDetails(
                userOrderData: data,
              ));
        },
      ),
    );
  }
}

extension BoolParsing on String {
  bool parseBool() {
    if (toLowerCase() == 'true') {
      return true;
    } else if (toLowerCase() == 'false') {
      return false;
    }

    throw '"$this" can not be parsed to boolean.';
  }
}
