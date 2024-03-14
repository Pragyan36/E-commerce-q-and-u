import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/account_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_button.dart';

class MyRewards extends StatefulWidget {
  const MyRewards({Key? key}) : super(key: key);

  @override
  State<MyRewards> createState() => _MyRewardsState();
}

class _MyRewardsState extends State<MyRewards> {
  final controller = Get.put(AccountController());

  @override
  void initState() {
    controller.getUser();
    controller.fetchReward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'My Rewards'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Obx(
              () => _buildRewardBanner(),
            ),
            _buildDottedContainer(),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Refer you friends to join usoft through your referral code and earn reward points',
              style: subtitleStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              label: 'Share',
              btnClr: AppColor.kalaAppMainColor,
              txtClr: Colors.white,
              ontap: () {
                controller.share();
              },
            )
          ],
        ),
      ),
    );
  }

  _buildRewardBanner() {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.mainClr,
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You have accumulated\nreward points',
                style: titleStyle.copyWith(
                    color: Colors.white, fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 10,
              ),
              controller.rewardData.value.totalPoints != null
                  ? Text(
                      "Total Point: ${controller.rewardData.value.totalPoints.toString()}",
                      style: headingStyle.copyWith(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      "No Point",
                      style: headingStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
            ],
          ),
          Image.asset(
            'assets/images/reward.png',
            height: 100,
          ),
        ],
      ),
    );
  }

  _buildDottedContainer() {
    return DottedBorder(
      borderType: BorderType.RRect,
      dashPattern: const [6, 3],
      strokeWidth: 1,
      color: Colors.grey,
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Refer And earn ${controller.rewardData.value.pointsValue}',
                  style: titleStyle.copyWith(color: Colors.black45)),
              Text(
                controller.userdata.value.referal_code.toString() == "null"
                    ? "Not generated"
                    : controller.userdata.value.referal_code.toString(),
                style: headingStyle.copyWith(
                  color: AppColor.kalaAppMainColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
