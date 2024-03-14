// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../controllers/shipping_controller.dart';

// class AddNewAddress extends StatefulWidget {
//   AddNewAddress({Key? key}) : super(key: key);

//   @override
//   State<AddNewAddress> createState() => _AddNewAddressState();
// }

// class _AddNewAddressState extends State<AddNewAddress> {
//   String dropdownvalue = 'Item 1';
//   var items = [];
//   var provinceNotSelectedItems = ['Please Select a Province'];
//   var districtNotSelectedItems = ['Please Select a District'];
//   var controller = ShippingController();

//   @override
//   Widget build(BuildContext context) {
//     controller.fetchAddress();
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           padding: const EdgeInsets.all(20),
//           /*child: Column(
//             children: [

//               Obx(() => DropdownButtonFormField2(
//                     hint: Text("Select Province"),
//                     items: controller.provinceList
//                         .map((item) => DropdownMenuItem<String>(
//                               value: item.id.toString(),
//                               child: Text(
//                                 item.engName.toString(),
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ))
//                         .toList(),
//                     onChanged: (value) {
//                       controller.selectedProvince.value =
//                           int.parse(value.toString());
//                       print("Selected Province:" + value.toString());
//                       controller.selectedDistrict.value = 0;
//                       print("Selected District:" +
//                           controller.selectedDistrict.value.toString());
//                     },
//                     onSaved: (value) {
//                       dropdownvalue = value.toString();
//                     },
//                   )),
//               Obx(() => DropdownButtonFormField2(
//                     hint: Text("Select District"),
//                     items: controller.selectedProvince >= 1
//                         ? controller
//                             .provinceList[controller.selectedProvince.value - 1]
//                             .districts!
//                             .map((item) => DropdownMenuItem<String>(
//                                   value: item.id.toString(),
//                                   child: Text(
//                                     item.npName.toString(),
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ))
//                             .toList()
//                         : provinceNotSelectedItems
//                             .map((item) => DropdownMenuItem<String>(
//                                   value: item,
//                                   child: Text(
//                                     item,
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ))
//                             .toList(),
//                     onChanged: (value) {
//                       controller.selectedDistrict.value =
//                           int.parse(value.toString());
//                       print("Selected District ID:" + value.toString());
//                     },
//                     onSaved: (value) {
//                       dropdownvalue = value.toString();
//                     },
//                   )),
//               Obx(() => DropdownButtonFormField2(
//                     hint: Text("Select Locals"),
//                     items: controller
//                         .provinceList[controller.selectedProvince.value]
//                         .districts![controller.selectedDistrict.value]
//                         .localarea!
//                         .map((item) => DropdownMenuItem<String>(
//                               value: item.id.toString(),
//                               child: Text(
//                                 item.localName.toString(),
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ))
//                         .toList(),
//                     onChanged: (value) {
//                       controller.selectedLocal.value =
//                           int.parse(value.toString());
//                       print("Selected Local ID:" + value.toString());
//                     },
//                     onSaved: (value) {
//                       dropdownvalue = value.toString();
//                     },
//                   ))
//             ],
//           ),*/
//           child: Column(
//             children: [
//               /*===========Province===========*/
//               const Align(
//                 alignment: Alignment.topLeft,
//                 child: Text("Province"),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Obx(() => DropdownButtonFormField2(
//                     decoration: InputDecoration(
//                       isDense: true,
//                       contentPadding: EdgeInsets.zero,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                     ),
//                     isExpanded: true,
//                     hint: const Text(
//                       'Select Province',
//                       style: TextStyle(fontSize: 14),
//                     ),
//                     icon: const Icon(
//                       Icons.arrow_drop_down,
//                       color: Colors.black45,
//                     ),
//                     iconSize: 30,
//                     buttonHeight: 50,
//                     buttonPadding: const EdgeInsets.only(left: 20, right: 10),
//                     dropdownDecoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     items: controller.provinceList
//                         .map((item) => DropdownMenuItem<String>(
//                               value: item.id.toString(),
//                               child: Text(
//                                 item.engName.toString(),
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ))
//                         .toList(),
//                     validator: (value) {
//                       if (value == null) {
//                         return 'Please select a province.';
//                       }
//                     },
//                     onChanged: (value) {
//                       controller.selectedProvince.value =
//                           int.parse(value.toString());
//                     },
//                     onSaved: (value) {
//                       dropdownvalue = value.toString();
//                     },
//                   )),
//               const SizedBox(
//                 height: 10,
//               ),
//               /*===========District===========*/
//               const Align(
//                 alignment: Alignment.topLeft,
//                 child: Text("District"),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Obx(() => DropdownButtonFormField2(
//                     decoration: InputDecoration(
//                       isDense: true,
//                       contentPadding: EdgeInsets.zero,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                     ),
//                     isExpanded: true,
//                     hint: const Text(
//                       'Select District',
//                       style: TextStyle(fontSize: 14),
//                     ),
//                     icon: const Icon(
//                       Icons.arrow_drop_down,
//                       color: Colors.black45,
//                     ),
//                     iconSize: 30,
//                     buttonHeight: 50,
//                     buttonPadding: const EdgeInsets.only(left: 20, right: 10),
//                     dropdownDecoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     items: controller.selectedProvince >= 1
//                         ? controller
//                             .provinceList[controller.selectedProvince.value - 1]
//                             .districts!
//                             .map((item) => DropdownMenuItem<String>(
//                                   value: item.id.toString(),
//                                   child: Text(
//                                     item.npName.toString(),
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ))
//                             .toList()
//                         : provinceNotSelectedItems
//                             .map((item) => DropdownMenuItem<String>(
//                                   value: item,
//                                   child: Text(
//                                     item,
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ))
//                             .toList(),
//                     validator: (value) {
//                       if (value == null) {
//                         return 'Please select gender.';
//                       }
//                     },
//                     onChanged: (value) {
//                       controller.selectedDistrict.value =
//                           int.parse(value.toString());
//                       print("Selected District ID:" + value.toString());
//                       //Do something when changing the item if you want.
//                     },
//                     onSaved: (value) {
//                       dropdownvalue = value.toString();
//                     },
//                   )),
//               const SizedBox(
//                 height: 10,
//               ),
//               /*===========Locals===========*/
//               const Align(
//                 alignment: Alignment.topLeft,
//                 child: Text("Local"),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Obx(() => DropdownButtonFormField2(
//                     decoration: InputDecoration(
//                       isDense: true,
//                       contentPadding: EdgeInsets.zero,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       //Add more decoration as you want here
//                       //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
//                     ),
//                     isExpanded: true,
//                     hint: const Text(
//                       'Select Local',
//                       style: TextStyle(fontSize: 14),
//                     ),
//                     icon: const Icon(
//                       Icons.arrow_drop_down,
//                       color: Colors.black45,
//                     ),
//                     iconSize: 30,
//                     buttonHeight: 50,
//                     buttonPadding: const EdgeInsets.only(left: 20, right: 10),
//                     dropdownDecoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     items: controller.selectedProvince >= 1 &&
//                             controller.selectedDistrict >= 1
//                         ? controller
//                             .provinceList[controller.selectedProvince.value - 1]
//                             .districts![controller.selectedDistrict.value - 1]
//                             .localarea!
//                             .map((item) => DropdownMenuItem<String>(
//                                   value: item.id.toString(),
//                                   child: Text(
//                                     item.localName.toString(),
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ))
//                             .toList()
//                         : provinceNotSelectedItems
//                             .map((item) => DropdownMenuItem<String>(
//                                   value: item,
//                                   child: Text(
//                                     item,
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ))
//                             .toList(),
//                     validator: (value) {
//                       if (value == null) {
//                         return 'Please select gender.';
//                       }
//                     },
//                     onChanged: (value) {
//                       //Do something when changing the item if you want.
//                     },
//                     onSaved: (value) {
//                       dropdownvalue = value.toString();
//                     },
//                   )),
//               const SizedBox(
//                 height: 10,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
