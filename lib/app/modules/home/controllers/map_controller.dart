import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:q_and_u_furniture/app/model/address.dart';
import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';

class MapViewController extends GetxController {
  final LandingController landingcontroller = Get.put(LandingController());
  final RxInt count = 0.obs;
  Position? currentPosition;
  RxList<Address> address = <Address>[].obs;
  RxString currentAddress = "".obs;
  RxMap<String, Marker> markers = <String, Marker>{}.obs;
  RxString location = "ktm".obs;
  RxDouble markerPositionLat = 0.0.obs;
  RxDouble markerPositionLong = 0.0.obs;


  MapViewController(){
    _onInit();
  }

  @override
  void _onInit() async {
    // log("hello guys");
    getPlaceName();
    super.onInit();
  }

  RxDouble storedLatitude = 0.0.obs;
  RxDouble storedLongitude = 0.0.obs;

  void getPlaceName() async {
    Position position = await getGeoLocationPosition();
    currentPosition = Position(
      latitude: position.latitude,
      longitude: position.longitude,
      timestamp: position.timestamp,
      accuracy: position.altitude,
      altitude: position.altitude,
      heading: position.heading,
      speed: position.speed,
      speedAccuracy: position.speedAccuracy,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );
    if (currentPosition != null) {
      storedLatitude.value = currentPosition!.latitude;
      storedLongitude.value = currentPosition!.longitude;
      log(storedLatitude.value.toString(), name: "Stored Latitude");
      log(storedLongitude.value.toString(), name: "Stored Longitude");
    }
    getAddressFromLatLong(currentPosition!);
  }

  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error(
        'Location services are disabled.',
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(
          'Location permissions are denied',
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark place = placemarks[0];
    String userLocation =
        "${place.street}, ${place.subLocality}, ${place.postalCode}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    currentAddress.value = userLocation.toString();
    markerPositionLat.value = position.latitude;
    markerPositionLong.value = position.longitude;
    landingcontroller.fetchJustForYou(
      '${place.locality}',
    );
    landingcontroller.selectedSlug.value != ""
        ? landingcontroller.fetchJustForYou(
            '${place.locality}',
          )
        : landingcontroller
            .fetchJustForYou(
            '${place.locality}',
          )
            .then(
            (data) {
              landingcontroller.selectedSlug.value =
                  data['data']['tags'][0]['slug'];
            },
          );
  }
}
