import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:farmitra/app/ApiModels/getGrieviancesCategory.dart';
import 'package:farmitra/app/constants/api_endpoints.dart';
import 'package:farmitra/app/services/network_services.dart';

class TextSupportController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;
  var grievancesCategoryList = <GrievancesCategoryModel>[].obs;

  var selectedItem = ''.obs;
  var selectedCategoryId = 0.obs;

  var isDropdownValid = true.obs;
  // var isChecked = false.obs;

  var entertext = TextEditingController();
  final wordCount = 0.obs;
  var selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchGrievancesCategory();
    entertext.addListener(() {
      wordCount.value = _getWordCount(entertext.text);
    });
  }

  int _getWordCount(String text) {
    return text.trim().isEmpty ? 0 : text.trim().split(RegExp(r'\s+')).length;
  }

  Future<void> fetchGrievancesCategory() async {
    try {
      isLoading.value = true;

      final response = await _apiService.callApi(
        endpoint: ApiEndpoints.fetchGreviancesCategory,
        method: 'GET',
      );

      if (response['success'] == true && response['data'] is List) {
        final List<dynamic> data = response['data'];
        grievancesCategoryList.value =
            data
                .whereType<Map<String, dynamic>>()
                .map((item) => GrievancesCategoryModel.fromJson(item))
                .toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch grievance categories');
    } finally {
      isLoading.value = false;
    }
  }

  void updatedSelectedValue(String value) {
    selectedItem.value = value;
    final selected = grievancesCategoryList.firstWhereOrNull(
      (e) => e.name == value,
    );
    if (selected != null) {
      selectedCategoryId.value = selected.id ?? 0;
      print('Selected id ${selectedCategoryId.value}}');
    }
    isDropdownValid.value = true;
  }

  bool validateDropdown() {
    if (selectedItem.value.isEmpty) {
      isDropdownValid.value = false;
      return false;
    }
    return true;
  }

  // void toggleCheckBox(bool? value) {
  //   isChecked.value = value ?? false;
  // }

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> submitGrievance() async {
    if (selectedCategoryId.value == 0) {
      Get.snackbar('Error', 'Please select a category');
      return;
    }

    if (entertext.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter a description');
      return;
    }

    try {
      isLoading.value = true;

      final imageFile = selectedImage.value;
      final formData = {
        'category_id': selectedCategoryId.value.toString(),
        'description': entertext.text.trim(),
      };

      debugPrint('🔍 Submitting Grievance...');
      debugPrint('Category ID: ${formData['category_id']}');
      debugPrint('Description: ${formData['description']}');
      debugPrint('Image File: ${imageFile?.path ?? "No Image"}');

      final response = await _apiService.callApi(
        endpoint: ApiEndpoints.postSubmitGreviances,
        method: 'POST',
        isMultipart: true,
        formData: formData,
        fileMap: imageFile != null ? {'image': imageFile} : null,
        fileFieldName: 'image',
      );

      debugPrint('📥 Response Body: $response');

      if (response['success'] == true) {
        Get.snackbar('Success', 'Grievance submitted successfully');
      } else {
        Get.snackbar('Error', response['message'] ?? 'Submission failed');
      }
    } catch (e) {
      debugPrint('❌ Submit grievance error: $e');
      Get.snackbar('Error', 'Failed to submit grievance: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
