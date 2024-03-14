import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/search/controllers/search_controller.dart';
import 'package:q_and_u_furniture/app/modules/search/views/search_panel.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final controller = Get.put(
    CustomSearchController(),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const Hero(
                tag: "searchBar",
                child: SearchPanel(),
              );
            },
          ),
        );
      },
      child: Container(
        height: 35,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColor.kalaAppAccentColor,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Icon(
              Icons.search,
              color: Colors.black,
              size: 20.sp,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Search Products',
              style: subtitleStyle.copyWith(color: Colors.black),
            ),
            const Spacer(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Icon(
                //   Iconsax.scan,
                //   color: Colors.black,
                // ),
                SizedBox(
                  width: 10,
                ),
                // Icon(
                //   Icons.keyboard_voice_outlined,
                //   color: Colors.black,
                // ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
