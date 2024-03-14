import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/controllers/product_detail_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SpecificationTab extends StatefulWidget {
  const SpecificationTab({
    Key? key,
  }) : super(key: key);

  @override
  State<SpecificationTab> createState() => _SpecificationTabState();
}

class _SpecificationTabState extends State<SpecificationTab> {
  final controller = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    final specification =
        controller.productdetail.value.specificationData?.specification;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (specification != null)
          HtmlWidget(
            specification.toString(),
            textStyle: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
            customStylesBuilder: (element) {
              if (element.localName == 'th') {
                return {'padding': '0'};
              }
              return null;
            },
          )
        else
          const SizedBox(),
      ],
    );
  }
}
