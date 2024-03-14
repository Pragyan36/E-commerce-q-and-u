import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:q_and_u_furniture/app/modules/department/controllers/department_controller.dart';
import 'package:q_and_u_furniture/app/modules/department/views/department_view.dart';
import 'package:q_and_u_furniture/app/widgets/custom_searchbar.dart';

import '../../../constants/constants.dart';

class DepartmentViewAllView extends StatefulWidget {
  const DepartmentViewAllView({Key? key}) : super(key: key);

  @override
  State<DepartmentViewAllView> createState() => _DepartmentViewAllViewState();
}

class _DepartmentViewAllViewState extends State<DepartmentViewAllView> {
  final controller = Get.put(DepartmentController());

  final List<Map> types = [
    {'label': 'All', 'id': 0},
    {'label': 'Men', 'id': 1},
    {'label': 'Women', 'id': 2},
    {'label': 'Kids', 'id': 3},
    {'label': 'Young adult', 'id': 4},
    {'label': 'Sweat shirts', 'id': 5},
  ];

  final List<String> items = [
    'New In ',
    'Clothing',
    'Shoes',
    'Sportswear',
    'Accessories'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomSearchBar(),
            ),
            const SizedBox(
              height: 20,
            ),
            _buildTypeSlider(),
            const SizedBox(
              height: 20,
            ),
            buildAdCard(),
            const SizedBox(
              height: 20,
            ),
            ...List.generate(
              items.length,
              (index) => _buildItemListtile(
                items[index],
                Image.asset(AppImages.shoes),
                () {
                  Get.to(() => DepartmentView());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTypeSlider() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...List.generate(
                types.length,
                (index) => Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Obx(
                        () => MaterialButton(
                            color: controller.selectedIndex.value ==
                                    types[index]['id']
                                ? AppColor.kalaAppMainColor
                                : Colors.white,
                            height: 40,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: controller.selectedIndex.value ==
                                        types[index]['id']
                                    ? AppColor.kalaAppAccentColor
                                    : Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            highlightColor: Colors.grey.shade200,
                            child: Text(
                              types[index]['label'],
                              style: subtitleStyle.copyWith(
                                  color: controller.selectedIndex.value ==
                                          types[index]['id']
                                      ? Colors.white
                                      : Colors.grey.shade600),
                            ),
                            onPressed: () {
                              controller.selectedIndex.value =
                                  types[index]['id'];
                            }),
                      ),
                    ))
          ],
        ));
  }

  buildAdCard() {
    return Container(
      width: double.infinity,
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColor.mainClr,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'GET ',
                      style: titleStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontStyle: FontStyle.italic)),
                  TextSpan(
                      text: '20% ',
                      style: titleStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                          fontStyle: FontStyle.italic)),
                  TextSpan(
                      text: 'OFF',
                      style: titleStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontStyle: FontStyle.italic)),
                ])),
                Text(
                  'EVERYTHING',
                  style: titleStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'With Code: U-soft004',
                  style: subtitleStyle.copyWith(
                      color: Colors.white, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          Container(
            height: 120,
            padding: const EdgeInsets.only(right: 30),
            child: Image.asset(
              AppImages.shoes,
            ),
          )
        ],
      ),
    );
  }

  _buildItemListtile(title, img, ontap) {
    return ListTile(
      leading: img,
      title: Text(
        title,
        style: titleStyle.copyWith(fontWeight: FontWeight.bold),
      ),
      onTap: ontap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.black54,
        size: 20.sp,
      ),
    );
  }
}
