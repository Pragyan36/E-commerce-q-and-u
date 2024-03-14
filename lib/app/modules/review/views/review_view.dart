import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_button.dart';
import 'package:q_and_u_furniture/app/widgets/inputfield.dart';

import '../controllers/review_controller.dart';

class ReviewView extends GetView<ReviewController> {
  ReviewView({Key? key}) : super(key: key);
  final List<Map> comm = [
    {'comment': 'Love it', 'id': 0},
    {'comment': 'Great Product!', 'id': 1},
    {'comment': 'Recommended', 'id': 2},
    {'comment': 'Original Material', 'id': 3},
    {'comment': 'Awesome Service', 'id': 4}
  ];

  final List<Map> emoji = [
    {'icon1': Iconsax.emoji_happy, 'icon2': Iconsax.emoji_happy5, 'id': 0},
    {'icon1': Iconsax.emoji_normal, 'icon2': Iconsax.emoji_normal5, 'id': 1},
    {'icon1': Iconsax.emoji_sad, 'icon2': Iconsax.emoji_sad5, 'id': 2},
    {'icon1': Iconsax.emoji_normal, 'icon2': Iconsax.emoji_normal, 'id': 3},
    {'icon1': Iconsax.emoji_normal, 'icon2': Iconsax.emoji_normal, 'id': 4},
    {'icon1': Iconsax.emoji_normal, 'icon2': Iconsax.emoji_normal, 'id': 5},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Review'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ListTile(
                visualDensity: const VisualDensity(vertical: 4),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                leading: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(
                    AppImages.shoes,
                  ),
                ),
                title: Text(
                  'Nike Academy Team\n- sports bag',
                  style: titleStyle,
                ),
              ),
              Text(
                'Upload Image',
                style: subtitleStyle,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                      5,
                      (index) => Icon(
                            Iconsax.star1,
                            color: Colors.amber,
                            size: 30.sp,
                          ))
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 10,
                children: [
                  ...List.generate(
                      comm.length,
                      (index) => Obx(
                            () => MaterialButton(
                                color: controller.selectedindex.value ==
                                        comm[index]['id']
                                    ? AppColor.kalaAppMainColor
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  comm[index]['comment'],
                                  style: subtitleStyle.copyWith(
                                      color: controller.selectedindex.value ==
                                              comm[index]['id']
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                onPressed: () {
                                  controller.selectedindex.value =
                                      comm[index]['id'];
                                  controller.commentCon.text =
                                      comm[index]['comment'];
                                }),
                          ))
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'So what you think about the product',
                style: subtitleStyle.copyWith(color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
              ),
              MyInputField(
                labelText: 'hint',
                ismultiline: true,
                controller: controller.commentCon,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'How was your seller service?',
                style: subtitleStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                      emoji.length,
                      (index) => Obx(
                            () => IconButton(
                                onPressed: () {
                                  controller.selectedEmojiindex.value =
                                      emoji[index]['id'];
                                },
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                icon: Icon(
                                  controller.selectedEmojiindex.value ==
                                          emoji[index]['id']
                                      ? emoji[index]['icon2']
                                      : emoji[index]['icon1'],
                                  size: 25.sp,
                                  color: controller.selectedEmojiindex.value ==
                                          emoji[index]['id']
                                      ? AppColor.kalaAppMainColor
                                      : Colors.grey,
                                )),
                          ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                    label: 'Send Feedback',
                    btnClr: AppColor.kalaAppMainColor,
                    txtClr: Colors.white,
                    ontap: () {}),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
