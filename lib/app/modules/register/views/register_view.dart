import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/register/controllers/register_controller.dart';
import 'package:q_and_u_furniture/app/routes/app_pages.dart';
import 'package:q_and_u_furniture/app/utils/validators.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_buttons.dart';
import 'package:q_and_u_furniture/app/widgets/inputfield.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _districtKey = GlobalKey<FormState>();
  final _areaKey = GlobalKey<FormState>();
  final _provinceKey = GlobalKey<FormState>();
  final loginCon = Get.put(
    LoginController(),
  );

  @override
  final loginController = Get.put(
    RegisterController(),
  );

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Register New User",
        trailing: const SizedBox(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: Uri.encodeFull(
                            loginCon.siteDetailList[0].value ?? ""),
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
                      height: 40,
                    ),
                    Text(
                      'Create a new account',
                      style: headingStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Please enter the credentials below to start using the application.',
                      style: subtitleStyle,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    MyInputField(
                      labelText: 'Full Name',
                      controller: loginController.name,
                      inputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (v) => validateIsEmpty(
                        string: v,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyInputField(
                      labelText: 'Email',
                      inputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      controller: loginController.email,
                      validator: (v) => validateEmail(
                        string: v,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyInputField(
                      labelText: 'Phone',
                      inputType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      controller: loginController.phone,
                      validator: (v) => validatePhone(
                        string: v,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // MyInputField(
                    //   labelText: 'Additional Address (Optional)',
                    //   controller: loginController.address,
                    //   textInputAction: TextInputAction.next,
                    //   inputType: TextInputType.streetAddress,
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // MyInputField(
                    //   labelText: 'Zip Code (Optional)',
                    //   controller: loginController.zip,
                    //   inputType: TextInputType.number,
                    //   textInputAction: TextInputAction.next,
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // _buildAddress(),
                    Obx(
                      () => MyInputField(
                        labelText: 'Password',
                        textInputAction: TextInputAction.next,
                        inputType: TextInputType.text,
                        suffix: IconButton(
                          onPressed: () {
                            loginController.viewPassword.value =
                                !loginController.viewPassword.value;
                          },
                          icon: loginController.viewPassword.value
                              ? Icon(
                                  Icons.visibility_off,
                                  size: 20.sp,
                                )
                              : Icon(
                                  Icons.password,
                                  size: 20.sp,
                                ),
                        ),
                        obscuretext: loginController.viewPassword.value,
                        controller: loginController.password,
                        validator: (v) => validateIsEmpty(
                          string: v,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => MyInputField(
                        labelText: 'Confirm Password',
                        textInputAction: TextInputAction.next,
                        inputType: TextInputType.text,
                        suffix: IconButton(
                          onPressed: () {
                            loginController.viewConPassword.value =
                                !loginController.viewConPassword.value;
                          },
                          icon: loginController.viewConPassword.value
                              ? Icon(
                                  Icons.visibility_off,
                                  size: 20.sp,
                                )
                              : Icon(
                                  Icons.password,
                                  size: 20.sp,
                                ),
                        ),
                        obscuretext: loginController.viewConPassword.value,
                        controller: loginController.confirmpassword,
                        validator: (v) => confirmPassword(
                          password: loginController.password.text,
                          cPassword: v,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // MyInputField(
                    //   labelText: 'Referral Code (Optional)',
                    //   textInputAction: TextInputAction.done,
                    //   controller: loginController.referalCode,
                    // ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: CustomButtons(
                        label: 'Sign Up',
                        txtClr: Colors.white,
                        btnClr: AppColor.kalaAppMainColor,
                        ontap: () async {
                          if (_formKey.currentState!.validate()) {
                            await loginController.register();
                          } else {
                            getSnackbar(
                              message:
                                  "Please fill all the required information",
                              bgColor: Colors.red,
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Already a member? ',
                          style: subtitleStyle,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Log In',
                              style: subtitleStyle.copyWith(
                                color: AppColor.kalaAppMainColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.toNamed(Routes.LOGIN),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).viewPadding.bottom,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildAddress() {
    return Obx(
      () => loginController.loading.value
          ? Container()
          : Column(
              children: [
                /*---------------Province--------*/
                // Form(
                // key: _provinceKey,
                Focus(
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade300.withOpacity(0.4),
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.only(
                        left: 0,
                        right: 0,
                        top: 5,
                        bottom: 5,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    isExpanded: true,
                    hint: Text(
                      'Select Province',
                      style: subtitleStyle.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    buttonHeight: 40,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    items: loginController.addresses
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item.id.toString(),
                            onTap: () {
                              loginController.selectedProvinceName =
                                  item.engName.toString();
                            },
                            child: Text(
                              item.engName.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select province.';
                      }
                    },
                    onChanged: (value) {
                      _districtKey.currentState!.reset();
                      _areaKey.currentState!.reset();
                      loginController.districts.clear();
                      loginController
                          .addresses[int.parse(value.toString()) - 1].districts
                          ?.forEach(
                        (element) {
                          loginController.districts.add(element);
                        },
                      );
                    },
                    onSaved: (value) {},
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                /*----------District-----------*/
                Form(
                  key: _districtKey,
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade300.withOpacity(0.4),
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.only(
                        left: 0,
                        right: 0,
                        top: 5,
                        bottom: 5,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    isExpanded: true,
                    hint: Text(
                      'Select District',
                      style: subtitleStyle.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    buttonHeight: 40,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    items: loginController.districts
                        .map(
                          (item) => DropdownMenuItem<String>(
                            onTap: () {
                              loginController.selectedDistrictName =
                                  item.npName.toString();
                            },
                            value: item.id.toString(),
                            child: Text(
                              item.npName.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select district.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _areaKey.currentState!.reset();
                      loginController.selectedDistrict
                          .addAll(loginController.districts);

                      loginController.selectedDistrict.retainWhere(
                        (element) =>
                            element.id ==
                            int.parse(
                              value.toString(),
                            ),
                      );
                      loginController.areas.clear();
                      loginController.selectedDistrict[0].localarea?.forEach(
                        (element) {
                          loginController.areas.add(element);
                        },
                      );
                    },
                    onSaved: (value) {},
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                /*------------Area-----------*/
                Form(
                  key: _areaKey,
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade300.withOpacity(0.4),
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.only(
                        left: 0,
                        right: 0,
                        top: 5,
                        bottom: 5,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    isExpanded: true,
                    hint: Text(
                      'Select Area',
                      style: subtitleStyle.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    buttonHeight: 40,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    items: loginController.areas
                        .map(
                          (item) => DropdownMenuItem<String>(
                            onTap: () {
                              loginController.selectedAreaName =
                                  item.localName.toString();
                            },
                            value: item.id.toString(),
                            child: Text(
                              item.localName.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select area.';
                      }
                      return null;
                    },
                    onChanged: (value) {},
                    onSaved: (value) {},
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                /*-----------Others--------*/
              ],
            ),
    );
  }
}
