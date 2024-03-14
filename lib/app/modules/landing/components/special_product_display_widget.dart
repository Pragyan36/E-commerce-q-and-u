import 'package:flutter/material.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';

class SpecialOffersDisplayWidget extends StatelessWidget {
  final LandingController controller;
  final int index;

  const SpecialOffersDisplayWidget({
    super.key,
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Image.network(
              controller.specialProductsList[index].images?[index].image ?? "",
              fit: BoxFit.cover,
            ),
          ),
          Text(
            controller.specialProductsList[index].name ?? "N/A",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          (controller.specialProductsList[index].stocks?[index].price) != null
              ? Row(
                  children: [
                    Text(
                      "Rs. ${(controller.specialProductsList[index].stocks?[index].price) ?? 0}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColor.kalaAppMainColor,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Rs. ${(controller.specialProductsList[index].stocks?[index].specialPrice) ?? 0}",
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              : Text(
                  "Rs. ${(controller.specialProductsList[index].stocks?[index].specialPrice) ?? 0}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColor.kalaAppMainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ],
      ),
    );
  }
}