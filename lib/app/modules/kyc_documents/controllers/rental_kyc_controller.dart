import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class RentalKycController extends GetxController {
  final box = GetStorage();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print('Stored Vendor Details on kyc page ${box.read('user_details')} ');
    print('Stored Vendor Role on kyc page ${box.read('user_role')}');
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

  var front = Rx<File?>(null);
  var insideImage = Rx<File?>(null);
  var outsideImage = Rx<File?>(null);
  var ownerWithFrontShop = Rx<File?>(null);
  var ownerWithInsideShop = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  // Function to pick image from camera or gallery
  Future<void> pickImage(String type, ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        if (type == 'inside') {
          insideImage.value = File(pickedFile.path);
        } else if (type == 'outside') {
          outsideImage.value = File(pickedFile.path);
        } else if (type == 'ownerWithFrontShop') {
          ownerWithFrontShop.value = File(pickedFile.path);
        } else if (type == 'ownerWithInsideShop') {
          ownerWithInsideShop.value = File(pickedFile.path);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  // Function to capture image from camera
  Future<void> captureImage(String type) async {
    await pickImage(type, ImageSource.camera);
  }

  // Function to select image from gallery
  Future<void> uploadFromGallery(String type) async {
    await pickImage(type, ImageSource.gallery);
  }
}
