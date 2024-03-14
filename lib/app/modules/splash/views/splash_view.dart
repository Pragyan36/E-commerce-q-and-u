import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/splash/controllers/splash_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_loading_indicator.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final controller = Get.put(
    SplashController(),

  );

  @override
  void initState() {
   controller.  onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kalaAppAccentColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 200,
              child: Image.asset(
                AppImages.kalaAppLogo,
              ),
            ),
          ),
          // const CustomLoadingIndicator(
          //   isCircle: false,
          // ),
        ],
      ),
    );
  }
}
