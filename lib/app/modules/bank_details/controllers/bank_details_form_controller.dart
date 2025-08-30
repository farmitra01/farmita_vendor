import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:farmitra/app/constants/api_endpoints.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/services/network_services.dart';

class BankDetailsFormController extends GetxController {
  final ApiService _apiService = ApiService();

  var accountNo = TextEditingController();
  var confirmNo = TextEditingController(); // still in UI but not validated
  var holderName = TextEditingController();
  var bankName = TextEditingController();
  var branchName = TextEditingController();
  var ifsc = TextEditingController();
  var pan = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final selectedImage = Rx<File?>(null);

  var isChecked = false.obs;
  var selectedItem = ''.obs;
  var isDropdownValid = true.obs;
  var isLoading = false.obs;

  List<String> bankDetails = [
    'Cancel Cheque',
    'Bank PassBook',
    'Bank Statement',
    'Others',
  ];

  void updatedSelectedValue(String value) {
    selectedItem.value = value;
    isDropdownValid.value = true;
  }

  bool validateDropdown() {
    if (selectedItem.value.isEmpty) {
      isDropdownValid.value = false;
      return false;
    }
    return true;
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

  Future<bool> submitBankDetails() async {
    isLoading.value = true;

    try {
      final userId = GetStorage().read('user_id');
      final List<dynamic> userTypes = GetStorage().read('user_type') ?? [];

      // String accountableType = '';
      // if (userTypes.contains('Vendor')) {
      //   accountableType = 'Vendor';
      // } else if (userTypes.contains('Expert')) {
      //   accountableType = 'Vxpert';
      // }

      // if (userId == null || accountableType.isEmpty) {
      //   Get.snackbar(
      //     'Error',
      //     'User ID or user type missing',
      //     backgroundColor: AppColors.error,
      //     colorText: Colors.white,
      //   );
      //   return false;
      // }

      final formData = {
        'accountable_id': userId,
        'accountable_type': 'Vendor',
        //  accountableType,
        'account_no': accountNo.text.trim(),
        'account_holder_name': holderName.text.trim(),
        'bank_name': bankName.text.trim(),
        'branch_name': branchName.text.trim(),
        'ifsc_code': ifsc.text.trim(),
        'pan_card_no': pan.text.trim(),
      };

      final fileMap = <String, File>{};
      if (selectedImage.value != null) {
        fileMap['document'] = selectedImage.value!;
      }

      final response = await _apiService.callApi(
        endpoint: ApiEndpoints.addBankDetails,
        method: 'POST',
        formData: formData,
        fileMap: fileMap,
        isMultipart: true,
        requireAuth: true,
      );

      if (response['success'] == true) {
        Get.snackbar(
          'Success',
          response['message'] ?? 'Bank details added successfully',
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
