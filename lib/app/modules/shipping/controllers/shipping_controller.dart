// ignore_for_file: unnecessary_overrides, prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/data/models/shipping_address_model.dart';
import 'package:q_and_u_furniture/app/data/models/shipping_charge_model.dart';
import 'package:q_and_u_furniture/app/data/models/user_billing_address.dart';
import 'package:q_and_u_furniture/app/data/models/user_shipping_address.dart';
import 'package:q_and_u_furniture/app/data/services/shipping_service.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';

class ShippingController extends GetxController {
  final isShippingAddressBtnSelected = false.obs;
  final isBillingAddressBtnSelected = false.obs;

  var billingSameAsShipping = false.obs;
  var select;

  // var homeSelected;
  // var differentSelected;
  /*----*/
  // var billingAddressList = <ShippingAddressData>[].obs;
  // var selectedProvince = 1.obs;
  // var selectedProvinceBilling = 1.obs;
  // var selectedDistrict = 1.obs;
  // var selectedDistrictBilling = 1.obs;
  // var selectedLocal = 0.obs;
  // var selectedLocalBilling = 0.obs;
  var loading = false.obs;

  // var disableProvince = false.obs;
  // var disableProvinceBilling = false.obs;
  // var disableDistrict = false.obs;
  // var disableDistrictBilling = false.obs;

  var userShippingdetail = <UserShippingAddressData>[].obs;
  var userBillingDetail = <UserBillingAddressData>[].obs;

  final logincon = Get.put(LoginController());

  /*Text Editing Controllers*/
  final fullname = TextEditingController();
  final fullnameBilling = TextEditingController();
  final email = TextEditingController();
  final emailBilling = TextEditingController();
  final phone = TextEditingController();
  final phoneBilling = TextEditingController();

/*  final province = TextEditingController();
  final provinceBilling = TextEditingController();*/
/*  final district = TextEditingController();
  final districtBilling = TextEditingController();*/
/*  final area = TextEditingController();
  final areaBilling = TextEditingController();*/
  final additionAddress = TextEditingController();
  final additionAddressBilling = TextEditingController();
  final zip = TextEditingController();
  final zipBilling = TextEditingController();
  final areaId = TextEditingController();
  final areaIdBilling = TextEditingController();

  final additionaladdresscontrolle = TextEditingController();
  var loadinshipping = false.obs;
  var loadingBillingShipping = false.obs;
  var zipAddress = <Localarea>[].obs;
  setSelectedRadio(val) {
    select = val;
    update();
  }

  setSelectedRadioForHomeAddress(val) {
    select = val;
    update();
  }

  setSelectedRadioForDifferentAddress(val) {
    select = val;
    update();
  }

  /*Variables for Shipping Address*/
  var shippingAddressList = <ShippingAddressData>[].obs;
  var districtsShipping = <Districts>[].obs;
  var selectedDistrictShipping = <Districts>[].obs;
  var areasShipping = <Localarea>[].obs;
  var additionalShipping = <GetRouteCharge>[].obs;

  var providerName = [].obs;
  var districtName = [].obs;

  var selectedProvinceNameShipping = '';
  var selectedDistrictNameShipping = '';
  var selectedAreaNameShipping = '';
  var selectedAdditionalShipping = '';

  /*Variables for Billing Address*/
  /*var billingAddressList = <ShippingAddressData>[].obs;
  var districtsBilling = <Districts>[].obs;
  var selectedDistrictBilling = <Districts>[].obs;
  var areasBilling = <Localarea>[].obs;

  var selectedProvinceNameBilling = '';
  var selectedDistrictNameBilling = '';
  var selectedAreaNameBilling = '';*/

  @override
  void onInit() {
    isShippingAddressBtnSelected(true);
    fetchUserShippingAddress();
    fetchUserBillingAddress();
    fetchAddressSelector();
    // fetchAddressBilling();
    // selectedProvince.value = 1;
    // selectedProvinceBilling.value = 1;
    // selectedDistrict.value = 1;
    // selectedDistrictBilling.value = 1;
    // disableProvince(false);
    // disableProvinceBilling(false);
    // disableDistrict(false);
    // disableDistrictBilling(false);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  fetchAddressSelector() async {
    var data = await ShippingService().getAddressSelector();
    if (data != null) {
      shippingAddressList.clear();

      data['data'].forEach(
          (v) => shippingAddressList.add(ShippingAddressData.fromJson(v)));
    }
  }

  /*fetchAddressBilling() async {
    var data = await ShippingService().getAddressSelector();
    if (data != null) {
      billingAddressList.clear();

      data['data'].forEach(
          (v) => billingAddressList.add(ShippingAddressData.fromJson(v)));
    }
  }*/

  var shippingAddressSelectedId = 0.obs;

  fetchUserShippingAddress() async {
    loading(true);
    var data = await ShippingService().getUserShippingAddress(
      AppStorage.readAccessToken,
    );
    log("nikhil$data");
    if (data != null) {
      loading(false);
      userShippingdetail.clear();
      data['data'].forEach(
          (v) => userShippingdetail.add(UserShippingAddressData.fromJson(v)));
      shippingAddressSelectedId.value = userShippingdetail[0].id!.toInt();
      charge.value = int.parse(userShippingdetail[0].charge!);
    }
  }

  var billingAddressSelectedId = 0.obs;

  fetchUserBillingAddress() async {
    loading(true);
    var data = await ShippingService().getUserBillingAddress(
      AppStorage.readAccessToken,
    );
    if (data != null) {
      loading(false);
      userBillingDetail.value = List<UserBillingAddressData>.from(
          data['data'].map((x) => UserBillingAddressData.fromJson(x)));
      billingAddressSelectedId.value =
          userBillingDetail.isNotEmpty ? userBillingDetail[0].id ?? 0 : 0;
    } else {}
  }

  addShippingAddress() async {
    loadinshipping.value = true;
    // print("additionaladdresscontrolle12345${additionaladdresscontrolle.text}");

    var data =
        await ShippingService().addShippingAddress(AppStorage.readAccessToken, {
      "name": fullname.text.trim(),
      "email": email.text.trim(),
      "province": selectedProvinceNameShipping,
      "phone": phone.text.trim(),
      "district": selectedDistrictNameShipping,
      "area": selectedAreaNameShipping,
      "additional_address": additionaladdresscontrolle.text,
      "zip": zip.text.trim(),
      // "area_id": areaId.text.trim(),
    });
    print("addShippingAddress$addShippingAddress");
    if (data != null) {
      loadinshipping.value = false;

      goBackAndClearDropDown();
      fetchUserShippingAddress();
      if (data['error'] == true) {
        getSnackbar(message: data['msg'], error: true);
      }
    }
  }

  addBillingAddress() async {
    loadingBillingShipping.value = true;
    var data =
        await ShippingService().addBillingAddress(AppStorage.readAccessToken, {
      "name": fullnameBilling.text.trim(),
      "email": emailBilling.text.trim(),
      "province": selectedProvinceNameShipping,
      "phone": phoneBilling.text.trim(),
      "district": selectedDistrictNameShipping,
      "area": selectedAreaNameShipping,
      "additional_address": additionaladdresscontrolle.text,
      "zip": zipBilling.text.trim(),
      // "area_id": areaIdBilling.text.trim(),
    });
    if (data != null) {
      loadingBillingShipping.value = false;
      goBackAndClearDropDown();
      fetchUserBillingAddress();
      if (data['error'] == false) {
        getSnackbar(message: data['msg'], error: true);
      }
    }
  }

  updateBillingAddress(id) async {
    var data = await ShippingService().updateBillingAddress(
        AppStorage.readAccessToken,
        {
          "name": fullnameBilling.text.trim(),
          "email": emailBilling.text.trim(),
          "province": selectedProvinceNameShipping,
          "phone": phoneBilling.text.trim(),
          "district": selectedDistrictNameShipping,
          "area": selectedAreaNameShipping,
          "additional_address": additionAddressBilling.text.trim(),
          "zip": zipBilling.text.trim(),
          // "area_id": areaIdBilling.text.trim(),
        },
        id: id);
    if (data != null) {
      goBackAndClearDropDown();
      fetchUserBillingAddress();
      if (data['error'] == true) {
        getSnackbar(message: data['msg'], error: true);
      }
    }
  }

  updateShippingAddress(id) async {
    var data = await ShippingService().updateShippingAddress(
        AppStorage.readAccessToken,
        {
          "name": fullname.text.trim(),
          "email": email.text.trim(),
          "province": selectedProvinceNameShipping,
          "phone": phone.text.trim(),
          "district": selectedDistrictNameShipping,
          "area": selectedAreaNameShipping,
          "additional_address": additionAddress.text.trim(),
          "zip": zip.text.trim(),
          // "area_id": areaId.text.trim(),
        },
        id: id);

    if (data != null) {
      goBackAndClearDropDown();
      fetchUserShippingAddress();
      if (data['error'] == true) {
        getSnackbar(message: data['msg'], error: true);
      }
    }
  }

  deleteShippingAddress(id) async {
    var data = await ShippingService()
        .deleteShippingAddressbyId(AppStorage.readAccessToken, id: id);
    fetchUserShippingAddress();

    if (data != null) {
      if (data['error'] == false) {
        getSnackbar(message: data['msg']);
      } else {
        getSnackbar(message: data['msg'], error: true);
      }
    }
  }

  deleteBillingAddress(id) async {
    var data = await ShippingService()
        .deleteBillingAddressbyId(AppStorage.readAccessToken, id: id);
    fetchUserBillingAddress();

    if (data != null) {
      if (data['error'] == false) {
        getSnackbar(message: data['msg']);
      } else {
        getSnackbar(message: data['msg'], error: true);
      }
    }
  }

  var shippingCharge = <ShippingChargeData>[].obs;
  var charge = 0.obs;

  getShippingCharge(id) async {
    var data = await ShippingService()
        .getShippingCharge(AppStorage.readAccessToken, id: '$id');
    print("charge$data");
    log('shippig charge:  $data');
    if (data != null) {
      if (data['error'] == false) {
        shippingCharge.clear();
        print("charge$data");
        data['data'].forEach((v) {
          shippingCharge.add(ShippingChargeData.fromJson(v));
        });
      } else {}
    }
  }

  Future<void> goBackAndClearDropDown() async {
    districtsShipping.clear();
    areasShipping.clear();
    additionalShipping.clear();
    Get.back();
  }
}
