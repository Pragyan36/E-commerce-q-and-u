import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:q_and_u_furniture/app/data/products.dart';

import '../constants/constants.dart';

class CartTileWidget extends StatelessWidget {
  const CartTileWidget(
      {Key? key, required this.product, this.ontap, this.quantity})
      : super(key: key);

  final Products product;
  final int? quantity;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10, right: 10),
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200,
            ),
            child: Image.network(
              product.productImage.toString(),
              height: 120,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                product.productname.toString(),
                style: subtitleStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Size: L',
                style: subtitleStyle.copyWith(color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    product.productPrice.toString(),
                    style: subtitleStyle.copyWith(fontWeight: FontWeight.bold),
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
              // IconButton(
              //   onPressed: ontap,
              //   icon: const Icon(
              //     Icons.close,
              //   ),
              // ),
              Container(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  buildincdecButton(Icons.remove, () {}),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    quantity.toString(),
                    style: subtitleStyle,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  buildincdecButton(Icons.add, () {}),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  buildincdecButton(IconData icon, ontap) {
    return SizedBox(
        width: 30,
        height: 30,
        child: OutlinedButton(
            onPressed: ontap,
            style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            child: Icon(
              icon,
              size: 16.sp,
              color: Colors.black87,
            )));
  }
}
