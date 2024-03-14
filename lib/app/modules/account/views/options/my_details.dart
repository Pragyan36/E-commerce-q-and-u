import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/account_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/utils/validators.dart';
import 'package:q_and_u_furniture/app/widgets/circular_icons.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_buttons.dart';
import 'package:q_and_u_furniture/app/widgets/inputfield.dart';
import 'package:q_and_u_furniture/app/widgets/loading_widget.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyDetails extends StatefulWidget {
  const MyDetails({Key? key}) : super(key: key);

  @override
  State<MyDetails> createState() => _MyDetailsState();
}

class _MyDetailsState extends State<MyDetails> {
  final AccountController controller = Get.put(
    AccountController(),
  );
  final LoginController logincon = Get.put(
    LoginController(),
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller.getUser();
    controller.getMyDetails();
    debugPrint(controller.myDetails.value.district);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var img = '${controller.userdata.value.photo}';
    if (img == 'null') {}
    log("MyDetails:imgUrl:$img");
    return Scaffold(
      appBar: CustomAppbar(
        title: 'My Details',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: Obx(
            () => controller.loading.isTrue
                ? const LoadingWidget()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      profileImage(),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: subtitleStyle.copyWith(
                                  fontSize: 16.sp,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Divider(),
                              Text(
                                'Email',
                                style: subtitleStyle.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                              const Divider(),
                              Text(
                                'Phone',
                                style: subtitleStyle.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                              const Divider(),
                              Text(
                                'Country',
                                style: subtitleStyle.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                              const Divider(),
                              Text(
                                'Province',
                                style: subtitleStyle.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                              const Divider(),
                              Text(
                                'District',
                                style: subtitleStyle.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                              const Divider(),
                              Text(
                                'Municipality',
                                style: subtitleStyle.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                              const Divider(),
                              Text(
                                'Additional Area',
                                style: subtitleStyle.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                              const Divider(),
                              Text(
                                'Zip Code',
                                style: subtitleStyle.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                          Obx(
                            () => Flexible(
                              child: Column(
                                children: [
                                  // NAME SECTION
                                  Text(
                                    controller.userdata.value.name.toString(),
                                    style: subtitleStyle.copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.grey,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                  const Divider(),
                                  // EMAIL SECTION
                                  Text(
                                    controller.userdata.value.email.toString(),
                                    style: subtitleStyle.copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.grey,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  const Divider(),
                                  // PHONE SECTION
                                  Text(
                                    controller.userdata.value.phone == null
                                        ? "Not Set"
                                        : controller.userdata.value.phone
                                            .toString(),
                                    style: subtitleStyle.copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  // COUNTRY SECTION
                                  const Divider(),
                                  Text(
                                    controller.country.text,
                                    style: subtitleStyle.copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const Divider(),
                                  // PROVINCE SECTION
                                  Text(
                                    controller.userdata.value.province == null
                                        ? "Not Set"
                                        : controller.userdata.value.province
                                            .toString(),
                                    style: subtitleStyle.copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.grey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                  // DISTRICT SECTION
                                  const Divider(),
                                  Text(
                                    controller.userdata.value.district == null
                                        ? "Not Set"
                                        : controller.userdata.value.district
                                            .toString(),
                                    style: subtitleStyle.copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.grey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                  // MUNICIPALITY SECTION
                                  const Divider(),
                                  Text(
                                    controller.userdata.value.area == null
                                        ? "Not Set"
                                        : controller.userdata.value.area
                                            .toString(),
                                    style: subtitleStyle.copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const Divider(),
                                  // ADDITIONAL AREA SECTION
                                  Text(
                                    controller.userdata.value.address == null
                                        ? "Not Set"
                                        : controller.userdata.value.address
                                            .toString(),
                                    style: subtitleStyle.copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const Divider(),
                                  // ZIP CODE SECTION
                                  Text(
                                    controller.userdata.value.zip == null
                                        ? "Not Set"
                                        : controller.userdata.value.zip
                                            .toString(),
                                    style: subtitleStyle.copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: CustomButtons(
                          width: double.infinity,
                          label: 'Edit',
                          btnClr: AppColor.kalaAppMainColor,
                          txtClr: Colors.white,
                          ontap: () {
                            Get.bottomSheet(
                              isDismissible: true,
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
                                child: PopScope(
                                  canPop: true,
                                  child: Container(
                                    color: Colors.white,
                                    height:
                                        MediaQuery.of(context).size.height - 90,
                                    padding: const EdgeInsets.only(
                                      bottom: 0,
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Align(
                                              alignment: Alignment.topRight,
                                              child: CustomCircularIcon(),
                                            ),
                                            Obx(
                                              () =>
                                                  controller.isImagePicked.value
                                                      ? Obx(
                                                          () => Row(
                                                            children: [
                                                              Center(
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 42,
                                                                  backgroundColor:
                                                                      AppColor
                                                                          .kalaAppMainColor,
                                                                  child: controller
                                                                              .selectedImagePath
                                                                              .value ==
                                                                          ""
                                                                      ? Container()
                                                                      : CircleAvatar(
                                                                          radius:
                                                                              40,
                                                                          backgroundColor: Colors
                                                                              .grey
                                                                              .shade200,
                                                                          backgroundImage:
                                                                              FileImage(
                                                                            File(controller.selectedImagePath.value),
                                                                          ),
                                                                        ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : profileImage(),
                                            ),
                                            Center(
                                              child: TextButton(
                                                onPressed: () {
                                                  controller.getImage();
                                                },
                                                child: Text(
                                                  'Edit Profile Picture',
                                                  style: subtitleStyle,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Name',
                                              style: subtitleStyle,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            MyInputField(
                                              labelText: 'Name',
                                              controller: controller.name,
                                              validator: (v) => validateIsEmpty(
                                                string: v,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Email',
                                              style: subtitleStyle,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            MyInputField(
                                              labelText: 'Email',
                                              controller: controller.email,
                                              validator: (v) =>
                                                  validateEmail(string: v),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Phone',
                                              style: subtitleStyle,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            MyInputField(
                                              labelText: 'Phone',
                                              controller: controller.phone,
                                              inputType: TextInputType.number,
                                              validator: (v) =>
                                                  validatePhone(string: v),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Address',
                                              style: subtitleStyle,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildAddress(),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Additional Address',
                                              style: subtitleStyle,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            MyInputField(
                                              labelText: 'Address',
                                              controller: controller.address,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Zip Code',
                                              style: subtitleStyle,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            MyInputField(
                                              labelText: 'Zip code',
                                              controller: controller.zip,
                                              inputType: TextInputType.number,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Center(
                                              child: CustomButtons(
                                                width: double.infinity,
                                                label: 'Update',
                                                btnClr:
                                                    AppColor.kalaAppMainColor,
                                                txtClr: Colors.white,
                                                ontap: () async {
                                                  if (!_formKey.currentState!
                                                      .validate()) {
                                                    getSnackbar(
                                                      message:
                                                          "Please fill form correctly",
                                                      error: true,
                                                      bgColor: Colors.red,
                                                    );
                                                    return;
                                                  }
                                                  controller
                                                          .updateProfiles.value
                                                      ? null
                                                      : controller
                                                          .updateProfile();
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 70,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                            controller.isTapDistrict.value = false;
                            controller.isTapProvince.value = false;
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

  _buildAddress() {
    return Obx(
      () => Column(
        children: [
          // PROVINCE SECTION
          DropdownButtonFormField2(
            value: controller.province.value.toString(),
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
            hint: const Text(
              'Select Province',
              style: TextStyle(fontSize: 14),
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
            items: controller.addresses
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item.id.toString(),
                    onTap: () {
                      controller.selectedProvinceName = item.engName.toString();
                      controller.isTapProvince.value = true;
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
            onChanged: (value) {
              controller.districts.clear(); // Reset selected district
              controller.addresses[int.parse(value.toString()) - 1].districts
                  ?.forEach(
                (element) {
                  controller.districts.add(element);
                  debugPrint(
                      "Controller of district is ${controller.districts.first}");
                },
              );
            },
            onSaved: (value) {},
          ),
          const SizedBox(
            height: 10,
          ),
          // DISTRICT SECTION
          MyInputField(
            labelText: "Select district",
            controller: controller.districtController,
            widget: Container(),
            ontap: () {
              controller.isTapProvince.value == true
                  ? showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 600,
                          child: AlertDialog(
                            title: const Text('Select District'),
                            content: SizedBox(
                              width: double.maxFinite,
                              height: 400,
                              child: ListView.builder(
                                itemCount: controller.districts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var districtList =
                                      controller.districts[index];
                                  return ListTile(
                                    title: Text(
                                      districtList.npName.toString(),
                                    ),
                                    onTap: () {
                                      setState(
                                        () {
                                          controller.districtController.text =
                                              districtList.npName.toString();
                                          controller.selectedDistrictName =
                                              districtList.npName.toString();
                                          controller.areas.clear();
                                          controller.districts[index].localarea
                                              ?.forEach(
                                            (element) {
                                              controller.areas.add(element);
                                            },
                                          );
                                          controller.isTapDistrict.value = true;
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : const SizedBox();
            },
          ),
          const SizedBox(
            height: 10,
          ),
          // AREA SECTION
          MyInputField(
            widget: Container(),
            labelText: "Select area",
            controller: controller.areaController,
            ontap: () {
              controller.isTapDistrict.value == true
                  ? showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Select area'),
                          content: SizedBox(
                            width: double.maxFinite,
                            child: SizedBox(
                              height: 400,
                              child: ListView.builder(
                                itemCount: controller.areas.length,
                                itemBuilder: (
                                  BuildContext context,
                                  int index,
                                ) {
                                  var areaList = controller.areas[index];
                                  return ListTile(
                                    title: Text(areaList.localName.toString()),
                                    onTap: () {
                                      controller.areaController.text =
                                          areaList.localName.toString();
                                      controller.selectedAreaName =
                                          areaList.localName.toString();
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    )
                  : const SizedBox();
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  profileImage() {
    return Center(
      child: Hero(
        tag: 'img',
        child: CircleAvatar(
          radius: 40,
          backgroundColor: AppColor.kalaAppMainColor,
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  controller.userdata.value.social_avatar != null
                      ? controller.userdata.value.social_avatar!
                      : controller.userdata.value.photo != null
                          ? controller.userdata.value.photo!
                          : '$url/frontend/images/avatar.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
