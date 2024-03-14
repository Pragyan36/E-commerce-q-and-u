// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/data/models/shipping_address_model.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/modules/shipping/controllers/shipping_controller.dart';
import 'package:q_and_u_furniture/app/routes/app_pages.dart';
import 'package:q_and_u_furniture/app/utils/validators.dart';
import 'package:q_and_u_furniture/app/widgets/circular_icons.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_button.dart';
import 'package:q_and_u_furniture/app/widgets/custom_buttons.dart';
import 'package:q_and_u_furniture/app/widgets/custom_loading_indicator.dart';
import 'package:q_and_u_furniture/app/widgets/inputfield.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';

class ShippingView extends GetView<ShippingController> {
  ShippingView({Key? key}) : super(key: key);

  @override
  final ShippingController loginController = Get.put(ShippingController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CartController cartController = Get.put(CartController());
  final GlobalKey<FormState> _districtKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _areaKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _additionalAreaKey = GlobalKey<FormState>();
  final NumberFormat formatter = NumberFormat('#,###');

  @override
  Widget build(BuildContext context) {
    Map<int, String> idToEngNameMap = {};
    for (ShippingAddressData address in loginController.shippingAddressList) {
      idToEngNameMap[address.id!] = address.engName!;
    }
    // loginController.providerName.clear();
    // loginController.districtName.clear();

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Checkout',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(
                    label: 'Shipping Address',
                    borderClr:
                        loginController.isShippingAddressBtnSelected.value
                            ? AppColor.kalaAppMainColor
                            : Colors.grey.shade200,
                    txtClr: loginController.isShippingAddressBtnSelected.value
                        ? AppColor.kalaAppMainColor
                        : Colors.black,
                    ontap: () {
                      loginController.isShippingAddressBtnSelected(true);
                      loginController.isBillingAddressBtnSelected(false);
                    },
                  ),
                  IgnorePointer(
                    ignoring: loginController.billingSameAsShipping.isTrue
                        ? true
                        : false,
                    child: _buildButton(
                      label: 'Billing Address',
                      borderClr:
                          loginController.isBillingAddressBtnSelected.value
                              ? AppColor.kalaAppMainColor
                              : Colors.grey.shade200,
                      txtClr: loginController.isShippingAddressBtnSelected.value
                          ? Colors.black
                          : AppColor.kalaAppMainColor,
                      ontap: () {
                        loginController.isBillingAddressBtnSelected(true);

                        loginController.isShippingAddressBtnSelected(false);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => loginController.isShippingAddressBtnSelected.value

                  ///Shipping
                  ? Column(
                      children: [
                        loginController.loading.isTrue
                            ? const CustomLoadingIndicator(isCircle: true)
                            : Column(
                                children: [
                                  loginController.userShippingdetail.isNotEmpty
                                      ? ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: loginController
                                              .userShippingdetail.length,
                                          itemBuilder: (context, index) {
                                            var data = loginController
                                                .userShippingdetail[index];
                                            int addressId = int.parse(
                                              data.province.toString(),
                                            );
                                            String? engName =
                                                idToEngNameMap[addressId];

                                            return Obx(
                                              () => _buildRadioListtile(
                                                '${data.area}, ${engName == null ? "" : "$engName,"} ${data.additionalAddress == null ? "" : "${data.additionalAddress}"} ${data.zip == null ? "" : "${data.zip}"}',
                                                'Your shipping address',
                                                () {
                                                  loginController
                                                          .fullname.text =
                                                      data.name.toString();
                                                  loginController.email.text =
                                                      data.email.toString();
                                                  loginController.phone.text =
                                                      data.phone.toString();
                                                  loginController
                                                          .additionAddress
                                                          .text =
                                                      data.additionalAddress ==
                                                              null
                                                          ? ""
                                                          : data
                                                              .additionalAddress
                                                              .toString();
                                                  loginController.zip.text =
                                                      data.zip == null
                                                          ? ""
                                                          : data.zip.toString();
                                                  _buildBottomsheet(
                                                    true,
                                                    isUpdate: true,
                                                    id: data.id!.toInt(),
                                                  );
                                                },
                                                () {
                                                  loginController
                                                      .deleteShippingAddress(
                                                    data.id!.toInt(),
                                                  );
                                                },
                                                data.id!.toInt(),
                                                loginController
                                                    .shippingAddressSelectedId
                                                    .value,
                                                (val) {
                                                  loginController
                                                      .shippingAddressSelectedId
                                                      .value = val;
                                                  loginController.charge.value =
                                                      data.charge!;
                                                },
                                              ),
                                            );
                                          },
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            'Empty Address',
                                            style: subtitleStyle,
                                          ),
                                        ),
                                  IconButton(
                                    onPressed: () {
                                      _buildBottomsheet(true);
                                    },
                                    splashColor: AppColor.kalaAppAccentColor,
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      Icons.add_circle_outline_rounded,
                                      color: Colors.grey.shade500,
                                      size: 50,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Add Shipping Address',
                                    style: subtitleStyle,
                                  )
                                ],
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )

                  ///Billing
                  : Column(
                      children: [
                        Obx(
                          () => loginController.loading.isTrue
                              ? const CustomLoadingIndicator(isCircle: true)
                              : Column(
                                  children: [
                                    loginController.userBillingDetail.isNotEmpty
                                        ? ListView.builder(
                                            itemCount: loginController
                                                .userBillingDetail.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              var data = loginController
                                                  .userBillingDetail[index];
                                              return _buildRadioListtile(
                                                '${data.area ?? ""},${data.additionalAddress == null ? "" : "${data.additionalAddress},"} ${data.zip == null ? "" : '${data.zip}'}',
                                                'Your billing address',
                                                () async {
                                                  loginController
                                                          .fullnameBilling
                                                          .text =
                                                      data.name.toString();
                                                  loginController
                                                          .emailBilling.text =
                                                      data.email.toString();
                                                  loginController
                                                          .phoneBilling.text =
                                                      data.phone.toString();
                                                  loginController
                                                          .additionAddressBilling
                                                          .text =
                                                      data.additionalAddress
                                                          .toString();
                                                  loginController
                                                          .zipBilling.text =
                                                      data.zip.toString();
                                                  _buildBottomsheet(
                                                    false,
                                                    isUpdate: true,
                                                    id: data.id!.toInt(),
                                                  );
                                                },
                                                () {
                                                  loginController
                                                      .deleteBillingAddress(
                                                    data.id!.toInt(),
                                                  );
                                                },
                                                data.id!.toInt(),
                                                loginController
                                                    .billingAddressSelectedId
                                                    .value,
                                                (val) {
                                                  loginController
                                                      .billingAddressSelectedId
                                                      .value = int.parse(
                                                    val.toString(),
                                                  );
                                                },
                                              );
                                            },
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                              'Empty Address',
                                              style: subtitleStyle,
                                            ),
                                          ),
                                    IconButton(
                                      onPressed: () {
                                        _buildBottomsheet(false);
                                      },
                                      padding: EdgeInsets.zero,
                                      splashColor: AppColor.kalaAppMainColor,
                                      icon: Icon(
                                        Icons.add_circle_outline_rounded,
                                        color: Colors.grey.shade500,
                                        size: 50,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Add Billing Address',
                                      style: subtitleStyle,
                                    )
                                  ],
                                ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
            ),
            ListTile(
              leading: Obx(
                () => Checkbox(
                  activeColor: AppColor.kalaAppMainColor,
                  value: loginController.billingSameAsShipping.value,
                  onChanged: (val) {
                    loginController.billingSameAsShipping.value = val!;
                  },
                ),
              ),
              title: Text(
                'Billing address is the same as my shipping address',
                style: subtitleStyle,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              minLeadingWidth: 10,
              horizontalTitleGap: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildAmountTile(
                    'Sub-total',
                    'Rs.${formatter.format(cartController.cartSummary.value.totalAmount)}',
                  ),
                  _buildAmountTile(
                    'VAT (%)',
                    formatter.format(cartController.cartSummary.value.vat),
                  ),
                  Obx(
                    () => _buildAmountTile(
                      'Shipping Charge',
                      'Rs. ${formatter.format(loginController.charge.value)} ',
                    ),
                  ),
                  Obx(
                    () => _buildAmountTile(
                      'Material Charge',
                      'Rs. ${formatter.format(int.parse(cartController.cartSummary.value.materialPrice ?? "0"))}',
                    ),
                  ),
                  const Divider(
                    thickness: 1.5,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Obx(
                    () => _buildAmountTile(
                      'Total',
                      'Rs. ${formatter.format(cartController.cartSummary.value.grandTotal! + loginController.charge.value + int.parse(cartController.cartSummary.value.materialPrice ?? "0"))}',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: CustomButton(
            label: 'Continue',
            btnClr: AppColor.kalaAppMainColor,
            txtClr: Colors.white,
            ontap: () {
              /*If Billing is same as shipping*/
              if (loginController.billingSameAsShipping.value) {
                if (loginController.userShippingdetail.isNotEmpty) {
                  Get.toNamed(
                    Routes.PAYMENT,
                    arguments: [
                      loginController.shippingAddressSelectedId,
                      loginController.billingAddressSelectedId,
                      loginController.billingSameAsShipping,
                      loginController.charge.value
                    ],
                  );
                } else {
                  getSnackbar(message: 'Please add shipping address first');
                }
              }
              /*If Billing is not same as shipping*/
              else {
                if (loginController.userShippingdetail.isNotEmpty &&
                    loginController.userBillingDetail.isNotEmpty) {
                  Get.toNamed(
                    Routes.PAYMENT,
                    arguments: [
                      loginController.shippingAddressSelectedId,
                      loginController.billingAddressSelectedId,
                      loginController.billingSameAsShipping,
                      loginController.charge.value
                    ],
                  );
                } else {
                  getSnackbar(
                      message: 'Please add shipping and billing address',
                      error: true,
                      bgColor: Colors.red);
                }
              }
            },
          ),
        ),
      ),
    );
  }

  _buildButton({
    required String label,
    required Color borderClr,
    required Color txtClr,
    required void Function()? ontap,
  }) {
    return MaterialButton(
      color: Colors.white,
      height: 50,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: borderClr,
          width: 1,
        ),
      ),
      onPressed: ontap,
      child: Text(
        label,
        style: subtitleStyle.copyWith(
          color: txtClr,
        ),
      ),
    );
  }

  _buildRadioListtile(
    title,
    subtitle,
    ontap,
    ondelete,
    Object value,
    grpvalue,
    onChanged,
  ) {
    return RadioListTile(
      title: Text(
        title,
        style: subtitleStyle,
      ),
      selectedTileColor: AppColor.kalaAppMainColor,
      activeColor: AppColor.kalaAppMainColor,
      subtitle: Text(
        subtitle,
        style: subtitleStyle.copyWith(color: Colors.grey),
      ),
      secondary: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: ontap, icon: const Icon(Iconsax.edit)),
          IconButton(onPressed: ondelete, icon: const Icon(Iconsax.trash)),
        ],
      ),
      value: value,
      groupValue: grpvalue,
      onChanged: onChanged,
    );
  }

  _buildAmountTile(title, total) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(vertical: -3),
      title: Text(
        title,
        style: subtitleStyle.copyWith(color: Colors.grey),
      ),
      trailing: Text(
        total,
        style: subtitleStyle.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }

  void _buildBottomsheet(
    isShipping, {
    bool isUpdate = false,
    int id = 0,
  }) {
    Get.bottomSheet(
      isScrollControlled: true,
      ignoreSafeArea: false,
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomCircularIcon(),
                  const SizedBox(
                    height: 10,
                  ),
                  MyInputField(
                    labelText: 'Full name',
                    textInputAction: TextInputAction.next,
                    inputType: TextInputType.text,
                    controller: isShipping
                        ? loginController.fullname
                        : loginController.fullnameBilling,
                    validator: (v) => validateIsEmpty(string: v),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyInputField(
                    inputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (v) => validateEmail(string: v),
                    labelText: 'Email',
                    controller: isShipping
                        ? loginController.email
                        : loginController.emailBilling,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyInputField(
                    textInputAction: TextInputAction.next,
                    validator: (v) => validatePhone(string: v),
                    labelText: 'Phone',
                    inputType: TextInputType.number,
                    controller: isShipping
                        ? loginController.phone
                        : loginController.phoneBilling,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  /*==================*/
                  _buildAddressSelector(isShipping),
                  /*==================*/
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: _additionalAreaKey,
                    child: MyInputField(
                      labelText: 'Additional Address',
                      inputType: TextInputType.name,
                      controller: loginController.additionaladdresscontrolle,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyInputField(
                      inputType: TextInputType.number,
                      // validator: (v) => isShipping
                      //     ? validateIsEmpty(string: v)
                      //     : validateNothing(string: v),
                      labelText: 'Zip',
                      controller: isShipping
                          ? loginController.zip
                          : loginController.zipBilling),
                  const SizedBox(
                    height: 10,
                  ),
                  isUpdate
                      ? CustomButtons(
                          width: double.infinity,
                          label: 'Update',
                          btnClr: AppColor.kalaAppMainColor,
                          txtClr: Colors.white,
                          ontap: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            if (!_districtKey.currentState!.validate()) {
                              return;
                            }
                            if (!_areaKey.currentState!.validate()) {
                              return;
                            }

                            if (isShipping) {
                              if (!_additionalAreaKey.currentState!
                                  .validate()) {
                                return;
                              }
                            } else {
                              //doNothing because additional address is not required in billing
                            }

                            if (isShipping) {
                              loginController.updateShippingAddress(id);
                            } else {
                              loginController.updateBillingAddress(id);
                            }
                          })
                      : CustomButtons(
                          width: double.infinity,
                          label: 'Confirm',
                          btnClr: AppColor.kalaAppMainColor,
                          txtClr: Colors.white,
                          ontap: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            if (!_districtKey.currentState!.validate()) {
                              return;
                            }
                            if (!_areaKey.currentState!.validate()) {
                              return;
                            }
                            if (isShipping) {
                              if (!_additionalAreaKey.currentState!
                                  .validate()) {
                                return;
                              }
                            } else {}

                            if (isShipping) {
                              debugPrint(
                                  "additionaladdresscontrolle123${loginController.additionaladdresscontrolle.text}");
                              loginController.addShippingAddress();
                              loginController.onInit();
                            } else {
                              loginController.loadinshipping.value
                                  ? null
                                  : loginController.addBillingAddress();
                              loginController.onInit();
                            }
                          },
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildAddressSelector(isShipping) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Province',
          style: subtitleStyle,
        ),
        const SizedBox(
          height: 5,
        ),
        Obx(
          () => DropdownButtonFormField2(
            decoration: InputDecoration(
              fillColor: Colors.grey.shade300.withOpacity(0.4),
              filled: true,
              isDense: true,
              contentPadding:
                  const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
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
              style: subtitleStyle,
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.black45,
            ),
            iconSize: 30,
            buttonHeight: 50,
            buttonPadding: const EdgeInsets.only(left: 20, right: 10),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            items: loginController.shippingAddressList
                .map((item) => DropdownMenuItem<String>(
                      value: item.id.toString(),
                      onTap: () {
                        loginController.selectedProvinceNameShipping =
                            item.id.toString();
                        _districtKey.currentState!.reset();
                        _areaKey.currentState!.reset();

                        loginController.districtsShipping.clear();
                        loginController.areasShipping.clear();

                        clearAndResetAdditionalAddress();
                        log("selectedProvinceNameShipping${loginController.selectedProvinceNameShipping}");
                      },
                      child: Text(
                        item.engName.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Please select province.';
              }
              return null;
            },
            onChanged: (value) {
              _districtKey.currentState!.reset();
              _areaKey.currentState!.reset();
              loginController.districtsShipping.clear();
              clearAndResetAdditionalAddress();

              loginController
                  .shippingAddressList[int.parse(value.toString()) - 1]
                  .districts
                  ?.forEach((element) {
                loginController.districtsShipping.add(element);
              });
            },
            onSaved: (v) {},
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'District',
          style: subtitleStyle,
        ),
        const SizedBox(
          height: 5,
        ),
        Obx(
          () => Form(
            key: _districtKey,
            child: DropdownButtonFormField2(
              decoration: InputDecoration(
                fillColor: Colors.grey.shade300.withOpacity(0.4),
                filled: true,
                isDense: true,
                contentPadding:
                    const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
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
                style: subtitleStyle,
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 30,
              buttonHeight: 50,
              buttonPadding: const EdgeInsets.only(left: 20, right: 10),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
              items: loginController.districtsShipping
                  .map((item) => DropdownMenuItem<String>(
                        onTap: () {
                          loginController.selectedDistrictNameShipping =
                              item.id.toString();
                          clearAndResetAdditionalAddress();
                          log("selectedDistrictNameShipping:${loginController.selectedDistrictNameShipping}");
                        },
                        value: item.id.toString(),
                        child: Text(
                          item.npName.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select district.';
                }
                return null;
              },
              onChanged: (value) {
                _areaKey.currentState!.reset();

                clearAndResetAdditionalAddress();

                loginController.selectedDistrictShipping
                    .addAll(loginController.districtsShipping);

                loginController.selectedDistrictShipping.retainWhere(
                    (element) => element.id == int.parse(value.toString()));
                loginController.areasShipping.clear();

                loginController.selectedDistrictShipping[0].localarea
                    ?.forEach((element) {
                  loginController.areasShipping.add(element);
                });
              },
              onSaved: (v) {},
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Area',
          style: subtitleStyle,
        ),
        const SizedBox(
          height: 5,
        ),
        Obx(
          () => Form(
              key: _areaKey,
              child: DropdownButtonFormField2(
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade300.withOpacity(0.4),
                  filled: true,
                  isDense: true,
                  contentPadding: const EdgeInsets.only(
                      left: 0, right: 0, top: 5, bottom: 5),
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
                  style: subtitleStyle,
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
                buttonHeight: 50,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                ),
                items: loginController.areasShipping
                    .map((item) => DropdownMenuItem<String>(
                          onTap: () {
                            loginController.selectedAreaNameShipping =
                                item.localName.toString();
                            clearAndResetAdditionalAddress();
                            log("selectedAreaNameShipping:${loginController.selectedAreaNameShipping}");
                          },
                          value: item.id.toString(),
                          child: Text(
                            item.localName.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select area.';
                  }
                  return null;
                },
                onChanged: (v) async {
                  debugPrint("124$v");
                  clearAndResetAdditionalAddress();

                  await loginController.getShippingCharge(v);
                },
                onSaved: (v) {},
              )),
        ),
      ],
    );
  }

  void clearAndResetAdditionalAddress() {
    loginController.shippingCharge.clear();
    _additionalAreaKey.currentState!.reset();
    loginController.shippingCharge.clear();
    loginController.additionAddress.text = "";
    loginController.additionAddressBilling.text = "";
  }
}
