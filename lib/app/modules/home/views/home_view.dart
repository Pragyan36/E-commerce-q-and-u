import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_keyhash/flutter_facebook_keyhash.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/modules/account/views/account_view.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/modules/cart/views/cart_view.dart';
import 'package:q_and_u_furniture/app/modules/category/views/category_view.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';
import 'package:q_and_u_furniture/app/modules/landing/views/landing_view.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/views/wishlist_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.put(HomeController());
  final controllerlanding = Get.put(LandingController());
  final wishListController = Get.put(WishlistController());
  final cartcontroller = Get.put(CartController());
  int currentDialogIndex = 0;

  final List<Widget> screens = [
    const LandingView(),
    const CategoryView(),
    CartView(),
    WishlistView(),
    AccountView()
  ];

  void _showDialogBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: AlertDialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: const Color.fromARGB(0, 255, 253, 253),
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    _showNextDialog();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: AppColor.kalaAppMainColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            content: Obx(
              () => SizedBox(
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        _showNextDialog();
                      },
                      child: controller.loadingSkipAds.isTrue
                          ? Container()
                          : CachedNetworkImage(
                              imageUrl:
                                  "${controller.skipadlist[currentDialogIndex].mobileImage}",
                              fit: BoxFit.fitWidth,
                              placeholder: (context, url) =>
                                  Image.asset(AppImages.placeHolder),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showNextDialog() {
    setState(() {
      if (currentDialogIndex < controller.skipadlist.length - 1) {
        currentDialogIndex++;
        _showDialogBox();
      }
    });
  }

  void printKeyHash() async {
    String? key = await FlutterFacebookKeyhash.getFaceBookKeyHash ??
        'Unknown platform version';
    debugPrint("hash key is $key");
  }

  @override
  void initState() {
    log("TOKEN:HomeView${AppStorage.readAccessToken}");
    // SchedulerBinding.instance.scheduleFrameCallback((timeStamp) {
    //   wishListController.fetchWishlist();
    // });
    // wishListController.fetchWishlist();

    printKeyHash();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.skipadlist.isNotEmpty) _showDialogBox();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: false,
        onPopInvoked: (shouldPop) async {
          await Get.defaultDialog<bool>(
            barrierDismissible: false,
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.symmetric(horizontal: 20),
            title: '',
            content: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Text(
                                    'Are you sure you want to exit?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w700,
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColor.kalaAppSecondaryColor,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
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
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColor.kalaAppMainColor,
                                      ),
                                      onPressed: () {
                                        exit(0);
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
        child: Scaffold(
          backgroundColor: AppColor.kalaAppAccentColor,
          body: IndexedStack(
            index: controller.selectedindex.value,
            children: screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            elevation: 5,
            selectedIconTheme: const IconThemeData(color: Colors.black),
            selectedLabelStyle: const TextStyle(color: Colors.black),
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  controller.selectedindex.value != 0
                      ? Iconsax.home
                      : Iconsax.home1,
                  color: AppColor.kalaAppMainColor,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  controller.selectedindex.value != 1
                      ? Iconsax.category
                      : Iconsax.category5,
                  color: AppColor.kalaAppMainColor,
                ),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: cartcontroller.cartAssetsList.isNotEmpty
                    ? Badge(
                        backgroundColor: AppColor.kalaAppSecondaryColor,
                        label: Text(
                          '${cartcontroller.cartAssetsList.length}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        child: Icon(
                          controller.selectedindex.value != 2
                              ? Iconsax.shopping_cart
                              : Iconsax.shopping_cart5,
                          color: AppColor.kalaAppMainColor,
                        ),
                      )
                    : Icon(
                        controller.selectedindex.value != 2
                            ? Iconsax.shopping_cart
                            : Iconsax.shopping_cart5,
                        color: AppColor.kalaAppMainColor,
                      ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: wishListController.wishlistitems.isNotEmpty
                    ? Badge(
                        backgroundColor: AppColor.kalaAppSecondaryColor,
                        label: Text(
                          '${wishListController.wishlistitems.length}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        child: const Icon(
                          Iconsax.heart,
                          color: AppColor.kalaAppMainColor,
                        ),
                      )
                    : Icon(
                        controller.selectedindex.value != 3
                            ? Iconsax.heart
                            : Iconsax.heart5,
                        color: AppColor.kalaAppMainColor,
                      ),
                label: 'Wishlist',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  controller.selectedindex.value != 4
                      ? Iconsax.more_circle
                      : Iconsax.more_circle5,
                  color: AppColor.kalaAppMainColor,
                ),
                label: 'More',
              ),
            ],
            currentIndex: controller.selectedindex.value,
            unselectedItemColor: Colors.grey,
            onTap: controller.onItemTapped,
          ),
        ),
      ),
    );
  }
}
