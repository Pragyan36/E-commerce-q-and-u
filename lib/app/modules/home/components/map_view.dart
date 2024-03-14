import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/map_controller.dart';
import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_button.dart';
import 'package:q_and_u_furniture/app/widgets/custom_loading_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();
  final MapViewController controller = Get.put(
    MapViewController(),
  );
  final HomeController homecontroller = Get.put(
    HomeController(),
  );
  final LandingController landingcontroller = Get.put(
    LandingController(),
  );
  bool servicestatus = false;
  bool haspermission = false;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    controller.getPlaceName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("this is my loction ${controller.currentPosition?.latitude}");
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Obx(
                () => (controller.storedLatitude.value == 0.0 &&
                        controller.storedLongitude.value == 0.0)
                    ? const CustomLoadingIndicator(isCircle: true)
                    : GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            controller.currentPosition!.latitude,
                            controller.currentPosition!.longitude,
                          ),
                          zoom: 16.0,
                        ),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        gestureRecognizers: <Factory<
                            OneSequenceGestureRecognizer>>{
                          Factory<OneSequenceGestureRecognizer>(
                              () => EagerGestureRecognizer()),
                        },
                        markers: <Marker>{
                          Marker(
                            markerId: const MarkerId('myMarker'),
                            position: LatLng(
                              controller.markerPositionLat.value,
                              controller.markerPositionLong.value,
                            ),
                          ),
                        },
                        onTap: (LatLng latLng) {
                          Position positionTap = Position(
                            longitude: latLng.longitude,
                            latitude: latLng.latitude,
                            timestamp: DateTime.now(),
                            accuracy: 0.0,
                            altitude: 0.0,
                            heading: 0.0,
                            speed: 0.0,
                            speedAccuracy: 0.0,
                            altitudeAccuracy: 0,
                            headingAccuracy: 0,
                          );
                          controller.getAddressFromLatLong(positionTap);
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 20,
                  right: 60,
                ),
                child: Obx(
                  () => Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.location_on_outlined,
                        size: 20.sp,
                        color: AppColor.kalaAppMainColor,
                      ),
                      title: Text(
                        controller.currentAddress.value.isNotEmpty
                            ? controller.currentAddress.value
                            : "Choose location",
                        style: titleStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 20,
          ),
          child: SizedBox(
            width: double.infinity,
            child: CustomButton(
                label: 'Confirm Location',
                btnClr: AppColor.kalaAppMainColor,
                txtClr: Colors.white,
                ontap: () {
                  landingcontroller.fetchJustForYou(
                    controller.currentAddress.value,
                  );
                  Get.back();
                }),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
