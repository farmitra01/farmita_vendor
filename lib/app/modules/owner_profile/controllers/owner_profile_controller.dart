import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OwnerProfileController extends GetxController {
  //TODO: Implement OwnerProfileController

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
  var name = TextEditingController();
  var number = TextEditingController();
  var altNumber = TextEditingController();
  var email = TextEditingController();
  var location = TextEditingController(); 
  var address = TextEditingController();
  var floor = TextEditingController();
  var pincode = TextEditingController();
  
  var selectedGender = 'Male'.obs; // Default selection

  void changeGender(String value) {
    selectedGender.value = value;
  }
  
  RxList<int> selectedIndexes = <int>[].obs;

  void toggleSelection(int index) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
    } else {
      selectedIndexes.add(index);
    }
  }

  bool isSelected(int index) => selectedIndexes.contains(index);
  List<String> languages = [
    'Hindi',
    'English',
    'Gujrati',
    'Marathi',
    'Telagu',
    'Bengali',
    'Kannada',
    'Hariyanvi',
    'Panjabi',
    'Hydrabadi',
  ];
  final TextEditingController About = TextEditingController();


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
