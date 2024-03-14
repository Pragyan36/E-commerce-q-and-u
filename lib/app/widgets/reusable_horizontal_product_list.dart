import 'package:flutter/material.dart';
import 'package:q_and_u_furniture/app/widgets/custom_no_image_widget.dart';
import 'package:q_and_u_furniture/app/widgets/custom_section_header.dart';

class ReusableHorizontalProductList extends StatelessWidget {
  final String sectionHeader;
  final String imageUrl;
  final List productName;
  final String productPrice;
  final void Function()? onViewAllTapped;
  final void Function()? onProductTapped;
  final bool shouldViewAll;
  final int listLength;

  const ReusableHorizontalProductList({
    super.key,
    required this.sectionHeader,
    required this.imageUrl,
    required this.productName,
    required this.productPrice,
    required this.onViewAllTapped,
    required this.onProductTapped,
    required this.shouldViewAll,
    required this.listLength,
  });

  @override
  Widget build(BuildContext context) {
    int itemCount;
    if (listLength > 8) {
      itemCount = 8;
    } else {
      itemCount = listLength;
    }

    return Column(
      children: [
        CustomSectionHeader(
          headerName: sectionHeader,
          onViewAllTapped: onViewAllTapped,
          shouldViewAll: shouldViewAll,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          height: 160,
          child: MediaQuery.removePadding(
            context: context,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: onProductTapped,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            "${productName[index].images[0].image}",
                            errorBuilder: (context, error, stackTrace) {
                              return CustomNoImageWidget();
                            },
                            fit: BoxFit.cover,
                            height: 100,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            productName[index].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Rs. ${(productName[index].stocks[0].price)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 5,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
