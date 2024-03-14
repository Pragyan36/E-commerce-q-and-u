// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:q_and_u_furniture/app/modules/category/controllers/category_controller.dart';
// import 'package:q_and_u_furniture/app/widgets/category_product_card.dart';
//
// import '../../../data/models/child_category_model.dart';
// import '../../../widgets/product_tile.dart';
//
// class CategoryList extends StatelessWidget {
//   CategoryList({Key? key, required this.product}) : super(key: key);
//   final Category product;
//
//   final controller = Get.put(CategoryController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Obx(
//         () => controller.isListview.value
//             ? ListView.builder(
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                   return const ProductTile(
//                     bestseller: false,
//                     price: '100',
//                     productImg:
//                         'https://assets.adidas.com/images/w_600,f_auto,q_auto/ce8a6f3aa6294de988d7abce00c4e459_9366/Breaknet_Shoes_White_FX8707_01_standard.jpg',
//                     productName: 'Addidas',
//                     rating: '2',
//                   );
//                 })
//             : GridView.builder(
//                 physics: const ClampingScrollPhysics(),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 10,
//                   childAspectRatio:
//                       Device.orientation == Orientation.portrait ? 3 / 5 : 1.4,
//                 ),
//                 itemCount: 10,
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   return const CategoryProductCard(data: null,);
//                 },
//               ),
//       ),
//     );
//   }
// }
