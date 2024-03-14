import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/modules/home/views/home_view.dart';
import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';
import 'package:q_and_u_furniture/app/modules/staffdashboard/views/dashboard_view.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';
import 'package:q_and_u_furniture/main.dart';

class SplashController extends GetxController {
  var result = false.obs;
  final controller = Get.put(LandingController());
  final homecontroller = Get.put(HomeController());

  @override
  void onInit() {
    super.onInit();
    checkInternet();
    nextScreen();
    controller.onInit();
    homecontroller.fetchskipads();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        getToken();
      },
    );
  }

  var firetoken = ''.obs;

  getToken() async {
    if (isFirebaseInitialized) {
      firetoken.value = (await FirebaseMessaging.instance.getToken())!;
    } else {
      /*Initialize Firebase app*/
      await Firebase.initializeApp();
      firetoken.value = (await FirebaseMessaging.instance.getToken())!;
    }
  }

  checkInternet() async {
    result.value = (await InternetConnectionChecker().hasConnection);
    if (result.value == true) {
    } else {
      getSnackbar(
        bgColor: Colors.red,
        message: "No internet connection",
        error: true,
      );
    }
  }

  nextScreen() async {
    await Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.offAll(() => AppStorage.readIsStaffLoggedIn == true
            ? const StaffDashboard()
            : const HomeView());
      },
    );
  }
}
