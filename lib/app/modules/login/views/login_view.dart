import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/views/forgot_password_view.dart';
import 'package:q_and_u_furniture/app/modules/staffdashboard/controllers/dashboard_controller.dart';
import 'package:q_and_u_furniture/app/routes/app_pages.dart';
import 'package:q_and_u_furniture/app/utils/validators.dart';
import 'package:q_and_u_furniture/app/widgets/custom_buttons.dart';
import 'package:q_and_u_furniture/app/widgets/custom_loading_indicator.dart';
import 'package:q_and_u_furniture/app/widgets/inputfield.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginView extends GetView<LoginController> {
  LoginView({
    super.key,
  });

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyDialog = GlobalKey<FormState>();

  @override
  final controller = Get.put(LoginController());
  final landingcontroller = Get.put(LandingController());
  final dashboardcontroller = Get.put(StaffDashboardController());
  final TextEditingController _facebookEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.fetchSiteDetails();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 40,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: CachedNetworkImage(
                    imageUrl: Uri.encodeFull(
                        controller.siteDetailList[0].value ?? ""),
                    height: 100,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) {
                      return Container(
                        width: 40,
                        height: 40,
                        color: Colors.red,
                        child: const Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'Welcome to Q & U Hongkong Furniture',
                    style: headingStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'Please enter the credentials below to start using the app.',
                    style: subtitleStyle,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                MyInputField(
                  labelText: 'Email',
                  controller: controller.email,
                  textInputAction: TextInputAction.next,
                  validator: (v) => validateEmail(string: v),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => MyInputField(
                    labelText: 'Password',
                    textInputAction: TextInputAction.done,
                    controller: controller.password,
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text(
                        'Forgot password?',
                        style: subtitleStyle.copyWith(
                          color: AppColor.kalaAppMainColor,
                        ),
                      ),
                      onPressed: () {
                        Get.to(
                          () => ForgotPasswordView(),
                        );
                      },
                    ),
                    Expanded(
                      child: Obx(
                        () => CheckboxListTile(
                          activeColor: AppColor.kalaAppMainColor,
                          value: controller.rememberMe.value,
                          onChanged: (value) {
                            controller.rememberMe.value =
                                !controller.rememberMe.value;
                            AppStorage.saveRememberme(value);
                          },
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'Remember Me',
                            style: subtitleStyle,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: controller.loginLoading.isTrue
                        ? CustomButtons(
                            label: '. . . ',
                            txtClr: Colors.white,
                            btnClr: AppColor.kalaAppMainColor,
                            ontap: () {},
                          )
                        : CustomButtons(
                            label: 'Sign In',
                            txtClr: Colors.white,
                            btnClr: AppColor.kalaAppMainColor,
                            ontap: () {
                              if (_formKey.currentState!.validate()) {
                                controller.loginLoading.value
                                    ? null
                                    : controller.login();
                                // then(
                                //         () {
                                //           landingcontroller.onInit();
                                //           landingcontroller.fetchJustForYou(
                                //             landingcontroller
                                //                 .selectedSlug.value,
                                //           );
                                //         },
                                //       );
                                controller.rememberMeData();
                              }
                            },
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // ElevatedButton(
                //   onPressed: () async {
                //     await controller.login();
                //     // await controller.customerLogin(
                //     //   email: "maharjanpragyan0@gmail.com",
                //     //   password: "pragyan",
                //     // );
                //   },
                //   child: const Text("Login"),
                // ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Not a member yet? ',
                      style: subtitleStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Join now',
                          style: subtitleStyle.copyWith(
                            color: AppColor.kalaAppMainColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.toNamed(Routes.REGISTER),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    ' Or sign-up in with',
                    style: subtitleStyle,
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildButton(
                      icon: const Icon(
                        Icons.facebook,
                        color: Colors.white,
                      ),
                      label: "facebook",
                      btnClr: AppColor.facebookColor,
                      txtClr: Colors.white,
                      ontap: () {
                        controller.facebookLogin().then(
                          (value) {
                            if (value["msg"]["email"].contains(
                              "The email must be a valid email address.",
                            )) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Form(
                                    key: _formKeyDialog,
                                    child: AlertDialog(
                                      title: const Text(
                                        'Email was not found in your facebook account. Please enter your email and try again',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                        ),
                                      ),
                                      content: TextFormField(
                                        validator: (v) =>
                                            validateEmail(string: v),
                                        controller: _facebookEmail,
                                        decoration: const InputDecoration(
                                          hintText: 'Enter your email',
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            if (_formKeyDialog.currentState!
                                                .validate()) {
                                              controller
                                                  .facebookLoginWithTextField(
                                                email: _facebookEmail.text,
                                              );
                                              Navigator.of(context).pop();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else {
                              log("String is not present");
                            }
                          },
                        );
                      },
                    ),
                    _buildButton(
                      icon: Image.asset(
                        "assets/images/google.png",
                        height: 20,
                      ),
                      label: "Google",
                      btnClr: Colors.white,
                      txtClr: Colors.black,
                      ontap: () {
                        controller.googleLogin();
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: controller.staffLoginLoading.isTrue
                      ? const CustomLoadingIndicator(
                          isCircle: true,
                        )
                      : CustomButtons(
                          label: 'Sign In as Staff',
                          txtClr: Colors.white,
                          btnClr: AppColor.kalaAppSecondaryColor2,
                          ontap: () {
                            _staffpopDialog(context);
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _staffpopDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.logo,
                height: 50,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text('Staff Login'),
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.99,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyInputField(
                  labelText: 'Email',
                  controller: controller.emailstaff,
                  validator: (v) => validateEmail(string: v),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => MyInputField(
                    labelText: 'Password',
                    controller: controller.passwordstaff,
                    suffix: IconButton(
                      onPressed: () {
                        controller.viewPasswordstaff.value =
                            !controller.viewPasswordstaff.value;
                      },
                      icon: Icon(
                        controller.viewPasswordstaff.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20.sp,
                        color: AppColor.kalaAppMainColor,
                      ),
                    ),
                    obscuretext: controller.viewPasswordstaff.value,
                    validator: (v) => validatePassword(string: v),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          actions: [
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: controller.loginLoading.isTrue
                      ? CustomButtons(
                          label: '. . . ',
                          txtClr: Colors.white,
                          btnClr: AppColor.kalaAppMainColor,
                          ontap: () {},
                        )
                      : CustomButtons(
                          label: 'Sign In',
                          txtClr: Colors.white,
                          btnClr: AppColor.kalaAppMainColor,
                          ontap: () {
                            controller.loginDelivery();
                          },
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _buildButton({
    required Widget icon,
    required String label,
    required Color btnClr,
    required Color txtClr,
    required void Function()? ontap,
  }) {
    return SizedBox(
      height: 50,
      width: 40.w,
      child: MaterialButton(
        onPressed: ontap,
        elevation: 5,
        color: btnClr,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(
              width: 10,
            ),
            Text(
              label,
              style: titleStyle.copyWith(
                color: txtClr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
