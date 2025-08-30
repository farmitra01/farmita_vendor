import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'; // 👈 for reverse geocoding
import 'package:http/http.dart' as http;

class StoreSearchLocationController extends GetxController {
  final Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  final Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);
  final RxBool isLoading = false.obs;
  final RxList<Map<String, dynamic>> searchResults =
      <Map<String, dynamic>>[].obs;
  final RxString searchedSelectedLocation = ''.obs;
  final latLng = ''.obs;
  late final MapController mapController;

  @override
  void onInit() {
    super.onInit();
    mapController = MapController();
    _getCurrentLocation();
  }

  /// 📍 Fetch current location (initial load)
  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.always &&
            permission != LocationPermission.whileInUse) {
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final latLng = LatLng(position.latitude, position.longitude);
      currentLocation.value = latLng;
      selectedLocation.value = latLng;
      mapController.move(latLng, 15);
    } catch (e) {
      print('Location fetch error: $e');
    }
  }

  /// 🔍 Search location via OpenStreetMap
  Future<void> searchLocation(String query) async {
    if (query.trim().isEmpty) return;

    isLoading.value = true;
    searchResults.clear();

    final url =
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=10';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': 'flutter_map_app'},
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        searchResults.value = data.cast<Map<String, dynamic>>();
      } else {
        print('API failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Search error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// 📌 Select a location from results
  void selectLocation(Map<String, dynamic> place) {
    final lat = double.tryParse(place['lat'] ?? '');
    final lon = double.tryParse(place['lon'] ?? '');
    final displayName = place['display_name'] ?? '';

    if (lat != null && lon != null) {
      final latLng = LatLng(lat, lon);
      selectedLocation.value = latLng;
      searchedSelectedLocation.value = displayName;
      mapController.move(latLng, 15);
      searchResults.clear();
    }
  }

  /// ✅ Move map to initial position after ready
  void onMapReady() {
    final latLng = selectedLocation.value ?? currentLocation.value;
    if (latLng != null) {
      mapController.move(latLng, 15);
    }
  }

  /// 📍 Use device location + reverse geocode
  Future<void> getCurrentLocationAndAddress() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final latLng = LatLng(position.latitude, position.longitude);

      selectedLocation.value = latLng;
      mapController.move(latLng, 15);

      final placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        searchedSelectedLocation.value =
            '${place.name ?? ''}, ${place.street ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.postalCode ?? ''}';
      }
    } catch (e) {
      print('Current location error: $e');
    }
  }

  /// 🔙 Return selected address to previous page
  void confirmSelection() {
    Get.back(result: searchedSelectedLocation.value);
  }
}
