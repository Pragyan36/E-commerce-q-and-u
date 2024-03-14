import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:q_and_u_furniture/app/data/models/review_model.dart';
import 'package:q_and_u_furniture/app/data/models/shipping_address_model.dart';
import 'package:q_and_u_furniture/app/data/models/staff_user_model.dart';
import 'package:q_and_u_furniture/app/data/models/user_model.dart';
import 'package:q_and_u_furniture/app/data/models/user_review_model.dart';
import 'package:q_and_u_furniture/app/data/services/auth_service.dart';
import 'package:q_and_u_furniture/app/data/services/profile_service.dart';
import 'package:q_and_u_furniture/app/data/services/review_service.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/model/my_detail.dart';
import 'package:q_and_u_furniture/app/model/reward.dart';
import 'package:q_and_u_furniture/app/model/site_details_model.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountController extends GetxController {
  var selectedStatus = 0.obs;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  /*final storage = const FlutterSecureStorage();
  var savedToken = ''.obs;*/

  final name = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final area = TextEditingController();
  final email = TextEditingController();
  final country = TextEditingController();
  final provinceController = TextEditingController();
  final districtController = TextEditingController();
  final areaController = TextEditingController();
  final zip = TextEditingController();

  // final photo = TextEditingController();
  final shippingaddress = TextEditingController();

  var userdata = UserData().obs;
  var staffuserdata = StaffUserModel().obs;
  var myDetails = MyUserData().obs;
  var province = ''.obs;
  var rewardData = RewardData().obs;
  var myReviewResponse = ReviewModel().obs;
  var myReviewList =
      //  UserReviewModel().obs;
      <UserReviewData>[].obs;
  var loading = false.obs;
  var sitedetail = <SiteDetailData>[].obs;
  final String tag = "LoginController";

  /*Variables for Address Selector Dropdowns*/
  var addresses = <ShippingAddressData>[].obs;
  var districts = <Districts>[].obs;
  var selectedDistrict = <Districts>[].obs;
  var areas = <Localarea>[].obs;

  // var loading = false.obs;

  var selectedProvinceName = '';
  var selectedDistrictName = '';
  var selectedAreaName = '';
  var isTapProvince = false.obs;
  var isTapDistrict = false.obs;
  var isImagePicked = false.obs;
  var loader = false.obs;
  var updateProfiles = false.obs;

  LoginController logincon = Get.find();

  @override
  void onInit() async {
    // log("AccountController:onInit");
    super.onInit();
    await getUser();
    await getMyDetails();
    // log("AccountController:onInit:loginStatus:${AppStorage.readIsLoggedIn}");
    if (logincon.logindata.value.read('USERID') != null) {
      // log("AccountController:onInit:isLoggedIn");

      // log("Got User");
      fetchMyReviews();
      // log("Got My Reviews");
    }
    fetchSiteDetail();
    // log("Got Site Detail");
    fetchAddresses();
    // log("Got Address");
    name.text = userdata.value.name.toString();
    phone.text =
        userdata.value.phone == null ? "" : userdata.value.phone.toString();
    address.text =
        userdata.value.address == null ? "" : userdata.value.address.toString();
    area.text =
        userdata.value.area == null ? "" : userdata.value.area.toString();
    country.text = "Nepal";
    email.text = userdata.value.email.toString();
    userdata.value.district.toString();
    userdata.value.area.toString();

    // photo = logincon.userdata.value.;
    selectedStatus.value = 0;
  }

  void share() async {
    final String referralCode = userdata.value.referal_code!;
    const String fallbackUrl = 'https://www.celermart.com/';

    Share.share(
      'Download Q & U Hongkong Furniture with my referral code: $referralCode\nHere is the link: $fallbackUrl',
      subject: 'Check out Q & U Hongkong Furniture!',
    );
  }

  void getImage() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          "${((File(selectedImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";
      // uploadImage(File(selectedImagePath.value));
      isImagePicked.value = true;
    } else {
      isImagePicked.value = false;
      getSnackbar(
          message: 'No image selected', bgColor: Colors.red, error: true);
    }
  }

  getUser() async {
    loading.value = true;
    var data =
        await ProfileService().getUser(logincon.logindata.value.read('USERID'));
    if (data != null) {
      userdata.value = UserData.fromJson(data['data']);
    }
    loading.value = false;
  }

  getstaff() async {
    loading.value = true;
    var data = await ProfileService()
        .getUserStaff(logincon.stafflogindata.value.read('USERID'));
    debugPrint("hello123$data");
    if (data != null) {
      staffuserdata.value = StaffUserModel.fromJson(data);

      debugPrint(" staffuserdata.value${staffuserdata.value}");
    }
    loading.value = false;
  }

  getMyDetails() async {
    loading.value = true;
    var data = await ProfileService()
        .getMyDetails(logincon.logindata.value.read('USERID'));
    debugPrint("anis data is $data");
    if (data != null) {
      debugPrint("null xina");
      myDetails.value = MyUserData.fromJson(data['data']);
      debugPrint("hello null ${myDetails.value.province}");

      if (myDetails.value.province == null ||
          myDetails.value.province == 'null') {
        debugPrint("xiryo yar");
        province.value = "1";
      } else {
        province.value = myDetails.value.province.toString();

        debugPrint("else ma xiryo");
      }
    }
    loading.value = false;
  }

  fetchReward() async {
    loading.value = true;
    var data = await ProfileService().getReward(AppStorage.readAccessToken);
    if (data != null) {
      rewardData.value = RewardData.fromJson(data['data']);
    }
    loading.value = false;
  }

  updateProfile() async {
    updateProfiles.value = true;

    var data = await ProfileService().updateProfile(
        AppStorage.readAccessToken,
        {
          "name": name.text,
          "phone": phone.text,
          "email": email.text,
          "province": selectedProvinceName,
          "district": selectedDistrictName,
          "area": selectedAreaName,
          "address": address.text,
          "zip": zip.text,
          // "area": area.text,
          "country": country.text,
          // "photo": MultipartFile(photo, filename: '$photo.png'),
          "shipping_address": shippingaddress.text,
        },
        selectedImagePath.value);
    if (data != null) {
      await Future.delayed(const Duration(seconds: 2), () {});
      updateProfiles.value = false;
      // var res = jsonDecode(data);
      debugPrint(data.toString());
      goBackAndClearDropDown();
      if (data['error'] == false) {
        // log(data['msg'].toString());

        getSnackbar(message: data['msg'].toString());
        getUser();
      } else {
        log("AccountController:updateUser:error${data['error']}");
      }
    }
  }

  var reviewLoading = false.obs;

  fetchMyReviews() async {
    reviewLoading(true);
    var data = await ReviewService().getMyReviews(
      AppStorage.readAccessToken,
    );
    // if (data!=null) {
    //   reviewLoading(false);

    if (data.error == false) {
      reviewLoading(false);

      debugPrint(data.data.toString());
      myReviewList.value = data.data!;
      // myReviewList.value = UserReviewModel.fromJson(data);
      // myReviewList.value =
      //     data['data'].map((v) => ReviewData.fromJson(v)).toList();
      // data['data']
      //     .forEach((v) => myReviewList.add(UserReviewData.fromJson(v)));
    }
    // } else {}
  }

  fetchSiteDetail() async {
    var data = await ProfileService().siteDetail();
    if (data != null) {
      data['data'].forEach((v) => sitedetail.add(SiteDetailData.fromJson(v)));
    }
  }

  Future<void> launchurl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  /*========Fetch data for Address Selector ==========*/
  fetchAddresses() async {
    loading.value = true;
    var data = await AuthService().getAddresses();
    // debugPrint('object'+)
    if (data != null) {
      loading.value = false;
      addresses.clear();
      data['data']
          .forEach((v) => addresses.add(ShippingAddressData.fromJson(v)));
      // log("fetchAddresses:length: ${addresses.length} data: ${data['data']}");
    }
    loading.value = false;
  }

  Future<void> goBackAndClearDropDown() async {
    districts.clear();
    areas.clear();
    Get.back();
  }
}
