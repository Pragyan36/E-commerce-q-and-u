import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/data/models/cart_model.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CartTile extends StatefulWidget {
  const CartTile({
    Key? key,
    this.img,
    this.name,
    this.price,
    this.ontap,
    this.quantity,
    this.productid,
    this.index,
    this.data,
  }) : super(key: key);

  final CartAssets? data;
  final String? img;
  final String? name;
  final String? price;
  final int? quantity;
  final int? productid;
  final int? index;
  final VoidCallback? ontap;

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final controller = Get.put(CartController());
  int b = 0;

  @override
  Widget build(BuildContext context) {
    int a = widget.data!.qty!.toInt() + b;
    // final String? jsonString = widget.data!.options;
    var newjSON = json.decode(widget.data!.options!);


    return Card(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10, right: 10),
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
              ),
              child: CachedNetworkImage(
                imageUrl: widget.data?.productImage?[0].image?.replaceAll(
                      RegExp(r'http://127.0.0.1:8000'),
                      url,
                    ) ??
                    'https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c2hvZXN8ZW58MHx8MHx8&w=1000&q=80',
                fit: BoxFit.contain,
                placeholder: (ctx, t) {
                  return Image.asset(
                    'assets/images/Placeholder.png',
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50.sp,
                  child: Text(
                    widget.data!.productName.toString(),
                    style: subtitleStyle,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //             ListView.builder(
                //             itemCount: data.length,
                // itemBuilder: (context, index) {
                // return ListTile(
                // title: Text(data[index]['title']),
                // );}),
                // Text("${jsonData.toString()} "),
                SizedBox(
                  width: 180,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: newjSON.length,
                    itemBuilder: (context, index) {
                      var item = newjSON[index];
                      return Row(
                        children: [
                          Text(
                            "${item["title"]}: ",
                            style: subtitleStyle.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            item['value'],
                            style: subtitleStyle.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Rs. ${widget.data!.price.toString()}",
                      style: subtitleStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 25.w,
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: widget.ontap,
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    buildincdecButton(
                      icon: Icons.remove,
                      ontap: () {
                        setState(
                          () {
                            if (a >= 1) {
                              a--;
                              controller.updateCartitem(
                                widget.data?.id,
                                a,
                              );
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      a.toString(),
                      style: subtitleStyle.copyWith(fontSize: 16.sp),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    buildincdecButton(
                      icon: Icons.add,
                      ontap: () {
                        setState(() {
                          a++;
                        });
                        controller.updateCartitem(
                          widget.data?.id,
                          a,
                        );
                      },
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  buildincdecButton({
    required IconData icon,
    required void Function()? ontap,
  }) {
    return SizedBox(
      width: 30,
      height: 30,
      child: OutlinedButton(
        onPressed: ontap,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Icon(
          icon,
          size: 16.sp,
          color: Colors.black87,
        ),
      ),
    );
  }
}
