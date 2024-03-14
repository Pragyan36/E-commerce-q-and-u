import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/data/models/child_category_model.dart';
import 'package:flutter/material.dart';
import 'package:q_and_u_furniture/app/modules/category/controllers/category_controller.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/views/product_detail_view.dart';
import '../../../widgets/no_product_widget.dart';

class CustomGrid extends StatefulWidget {
  const CustomGrid({
    super.key,
    required this.data,
  });

  final List<Category> data;

  @override
  State<CustomGrid> createState() => _CustomGridState();
}

class _CustomGridState extends State<CustomGrid> {
  final controller = Get.put(
    CategoryController(),
  );

  @override
  Widget build(BuildContext context) {
    return controller.childcategoryList.first.products == null
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: NoProductWidget(),
          )
        : GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: controller.childcategoryList.first.products?.length ?? 0,
            itemBuilder: (context, index) {
              var data = controller.childcategoryList.first.products![index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.selectedSortingItem.value = "1";
                      Get.to(
                        () => ProductDetailView(
                          productname: data.name,
                          productprice: data.id.toString(),
                          slug: data.slug,
                          productid: data.id,
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: CachedNetworkImageProvider(
                        '${controller.childcategoryList.first.products![index].image?.replaceAll(
                          RegExp(r'http://127.0.0.1:8000'),
                          url,
                        )}',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    controller.childcategoryList.first.products![index].name
                        .toString(),
                    textAlign: TextAlign.center,
                    style: subtitleStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
                ],
              );
            },
          );
  }
}
