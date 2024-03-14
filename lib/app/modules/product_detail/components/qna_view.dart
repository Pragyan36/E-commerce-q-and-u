import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/controllers/product_detail_controller.dart';
import 'package:q_and_u_furniture/app/widgets/nodata.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class QnAView extends StatelessWidget {
  QnAView({Key? key, required this.id}) : super(key: key);

  final controller = Get.put(ProductDetailController());

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            )),
        title: Text(
          'Questions and Answers',
          style: titleStyle.copyWith(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: controller.questionAnsList.isEmpty
            ? const NoDataView(
                text: 'No data available',
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      _buildQueAnsTile(
                          questions: true,
                          ques:
                              controller.questionAnsList[index].questionAnswer,
                          name: controller.questionAnsList[index].user?.name),
                      controller.questionAnsList[index].answer
                                  ?.questionAnswer ==
                              null
                          ? Container()
                          : _buildQueAnsTile(
                              questions: false,
                              ques: controller.questionAnsList[index].answer
                                  ?.questionAnswer,
                              name: controller
                                  .questionAnsList[index].answer?.user?.name),
                    ],
                  );
                },
                separatorBuilder: (context, i) {
                  return const Divider();
                },
                itemCount: controller.questionAnsList.length,
              ),
      ),
    );
  }

  _buildQueAnsTile({
    required bool questions,
    ques,
    name,
  }) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      leading: CircleAvatar(
        backgroundColor: questions ? AppColor.kalaAppMainColor : Colors.grey,
        radius: 12,
        child: Text(
          questions ? 'Q' : 'A',
          style: subtitleStyle.copyWith(color: Colors.white),
        ),
      ),
      minLeadingWidth: 5,
      title: Text(
        ques ?? 'null',
        style: subtitleStyle,
      ),
      subtitle: Text(
        name ?? 'null',
        style: subtitleStyle.copyWith(fontSize: 12.sp),
      ),
    );
  }
}
