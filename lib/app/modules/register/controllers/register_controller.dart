// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:q_and_u_furniture/app/data/models/shipping_address_model.dart';
import 'package:q_and_u_furniture/app/data/services/auth_service.dart';
import 'package:q_and_u_furniture/app/modules/register/components/verify_otp.dart';
import 'package:q_and_u_furniture/app/routes/app_pages.dart';
import 'package:q_and_u_furniture/app/widgets/loading_widget.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';
import 'package:smart_auth/smart_auth.dart';

class RegisterController extends GetxController {
  final TextEditingController name = TextEditingController();
  final TextEditingController referalCode = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController zip = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  final OtpFieldController otpController = OtpFieldController();

  final RxInt count = 0.obs;
  RxList<ShippingAddressData> addresses = <ShippingAddressData>[].obs;
  var addressdata = ShippingAddress().obs;
  var districts = <Districts>[].obs;
  var selectedDistrict = <Districts>[].obs;
  var areas = <Localarea>[].obs;
  var loading = false.obs;
  var viewPassword = true.obs;
  var viewConPassword = true.obs;

  var selectedProvinceName = '';
  var selectedDistrictName = '';
  var selectedAreaName = '';
  var registerLoading = false.obs;

  @override
  void onInit() {
    fetchAddresses();
    getAppSignature();
    smsRetriever();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    name.dispose();
    referalCode.dispose();
    email.dispose();
    phone.dispose();
    address.dispose();
    zip.dispose();
    password.dispose();
    confirmpassword.dispose();
    super.onClose();
  }

  void increment() => count.value++;
  var userPhone = "".obs;

  register() async {
    registerLoading.value = true;
    log("RegisterController:register");
    Get.defaultDialog(content: const LoadingWidget(), title: 'Loading...');
    var data = await AuthService().register(
        name: name.text,
        email: email.text,
        password: password.text,
        confirmPassword: confirmpassword.text,
        phone: phone.text,
        address: address.text,
        photo: "",
        province: selectedProvinceName,
        district: selectedDistrictName,
        area: selectedAreaName,
        zip: zip.text,
        referalCode: referalCode.text);
    if (data != null) {
      await Future.delayed(const Duration(seconds: 2));
      registerLoading.value = false;
      Get.back();
      if (data['error'] == false) {
        userPhone.value = phone.text;
        getSnackbar(message: data['message']);
        // Get.offAllNamed(Routes.LOGIN);
        Get.to(() => VerifyOtpScreen());
      }
      if (data['error'] == true) {
        getSnackbar(message: data['msg']);
        // if (data['msg'] != null && data['msg']['referal_code'] != null) {
        //   getSnackbar(message: data['msg']["referal_code"][0]);
        // }
      }
    }
  }

  fetchAddresses() async {
    loading.value = true;
    var data = await AuthService().getAddresses();
    // debugPrint('object'+)
    if (data != null) {
      addresses.clear();
      // addresses.clear();
      // addressdata.value = ShippingAddress.fromJson(data['data']);
      data['data']
          .forEach((v) => addresses.add(ShippingAddressData.fromJson(v)));
      // log("fetchAddresses:length: ${addresses.length} data: ${data['data']}");
      debugPrint("addressdata $data");
    }
    loading.value = false;
  }

  verifyUser(otp) async {
    var data = await AuthService().verifyRegisteredUser(
      emailorphone: userPhone.value,
      otp: otp,
    );
    debugPrint(data.toString());

    if (data != null) {
      Get.offAndToNamed(Routes.LOGIN);
      if (data['error'] == true) {
        getSnackbar(message: data['msg'].toString());
      }
      if (data['error'] == false) {
        getSnackbar(message: data['msg'].toString());
      }
    }
  }

  resendOtp() async {
    var data = await AuthService()
        .resendOtpRegisteredUser(emailorphone: userPhone.value);
    debugPrint(data.toString());
    otpController.clear();
    if (data != null) {
      if (data['error'] == true) {
        getSnackbar(message: data['msg'].toString());
      }
      if (data['error'] == false) {
        getSnackbar(message: data['msg'].toString());
      }
    }
  }

  final smartAuth = SmartAuth();
  final pinputController = TextEditingController();
  var smsSign = ''.obs;

  void getAppSignature() async {
    final res = await smartAuth.getAppSignature();
    smsSign.value = res!;
    debugPrint('Signature: $res');
  }

  void getSmsCode() async {
    final res = await smartAuth.getSmsCode(matcher: smsSign.toString());
    debugPrint('SMSsa: $res');

    if (res.codeFound) {
      debugPrint('SMS: ${res.code}');
      debugPrint('SMS: ${res.code}');
    } else {
      debugPrint('SMS Failure:');
    }
  }

  void userConsent() async {
    debugPrint('userConsent: ');
    final res = await smartAuth.getSmsCode(useUserConsentApi: true);
    userConsent();
    if (res.codeFound) {
      pinputController.text = res.code!;
    } else {
      debugPrint('userConsent failed: $res');
    }
    debugPrint('userConsent: $res');
  }

  void smsRetriever() async {
    final res = await smartAuth.getSmsCode();
    smsRetriever();
    if (res.codeFound) {
      pinputController.text = res.code!;
    } else {
      debugPrint('smsRetriever failed: $res');
    }
    debugPrint('smsRetriever: $res');
  }
}

/* data['data'][0]['districts']
          .forEach((v) => districts.add(Districts.fromJson(v)));
      data['data'][0]['districts'][0]['localarea']
          .forEach((v) => areas.add(Localarea.fromJson(v)));*/
