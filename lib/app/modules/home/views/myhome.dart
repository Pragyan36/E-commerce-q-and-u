// // ignore_for_file: library_private_types_in_public_api, avoid_print
//
// import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:q_and_u_furniture/app/constants/constants.dart';
// import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
// import 'package:q_and_u_furniture/app/widgets/product_card.dart';
//
// class MyHome extends StatefulWidget {
//   const MyHome({Key? key}) : super(key: key);
//
//   @override
//   _MyHomeState createState() => _MyHomeState();
// }
//
// class _MyHomeState extends State<MyHome> {
//   late ScrollController scrollcontroller;
//   HomeController homecon = Get.put(HomeController());
//   List<String> items = List.generate(100, (index) => 'Hello $index');
//
//   @override
//   void initState() {
//     super.initState();
//     scrollcontroller = ScrollController()..addListener(_scrollListener);
//   }
//
//   @override
//   void dispose() {
//     scrollcontroller.removeListener(_scrollListener);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print(homecon.numberOfPostsPerRequest);
//     return Scaffold(
//       body: DefaultTabController(
//         length: 2,
//         child: ExtendedNestedScrollView(
//             headerSliverBuilder: (context, t) {
//               return <Widget>[
//                 const SliverToBoxAdapter(
//                   child: SizedBox(
//                     height: 20,
//                   ),
//                 ),
//                 SliverToBoxAdapter(
//                     child: TabBar(tabs: [
//                   Tab(
//                     child: Text(
//                       'Home',
//                       style: titleStyle,
//                     ),
//                   ),
//                   Tab(
//                     child: Text(
//                       'Home',
//                       style: titleStyle,
//                     ),
//                   ),
//                 ]))
//               ];
//             },
//             body: TabBarView(children: [
//               _buildTabs(),
//               _buildTabs(),
//             ])
//             // Container(
//             //   color: Colors.white,
//             //   child: Obx(() => GridView.builder(
//             //       itemCount: homecon.productsList.length,
//             //       // physics: const NeverScrollableScrollPhysics(),
//             //       controller: scrollcontroller,
//             //       padding: const EdgeInsets.symmetric(horizontal: 10),
//             //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             //         crossAxisCount: 2,
//             //         childAspectRatio: Device.orientation == Orientation.portrait
//             //             ? 1 / 1.45
//             //             : 1.4,
//             //         crossAxisSpacing: 10,
//             //         mainAxisSpacing: 15,
//             //       ),
//             //       itemBuilder: (context, index) {
//             //         var data = homecon.productsList[index];
//
//             //         return ProductCard(
//             //           price: data.price.toString(),
//             //           productImg: data.image,
//             //           productName: data.title,
//             //           rating: data.rating!.rate.toString(),
//             //         );
//             //       })),
//             // ),
//             ),
//       ),
//
//       // Obx(() => GridView.builder(
//       //     itemCount: homecon.productsList.length,
//       //     // physics: const NeverScrollableScrollPhysics(),
//       //     controller: scrollcontroller,
//       //     padding: const EdgeInsets.symmetric(horizontal: 10),
//       //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       //       crossAxisCount: 2,
//       //       childAspectRatio:
//       //           Device.orientation == Orientation.portrait ? 1 / 1.45 : 1.4,
//       //       crossAxisSpacing: 10,
//       //       mainAxisSpacing: 15,
//       //     ),
//       //     itemBuilder: (context, index) {
//       //       var data = homecon.productsList[index];
//
//       //       return ProductCard(
//       //         price: data.price.toString(),
//       //         productImg: data.image,
//       //         productName: data.title,
//       //         rating: data.rating!.rate.toString(),
//       //       );
//       //     })),
//       floatingActionButton: FloatingActionButton(onPressed: () {
//         homecon.fetchProducts();
//       }),
//     );
//   }
//
//   void _scrollListener() {
//     print(scrollcontroller.position.extentAfter);
//     if (scrollcontroller.position.extentAfter < 1) {
//       print('object');
//       homecon.numberOfPostsPerRequest.value += 4;
//       homecon.fetchProducts();
//     }
//   }
//
//   _buildTabs() {
//     return Obx(() => GridView.builder(
//         itemCount: homecon.productsList.length,
//         // physics: const NeverScrollableScrollPhysics(),
//         controller: scrollcontroller,
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio:
//               Device.orientation == Orientation.portrait ? 1 / 1.45 : 1.4,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 15,
//         ),
//         itemBuilder: (context, index) {
//           var data = homecon.productsList[index];
//
//           return ProductCard(
//             price: data.price.toString(),
//             productImg: data.image.toString(),
//             productName: data.title,
//             rating: data.rating!.rate.toString(),
//           );
//         }));
//   }
// }
