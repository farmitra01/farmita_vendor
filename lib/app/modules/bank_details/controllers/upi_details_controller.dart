import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:farmitra/app/services/network_services.dart';
import 'package:farmitra/app/constants/api_endpoints.dart';
import 'package:farmitra/app/constants/app_colors.dart';

class UpiDetailsController extends GetxController {
  final ApiService _apiService = ApiService();

  final isLoading = false.obs;
  final selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  final customerName = TextEditingController();
  final upiId = TextEditingController();
  final isChecked = false.obs;

  final selectedItem = ''.obs;
  final isDropdownValid = true.obs;

  List<String> storeChannelList = [
    'Cancel Cheque',
    'Bank PassBook',
    'Bank Details',
    'Others',
  ];

  void updatedSelectedValue(String value) {
    selectedItem.value = value;
    isDropdownValid.value = true;
  }

  void toggleCheckBox(bool? value) {
    isChecked.value = value ?? false;
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final File originalFile = File(pickedFile.path);

      final XFile?
      compressedXFile = await FlutterImageCompress.compressAndGetFile(
        originalFile.absolute.path,
        '${originalFile.parent.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg',
        quality: 60,
      );

      selectedImage.value =
          compressedXFile != null ? File(compressedXFile.path) : originalFile;
    }
  }

  Future<bool> submitUpiDetails({
    required int upiableId,
    required String upiableType,
  }) async {
    isLoading.value = true;

    try {
      final Map<String, dynamic> data = {
        'upiable_id': upiableId,
        'upiable_type':
            //  upiableType,
            'Vendor',
        'customer_name': customerName.text.trim(),
        'upi_id': upiId.text.trim(),
      };

      final Map<String, File> fileMap = {};
      if (selectedImage.value != null) {
        fileMap['qr_code'] = selectedImage.value!;
      }

      print('🟡 Submitting to: ${ApiEndpoints.addUpiDetails}');
      print('📤 Data: $data');
      print('🖼️ File: ${fileMap['qr_code']?.path}');

      final response = await _apiService.callApi(
        endpoint: ApiEndpoints.addUpiDetails,
        method: 'POST',
        formData: data,
        fileMap: fileMap,
        isMultipart: true,
        requireAuth: true,
      );

      print('✅ Response: $response');

      if (response['success'] == true) {
        Get.snackbar(
          'Success',
          response['message'] ?? 'UPI details submitted successfully',
          backgroundColor: AppColors.primaryGradinatMixColor,
          colorText: AppColors.white,
        );
        return true;
      } else {
        final errors = response['errors'] ?? {};
        final errorMessage = errors.entries
            .map((e) => '${e.key}: ${e.value}')
            .join('\n');

        Get.snackbar(
          'Error',
          errorMessage.isNotEmpty
              ? errorMessage
              : (response['message'] ?? 'Submission failed'),
          backgroundColor: AppColors.error,
          colorText: AppColors.white,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
