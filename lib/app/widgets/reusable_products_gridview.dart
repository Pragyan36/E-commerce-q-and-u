import 'package:flutter/material.dart';
import 'package:q_and_u_furniture/app/widgets/custom_section_header.dart';

class ReusableProductGridview extends StatelessWidget {
  final String sectionHeader;
  final String imageUrl;
  final String productName;
  final String productPrice;
  final void Function()? onViewAllTapped;
  final void Function()? onProductTapped;
  final bool shouldViewAll;
  final int listLength;

  const ReusableProductGridview({
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
    if (listLength > 4) {
      itemCount = 4;
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
        MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          removeTop: true,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: itemCount,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: onProductTapped,
                child: Padding(
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
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        productName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        productPrice,
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
              );
            },
          ),
        ),
      ],
    );
  }
}
