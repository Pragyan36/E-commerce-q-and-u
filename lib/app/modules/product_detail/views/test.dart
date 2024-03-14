// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ProductDetailView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Replace titleStyle with your desired TextStyle
//     TextStyle titleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

//     // Replace this with your actual controller and productdetail
//     var controller = Get.put(YourController());
//     // Assuming the productdetail is of type Map<String, String>
//     var attribute = controller.productdetail.value!.attribute;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Product Detail"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView(
//           children: List.generate(attribute!.length, (index) {
//             var keys = attribute.keys.toList();
//             var values = attribute.values.toList();
//             var individualValues = values[index].split(",");

//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "${keys[index]}:",
//                     style: titleStyle,
//                     textAlign: TextAlign.left,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: individualValues.map((value) {
//                       return Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey, // You can customize the border color here
//                             width: 1.0,          // You can customize the border width here
//                           ),
//                           borderRadius: BorderRadius.circular(8.0), // You can adjust the border radius as needed
//                         ),
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           value.trim(), // Trim the value to remove any leading/trailing spaces
//                           style: titleStyle,
//                           textAlign: TextAlign.left,
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }

// // Replace YourController with your actual controller class
// class YourController extends GetxController {
//   final productdetail = Rxn<Map<String, String>>();
// }

// void main() {
//   runApp(GetMaterialApp(
//     home: ProductDetailView(),
//   ));
// }
