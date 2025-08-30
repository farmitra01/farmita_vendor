import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class KycDocumentsController extends GetxController {
  //TODO: Implement KycDocumentsController

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

  var selectedItem = ''.obs;
  var isDropdownValid = true.obs;
  List<String> storeChannelList = [
    'Sustainable Crop Production Techniques',
    'Organic & Conventional Farming Practices',
    'Precision Agriculture',
    'Soil Health & Fertility Management',
    'Integrated Pest & Disease Management (IPDM)',
    'Crop Rotation & Diversification Strategies',
    'High-Yield Variety (HYV) Management',
    'Others',
  ];
  void updatedSelectedValue(String value) {
    selectedItem.value = value;
    isDropdownValid.value = true; // Reset validation when an item is selected
  }

  bool validateDropdown() {
    if (selectedItem.value.isEmpty) {
      isDropdownValid.value = false;
      return false;
    }
    return true;
  }

  var selectedItemQualification = ''.obs;
  var isDropdownValidQualification = true.obs;
  List<String> qualification = [
    'Doctrate',
    'Masters',
    'Graduate',
    'Under Graduate',
    'Diploma',
    'Other',
  ];
  void updatedSelectedValueQualification(String value) {
    selectedItemQualification.value = value;
    isDropdownValidQualification.value =
        true; // Reset validation when an item is selected
  }

  bool validateDropdownQualification() {
    if (selectedItemQualification.value.isEmpty) {
      isDropdownValidQualification.value = false;
      return false;
    }
    return true;
  }

  final TextEditingController specialization = TextEditingController();
  void increment() => count.value++;

  // var front = Rx<File?>(null);
  // var insideImage = Rx<File?>(null);
  // var outsideImage = Rx<File?>(null);
  // var ownerWithFrontShop = Rx<File?>(null);
  // var ownerWithInsideShop = Rx<File?>(null);
  // final ImagePicker _picker = ImagePicker();

  // // Function to pick image from camera or gallery
  // Future<void> pickImage(String type, ImageSource source) async {
  //   try {
  //     final XFile? pickedFile = await _picker.pickImage(source: source);

  //     if (pickedFile != null) {
  //       if (type == 'inside') {
  //         insideImage.value = File(pickedFile.path);
  //       } else if (type == 'outside') {
  //         outsideImage.value = File(pickedFile.path);
  //       } else if (type == 'ownerWithFrontShop') {
  //         ownerWithFrontShop.value = File(pickedFile.path);
  //       } else if (type == 'ownerWithInsideShop') {
  //         ownerWithInsideShop.value = File(pickedFile.path);
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to pick image: $e');
  //   }
  // }
  var selectedImage = Rx<File?>(
    null,
  ); // Reactive variable to track selected image

  final ImagePicker _picker = ImagePicker();

  // Function to pick image from camera or gallery
  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path); // Update reactive variable
    }
  }

  // Capture image from camera
  Future<void> captureImage() async {
    await pickImage(ImageSource.camera);
  }

  // Select image from gallery
  Future<void> uploadFromGallery() async {
    await pickImage(ImageSource.gallery);
  }
}
