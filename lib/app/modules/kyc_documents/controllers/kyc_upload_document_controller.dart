import 'dart:io';

import 'package:farmitra/app/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/constants/api_endpoints.dart';

class KycUploadDocumentController extends GetxController {
  // Reactive variables
  final count = 0.obs;
  final isChecked = false.obs;
  final selectedImage = Rx<File?>(null);
  final isLoading = false.obs;

  // API service
  final ApiService _apiService = ApiService();

  // Form controller
  final TextEditingController documentIdNo = TextEditingController();

  // Picker
  final ImagePicker _picker = ImagePicker();

  // Get argument from previous page
  late final String documentName;

  @override
  void onInit() {
    super.onInit();
    documentName = Get.arguments as String;
    print('Document Name: $documentName');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    documentIdNo.dispose();
    super.onClose();
  }

  void increment() => count.value++;

  // Toggle checkbox
  void toggleCheckBox(bool? value) {
    isChecked.value = value ?? false;
  }

  // Pick image from gallery or camera
  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  // Submit the document via API
  Future<bool> submitBusinessDocument() async {
    isLoading.value = true;

    try {
      final userId = GetStorage().read('user_id');
      if (userId == null) {
        print('useridaaaa $userId');

        Get.snackbar(
          'Error',
          'User ID not found',
          backgroundColor: AppColors.error,
          colorText: Colors.white,
        );
        return false;
      }

      if (documentIdNo.text.trim().isEmpty) {
        Get.snackbar(
          'Error',
          'Please enter document number',
          backgroundColor: AppColors.error,
          colorText: Colors.white,
        );
        return false;
      }

      final Map<String, String> formData = {
        'vendor_id': userId.toString(),
        'document_name': documentName,
        'document_no': documentIdNo.text.trim(),
      };

      final Map<String, File> fileMap = {};
      if (selectedImage.value != null) {
        fileMap['image'] = selectedImage.value!;
      }

      final response = await _apiService.callApi(
        endpoint: ApiEndpoints.addBusinessDocument,
        method: 'POST',
        formData: formData,
        fileMap: fileMap,
        isMultipart: true,
        requireAuth: true,
      );

      if (response['success'] == true) {
        Get.snackbar(
          'Success',
          response['message'] ?? 'Document uploaded successfully',
          backgroundColor: AppColors.primaryGradinatMixColor,
          colorText: Colors.white,
        );
        return true;
      } else {
        final errors = response['errors'] ?? {};
        final errorMsg = errors.entries
            .map((e) => '${e.key}: ${e.value}')
            .join('\n');
        Get.snackbar(
          'Error',
          errorMsg.isNotEmpty ? errorMsg : 'Submission failed',
          backgroundColor: AppColors.error,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Exception: $e',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
