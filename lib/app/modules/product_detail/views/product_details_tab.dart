import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/controllers/product_detail_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductDetailsTab extends StatefulWidget {
  const ProductDetailsTab({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDetailsTab> createState() => _ProductDetailsTabState();
}

class _ProductDetailsTabState extends State<ProductDetailsTab> {
  final controller = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => HtmlWidget(
        controller.productdetail.value.longDescription ?? "",
        // controller.showLongDesc.isTrue
        //     ? controller.productdetail.value.longDescription ?? ""
        //     : controller.productdetail.value.shortDescription ?? "",
        textStyle: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
