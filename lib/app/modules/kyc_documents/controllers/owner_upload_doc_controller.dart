import 'dart:io';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/constants/api_endpoints.dart';
import 'package:farmitra/app/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class OwnerUploadDocController extends GetxController {
  final count = 0.obs;
  final documentName = Get.arguments as String;

  final TextEditingController documentIdNo = TextEditingController();
  final TextEditingController name = TextEditingController();

  var isChecked = false.obs;

  final ImagePicker _picker = ImagePicker();
  final ApiService _apiService = ApiService();

  void toggleCheckBox(bool? value) {
    isChecked.value = value ?? false;
  }

  var inside = RxString('');
  var outside = RxString('');
  var aadhar = RxString(' ');
  var isInsideValid = true.obs;
  var isOutsideValid = true.obs;
  var isAadharValid = true.obs;
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
              style: TextStyle(color: AppColors.primaryGradinatMixColor),
            ),
          ),
          TextButton(
            onPressed: () => Get.back(result: ImageSource.gallery),
            child: Text(
              'Gallery',
              style: TextStyle(color: AppColors.primaryGradinatMixColor),
            ),
          ),
        ],
      ),
    );

    if (source == null) return;

    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (imageType == 'Front Side') {
      if (pickedFile != null) {
        inside.value = pickedFile.path;
        isInsideValid.value = true;
      } else {
        isInsideValid.value = false;
      }
    } else if (imageType == 'Back Side') {
      if (pickedFile != null) {
        outside.value = pickedFile.path;
        isOutsideValid.value = false;
      } else if (imageType == 'Aadhar') {
        // 👈 FIXED here
        if (pickedFile != null) {
          aadhar.value = pickedFile.path;
          isAadharValid.value = true;
        } else {
          isAadharValid.value = false;
        }
      }
    }
  }

  // final selectedImage = Rx<File?>(null);

  //  Future<void> pickAdhar(ImageSource source) async {
  //   final XFile? pickedFile = await _picker.pickImage(source: source);
  //   if (pickedFile != null) {
  //     selectedImage.value = File(pickedFile.path);
  //   }
  // }

  Future<bool> submitOwnerDocument() async {
    final userId = GetStorage().read('user_id');
    final List<dynamic> userTypes = GetStorage().read('user_type') ?? [];
    print('usertype in response $userTypes');
    // String documentableType = '';
    // if (userTypes.contains('Vendor')) {
    //   documentableType = 'Vendor';
    // } else if (userTypes.contains('Expert')) {
    //   documentableType = 'Expert';
    // }

    // if (userId == null || documentableType.isEmpty) {
    //   Get.snackbar(
    //     'Error',
    //     'User ID or user type missing',
    //     backgroundColor: AppColors.error,
    //     colorText: Colors.white,
    //   );
    //   return false;
    // }

    if (inside.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Front image is required.',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
      return false;
    }

    final formData = {
      'documentable_id': userId,
      'documentable_type':
          // documentableType
          'Vendor',
      'document_name': documentName,
      'full_name': name.text.trim(),
      'document_no': documentIdNo.text.trim(),
    };

    final fileMap = <String, File>{'front_image': File(inside.value)};

    if (outside.value.isNotEmpty) {
      fileMap['back_image'] = File(outside.value);
    }

    try {
      final response = await _apiService.callApi(
        endpoint: ApiEndpoints.addOwnerDocument,
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
    }
  }

  @override
  void onClose() {
    // dispose text controllers
    documentIdNo.dispose();
    name.dispose();

    // reset reactive values
    isChecked.value = false;
    inside.value = '';
    outside.value = '';
    isInsideValid.value = true;
    isOutsideValid.value = true;

    super.onClose();
  }
}
