import 'package:farmitra/app/data/models/store_about_model/store_about_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class AboutController extends GetxController {
  //TODO: Implement AboutController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  var aboutStore = TextEditingController().obs;
  // var isExpanded = false.obs;
  // void toggleTExt() {
  //   isExpanded.value = !isExpanded.value;
  // }

  var isTextVisible = false.obs;

  void showText() {
    if (aboutStore.value.text.isNotEmpty) {
      isTextVisible.value = true;
      print(aboutStore);
      print("Worked");
    } else {
      print("Not Worked");
    }
  }

  List<StoreAboutModel> amenities =
      [
        StoreAboutModel(
          text: 'Beverage',
          icon: Icons.emoji_food_beverage_outlined,
        ),
        StoreAboutModel(text: 'AC', icon: Icons.ac_unit),
        StoreAboutModel(text: 'Wi-Fi', icon: Icons.wifi),
        StoreAboutModel(text: 'Parking', icon: Icons.local_parking_rounded),
        StoreAboutModel(text: 'TV', icon: Icons.live_tv_rounded),
        StoreAboutModel(text: 'Card Payment', icon: Icons.payment_rounded),
        StoreAboutModel(text: 'CCTV', icon: Icons.camera_indoor_outlined),
      ].obs;

  var selectedAmenities = <StoreAboutModel>[].obs;

  void addAmenitiesToGrid(StoreAboutModel item) {
    if (!selectedAmenities.contains(item)) {
      selectedAmenities.add(item);
    }
  }
}
