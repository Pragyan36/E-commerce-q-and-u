import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/modules/home/views/home_view.dart';
import 'package:q_and_u_furniture/app/modules/landing/views/landing_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/utils/validators.dart';
import 'package:q_and_u_furniture/app/widgets/custom_button.dart';
import 'package:q_and_u_furniture/app/widgets/inputfield.dart';

import '../../../constants/constants.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({Key? key}) : super(key: key);

  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit'),
              content: const Text('Do you want to exit?'),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColor.mainClr, // Set the button's background color
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(false); // Return false to prevent exiting
                  },
                  child: const Text('No'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor
                        .kalaAppMainColor, // Set the button's background color
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true); // Return true to exit
                  },
                  child: const Text('Yes'),
                ),
              ],
            ),
          );
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Image.asset(AppImages.logo),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Reset Password',
                      style: headingStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Password should contain atleast 6 characters',
                      style: subtitleStyle.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => MyInputField(
                        labelText: 'New Password',
                        controller: controller.newpassword,
                        suffix: IconButton(
                            onPressed: () {
                              controller.viewPassword.value =
                                  !controller.viewPassword.value;
                            },
                            icon: Icon(
                              controller.viewPassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 20.sp,
                              color: AppColor.kalaAppMainColor,
                            )),
                        obscuretext: controller.viewPassword.value,
                        validator: (v) => validatePassword(string: v),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => MyInputField(
                        labelText: 'Confirm Password',
                        controller: controller.confirmpassword,
                        suffix: IconButton(
                            onPressed: () {
                              controller.viewPassword1.value =
                                  !controller.viewPassword1.value;
                            },
                            icon: Icon(
                              controller.viewPassword1.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 20.sp,
                              color: AppColor.kalaAppMainColor,
                            )),
                        obscuretext: controller.viewPassword1.value,
                        validator: (v) => confirmPassword(
                            password: controller.newpassword.text,
                            cPassword: v),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        label: 'Reset Password',
                        btnClr: AppColor.kalaAppMainColor,
                        txtClr: Colors.white,
                        ontap: () {
                          if (_formKey.currentState!.validate()) {
                            controller.resetPassword();
                            if (controller.loading.isTrue) {
                              Get.defaultDialog(
                                  title: 'Loading',
                                  content: const CircularProgressIndicator());
                            } else {
                              if (_formKey.currentState!.validate()) {
                                controller.loginLoading.value
                                    ? null
                                    : controller.resetPassword();
                                // then(
                                //         () {
                                //           landingcontroller.onInit();
                                //           landingcontroller.fetchJustForYou(
                                //             landingcontroller
                                //                 .selectedSlug.value,
                                //           );
                                //         },
                                //       );
                                // controller.rememberMeData();
                              }
                            }
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
