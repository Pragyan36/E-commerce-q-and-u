import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/views/reset_password_view.dart';
import 'package:q_and_u_furniture/app/utils/validators.dart';
import 'package:q_and_u_furniture/app/widgets/circular_icons.dart';
import 'package:q_and_u_furniture/app/widgets/custom_buttons.dart';
import 'package:q_and_u_furniture/app/widgets/inputfield.dart';

import '../../../constants/constants.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({Key? key}) : super(key: key);

  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const CustomCircularIcon(),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Image.asset(
                    AppImages.logo,
                    height: 150,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Recovery Password',
                  style: headingStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Please enter your email below to receive your password reset instruction',
                  style: subtitleStyle.copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyInputField(
                  labelText: 'Example@gmail.com',
                  controller: controller.otpEmail,
                  validator: (v) => validateEmail(string: v),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    child: CustomButtons(
                      label:
                          controller.load.isFalse ? 'Send OTP' : 'Loading...',
                      btnClr: AppColor.kalaAppMainColor,
                      txtClr: Colors.white,
                      ontap: () {
                        if (_formKey.currentState!.validate()) {
                          controller.sendOtp();
                          if (controller.loading.isTrue) {
                            Get.defaultDialog(
                                title: 'Loading',
                                content: const CircularProgressIndicator());
                          } else {
                            Get.to(ResetPasswordView());
                          }
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
