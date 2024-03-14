import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';

import '../constants/constants.dart';
import '../modules/splash/controllers/splash_controller.dart';
import '../modules/splash/views/splash_view.dart';

class NoInternetLayout extends StatelessWidget {
  const NoInternetLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("No Internet Connection"),
          MaterialButton(
              color: AppColor.mainClr,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: const Text(
                "Refresh",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (await Connectivity().checkConnectivity() ==
                    ConnectivityResult.none) {
                  getSnackbar(
                      message: "Still Not Connected to Internet",
                      error: true,
                      bgColor: Colors.red);
                } else {
                  final splashController = Get.put(SplashController());
                  splashController.onInit();
                  Get.offAll(const SplashView());
                }
              }),
        ],
      ),
    );
  }
}
