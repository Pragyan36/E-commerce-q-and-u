import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/data/models/customer_care.dart';
import 'package:q_and_u_furniture/app/data/models/featured_product_model.dart';
import 'package:q_and_u_furniture/app/data/models/skip_ads_model.dart';
import 'package:q_and_u_furniture/app/data/models/slider_model.dart';
import 'package:q_and_u_furniture/app/data/models/specfic_featured_model.dart';
import 'package:q_and_u_furniture/app/data/models/specific_featured_product_model.dart';
import 'package:q_and_u_furniture/app/data/models/top_ranked.dart';
import 'package:q_and_u_furniture/app/data/services/home_service.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/helper/sql_helper.dart';
import 'package:q_and_u_furniture/app/model/ads_model.dart';
import 'package:q_and_u_furniture/app/model/privacy_menu.dart';
import 'package:q_and_u_furniture/app/model/product_model.dart';
import 'package:q_and_u_furniture/app/model/social_icon.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/views/login_view.dart';
import 'package:q_and_u_furniture/app/modules/notification/views/notification_view.dart';
import 'package:q_and_u_furniture/app/modules/notification/views/staff_notification.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';
import 'package:q_and_u_furniture/main.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final selectedindex = 0.obs;
  final selectedbanner = 0.obs;
  final productsList = <Data>[].obs;
  final specificFeaturedProductData = <SpecificFeaturedProductData>[].obs;
  var adsList = <AdsData>[].obs;
  final sliderList = <SliderModel>[].obs;
  final toprankedList = <TopRankedData>[].obs;
  final featuredList = <FeaturedProductModel>[].obs;
  final specificfeaturedList = <FeaturedProductsList>[].obs;
  late ScrollController scrollcontroller;
  var adIndex = 0.obs;

  final cartController = Get.put(CartController());
  final wishListController = Get.put(WishlistController());
  final logincon = Get.put(LoginController());

  /*Variables for Notification*/
  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var notificationCounter = 0;

  final socialIcon = <SocialIconHeadingModel>[].obs;
  final customCare = <CustomerCareModel>[].obs;

  var loading = false.obs;
  final privacyPolicy = <PrivacyMenuModel>[].obs;

  @override
  void onInit() {
    log("HomeController:onInit");
    log("TOKEN:HomeController${AppStorage.readAccessToken}");

    super.onInit();
    fetchskipads();
    scrollcontroller = ScrollController()..addListener(_scrollListener);
    getToken();
    refreshNotification();
    handleBackgroundNotificationClick();
    handleForegroundNotification();
    fetchSocialIcon();
    fetchCustomerCare();
    fetchPrivacyPolicy();
  }

  var firetoken = ''.obs;

  getToken() async {
    log("HomeController:getToken");
    firetoken.value = (await FirebaseMessaging.instance.getToken())!;
  }

  Future<void> makeUrl(String url) async {
    if (!await canLaunchUrl(
      Uri.parse(url),
    )) {
      await launchUrl(
        Uri.parse(url),
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> makePhoneCall(String url) async {
    if (!await canLaunchUrl(
      Uri.parse(url),
    )) {
      await launchUrl(
        Uri.parse(url),
      );
    } else {
      await launchUrl(
        Uri.parse(url),
      );
    }
  }

  void onItemTapped(int index) async {
    if (AppStorage.readIsLoggedIn != true) {
      if (index == 2 || index == 3 || index == 4) {
        Get.to(
          () => LoginView(),
        );
      } else {
        selectedindex.value = index;
      }
    }
    //Logged In
    else {
      //Check Internet
      if (index == 2 || index == 3 || index == 4) {
        if (await Connectivity().checkConnectivity() ==
            ConnectivityResult.none) {
          getSnackbar(
              message: "No Internet Connection",
              error: true,
              bgColor: Colors.red);
          return;
        }
      } else {
        selectedindex.value = index;
      }
      selectedindex.value = index;
    }
    if (selectedindex.value == 2) {
      cartController.fetchCart();
      return;
    }
    if (selectedindex.value == 3) {
      // log("selectedindex:3");
      wishListController.fetchWishlist();
      return;
    }
    // log('HomeController:onItemTapped:$index');
  }

  final loadingSkipAds = false.obs;
  var skipadlist = <SkipAdslist>[].obs;
  fetchskipads() async {
    loadingSkipAds(true);
    var data = await HomeService().getSkipAds();
    debugPrint("dataads $data");

    if (data != null) {
      // log("LandingController:homeSlider ${data['data']['sliders']}");
      loadingSkipAds(false);
      // departmentlist.clear();
      // featuredlist.clear();
      skipadlist.clear();
      // homeData.value = HomeModelData.fromJson(data['data']);

      // data['data'].forEach((v) => sliderlist.add(Sliders.fromJson(v)));
      data['data'].forEach((v) => skipadlist.add(SkipAdslist.fromJson(v)));
      // data['data']['featured_category']
      //     .forEach((v) => departmentlist.add(FeaturedCategory.fromJson(v)));
      // data['data']['featured_section']
      //     .forEach((v) => featuredlist.add(FeaturedSection.fromJson(v)));
      if (data['error'] == false) {}
    }
  }

  var notifications = [].obs;

  refreshNotification() async {
    var data = await SQLHelper.getItems();
    notifications.value = data;
    debugPrint("dataNotification $data");
  }

  deleteAllNotifications() async {
    await SQLHelper.deleteAll();
    refreshNotification();
    getSnackbar(message: "Deleted all Notifications");
  }

  Future<void> addItem(title, body, image) async {
    log("SQL Helper:----HomeController:addItem");
    await SQLHelper.createItem(title, body, image);
    refreshNotification();
  }

  void deleteItem(id) async {
    await SQLHelper.deleteItem(id);
    getSnackbar(bgColor: Colors.red, message: 'Notification Deleted');
    refreshNotification();
  }

  var isLoading = false.obs;
  var isLastPage = false.obs;
  var pageNumber = 0.obs;
  var numberOfPostsPerRequest = 6.obs;
  var tapdown = false.obs;

  void _scrollListener() {
    debugPrint(scrollcontroller.position.extentAfter.toString());
    if (scrollcontroller.position.extentAfter < 1) {
      numberOfPostsPerRequest.value += 4;
      fetchProducts();
    }
  }

  fetchAllFeaturedSpecific() async {
    //isLoading(true);
    var data = await HomeService().getAllFeaturedSpecific(1);
    // log(data['data'].toString());
    if (data != null) {
      //isLoading(false);
      specificFeaturedProductData.clear();
      data['data'].forEach((v) => specificFeaturedProductData
          .add(SpecificFeaturedProductData.fromJson(v)));
    }
  }

  fetchProducts() async {
    isLoading(true);
    var data = await HomeService().getAllProducts(1);
    // log(data['data'].toString());
    if (data != null) {
      isLoading(false);
      productsList.clear();
      data['data'].forEach((v) => productsList.add(Data.fromJson(v)));
    }
  }

  fetchAds() async {
    isLoading(true);
    var data = await HomeService().getAds();
    debugPrint("dataformhome $data");
    // log("Ads :$data['error']");
    if (data != null) {
      isLoading(false);
      adsList.clear();
      data['data'].forEach((v) => adsList.add(AdsData.fromJson(v)));
    }
  }

  fetchSlider() async {
    var data = await HomeService().getSlider();
    // log("Slider :$data");
    if (data != null) {
      sliderList.clear();
      data.forEach((v) => sliderList.add(SliderModel.fromJson(v)));
    }
  }

  fetchTopRanked() async {
    var data = await HomeService().getTopRanked();
    // log("TopRanked :$data");
    if (data != null) {
      toprankedList.clear();
      data['data'].forEach((v) => toprankedList.add(TopRankedData.fromJson(v)));
    }
  }

  fetchFeaturedProducts() async {
    var data = await HomeService().getFeaturedProducts();
    // log("getFeaturedProducts :$data");
    if (data != null) {
      featuredList.clear();
      data.forEach((v) => featuredList.add(FeaturedProductModel.fromJson(v)));
    }
  }

  fetchSpecificFeaturedProducts(id) async {
    loading(true);
    var data = await HomeService().getSpecificFeatured(id);
    // log("getSpecificFeaturedProducts :$data");
    if (data != null) {
      loading(false);

      specificfeaturedList.clear();
      data['data']['featured_products'].forEach(
          (v) => specificfeaturedList.add(FeaturedProductsList.fromJson(v)));
    }
  }

  // LoginController logincon = Get.find();

  location(shippingaddress) async {
    var data = await HomeService()
        .location(shippingaddress, logincon.logindata.value.read('USERID'));
    if (data != null) {
      getSnackbar(message: 'location updated');
    }
  }

  Future<void> handleBackgroundNotificationClick() async {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
        );
        flutterLocalNotificationsPlugin.initialize(
          initializationSettings,
          onSelectNotification: (String? payload) async {
            Get.to(
              AppStorage.readIsStaffLoggedIn == true
                  ? StaffNotificationView()
                  : NotificationView(),
            );
          },
        );
        // RemoteNotification? notification = message.notification;
        // AndroidNotification? android = message.notification?.android;
        Get.to(
          NotificationView(),
        );
      },
    ).onData((message) {
      log("1.OnFirebaseMessage:onData:notificationCounter:$notificationCounter");
      /*NOTE: THIS FUNCTION WAS EXECUTING TWO TIMES FOR NO REASON
          * SO FOR A WORKAROUND A COUNTER HAS BEEN USED TO AVOID DOUBLE EXECUTION
          * HAPPENS ONLY AFTER FIRST LOGIN*/
      debugPrint("new message is ${message.notification!.title}");
      // if (notificationCounter >= 1) {
      //   log("4. notificationCounter value is more than or equal to 1");
      //   return;
      // }
      notificationCounter + 1;
      log("2. notificationCounter++:$notificationCounter");

      // log("HomeController:handleForegroundNotification:onMessageReceived");
      /*Save the notification in sqlite*/
      log("3. SQL Helper:----HomeController:handleForegroundNotification");
      addItem(message.notification?.title, message.notification?.body,
          message.notification!.android!.imageUrl ?? "");
      // log("HomeController:handleForegroundNotification:message:${message.data}");
    });
  }

  void handleForegroundNotification() {
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        Get.to(
          NotificationView(),
        );
      },
    );
    /*Listen to message received on Foreground*/
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Get.to(AppStorage.readIsStaffLoggedIn == true
          ? StaffNotificationView()
          : NotificationView());
      notificationCounter + 1;
      log("2. notificationCounter++:$notificationCounter");
    }).onData((message) async {
      log("1.OnFirebaseMessage:onData:notificationCounter:$notificationCounter");
      /*NOTE: THIS FUNCTION WAS EXECUTING TWO TIMES FOR NO REASON
          * SO FOR A WORKAROUND A COUNTER HAS BEEN USED TO AVOID DOUBLE EXECUTION
          * HAPPENS ONLY AFTER FIRST LOGIN*/
      debugPrint("new message is ${message.notification!.title}");
      // if (notificationCounter >= 1) {
      //   log("4. notificationCounter value is more than or equal to 1");
      //   return;
      // }
      // notificationCounter + 1;
      // log("2. notificationCounter++:$notificationCounter");

      // log("HomeController:handleForegroundNotification:onMessageReceived");
      /*Save the notification in sqlite*/
      log("3. SQL Helper:----HomeController:handleForegroundNotification");
      addItem(message.notification?.title, message.notification?.body,
          message.notification!.android!.imageUrl ?? "");
      // log("HomeController:handleForegroundNotification:message:${message.data}");
      /*Show the notification*/
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        // log("HomeController:handleForegroundNotification:notification!=null");
        /*Show notification*/
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                color: Colors.blue,
                //      one that already exists in example app.
                icon: "@mipmap/ic_launcher",
              ),
            ));
      }
      Future.delayed(const Duration(seconds: 1), () {
        log('5. notificationCounter decremented');
        notificationCounter - 1;
      });
    });
  }

  fetchSocialIcon() async {
    try {
      var data = await HomeService().getSocialIcon();

      if (data != null) {
        socialIcon.clear();

        socialIcon.add(SocialIconHeadingModel.fromJson(data));
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'fetchAbout error');
    }
  }

  RxBool customerCareLoading = false.obs;

  fetchCustomerCare() async {
    try {
      customerCareLoading(true);
      var data = await HomeService().getCustomCare();
      log(data.toString(), name: "Customer Care Data");

      if (data != null) {
        customerCareLoading(false);
        customCare.clear();
        data['data']
            .forEach((v) => customCare.add(CustomerCareModel.fromJson(data)));
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'fetch customerCare error');
    } finally {
      customerCareLoading(false);
    }
  }

  fetchPrivacyPolicy() async {
    try {
      loading(true);
      var data = await HomeService().getPrivacyPolicy();

      if (data != null) {
        loading(false);
        privacyPolicy.clear();

        privacyPolicy.add(PrivacyMenuModel.fromJson(data));
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'fetch customerCare error');
    } finally {
      loading(false);
    }
  }
}
