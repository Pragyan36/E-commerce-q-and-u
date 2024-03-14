// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/helper/sql_helper.dart';
import 'package:q_and_u_furniture/app/model/social_icon.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/account_controller.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/my_details.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/my_review.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/views/TestOrder.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/views/about_us_view.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/views/complete_order.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/views/contact_us.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/views/custom_care.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/views/customer_service_view.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/views/return_order.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/views/return_policy_view.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/views/terms_view.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/views/login_view.dart';
import 'package:q_and_u_furniture/app/modules/splash/views/splash_view.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountView extends GetView<AccountController> {
  AccountView({Key? key}) : super(key: key);

  final AccountController loginController = Get.put(
    AccountController(),
  );
  final LoginController logincon = Get.put(
    LoginController(),
  );
  final HomeController homeController = Get.put(
    HomeController(),
  );

  @override
  Widget build(BuildContext context) {
    homeController.fetchSocialIcon();
    loginController.onInit();
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: ListTile(
                  leading: Obx(
                    () => Hero(
                      tag: 'img',
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey.shade200,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                loginController.userdata.value.social_avatar !=
                                        null
                                    ? loginController
                                        .userdata.value.social_avatar!
                                    : loginController.userdata.value.photo !=
                                            null
                                        ? loginController.userdata.value.photo!
                                        : '$url/frontend/images/avatar.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    'Hi',
                    style: subtitleStyle,
                  ),
                  subtitle: Obx(
                    () => Text(
                      loginController.userdata.value.name ?? '...',
                      style: subtitleStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  trailing: MaterialButton(
                    shape: CircleBorder(
                      side: BorderSide(
                        color: Colors.grey.shade400,
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Iconsax.edit,
                      size: 20.sp,
                      color: Colors.grey.shade500,
                    ),
                    onPressed: () {
                      Get.to(
                        () => const MyDetails(),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 10,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              // ACCOUNT SECTION
              Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10,
                        ),
                        child: Text(
                          "Account",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildAccountOptionTile(
                    'My Order',
                    Icons.shopping_bag_outlined,
                    () {
                      Get.to(
                        () => const MyOrderTestView(
                          isFromPurchaseView: false,
                        ),
                      );
                    },
                  ),
                  _buildAccountOptionTile(
                    'My Details',
                    Icons.event_note,
                    () {
                      Get.to(
                        () => const MyDetails(),
                      );
                    },
                  ),
                  _buildAccountOptionTile(
                    'Reviews',
                    Icons.messenger_outline,
                    () {
                      Get.to(
                        () => const MyReviewView(),
                      );
                    },
                  ),
                  _buildAccountOptionTile(
                    'Complete Order',
                    Icons.local_shipping,
                    () {
                      Get.to(
                        () => const CompleteOrderScreen(),
                      );
                    },
                  ),
                  _buildAccountOptionTile(
                    'Return Order',
                    Icons.keyboard_return,
                    () {
                      Get.to(
                        () => const ReturnOrderScreen(),
                      );
                    },
                  ),
                  _buildAccountOptionTile(
                    'Logout',
                    Icons.logout,
                    () async {
                      await Get.defaultDialog<bool>(
                        backgroundColor: Colors.transparent,
                        contentPadding: EdgeInsets.zero,
                        titlePadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        title: '',
                        content: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 1,
                            sigmaY: 1,
                          ),
                          child: Wrap(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.topCenter,
                                    margin: const EdgeInsets.only(top: 30),
                                    padding: const EdgeInsets.only(
                                      top: 50,
                                      left: 20,
                                      right: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Column(
                                          children: [
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                              ),
                                              child: Text(
                                                'Are you sure you want to logout?',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 13,
                                                      letterSpacing: 2,
                                                      color: Colors.black,
                                                    ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SizedBox(
                                                width: 100,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: AppColor
                                                        .kalaAppSecondaryColor2,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(false);
                                                  },
                                                  child: const Text('No'),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              SizedBox(
                                                width: 100,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: AppColor
                                                        .kalaAppMainColor,
                                                  ),
                                                  onPressed: () {
                                                    AppStorage.removeStorage();
                                                    SQLHelper.deleteAll();
                                                    WishlistController()
                                                        .wishlistitems
                                                        .clear();
                                                    // Get.offAll(
                                                    //   () => const HomeView(),
                                                    // );
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return const SplashView();
                                                        },
                                                      ),
                                                      (route) => false,
                                                    );
                                                    FacebookAuth.instance
                                                        .logOut();
                                                  },
                                                  child: const Text('Yes'),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Container(
                height: 10,
                color: const Color.fromARGB(255, 250, 247, 247),
              ),
              // SUPPORT SECTION
              Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10,
                        ),
                        child: Text(
                          "Support",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildAccountOptionTile(
                    "Customer Service",
                    Icons.question_answer_outlined,
                    () {
                      Get.to(
                        () => const CustomerServiceView(),
                      );
                    },
                  ),
                  _buildAccountOptionTile(
                    "About Us",
                    Icons.info,
                    () {
                      Get.to(
                        () => const AboutUsView(),
                      );
                    },
                  ),
                  _buildAccountOptionTile(
                    "Terms & Conditions",
                    Icons.list,
                    () {
                      Get.to(
                        () => const TermsView(),
                      );
                    },
                  ),
                  _buildAccountOptionTile(
                    "Contact Us",
                    Icons.contact_mail,
                    () {
                      Get.to(
                        () => ContactusView(),
                      );
                    },
                  ),
                  _buildAccountOptionTile(
                    "Return Policy",
                    Icons.policy,
                    () {
                      Get.to(
                        () => const ReturnPolicyView(),
                      );
                    },
                  ),
                  _buildAccountOptionTile(
                    "Customer Care",
                    Icons.person,
                    () {
                      Get.to(
                        () => const CustomerCareScreen(),
                      );
                    },
                  ),
                ],
              ),
              Container(
                height: 10,
                color: const Color.fromARGB(255, 250, 247, 247),
              ),
              // SOCIAL MEDIA SECTION
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder<SocialIconModel>(
                      future: fetchSocialMediaLinks(),
                      builder: (context, snapshot) {
                        var datas = snapshot.data;
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Center(
                                child: CachedNetworkImage(
                                  imageUrl: Uri.encodeFull(
                                    logincon.siteDetailList[0].value ?? "",
                                  ),
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 60.0,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Center(
                                        child: Text(
                                          datas!.data?.name.toString() ??
                                              "Q & U Hongkong Furniture",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: IconButton(
                                      onPressed: () {
                                        homeController.makePhoneCall(
                                          "tel:${datas.data!.phone}",
                                        );
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.phone,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: IconButton(
                                      onPressed: () {
                                        final Uri emailLaunchUri = Uri(
                                          scheme: 'mailto',
                                          path: datas.data!.email,
                                        );
                                        launchUrl(emailLaunchUri);
                                      },
                                      icon: const Icon(
                                        Icons.mail,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: IconButton(
                                      onPressed: () {
                                        homeController.makePhoneCall(
                                          datas.data!.facebook.toString(),
                                        );
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.facebook,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: IconButton(
                                      onPressed: () {
                                        homeController.makePhoneCall(
                                          datas.data!.instagram.toString(),
                                        );
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.instagram,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomShimmer(
                            widget: Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOfficeContacts({
    IconData? icon,
    String? text,
    Function()? onTap,
    Color? iconColor,
    String? subtitle,
  }) {
    return ListTile(
      onTap: onTap,
      title: Text(text!),
      leading: Icon(icon),
      subtitle: subtitle != null ? Text(subtitle) : const SizedBox(),
    );
  }

  _buildAccountOptionTile(
    title,
    icon,
    ontap,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      leading: Icon(
        icon,
        size: 20.sp,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: titleStyle,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16.sp,
        color: Colors.black12,
      ),
      onTap: ontap,
    );
  }

  buildLoginCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          children: [
            const Text("Login to your account or register a new one!"),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(
                  () => LoginView(),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              child: const Text("Login or Register"),
            )
          ],
        ),
      ),
    );
  }

  Future<SocialIconModel> fetchSocialMediaLinks() async {
    final response = await http.get(
      Uri.parse('$baseUrl/social-site'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(
        response.body.toString(),
      );
      return SocialIconModel.fromJson(data);
    } else {
      throw Exception('Failed to load social media links');
    }
  }
}
