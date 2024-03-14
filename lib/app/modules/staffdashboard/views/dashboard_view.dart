import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/account_controller.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/map_controller.dart';
import 'package:q_and_u_furniture/app/modules/notification/views/staff_notification.dart';
import 'package:q_and_u_furniture/app/modules/staffdashboard/controllers/dashboard_controller.dart';
import 'package:q_and_u_furniture/app/modules/staffdashboard/views/update_task.dart';
import 'package:q_and_u_furniture/app/modules/staffdashboard/views/widgets/order_details.dart';
import 'package:q_and_u_furniture/app/modules/staffdashboard/views/widgets/staff_drawer.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StaffDashboard extends StatefulWidget {
  const StaffDashboard({super.key});

  @override
  State<StaffDashboard> createState() => _StaffDashboardState();
}

class _StaffDashboardState extends State<StaffDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.put(AccountController());
  final dashboardcontroller = Get.put(StaffDashboardController());
  final mapcontroller = Get.put(MapViewController());
  final homeController = Get.put(HomeController());
  Map<String, double> dataMap = {
    "Delivered": 10,
    "Completed": 3,
    "Pending": 2,
    "Rejected": 2,
  };

  final Completer<GoogleMapController> _controller = Completer();

  // final controller = Get.put(MapViewController());
  final homecontroller = Get.put(HomeController());
  // final landingcontroller = Get.put(LandingController());
  bool servicestatus = false;
  bool haspermission = false;

  int _currentTabIndex = 0;

  // @override
  // void dispose() {
  //   // Cancel the timer when the widget is disposed to avoid memory leaks.
  //   timer?.cancel();
  //   super.dispose();
  // }
  Timer? timer;

  @override
  void initState() {
    // final dashboardcontroller = Get.put(StaffDashboardController());
    dashboardcontroller.fetchtask(AppStorage.readAccessToken);
    dashboardcontroller.fetchgraph(AppStorage.readAccessToken);
    dashboardcontroller.fetctusers(AppStorage.readAccessToken);
    dashboardcontroller.fetctAddTaskValue(AppStorage.readAccessToken);
    dashboardcontroller.date();
    controller.getstaff();
    mapcontroller.getPlaceName();
    toggleTimer();
    // dashboardcontroller.fetchlocation();

    super.initState();
  }

  void toggleTimer() {
    setState(() {
      timer = Timer.periodic(const Duration(minutes: 2), (Timer t) {
        mapcontroller.getPlaceName();
        print("time for 5 sec");
      });
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed to avoid memory leaks.
    timer?.cancel();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
                      padding:
                          const EdgeInsets.only(top: 50, left: 20, right: 20),
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
                                  'Do You Want to Exit the App?',
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors
                                          .green, // Set the button's background color
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
                                      exit(0); // Return true to exit
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

        return shoulpop!;
      },
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            dashboardcontroller
                .fetchtask(AppStorage.readAccessToken.toString());
            dashboardcontroller
                .fetchgraph(AppStorage.readAccessToken.toString());
          },
          child: DefaultTabController(
            length: 9,
            initialIndex: _currentTabIndex, // Number of tabs you want to have
            child: Scaffold(
              key: _scaffoldKey,
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      leading: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () {
                              // Open the right drawer
                              _scaffoldKey.currentState!.openDrawer();
                              // _scaffoldKey.currentState!.openEndDrawer();
                            },
                          ),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(90, 238, 238, 238),
                            radius: 18,
                            child: Center(
                              child: Obx(
                                () => badges.Badge(
                                  // badgeContent: Text(
                                  //   homeController.notifications.length
                                  //       .toString(),
                                  //   style: const TextStyle(color: Colors.black),
                                  // ),
                                  showBadge:
                                      homeController.notifications.isEmpty
                                          ? false
                                          : true,
                                  position: badges.BadgePosition.topEnd(
                                      end: 5, top: 5),

                                  //   badgeColor: AppColor.orange,
                                  child: IconButton(
                                      onPressed: () {
                                        Get.to(StaffNotificationView());
                                        // Get.toNamed(Routes.NOTIFICATION);
                                      },
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        Iconsax.notification,
                                        color: Colors.black,
                                        size: 18.sp,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      expandedHeight: 115.0,
                      floating: true,
                      pinned: true,
                      snap: true,
                      // elevation: 10,
                      backgroundColor: AppColor.white,
                      title: Obx(
                        () => RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'Good ${dashboardcontroller.timeOfDayMessage}! ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${controller.staffuserdata.value.data!.name}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Obx(
                      //   () => Container(
                      //     decoration: BoxDecoration(
                      //         color: Color.fromARGB(115, 255, 255, 255),
                      //         borderRadius: BorderRadius.circular(10)),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(5.0),
                      //       child: Row(
                      //         mainAxisSize: MainAxisSize.min,
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Icon(
                      //             CupertinoIcons.location_solid,
                      //             size: 18,
                      //           ),
                      //           Text(
                      //             mapcontroller.currentAddress.value,
                      //             style: subtitleStyle.copyWith(
                      //                 fontSize: 18,
                      //                 color: Colors.black,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      flexibleSpace: FlexibleSpaceBar(
                          background: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => controller.loading.isTrue
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      color: Colors.white,
                                      child: ListTile(
                                        leading: Obx(
                                          () => Hero(
                                            tag: 'img',
                                            child: CircleAvatar(
                                                radius: 25,
                                                backgroundColor:
                                                    Colors.grey.shade200,
                                                child: Container(
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: CachedNetworkImageProvider(controller
                                                                      .staffuserdata
                                                                      .value
                                                                      .data!
                                                                      .photo !=
                                                                  null
                                                              ? controller
                                                                  .staffuserdata
                                                                  .value
                                                                  .data!
                                                                  .photo!
                                                              : '$url/frontend/images/avatar.png'),
                                                          fit: BoxFit.cover)),
                                                )),
                                          ),
                                        ),

                                        subtitle: Obx(
                                          () => Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${controller.staffuserdata.value.data!.email}" ??
                                                    '...',
                                              ),
                                              Text(
                                                "${controller.staffuserdata.value.data!.address}" ??
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
                                    ),
                                  ),
                          ),
                        ],
                      )

                          // Image.network(
                          //   'https://images.pexels.com/photos/443356/pexels-photo-443356.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                          //   fit: BoxFit.cover,
                          // ),
                          ),
                    ),
                    SliverPersistentHeader(
                        // pinned: true,
                        delegate: MySliverPersistentHeaderDelegate(
                            child: Obx(
                              () => dashboardcontroller.taskLoading.isTrue
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Container(
                                        color: AppColor.white,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CustomShimmer(
                                                  baseColor:
                                                      const Color(0xFFe1edff),
                                                  // highlightColor: Color.fromARGB(
                                                  //     255, 229, 239, 254),
                                                  widget: Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 5,
                                                    ),
                                                    width: 165.0,
                                                    height: 110.0,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color(
                                                            0xFFe1edff),
                                                        shape:
                                                            BoxShape.rectangle),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CustomShimmer(
                                                  baseColor:
                                                      const Color(0xFFffe3e3),
                                                  // highlightColor: Color.fromARGB(
                                                  //     255, 253, 230, 230),
                                                  widget: Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 5,
                                                    ),
                                                    width: 165.0,
                                                    height: 110.0,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color(
                                                            0xFFffe3e3),
                                                        shape:
                                                            BoxShape.rectangle),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CustomShimmer(
                                                  baseColor:
                                                      const Color(0xFFe1edff),
                                                  // highlightColor: Color.fromARGB(
                                                  //     255, 231, 240, 255),
                                                  widget: Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 5,
                                                    ),
                                                    width: 165.0,
                                                    height: 110.0,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color(
                                                            0xFFe1edff),
                                                        shape:
                                                            BoxShape.rectangle),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Container(
                                        color: AppColor.white,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _taskContainer(
                                                "Delivered Task",
                                                dashboardcontroller.graphdata
                                                    .value.deliveredCount,
                                                const Color(0xFFe1edff),
                                                AppImages.piechart,
                                              ),
                                              _taskContainer(
                                                "Pending Task",
                                                dashboardcontroller.graphdata
                                                    .value.pendingCount!,
                                                const Color(0xFFffe3e3),
                                                AppImages.clock,
                                              ),
                                              _taskContainer(
                                                "Completed Task",
                                                dashboardcontroller.graphdata
                                                    .value.completedCount!,
                                                const Color(0xFFe1edff),
                                                AppImages.complete,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            maxHeight: 150,
                            minHeight: 150)),
                    SliverPersistentHeader(
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                          isScrollable: true, // Make the TabBar swipeable
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black54,
                          indicator: const BoxDecoration(
                            // Apply border color to selected tab
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.blue, width: 2.0),
                            ),
                          ),
                          tabs: const [
                            Tab(text: 'Assigned Task'),
                            Tab(text: 'Complete Task'),
                            Tab(text: 'Cancelled Task'),
                            Tab(text: 'Pending Task'),
                            Tab(text: 'In-Progress Task'),
                            Tab(text: 'On Hold Task'),
                            Tab(text: 'Overdue Task'),
                            Tab(text: 'Task Chart'),
                            Tab(text: 'Map'),
                          ],
                          onTap: (index) {
                            setState(() {
                              _currentTabIndex = index;
                            });
                          },
                        ),
                      ),
                      pinned: true,
                    ),
                  ];
                },
                body: _buildTabView(),
              ),
              drawer: const custom_dawer(),
            ),
          ),
        ),
      ),
    );
  }

  _taskContainer(name, value, color, image) {
    return Obx(
      () => dashboardcontroller.taskLoading.isTrue
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 165.0,
                height: 110.0,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10.0),
                  // border: Border.all(color: Colors.grey, width: 1.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13.0, vertical: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 18.0),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                                children: [
                                  TextSpan(
                                    text: '$value/',
                                    style: const TextStyle(
                                        color: Color(0xFF003893),
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                  TextSpan(
                                    text:
                                        '${dashboardcontroller.graphdata.value.myDeliveryTaskCount}',
                                    style: const TextStyle(
                                      color: Color(0xFF003893),
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(width: 10.0),
                            Image.asset(
                              image,
                              // Replace 'assets/image.png' with your image asset path
                              width: 35.0,
                              height: 35.0,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Task Progress",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildTabView() {
    return TabBarView(
      children: [
        _list("Assigned"),
        _list("Completed"),
        _list("Cancelled"),
        _list("Pending"),
        _list("In-Progress"),
        _list("On Hold"),
        _list("Overdue"),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(
              () => Row(
                children: [
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width / 3,
                  //   child: Text("hello "),
                  // ),
                  PieChart(
                    dataMap: {
                      "Delivered": dashboardcontroller
                          .graphdata.value.deliveredCount!
                          .toDouble(),
                      "Completed": dashboardcontroller
                          .graphdata.value.completedCount!
                          .toDouble(),
                      "Pending": dashboardcontroller
                          .graphdata.value.pendingCount!
                          .toDouble(),
                    },
                    chartType: ChartType
                        .disc, // You can also use 'pie' for a regular pie chart
                    chartRadius: MediaQuery.of(context).size.width / 2,
                    colorList: const [
                      Colors.blue,
                      Colors.green,
                      Colors.red,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            Obx(() => SizedBox(
                  height: 200,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        mapcontroller.currentPosition!.latitude,
                        mapcontroller.currentPosition!.longitude,
                      ),
                      zoom: 14.0,
                    ),
                    zoomGesturesEnabled: false,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer()),
                    },
                    markers: <Marker>{
                      Marker(
                        markerId: const MarkerId('myMarker'),
                        position: LatLng(
                          mapcontroller.markerPositionLat.value,
                          mapcontroller.markerPositionLong.value,
                        ),
                      ),
                    },
                    // onTap: (LatLng latLng) {
                    //   print("${latLng.latitude},${latLng.longitude}");
                    //   Position positionTap = Position(
                    //     longitude: latLng.longitude,
                    //     latitude: latLng.latitude,
                    //     timestamp: DateTime.now(),
                    //     accuracy: 0.0,
                    //     altitude: 0.0,
                    //     heading: 0.0,
                    //     speed: 0.0,
                    //     speedAccuracy: 0.0,
                    //   );
                    //   // mapcontroller.getAddressFromLatLong(positionTap);
                    // },
                  ),
                )),
          ],
        )
        // Content for Tab 1
        // _buildList(30), // Content for Tab 2
      ],
    );
  }

  _list(title) {
    return Obx(
      () => dashboardcontroller.taskLoading.isTrue
          ? ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CustomShimmer(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  widget: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                );
              })
          : RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                dashboardcontroller
                    .fetchtask(AppStorage.readAccessToken.toString());
                dashboardcontroller
                    .fetchgraph(AppStorage.readAccessToken.toString());
              },
              child: dashboardcontroller.taskdata.value.data!.tasks!
                      .where((taskdetail) => taskdetail.status == "$title")
                      .isEmpty
                  ? Center(child: Text("No task $title. "))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: dashboardcontroller.taskdata.value.data!.tasks!
                          .where((taskdetail) => taskdetail.status == "$title")
                          .length,
                      itemBuilder: (context, index) {
                        var taskdetail = dashboardcontroller
                            .taskdata.value.data!.tasks!
                            .where(
                                (taskdetail) => taskdetail.status == "$title")
                            .toList()[index];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              if (controller.staffuserdata.value.data!.roles![0]
                                      .name ==
                                  "staff") {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => UpdateTask(
                                          taskData: taskdetail,
                                        ))));
                              } else {
                                print("object");
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('${taskdetail.title}'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Name: ${taskdetail.order!.name}'),
                                          Text(
                                              'Email: ${taskdetail.order!.email}'),
                                          Text(
                                              'Location: ${taskdetail.order!.area}'),
                                          Text(
                                              'Payment: ${taskdetail.order!.paymentWith}'),
                                          Text(
                                              'OrderId: ${taskdetail.order!.refId}'),
                                          // SizedBox(
                                          //   width: 200,
                                          //   height: 200,
                                          //   child: ListView.builder(
                                          //       shrinkWrap: true,
                                          //       itemCount: taskdetail
                                          //           .order!.orderAssets!.length,
                                          //       itemBuilder: (context, index) {
                                          //         return Text(
                                          //             'OrderId: ${taskdetail.order!.orderAssets![index].price}');
                                          //       }),
                                          // ),
                                          TextButton(
                                            style: const ButtonStyle(
                                                padding:
                                                    MaterialStatePropertyAll(
                                                        EdgeInsets.all(0))),
                                            onPressed: () {
                                              homeController.makePhoneCall(
                                                  "tel:${taskdetail.order!.phone}");
                                            },
                                            child: Text(
                                              'Phone: ${taskdetail.order!.phone}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.off(OrderDetailsViewStaff(
                                              taskDetail: taskdetail,
                                            ));
                                            // homeController.makePhoneCall(
                                            //     "tel:${taskdetail.order!.phone}");
                                          },
                                          child:
                                              const Text('View Order Details'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            homeController.makePhoneCall(
                                                "tel:${taskdetail.order!.phone}");
                                          },
                                          child: const Text('Call Customer'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Container(
                              // width: 200,
                              // height: 200,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                // color: Colors.blue,
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          " ${index + 1}. ${taskdetail.title}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      '${taskdetail.action!.title} ${taskdetail.status} with ${taskdetail.priority} priority.'),
                                              // TextSpan(text: '\n'), // Aaccountdd a line break between the two texts
                                              // TextSpan(
                                              //     text: text2,
                                              //     style:
                                              //         TextStyle(fontWeight: FontWeight.w800)),
                                            ],
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        // RichTextWidget(
                                        //     text1: 'Created By: ',
                                        //     text2: '${taskdetail.createdBy}'),
                                        // SizedBox(height: 10),
                                        // RichTextWidget(
                                        //     text1: 'Created At: ',
                                        //     text2: '${taskdetail.startDate}'),
                                        // SizedBox(height: 10),
                                        // RichTextWidget(
                                        //     text1: 'Status: ', text2: '${taskdetail.status}'),
                                        // SizedBox(height: 10),
                                        // RichTextWidget(
                                        //     text1: 'Action: ',
                                        //     text2: '${taskdetail.action!.title}'),
                                        // SizedBox(height: 10),
                                        // RichTextWidget(
                                        //     text1: 'Priority: ',
                                        //     text2: '${taskdetail.priority}'),
                                      ],
                                    ),
                                  ),
                                  title != "Completed"
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              width: 140,
                                              child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(AppColor
                                                                .mainClr), // Change the color to your desired background color
                                                  ),
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'Change Task status of ${taskdetail.title}'),
                                                          content: SizedBox(
                                                            width: double
                                                                .maxFinite,
                                                            child: ListView
                                                                .builder(
                                                              itemCount: dashboardcontroller
                                                                  .addTaskValue
                                                                  .value
                                                                  .data!
                                                                  .status!
                                                                  .length, // Replace this with your actual item count
                                                              shrinkWrap: true,
                                                              itemBuilder:
                                                                  (context, i) {
                                                                return ListTile(
                                                                  title: Text(dashboardcontroller
                                                                      .addTaskValue
                                                                      .value
                                                                      .data!
                                                                      .status![i]),
                                                                  onTap: () {
                                                                    print(
                                                                        "${taskdetail.id}");
                                                                    print(
                                                                        "taped value${dashboardcontroller.addTaskValue.value.data!.status![i]}");
                                                                    // Do something when an item is tapped
                                                                    dashboardcontroller.updateTaskstatus(
                                                                        taskdetail
                                                                            .id
                                                                            .toString(),
                                                                        dashboardcontroller
                                                                            .addTaskValue
                                                                            .value
                                                                            .data!
                                                                            .status![i]);
                                                                    getSnackbar(
                                                                      message:
                                                                          "Status changed successuflly.",
                                                                      error:
                                                                          false,
                                                                    );

                                                                    Navigator.pop(
                                                                        context);

                                                                    dashboardcontroller.fetchtask(AppStorage
                                                                        .readAccessToken
                                                                        .toString());
                                                                    // Close the dialog
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          // actions: [
                                                          //   TextButton(
                                                          //     onPressed: () {
                                                          //       Navigator.pop(
                                                          //           context); // Close the dialog
                                                          //     },
                                                          //     child: Text('Close'),
                                                          //   ),
                                                          // ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: const Text(
                                                      "Update Status")),
                                            ),
                                            // SizedBox(
                                            //   width: 140,
                                            //   child: ElevatedButton(
                                            //       style: ButtonStyle(
                                            //         backgroundColor:
                                            //             MaterialStateProperty
                                            //                 .all<Color>(AppColor
                                            //                     .orange), // Change the color to your desired background color
                                            //       ),
                                            //       onPressed: () {},
                                            //       child: Text("Update Task")),
                                            // ),
                                            // Icon(Icons
                                            //     .arrow_forward_ios_outlined),
                                          ],
                                        )
                                      : const SizedBox()
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
    );
  }

  Widget _buildList(int count) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Item ${index.toString()}',
            style: const TextStyle(fontSize: 25.0),
          ),
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white, // Set the background color of the TabBar here
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  MySliverPersistentHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // Calculate the percentage of how much the header has shrunk
    final percentage = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    // Create some custom animation or effects based on the percentage
    // For example, you can change the opacity or animate other properties
    // of the child widget to give a smooth transition when the header shrinks.

    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant MySliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
