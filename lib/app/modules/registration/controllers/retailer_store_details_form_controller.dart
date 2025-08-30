import 'dart:io';
import 'dart:convert';
import 'package:farmitra/app/modules/registration/controllers/store_category_controller.dart';
import 'package:farmitra/app/modules/registration/controllers/store_location_controller.dart';
import 'package:farmitra/app/services/network_services.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:get_storage/get_storage.dart';

import 'package:farmitra/app/constants/api_endpoints.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/kyc_documents/views/rental_kyc.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class RetailerStoreDetailsFormController extends GetxController {
  final StoreLocationController storeLocationController = Get.put(
    StoreLocationController(),
  );

  @override
  void onInit() {
    super.onInit();
    final storedNumber = box.read('login_mobileNumber');
    if (storedNumber != null && storedNumber is String) {
      whatsAppNumber.text = storedNumber;
    }
    print(
      'Stored Vendor Details on Expert Registration page ${box.read('user_details')} ',
    );
    print('Store Role in vendor registration ${box.read('user_role')}');
  }

  // TextEditingControllers
  final box = GetStorage();
  final TextEditingController businessName = TextEditingController();
  final TextEditingController ownerName = TextEditingController();
  final TextEditingController whatsAppNumber = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController pincode = TextEditingController();

  // Dropdown
  var selectedItem = ''.obs;
  List<String> storeChannelList = ['Online', 'Physical', 'Both'];
  var isDropdownValid = true.obs;
  RxList<int> selectedIndexes = <int>[].obs;

  // void updatedSelectedValue(String value) {
  //   selectedItem.value = value;

  //   // Clear previous and update selected index based on dropdown value
  //   final index = storeChannelList.indexOf(value);
  //   if (index != -1) {
  //     selectedIndexes.value = [
  //       index + 10,
  //     ]; // Assuming subcategories start from 10
  //   }

  //   print('✅ selectedIndexes: $selectedIndexes');
  //   isDropdownValid.value = true;
  // }

  bool validateDropdown() {
    if (selectedItem.value.isEmpty) {
      isDropdownValid.value = false;
      return false;
    }
    return true;
  }

  // Image paths
  var selectedLogoPath = ''.obs;
  var selectedBannerPath = ''.obs;

  final ImagePicker _picker = ImagePicker();

  // Image validation flags
  var isLogoValid = true.obs;
  var isBannerValid = true.obs;

  // Loading flag
  var isLoading = false.obs;

  final ApiService _apiService = ApiService();

  // Pick image method
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

    if (source != null) {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        if (imageType == 'logo') {
          selectedLogoPath.value = pickedFile.path;
          isLogoValid.value = true;
        } else if (imageType == 'banner') {
          selectedBannerPath.value = pickedFile.path;
          isBannerValid.value = true;
        }
      }
    }
  }

  Future<ImageSource?> selectImageSourceDialog() async {
    return await Get.dialog<ImageSource>(
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
  }

  final arguments = Get.arguments ?? {};

  bool validateImages() {
    if (selectedLogoPath.value.isEmpty) isLogoValid.value = false;
    if (selectedBannerPath.value.isEmpty) isBannerValid.value = false;
    return isLogoValid.value && isBannerValid.value;
  }

  bool validateForm() {
    return validateDropdown();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter email';
    if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    if (value.length < 10) return 'Email must be at least 10 characters long';
    return null;
  }

  // ✅ Updated with console prints and error debug
  Future<void> submitRetailerStoreDetails() async {
    try {
      final storeCategoryController = Get.find<StoreCategoryController>();
      isLoading.value = true;
      print('🔄 Starting submitRetailerStoreDetails...');

      if (storeLocationController.combinedController.text.trim().isEmpty) {
        print('❌ Address is empty.');
        Get.snackbar(
          'Error',
          'Address is required.',
          backgroundColor: AppColors.error,
          colorText: AppColors.white,
        );
        return;
      }

      if (storeCategoryController.subCategoriesId.isEmpty) {
        print('❌ No subcategories selected.');
        Get.snackbar(
          'Error',
          'Select at least one subcategory.',
          backgroundColor: AppColors.error,
          colorText: AppColors.white,
        );
        return;
      }

      // final token = box.read('user_token');
      final token = box.read('user_token');

      if (token == null || token.isEmpty) {
        print('❌ Token is missing.');
        Get.snackbar(
          'Error',
          'Login required try again for login.',
          backgroundColor: AppColors.error,
          colorText: AppColors.white,
        );
        return;
      }

      // ✅ Construct formData
      final Map<String, dynamic> formData = {
        'business_module_id': storeCategoryController.businessModuleId.value,
        'module_category_id': storeCategoryController.moduleCategoryId.value,
        'store_name': businessName.text.trim(),
        "vendor_name": ownerName.text.trim(),
        'whatsapp_no': whatsAppNumber.text.trim(),
        'email': email.text.trim(),
        'address': storeLocationController.combinedController.text.trim(),
        'landmark': storeLocationController.landmark.text.trim(),
        'pincode': storeLocationController.pincode.text.trim(),
        'gps_location':
            '${storeLocationController.selectedLocation.value.latitude},${storeLocationController.selectedLocation.value.longitude}',

        'subcategories': storeCategoryController.subCategoriesId.toList(),
      };
      final fileMap = <String, File>{};
      if (selectedLogoPath.value.isNotEmpty) {
        fileMap['logo'] = File(selectedLogoPath.value);
      }
      if (selectedBannerPath.value.isNotEmpty) {
        fileMap['banner_image'] = File(selectedBannerPath.value);
      }

      print('📤 Sending to: ${ApiEndpoints.addvender}');
      print('📨 FormData: $formData');
      print('🖼️ Files: ${fileMap.keys}');
      print(
        'Selected Subcategory IDs: ${storeCategoryController.selectedItems}',
      );

      final response = await _apiService.callApi(
        endpoint: ApiEndpoints.addvender,
        method: 'POST',
        formData: formData,
        fileMap: fileMap,
        isMultipart: true,
        requireAuth: true,
      );

      print('✅ API Response: $response');

      if (response['success'] == true) {
        final userId = response['data']?['data']?['vendor']?['id'];
        final receivedUserType = response['data']?['data']?['roles'];
        box.write('user_details', response);
        box.write('user_id', userId);
        box.write('user_role', receivedUserType[0]);

        Get.snackbar(
          'Success',
          response['message'] ?? 'Data added successfully',
          backgroundColor: AppColors.primaryGradinatMixColor,
          colorText: AppColors.white,
        );
        print(
          'Stored response in local ${box.read('user_details')},${box.read('user_id')},${box.read('user_role')},',
        );
        Get.to(() => RentalKyc());
      } else {
        final errorMsg =
            response['message'] ??
            response['errors']?['error'] ??
            'Failed to submit details';
        Get.snackbar(
          'Error',
          errorMsg,
          backgroundColor: AppColors.error,
          colorText: AppColors.white,
        );
      }
    } catch (e) {
      print('❗ Exception occurred: $e');
      Get.snackbar(
        'Error',
        'Exception: $e',
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
      print('✅ Done submitRetailerStoreDetails');
    }
  }
}
