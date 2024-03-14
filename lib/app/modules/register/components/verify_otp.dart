import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:q_and_u_furniture/app/modules/register/controllers/register_controller.dart';

import '../../../constants/constants.dart';
import '../../../utils/validators.dart';
import '../../../widgets/custom_button.dart';

class VerifyOtpScreen extends StatelessWidget {
  VerifyOtpScreen({super.key});
  final controller = Get.put(RegisterController());
  final _formKey = GlobalKey<FormState>();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Image.asset(
                AppImages.logo,
                height: 100,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              'Verify Email or Phone',
              style: headingStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'An authentication code have been sent to your email/phone',
              style: subtitleStyle.copyWith(color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            // OTPTextField(
            //   length: 6,
            //   width: MediaQuery.of(context).size.width,
            //   fieldWidth: 40,
            //   controller: controller.otpController,
            //   style: const TextStyle(fontSize: 17),
            //   textFieldAlignment: MainAxisAlignment.spaceAround,
            //   fieldStyle: FieldStyle.underline,
            //   onCompleted: (pin) {
            //     // ignore: avoid_print
            //     print("Completed: $pin");
            //     controller.verifyUser(pin);
            //   },
            //   onChanged: (v) {},
            // ),
            Form(
              key: _formKey,
              child: Pinput(
                defaultPinTheme: defaultPinTheme,
                length: 6,
                // validator: (s) {
                //   return s == '2222' ? null : 'Pin is incorrect';
                // },
                validator: (value) => validateIsEmpty(string: value.toString()),
                controller: controller.pinputController,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsRetrieverApi,
                listenForMultipleSmsOnAndroid: true,

                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                controller.resendOtp();
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Didnt \'s receive code? ',
                      style: subtitleStyle.copyWith(color: Colors.grey),
                    ),
                    TextSpan(
                      text: 'Resend',
                      style: subtitleStyle.copyWith(color: AppColor.mainClr),
                      // recognizer: TapGestureRecognizer()
                      //   ..onTap = () {
                      //     print('asdsad');
                      //     // controller.resendOtp();
                      //   }
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                label: 'Continue',
                btnClr: AppColor.kalaAppMainColor,
                txtClr: Colors.white,
                ontap: () {
                  if (_formKey.currentState!.validate()) {
                    controller.verifyUser(controller.pinputController.text);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
