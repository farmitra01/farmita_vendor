import 'dart:io';
import 'package:farmitra/app/ApiModels/getUserDetails.dart';
import 'package:farmitra/app/constants/api_endpoints.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/storeProfile/controllers/storeTabProfile_controller.dart';
import 'package:farmitra/app/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';

class StoreProfileController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    fetchUserDetails();
    // final StoresTabProfileController  storesTabProfileController = StoresTabProfileController();
    // ✅ This is your Vendor model (UserData)
  }

  var currentIndex = 0.obs;
  void updateIndex(int index) {
    currentIndex.value = index;
  }

  /// Default grid & carousel images
  final List<String> defaultGridImages = [
    'assets/images/storeProfile/bannerImage-1.jpg',
    'assets/images/storeProfile/bannerImage-2.jpg',
    'assets/images/storeProfile/bannerImage-3.jpg',
    'assets/images/storeProfile/bannerImage-4.jpg',
    'assets/images/storeProfile/bannerImage-5.jpg',
  ];

  // Logo upload
  var selectedLogoPath = ''.obs;

  // Uploaded banner paths
  var selectedBannerPaths = <String>[].obs;

  // Combined images (default + uploaded)
  List<String> get allBannerImages => [
    ...defaultGridImages,
    ...selectedBannerPaths,
  ];

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(String imageType) async {
    final ImageSource? source = await Get.dialog<ImageSource>(
      AlertDialog(
        title: Text(
          'Select Image',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryGradinatMixColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: ImageSource.camera),
            child: Text(
              'Camera',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryGradinatMixColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Get.back(result: ImageSource.gallery),
            child: Text(
              'Gallery',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryGradinatMixColor,
              ),
            ),
          ),
        ],
      ),
    );
    if (source == null) return;
    if (imageType == 'logo') {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        selectedLogoPath.value = pickedFile.path;
      }
    } else if (imageType == 'banner') {
      final List<XFile> pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        // keep maximum 5 uploaded images
        selectedBannerPaths.assignAll(
          pickedFiles.take(5).map((file) => file.path).toList(),
        );
      }
    }
  }

  /// Clears upload section after clicking "Upload Images"
  void confirmUpload() {
    Get.snackbar("Success", "Images uploaded successfully!");
  }

  /// Add single banner image (for button tap in bottomsheet)
  Future<void> addBannerImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (selectedBannerPaths.length < 5) {
        selectedBannerPaths.add(image.path);
      } else {
        Get.snackbar("Limit Reached", "You can only upload 5 images");
      }
    }
  }

  final box = GetStorage();
  var isLoading = false.obs;
  var userDetails = Rxn<UserDetailsResponse>();

  final ApiService _apiService = ApiService();

  Future<void> fetchUserDetails() async {
    try {
      isLoading.value = true;

      final userDetailsBox = box.read('user_details');

      int? userId;

      if (userDetailsBox is Map &&
          userDetailsBox['data']['data']['vendor']['id'] != null) {
        userId = userDetailsBox['data']['data']['vendor']['id'] as int;
      } else if (userDetailsBox is int) {
        userId = userDetailsBox;
      } else {
        print("User id not found in storage");
        return;
      }

      final response = await _apiService.callApi(
        endpoint: '/vendor/$userId',
        method: 'GET',
      );

      if (response != null &&
          response['statusCode'] == 200 &&
          response['data'] != null) {
        userDetails.value = UserDetailsResponse.fromJson(response['data']);
      } else {
        userDetails.value = null;
        print("Failed response: $response");
      }
    } catch (e, stackTrace) {
      print("Error fetching user details: $e");
      print(stackTrace);
      userDetails.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}
