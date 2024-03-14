import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/account_controller.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/contact_controller.dart';
import 'package:q_and_u_furniture/app/utils/validators.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_button.dart';
import 'package:q_and_u_furniture/app/widgets/inputfield.dart';

class ContactusView extends StatelessWidget {
  ContactusView({Key? key}) : super(key: key);
  final controller = Get.put(ContactController());
  final acccontroller = Get.put(AccountController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Contact Us',
        trailing: Container(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  child: Card(
                    borderOnForeground: true,
                    child: ListTile(
                      leading: const Icon(
                        Icons.phone_android_outlined,
                      ),
                      title: Text(
                        'Contact our customer care center',
                        style: titleStyle,
                      ),
                      subtitle: Text(
                        acccontroller.sitedetail.elementAt(2).value.toString(),
                        style: subtitleStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    controller.launchCaller(
                      "tel:${acccontroller.sitedetail.elementAt(2).value}",
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  borderOnForeground: true,
                  child: ListTile(
                    leading: const Icon(
                      Icons.mail_outline,
                    ),
                    title: Text(
                      'Send us a message',
                      style: titleStyle,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyInputField(
                  labelText: 'FULL NAME',
                  controller: controller.fullname,
                  validator: (v) => validateIsEmpty(string: v),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyInputField(
                  labelText: 'Phone Number',
                  inputType: TextInputType.number,
                  controller: controller.phone,
                  validator: (v) => validatePhone(string: v),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyInputField(
                  labelText: 'Email',
                  controller: controller.email,
                  validator: (v) => validateEmail(string: v),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyInputField(
                  labelText: 'Your message is about',
                  controller: controller.title,
                  validator: (v) => validateIsEmpty(string: v),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyInputField(
                  labelText: 'Please Explain Issue',
                  ismultiline: true,
                  controller: controller.issue,
                  validator: (v) => validateIsEmpty(string: v),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    label: 'SEND MESSAGE',
                    btnClr: AppColor.kalaAppMainColor,
                    txtClr: Colors.white,
                    ontap: () {
                      if (_formKey.currentState!.validate()) {
                        controller.postMsg();
                      }
                    },
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
