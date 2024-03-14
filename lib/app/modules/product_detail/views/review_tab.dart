import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/components/qna_view.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/controllers/product_detail_controller.dart';
import 'package:q_and_u_furniture/app/utils/validators.dart';
import 'package:q_and_u_furniture/app/widgets/circular_icons.dart';
import 'package:q_and_u_furniture/app/widgets/custom_button.dart';
import 'package:q_and_u_furniture/app/widgets/inputfield.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ReviewTab extends StatefulWidget {
  const ReviewTab({
    Key? key,
  }) : super(key: key);

  @override
  State<ReviewTab> createState() => _ReviewTabState();
}

class _ReviewTabState extends State<ReviewTab> {
  final ProductDetailController controller = Get.put(
    ProductDetailController(),
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ListTile _buildQueAnsTile({
    required bool questions,
    required String question,
    required String name,
  }) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(
        horizontal: 0,
        vertical: -4,
      ),
      leading: CircleAvatar(
        backgroundColor: questions ? AppColor.kalaAppMainColor : Colors.grey,
        radius: 12,
        child: Text(
          questions ? 'Q' : 'A',
          style: subtitleStyle.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 5,
      title: Text(
        question,
        style: subtitleStyle,
      ),
      subtitle: Text(
        name,
        style: subtitleStyle.copyWith(
          fontSize: 12.sp,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Questions about this product',
              style: titleStyle,
            ),
            GestureDetector(
              onTap: () {
                Get.to(
                  () => QnAView(
                    id: controller.productdetail.value.id!.toInt(),
                  ),
                );
              },
              child: Text(
                'View all',
                style: subtitleStyle.copyWith(
                  color: AppColor.kalaAppMainColor,
                ),
              ),
            )
          ],
        ),
        Obx(
          () => controller.questionAnsList.isNotEmpty
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.questionAnsList.length >= 2 ? 2 : 1,
                  itemBuilder: (context, index) {
                    var data = controller.questionAnsList[index];

                    return Column(
                      children: [
                        _buildQueAnsTile(
                          questions: true,
                          question: data.questionAnswer ?? "N/A",
                          name: data.user?.name ?? "N/A",
                        ),
                        controller.questionAnsList[index].answer
                                    ?.questionAnswer ==
                                null
                            ? const SizedBox()
                            : _buildQueAnsTile(
                                questions: false,
                                question: data.answer?.questionAnswer ?? "N/A",
                                // name: data.user?.name ?? "N/A",
                                name: "",
                              ),
                      ],
                    );
                  },
                )
              : const SizedBox(),
        ),
        Center(
          child: TextButton(
            onPressed: () {
              if (AppStorage.readIsLoggedIn != true) {
                getSnackbar(message: "Please Login to ask a question.");
                return;
              }

              Get.bottomSheet(
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: defaultContainerRadius,
                      topRight: defaultContainerRadius,
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CustomCircularIcon(),
                        const SizedBox(
                          height: 10,
                        ),
                        MyInputField(
                          labelText: 'Question',
                          controller: controller.qna,
                          validator: (v) => validateIsEmpty(string: v),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: CustomButton(
                            label: 'Submit',
                            btnClr: AppColor.kalaAppMainColor,
                            txtClr: Colors.white,
                            ontap: () async {
                              Get.back();
                              if (_formKey.currentState!.validate()) {
                                await controller.postQues(
                                  controller.productdetail.value.id,
                                );
                                controller.fetchQuesAns(
                                  controller.productdetail.value.id,
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: Text(
              'Ask a question',
              style: titleStyle.copyWith(color: AppColor.kalaAppMainColor),
            ),
          ),
        ),
      ],
    );
  }
}
