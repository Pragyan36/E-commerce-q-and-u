// ignore_for_file: unnecessary_overrides, unnecessary_null_comparison

// import 'package:flutter_facebook_keyhash/flutter_facebook_keyhash.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/data/services/auth_service.dart';
import 'package:q_and_u_furniture/app/data/services/home_service.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/helper/sql_helper.dart';
import 'package:q_and_u_furniture/app/model/site_details_model.dart';
import 'package:q_and_u_furniture/app/modules/login/views/otp_authentication_view.dart';
import 'package:q_and_u_furniture/app/modules/login/views/reset_password_view.dart';
import 'package:q_and_u_furniture/app/modules/register/components/verify_otp.dart';
import 'package:q_and_u_furniture/app/modules/splash/views/splash_view.dart';
import 'package:q_and_u_furniture/app/modules/staffdashboard/controllers/dashboard_controller.dart';
import 'package:q_and_u_furniture/app/routes/app_pages.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';

class LoginController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController emailstaff = TextEditingController();
  final TextEditingController passwordstaff = TextEditingController();
  final TextEditingController otpEmail = TextEditingController();
  final TextEditingController newpassword = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  final OtpFieldController otpController = OtpFieldController();

  // final storage = const FlutterSecureStorage();

  var rememberMe = false.obs;
  var token = '';
  var otpToken = '';
  var resetToken = '';
  var loading = false.obs;
  var load = false.obs;
  var optloading = false.obs;
  var savedToken = ''.obs;
  var logindata = GetStorage().obs;
  var stafflogindata = GetStorage().obs;

  var viewPassword = true.obs;
  var viewPasswordstaff = true.obs;
  var viewPassword1 = true.obs;

  var loginLoading = false.obs;

  // var userdata = User().obs;

  @override
  void onInit() async {
    rememberMe.value =
        AppStorage.readRememberme == null ? false : AppStorage.readRememberme!;
    if (AppStorage.readRememberme == true) {
      email.text = await logindata.value.read('email');

      password.text = await logindata.value.read('password');
    }

    fetchSiteDetails();
    super.onInit();
  }

  sendOtp() async {
    loading(true);
    var data = await AuthService().sendOtp(email: otpEmail.text);
    log(data.toString());
    if (data != null) {
      await Future.delayed(const Duration(seconds: 2));
      loading(false);
      if (data["error"] == true) {
        getSnackbar(
          message: data['msg'],
          bgColor: AppColor.kalaAppMainColor,
          error: true,
        );
      } else {
        getSnackbar(message: 'Otp sent to email');
        Get.to(
          () => OtpAuthenticationView(
            email: otpEmail.text,
          ),
        );
      }
    }
  }

  getOtp(otp) async {
    optloading.value = true;
    var data = await AuthService().getOtp(email: otpEmail.text, otp: otp);
    log(otpEmail.text);
    if (data != null) {
      await Future.delayed(const Duration(seconds: 2));
      optloading.value = false;
      if (data["error"] == true) {
        getSnackbar(message: data['msg'], bgColor: Colors.red, error: true);
      } else {
        getSnackbar(message: 'Otp verified');
        // otpToken = data['token'];
        resetToken = data['reset_token'];
        Get.to(() => ResetPasswordView());
      }
    }
  }

  resetPassword() async {
    var data = await AuthService().resetPassword(
        email: otpEmail.text,
        resettoken: resetToken,
        password: newpassword.text,
        passwordconfirmation: confirmpassword.text);
    if (data != null) {
      if (data['error'] == false) {
        getSnackbar(message: data['msg']);
        Get.offNamed(Routes.LOGIN);
      } else {
        getSnackbar(message: 'Error', error: true);
      }
    }
  }

  rememberMeData() {
    if (rememberMe.isTrue) {
      logindata.value.write('rememberme', true);
      logindata.value.write('email', email.text);
      logindata.value.write('password', password.text);
      log('login data');
    } else {
      logindata.value.write('rememberme', false);

      logindata.value.write('email', '');
      logindata.value.write('password', '');
    }
  }

  //0. Server Login
  login() async {
    loginLoading.value = true;
    var data = await AuthService()
        .login(emailOrphone: email.text, password: password.text);
    log(data.toString(), name: "Login Data");

    if (data != null) {
      await Future.delayed(const Duration(seconds: 2));
      loginLoading.value = false;
      if (data['error'] == false) {
        email.clear();
        password.clear();
        getSnackbar(message: (data['message']));
        token = data['data']['token'];
        AppStorage.saveAccessToken(token);
        AppStorage.saveIsLoggedin(true);
        AppStorage.saveEmail(email.text);
        AppStorage.savePassword(password.text);
        await logindata.value
            .write("USERID", data['data']['user']['id'].toString());
        AppStorage.saveUserId(data['data']['user']['id'].toString());
        await SQLHelper.deleteAll();
        loginLoading.value = false;
        Get.offAll(() => const SplashView());
      } else if (data['error'] == true) {
        loginLoading.value = false;
        getSnackbar(
          message: (data['message']),
          bgColor: AppColor.red,
          error: true,
        );
        if (data['message'] ==
            'User Is Not Verified !! Otp Sent To Your Phone And Email') {
          Get.to(
            VerifyOtpScreen(),
          );
        }
      }
    }
  }

  var staffLoginLoading = false.obs;

  loginDelivery() async {
    staffLoginLoading.value = true;
    var data = await AuthService().logindelivery(
        emailOrphone: emailstaff.text, password: passwordstaff.text);
    // log(data);
    if (data != null) {
      await Future.delayed(const Duration(seconds: 2));
      staffLoginLoading.value = false;
      if (data['error'] == false) {
        emailstaff.clear();
        passwordstaff.clear();
        // getSnackbar(message: (data['message']));
        token = data['token'];
        AppStorage.saveAccessToken(token);
        AppStorage.saveIsStaffLoggedin(true);
        // AppStorage.saveEmail(emailstaff.text);
        // AppStorage.savePassword(passwordstaff.text);
        await stafflogindata.value
            .write("USERID", data['data']['id'].toString());
        AppStorage.saveUserId(data['data']['id'].toString());
        await SQLHelper.deleteAll();
        /* final splashController = Get.put(SplashController());
        splashController.onInit();*/
        final dashboardcontroller = Get.put(StaffDashboardController());
        dashboardcontroller.fetchtask(data['token']);
        dashboardcontroller.fetchgraph(data['token']);

        Get.offAll(() => const SplashView());

        /*final homeController = Get.put(HomeController());
        homeController.notifications.value = [];
        Get.toNamed(Routes.HOME);*/
        // Get.back();
        //     dashboardcontroller.fetchtask(AppStorage.readAccessToken);
        // dashboardcontroller.fetchgraph(AppStorage.readAccessToken);
        // accoi.getstaff();
        staffLoginLoading.value = false;
        getSnackbar(
            message: (data['message']), bgColor: AppColor.red, error: true);
      } else if (data['error'] == true) {
        staffLoginLoading.value = false;
        if (data['message'] is String) {
          staffLoginLoading.value = false;
          getSnackbar(
            message: data['message'],
            bgColor: AppColor.red,
            error: true,
          );
        } else if (data['message'] is Map<String, dynamic>) {
          staffLoginLoading.value = false;
          if (data['message']['email'] != null &&
              data['message']['email'] is List) {
            staffLoginLoading.value = false;
            getSnackbar(
              message: data['message']['email'][0],
              bgColor: AppColor.red,
              error: true,
            );
          } else if (data['message']['password'] != null &&
              data['message']['password'] is List) {
            staffLoginLoading.value = false;
            getSnackbar(
              message: data['message']['password'][0],
              bgColor: AppColor.red,
              error: true,
            );
          }
        }

        // getSnackbar(
        //     message: (data['message']), bgColor: AppColor.red, error: true);
      }
    }
  }

  //1.google Signin
  googleLogin() async {
    // try {

    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: ['email']).signIn();

    log("login1$googleUser");

    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication;

    String accessToken = googleSignInAuthentication.accessToken.toString();
    log('access token:$accessToken');
    // loading(true);
    var loginResponse = await AuthService().sociallogin(
        name: googleUser.displayName,
        email: googleUser.email,
        provider: googleUser.id,
        socialprovider: "google",
        avatar: googleUser.photoUrl,
        accesstoken: accessToken);
    if (loginResponse != null) {
      // loading(false);
      if (loginResponse['error'] == true) {
        getSnackbar(message: 'error login', bgColor: Colors.red, error: true);
      } else {
        getSnackbar(message: (loginResponse['msg']));
        token = loginResponse['data']['token'];
        AppStorage.saveAccessToken(token);
        AppStorage.saveIsLoggedin(true);

        await logindata.value
            .write("USERID", loginResponse['data']['user']['id'].toString());
        AppStorage.saveUserId(loginResponse['data']['user']['id'].toString());

        await SQLHelper.deleteAll();
        /*final splashController = Get.put(SplashController());
          splashController.onInit();*/
        Get.offAll(() => const SplashView());
        /*
          final homeController = Get.put(HomeController());
          homeController.notifications.value = [];
          Get.toNamed(Routes.HOME);*/
        log(logindata.value.read("USERID"));
      }
    }

    GoogleSignIn().disconnect();
    // } on Exception catch (e) {
    //   log("error is ....... $e");
    // }
  }

  //2. Facebook login
  facebookLogin() async {
    debugPrint("xiryo");
    final LoginResult facebookLogin = await FacebookAuth.instance.login(
      loginBehavior: LoginBehavior.webOnly,
      permissions: ['public_profile', 'email'],
    );

    log("FacebookLoginStatus:${facebookLogin.status}");

    if (facebookLogin.status == LoginStatus.success) {
      log("FacebookLoginSuccess");
      final userData = await FacebookAuth.instance.getUserData();

      if (userData['email'].toString() != null) {
        debugPrint("Email is null");
      }
      var loginResponse = await AuthService().sociallogin(
          name: userData['name'].toString(),
          email: userData['email'].toString(),
          provider: userData['id'].toString(),
          accesstoken: facebookLogin.accessToken?.token,
          socialprovider: 'facebook',
          avatar: userData['picture']['data']['url']);
      log("OurServerLoginResponse:===========================\n${loginResponse.toString()}");
      if (loginResponse['error'] == true) {
        getSnackbar(message: 'error login', bgColor: Colors.red, error: true);
        return loginResponse;
      }
      /*Save User data */
      else {
        getSnackbar(message: (loginResponse['msg']));
        token = loginResponse['data']['token'];
        AppStorage.saveAccessToken(token);
        AppStorage.saveIsLoggedin(true);
        AppStorage.savePassword(password.text);
        await logindata.value
            .write("USERID", loginResponse['data']['user']['id'].toString());
        AppStorage.saveUserId(loginResponse['data']['user']['id'].toString());

        log("Storage:FacebookLogin:isLoggedIn:${AppStorage.readIsLoggedIn}");
        log("Storage:FacebookLogin:userId:${AppStorage.readUserId}");
        // await storage.write(key: "TOKEN", value: token);

        /*await logindata.value
            .write("USERID", loginResponse['data']['user']['id'].toString());*/
        await SQLHelper.deleteAll();
        /*final splashController = Get.put(SplashController());
        splashController.onInit();*/
        Get.offAll(() => const SplashView());

        /* final homeController = Get.put(HomeController());
        homeController.notifications.value = [];
        Get.toNamed(Routes.HOME);*/
        FacebookAuth.instance.logOut();
      }
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
    } else {
      log("....Facebook auth Failed.........");
      log("FacebookLoginStatus:${facebookLogin.status}");
      log("FacebookLoginMessage:${facebookLogin.message}");
      getSnackbar(
          message: facebookLogin.message.toString(),
          bgColor: Colors.red,
          error: true);
    }
  }

  facebookLoginWithTextField({required String email}) async {
    debugPrint("xiryo");
    final LoginResult facebookLogin = await FacebookAuth.instance.login(
      loginBehavior: LoginBehavior.webOnly,
      permissions: ['public_profile', 'email'],
    );

    log("FacebookLoginStatus:${facebookLogin.status}");

    if (facebookLogin.status == LoginStatus.success) {
      log("FacebookLoginSuccess");
      final userData = await FacebookAuth.instance.getUserData();

      if (userData['email'].toString() != null) {
        debugPrint("Email is null");
      }
      var loginResponse = await AuthService().sociallogin(
          name: userData['name'].toString(),
          email: email.toString(),
          provider: userData['id'].toString(),
          accesstoken: facebookLogin.accessToken?.token,
          socialprovider: 'facebook',
          avatar: userData['picture']['data']['url']);
      log("OurServerLoginResponse:===========================\n${loginResponse.toString()}");
      if (loginResponse['error'] == true) {
        getSnackbar(message: 'error login', bgColor: Colors.red, error: true);
        return loginResponse;
      }
      /*Save User data */
      else {
        getSnackbar(message: (loginResponse['msg']));
        token = loginResponse['data']['token'];
        AppStorage.saveAccessToken(token);
        AppStorage.saveIsLoggedin(true);
        AppStorage.savePassword(password.text);
        await logindata.value
            .write("USERID", loginResponse['data']['user']['id'].toString());
        AppStorage.saveUserId(loginResponse['data']['user']['id'].toString());

        log("Storage:FacebookLogin:isLoggedIn:${AppStorage.readIsLoggedIn}");
        log("Storage:FacebookLogin:userId:${AppStorage.readUserId}");
        // await storage.write(key: "TOKEN", value: token);

        /*await logindata.value
            .write("USERID", loginResponse['data']['user']['id'].toString());*/
        await SQLHelper.deleteAll();
        /*final splashController = Get.put(SplashController());
        splashController.onInit();*/
        Get.offAll(() => const SplashView());

        /* final homeController = Get.put(HomeController());
        homeController.notifications.value = [];
        Get.toNamed(Routes.HOME);*/
        FacebookAuth.instance.logOut();
      }
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
    } else {
      log("....Facebook auth Failed.........");
      log("FacebookLoginStatus:${facebookLogin.status}");
      log("FacebookLoginMessage:${facebookLogin.message}");
      getSnackbar(
          message: facebookLogin.message.toString(),
          bgColor: Colors.red,
          error: true);
    }
  }

  RxBool siteDetailLoading = false.obs;
  RxList<SiteDetailData> siteDetailList = <SiteDetailData>[].obs;

  fetchSiteDetails() async {
    siteDetailLoading(true);
    SiteDetail? data = await HomeService().getSiteDetails();
    siteDetailList.clear();
    if (data != null) {
      print("check check $data");
      siteDetailLoading(false);
      siteDetailList.value = data.data!;
    } else {
      siteDetailLoading(false);
      log("There was an error fetching site details!");
    }
  }
}
