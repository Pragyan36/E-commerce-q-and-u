import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:q_and_u_furniture/app/modules/staffdashboard/views/addtask.dart';
import 'package:q_and_u_furniture/app/modules/staffdashboard/views/widgets/task_view.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/helper/sql_helper.dart';
import 'package:q_and_u_furniture/app/model/social_icon.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/account_controller.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/modules/home/views/home_view.dart';
import 'package:q_and_u_furniture/app/modules/staffdashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class custom_dawer extends StatefulWidget {
  const custom_dawer({
    super.key,
    // required this.controller,
  });

  // final AccountController controller;

  @override
  State<custom_dawer> createState() => _custom_dawerState();
}

class _custom_dawerState extends State<custom_dawer> {
  final dashboardcontroller = Get.put(StaffDashboardController());
  final accountcontroller = Get.put(AccountController());
  final homeController = Get.put(HomeController());
  void toggleTimer() {
    dashboardcontroller.fetchlocation();
  }

  // Timer? timer;

  // void toggleTimer() {
  //   setState(() {
  //     if (isTimerRunning) {
  //       // If the timer is running, cancel it.
  //       timer?.cancel();
  //     } else {
  //       // If the timer is not running, start it.
  //       timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
  //         print("time for 5 sec");
  //       });
  //     }
  //     // Toggle the timer running state.
  //     isTimerRunning = !isTimerRunning;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // The right drawer
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              _profileStaff(),
              Obx(() =>
                  (accountcontroller.staffuserdata.value.data!.roles![0].name !=
                          "delivery")
                      ? ListTile(
                          leading: const Icon(Icons.lock_person),
                          title: const Text('My Task'),
                          onTap: () {
                            Get.to(const MyTaskView());
                            // toggleTimer();

                            // Do something when the item in the drawer is tapped
                            // Get.offAll(() => HomeView()); // Close the drawer
                          },
                        )
                      : const SizedBox()),
              Obx(() =>
                  accountcontroller.staffuserdata.value.data!.roles![0].name !=
                          "delivery"
                      ? ListTile(
                          leading: const Icon(Icons.add_task_outlined),
                          title: const Text('Add Task'),
                          onTap: () {
                            dashboardcontroller.discription.clear();
                            dashboardcontroller.title.clear();
                            dashboardcontroller.startDate.clear();
                            dashboardcontroller.endDate.clear();

                            dashboardcontroller.selectedStaff == null;
                            dashboardcontroller.selectedOrder == null;
                            dashboardcontroller.selectedAction == null;
                            dashboardcontroller.selectedPriority == null;
                            dashboardcontroller.selectedStatus == null;
                            Get.to(const Addtask());
                            // Do something when the item in the drawer is tapped
                            // dashboardcontroller.fetchgraph(AppStorage.readAccessToken);
                          },
                        )
                      : const SizedBox()),
              Obx(
                () => accountcontroller
                            .staffuserdata.value.data!.roles![0].name ==
                        "delivery"
                    ? ListTile(
                        leading: Icon(dashboardcontroller.isTimerRunning.isFalse
                            ? Icons.pause
                            : Icons.play_arrow),
                        title: Text(dashboardcontroller.isTimerRunning.isFalse
                            ? 'Pause live location'
                            : 'Start live location'),
                        onTap: () {
                          toggleTimer();

                          // Do something when the item in the drawer is tapped
                          // Get.offAll(() => HomeView()); // Close the drawer
                        },
                      )
                    : const SizedBox(),
              ),
              // ListTile(
              //   title: Text('post location'),
              //   onTap: () {
              //     dashboardcontroller.postCurrentLocation();

              //     // Do something when the item in the drawer is tapped
              //     // Get.offAll(() => HomeView()); // Close the drawer
              //   },
              // ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                leading: Icon(
                  Icons.logout,
                  size: 20.sp,
                  color: Colors.black,
                ),
                title: Text(
                  "Log out",
                  style: titleStyle,
                ),
                // trailing: Icon(
                //   Icons.arrow_forward_ios_rounded,
                //   size: 16.sp,
                //   color: Colors.black12,
                // ),
                onTap: () async {
                  final shoulpop = await Get.defaultDialog<bool>(
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
                                    top: 50, left: 20, right: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
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
                                              horizontal: 10.0),
                                          child: Text(
                                            'Do You Want to logout ?',
                                            // maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 13,
                                                    letterSpacing: 2,
                                                    color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // SizedBox(height: buttonHeight ?? 20),
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
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: AppColor
                                                      .mainClr // Set the button's background color
                                                  ),
                                              onPressed: () {
                                                Navigator.of(context).pop(
                                                    false); // Return false to prevent exiting
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
                                                backgroundColor: AppColor
                                                    .orange, // Set the button's background color
                                              ),
                                              onPressed: () {
                                                AppStorage.removeStorage();
                                                SQLHelper.deleteAll();
                                                Get.offAll(
                                                    () => const HomeView());
                                                FacebookAuth.instance.logOut();
                                                dashboardcontroller
                                                    .isTimerRunning
                                                    .value = false;
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

                              //For displaying the emoji
                              // Positioned(
                              //     right: 0,
                              //     left: 0,
                              //     top: 0,
                              //     child: CircleAvatar(
                              //       radius: 48 + 2,
                              //       backgroundColor: Colors.white,
                              //       child: CircleAvatar(
                              //         radius: 48,
                              //         backgroundColor: Colors.white,
                              //         child: CircleAvatar(
                              //             radius: 35,
                              //             child: Image.asset(
                              //               'assets/images/appicon.png',
                              //               width: 100,
                              //               height: 100,
                              //               fit: BoxFit.cover,
                              //             )),
                              //       ),
                              //     ))
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
          Column(
            children: [
              _cardOfaddress(),
            ],
          )
        ],
      ),
    );
  }

  Container _profileStaff() {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: Obx(
          () => accountcontroller.loading.isTrue
              ? Container()
              : Hero(
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
                                    accountcontroller.staffuserdata.value.data!
                                                .photo !=
                                            null
                                        ? accountcontroller
                                            .staffuserdata.value.data!.photo!
                                        : '$url/frontend/images/avatar.png'),
                                fit: BoxFit.cover)),
                      )
                      // ClipOval(
                      //     child: CachedNetworkImage(
                      //       fit: BoxFit.cover,
                      //       imageUrl:
                      //           '$url/Uploads/user/${controller.userdata.value.photo}',
                      //       placeholder: (context, i) {
                      //         return const CircularProgressIndicator();
                      //       },
                      //     ),
                      //   ),

                      //  const Icon(
                      //   Iconsax.user,
                      //   color: AppColor.orange,
                      // ),
                      ),
                ),
        ),
        title: Text(
          "${accountcontroller.staffuserdata.value.data!.name}" ?? '...',
          style: subtitleStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${accountcontroller.staffuserdata.value.data!.email}" ?? '...',
              ),
              Text(
                "${accountcontroller.staffuserdata.value.data!.address}" ??
                    '...',
              ),
            ],
          ),
        ),
        // trailing: MaterialButton(
        //     shape: CircleBorder(
        //         side: BorderSide(
        //             color: Colors.grey.shade400, width: 1)),
        //     child: Icon(Iconsax.edit,
        //         size: 20.sp, color: Colors.grey.shade500),
        //     onPressed: () {
        //       Get.to(() => MyDetails());
        //     }),
      ),
    );
  }

  Card _cardOfaddress() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                      // const CircleAvatar(
                      //   radius: 40,
                      //   backgroundColor: Colors.transparent,
                      //   backgroundImage:
                      //       AssetImage("assets/images/appicon.png"),
                      // ),
                      Image.asset(
                        "assets/images/appicon.png",
                        height: 80,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Center(
                                child: Text(
                                  // "Q & U Hongkong Furniture "
                                  datas!.data!.name.toString(),
                                ),
                                // child: Text(
                                //   "Q & U Hongkong Furniture",
                                // ),
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
                                      "tel:${datas.data!.phone}");
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.phone,
                                  color: Colors.grey,
                                )),
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
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: IconButton(
                                onPressed: () {
                                  homeController.makePhoneCall(
                                      datas.data!.facebook.toString());
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.facebook,
                                  color: Colors.grey,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: IconButton(
                                onPressed: () {
                                  homeController.makePhoneCall(
                                      datas.data!.instagram.toString());
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.instagram,
                                  color: Colors.grey,
                                )),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(2.0),
                          //   child: IconButton(
                          //       onPressed: () {
                          //         homeController.makePhoneCall(datas!
                          //             .data!.twitter
                          //             .toString());
                          //       },
                          //       icon: Icon(
                          //         FontAwesomeIcons.twitter,
                          //         color: Colors.grey,
                          //       )),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.all(2.0),
                          //   child: IconButton(
                          //       onPressed: () {
                          //         homeController.makePhoneCall(datas!
                          //             .data!.youtube
                          //             .toString());
                          //       },
                          //       icon: Icon(
                          //         FontAwesomeIcons.youtube,
                          //         color: Colors.grey,
                          //       )),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.all(2.0),
                          //   child: IconButton(
                          //       onPressed: () {
                          //         homeController.makePhoneCall(datas!
                          //             .data!.address
                          //             .toString());
                          //       },
                          //       icon: Icon(
                          //         Icons.location_on_rounded,
                          //         color: Colors.grey,
                          //       )),
                          // ),
                        ],
                      ),
                      // buildOfficeContacts(
                      //   icon: FontAwesomeIcons.phone,
                      //   text: 'Phone',
                      //   iconColor: Colors.blue,
                      //   subtitle: '',
                      //   onTap: () {
                      //     homeController.makePhoneCall(
                      //         "tel:${datas.data!.phone}");
                      //   },
                      // ),
                      // const Divider(
                      //   height: 1,
                      //   color: Colors.grey,
                      // ),
                      // // buildOfficeContacts(
                      // //   icon: Icons.mail,
                      // //   text: 'Email',
                      // //   iconColor: Colors.blue,
                      // //   subtitle: '',
                      // //   onTap: () {
                      // //     final Uri emailLaunchUri = Uri(
                      // //       scheme: 'mailto',
                      // //       path: datas.data!.email,
                      // //     );

                      // //     launchUrl(emailLaunchUri);
                      // //   },
                      // // ),
                      // const Divider(
                      //   height: 1,
                      //   color: Colors.grey,
                      // ),
                      // // buildOfficeContacts(
                      // //   icon: FontAwesomeIcons.facebook,
                      // //   text: 'Facebook',
                      // //   iconColor: Colors.blue,
                      // //   subtitle: '',
                      // //   onTap: () {
                      // //     homeController.makePhoneCall(
                      // //         datas.data!.facebook.toString());
                      // //   },
                      // // ),
                      // const Divider(
                      //   height: 1,
                      //   color: Colors.grey,
                      // ),
                      // // buildOfficeContacts(
                      // //   icon: FontAwesomeIcons.instagram,
                      // //   text: 'Instagram',
                      // //   iconColor: Colors.blue,
                      // //   subtitle: '',
                      // //   onTap: () {
                      // //     homeController.makePhoneCall(
                      // //         datas.data!.instagram.toString());
                      // //   },
                      // // ),
                      // const Divider(
                      //   height: 1,
                      //   color: Colors.grey,
                      // ),
                      // buildOfficeContacts(
                      //   icon: FontAwesomeIcons.twitter,
                      //   text: 'Twitter',
                      //   iconColor: Colors.blue,
                      //   subtitle: '',
                      //   onTap: () {
                      //     homeController.makePhoneCall(
                      //         datas.data!.twitter.toString());
                      //   },
                      // ),
                      // const Divider(
                      //   height: 1,
                      //   color: Colors.grey,
                      // ),
                      // buildOfficeContacts(
                      //   icon: FontAwesomeIcons.youtube,
                      //   text: 'Youtube',
                      //   iconColor: Colors.blue,
                      //   subtitle: '',
                      //   onTap: () async {
                      //     // ignore: deprecated_member_use
                      //     homeController.makePhoneCall(
                      //         datas.data!.youtube.toString());
                      //   },
                      // ),
                      // const Divider(
                      //   height: 1,
                      //   color: Colors.grey,
                      // ),
                      // buildOfficeContacts(
                      //   icon: FontAwesomeIcons.map,
                      //   text: 'Map',
                      //   iconColor: Colors.blue,
                      //   subtitle: '',
                      //   onTap: () async {
                      //     homeController.makePhoneCall(
                      //         datas.data!.address.toString());
                      //   },
                      // ),
                    ],
                  );
                }
                return CustomShimmer(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  widget: Container(
                    height: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    width: MediaQuery.of(context).size.width,
                    // decoration: const BoxDecoration(
                    //     color: Colors.grey, shape: BoxShape.circle),
                  ),
                );
                // const CircularProgressIndicator();
              }),
        ],
      ),
    );
  }

  Future<SocialIconModel> fetchSocialMediaLinks() async {
    final response = await http
        .get(Uri.parse('https://www.celermart.nectar.com.np/api/social-site'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      return SocialIconModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response, throw an error.
      throw Exception('Failed to load social media links');
    }
  }
}
