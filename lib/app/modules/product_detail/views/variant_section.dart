import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/controllers/product_detail_controller.dart';

class SelectVariantsSection extends StatefulWidget {
  final ProductDetailController productDetailController;

  const SelectVariantsSection({
    super.key,
    required this.productDetailController,
  });

  @override
  State<SelectVariantsSection> createState() => _SelectVariantsSectionState();
}

class _SelectVariantsSectionState extends State<SelectVariantsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*
          SELECT COLOR SECTION
        */
        const Text(
          "Select Color:",
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount:
                widget.productDetailController.productdetail.value.colors?.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Obx(
                  () => GestureDetector(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: hexToColor("#eccbcb"),
                        border: Border.all(
                          color: widget.productDetailController
                                      .selectedColorIndex.value ==
                                  index
                              ? AppColor.kalaAppMainColor
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                    onTap: () {
                      widget.productDetailController.selectedColorIndex.value = index;
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        /*
          SELECT SIZE SECTION
        */
        const Text(
          "Select Size",
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Obx(
                  () => GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: widget.productDetailController
                                      .selectedColorIndex.value ==
                                  index
                              ? AppColor.kalaAppMainColor
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "22",
                        ),
                      ),
                    ),
                    onTap: () {
                      widget.productDetailController.selectedColorIndex.value = index;
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        /*
          SELECT SECOND SIZE SECTION
        */
        const Text(
          "Select Another Size",
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Obx(
                  () => GestureDetector(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: widget.productDetailController
                                      .selectedColorIndex.value ==
                                  index
                              ? AppColor.kalaAppMainColor
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                    onTap: () {
                      widget.productDetailController.selectedColorIndex.value = index;
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
