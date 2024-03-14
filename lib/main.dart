import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/helper/sql_helper.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/modules/notification/views/notification_view.dart';
import 'package:q_and_u_furniture/app/routes/app_pages.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  var data = message;
  addItem(
    data.notification?.title,
    data.notification?.body,
    data.notification!.android!.imageUrl ?? "",
  );
  Get.to(NotificationView());
}

Future<void> addItem(title, body, image) async {
  await SQLHelper.createItem(title, body, image);
}

Future<void> _requestPermissions() async {
  final PermissionStatus status = await Permission.notification.status;

  if (!status.isGranted) {
    await Permission.notification.request();
  }
}

/*Notification Channel Object which is used to create Notification*/
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  // 'This channel is used for important notifications.', // description
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

var isFirebaseInitialized = false;
Future<void> requestPermissions() async {
  PermissionStatus locationStatus = await Permission.location.request();
  debugPrint('Location permission status: $locationStatus');

  PermissionStatus storageStatus = await Permission.storage.request();
  debugPrint('Storage permission status: $storageStatus');

  PermissionStatus status = await Permission.notification.request();
  debugPrint('Notification permission status: $status');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeFirebase();
  _requestPermissions();
  await FlutterDownloader.initialize();
  initializeStorage();
  log("TOKEN::Main:${AppStorage.readAccessToken}");
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) =>
          ResponsiveSizer(builder: (context, orientation, screenType) {
        return OverlaySupport.global(
          child: KhaltiScope(
            builder: (context, navigatorKey) {
              return GetMaterialApp(
                scrollBehavior: ScrollConfiguration.of(context).copyWith(
                  physics: const BouncingScrollPhysics(),
                ),
                title: "Q & U Hongkong Furniture",
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  useMaterial3: false,
                  appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.black),
                    color: Colors.blue,
                    foregroundColor: Colors.black,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                      statusBarBrightness: Brightness.light,
                    ),
                  ),
                ),
                navigatorKey: navigatorKey,
                supportedLocales: const [
                  Locale('en', 'US'),
                  Locale('ne', 'NP'),
                ],
                localizationsDelegates: const [
                  KhaltiLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                initialRoute: AppPages.INITIAL,
                getPages: AppPages.routes,
              );
            },
            publicKey: 'test_public_key_30e12814fed64afa9a7d4a92a2194aeb',
          ),
        );
      }),
    ),
  );
  requestPermissions();
}

void initializeStorage() async {
  await GetStorage.init();
}

void initializeFirebase() async {
  if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
    const SnackBar(
      content: Text(
        "No internet connection",
      ),
      backgroundColor: Colors.red,
    );
  }

  final controller = Get.put(HomeController());

  await Firebase.initializeApp();
  Future.delayed(const Duration(seconds: 10), () async {
    await FirebaseMessaging.instance.subscribeToTopic(
        "com.nectardigit.q_and_u_furniture${AppStorage.readUserId.toString()}");
    // await FirebaseMessaging.instance
    //     .subscribeToTopic(AppStorage.readUserId.toString());
    debugPrint("user id is ${AppStorage.readUserId}");
    await FirebaseMessaging.instance
        .subscribeToTopic("com.nectardigit.q_and_u_furniture");
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /*This is for apple, to get notification when app is in foreground*/
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFirebaseInitialized = true;
  controller.handleBackgroundNotificationClick();
}
