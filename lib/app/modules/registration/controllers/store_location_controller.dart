import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class StoreLocationController extends GetxController {
  final selectedLocation = Rx<LatLng>(LatLng(28.6139, 77.2090));

  var address = TextEditingController();
  var pincode = TextEditingController();
  var landmark = TextEditingController();
  var additionalAddress = TextEditingController();
  var combinedController = TextEditingController();
  late final MapController mapController = MapController();
  // final latLng = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always)
          return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final latLng = LatLng(position.latitude, position.longitude);
      selectedLocation.value = latLng;

      await fetchAddressFromCoordinates(latLng);
    } catch (e) {
      print('Location error: \$e');
    }
  }

  Future<void> fetchAddressFromCoordinates(LatLng latLng) async {
    selectedLocation.value = latLng;
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        address.text =
            '${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}';
        pincode.text = place.postalCode ?? '';
      }
    } catch (e) {
      print('Reverse geocoding error: \$e');
    }
  }

  void updateLocation(LatLng point) async {
    selectedLocation.value = point;
    await fetchAddressFromCoordinates(point);
  }

  void CombinController() {
    combinedController.text =
        '${additionalAddress.text}  ${address.text}, ${landmark.text} - ${pincode.text} ';
  }

  void setAddressFromSearch(String addressStr, LatLng latLng) async {
    address.text = addressStr;
    selectedLocation.value = latLng;
    await fetchAddressFromCoordinates(latLng);
  }

  void updateAddressFromSearched(String searchedAddress) async {
    if (searchedAddress.isNotEmpty) {
      List<Location> locations = await locationFromAddress(searchedAddress);
      if (locations.isNotEmpty) {
        final LatLng latLng = LatLng(
          locations.first.latitude,
          locations.first.longitude,
        );
        selectedLocation.value = latLng;
        await fetchAddressFromCoordinates(latLng);
        address.text = searchedAddress;
      } else {
        address.text = searchedAddress;
      }
    }
  }
}
