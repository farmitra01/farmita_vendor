import 'dart:io';
import 'package:farmitra/app/constants/api_endpoints.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/kyc_documents/views/rental_kyc.dart';
import 'package:farmitra/app/modules/registration/controllers/store_category_controller.dart';
import 'package:farmitra/app/modules/registration/controllers/store_location_controller.dart';
import 'package:farmitra/app/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class StoreDetailsFormController extends GetxController {
  final TextEditingController other = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController whatsAppNumber = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController about = TextEditingController();
  final TextEditingController expertName = TextEditingController();
  final box = GetStorage();

  // @override
  // void onInit() {
  //   super.onInit();

  // }

  final StoreLocationController storeLocationController = Get.put(
    StoreLocationController(),
  );
  final categoryName = Get.arguments ?? {};

  final ApiService _apiService = ApiService();
  var isLoading = false.obs;
  var selectedItem = ''.obs;
  List<String> storeChannelList = ['Online', 'Physical', 'Both'];

  void updatedSelectedValue(String value) {
    selectedItem.value = value;
    // isDropdownValid.value = true;
  }

  // bool validateDropdown() {
  //   isDropdownValid.value = selectedItem.value.isNotEmpty;
  //   return isDropdownValid.value;
  // }

  var selectedLogoPath = ''.obs;
  var selectedBannerPath = ''.obs;

  final ImagePicker _picker = ImagePicker();

  var isBannerValid = true.obs;
  // var isDropdownValid = true.obs;

  Future<void> pickImage(String imageType) async {
    final ImageSource? source = await showDialog<ImageSource>(
      context: Get.context!,
      builder:
          (BuildContext context) => AlertDialog(
            title: Text(
              'Select Image',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryGradinatMixColor,
              ),
            ),
            content: const Text('Choose the source for the image.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, ImageSource.camera),
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
                onPressed: () => Navigator.pop(context, ImageSource.gallery),
                child: Text(
                  'Gallery',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryGradinatMixColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
          ),
    );

    if (source == null) {
      print('pickImage: No source selected (dialog cancelled)');
      return;
    }

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );
      if (pickedFile == null) {
        print('pickImage: No image selected for $source');
        Get.snackbar(
          'No Image Selected',
          'No image was selected from ${source == ImageSource.camera ? 'camera' : 'gallery'}.',
          backgroundColor: AppColors.error,
          colorText: AppColors.white,
        );
        return;
      }

      final file = File(pickedFile.path);
      final fileSizeMB = await file.length() / (1024 * 1024);

      if (imageType == 'logo' && fileSizeMB > 3) {
        Get.snackbar(
          'Error',
          'Logo image must be less than 3MB',
          backgroundColor: AppColors.error,
          colorText: AppColors.white,
        );
        print('pickImage: Logo image size $fileSizeMB MB exceeds 3MB limit');
        return;
      } else if (imageType == 'banner' && fileSizeMB > 5) {
        Get.snackbar(
          'Error',
          'Banner image must be less than 5MB',
          backgroundColor: AppColors.error,
          colorText: AppColors.white,
        );
        isBannerValid.value = false;
        print('pickImage: Banner image size $fileSizeMB MB exceeds 5MB limit');
        return;
      }

      if (imageType == 'logo') {
        selectedLogoPath.value = pickedFile.path;
        print('pickImage: Logo selected: ${pickedFile.path}');
      } else if (imageType == 'banner') {
        selectedBannerPath.value = pickedFile.path;
        isBannerValid.value = true;
        print('pickImage: Banner selected: ${pickedFile.path}');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image from ${source == ImageSource.camera ? 'camera' : 'gallery'}: $e',
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
        duration: const Duration(seconds: 5),
      );
      print('pickImage: Error picking image for $source: $e');
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
  // bool validateImages() {
  //   isLogoValid.value = selectedLogoPath.value.isNotEmpty;
  //   isBannerValid.value = selectedBannerPath.value.isNotEmpty;
  //   return isLogoValid.value && isBannerValid.value;
  // }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return 'Please enter email';
    if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
      return 'Please enter a valid email';
    }
    if (email.length < 10) return 'Email must be at least 10 characters long';
    return null;
  }

  var selectedGender = 'Male'.obs;

  void changeGender(String value) => selectedGender.value = value;

  // RxList<int> selectedIndexes = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    print(
      'Stored Vendor Details on Expert Registration page ${box.read('user_details')} ',
    );
    print(
      'Stored Vendor Role on Expert Registration page ${box.read('user_role')}',
    );
    final storedNumber = box.read('login_mobileNumber');
    if (storedNumber != null && storedNumber is String) {
      whatsAppNumber.text = storedNumber;
    }

    selectedIndexes.clear();
    print('StoreDetailsFormController initialized, selectedIndexes cleared');
    final arguments = Get.arguments ?? {};
    // initializeImages(
    //   arguments['logoImage'] as String?,
    //   arguments['bannerImage'] as String?,
    // );
    // initializeFromData(arguments['savedIndexes'] as List<dynamic>?);
  }

  var selectedIndexes = <int>[].obs;
  var selectedLanguages = <String>[].obs;

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

  void toggleSelection(int index) {
    if (index < 0 || index >= languages.length) {
      print('Invalid index in toggleSelection: $index');
      return;
    }

    final language = languages[index];

    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
      selectedLanguages.remove(language); // Remove language
    } else {
      selectedIndexes.add(index);
      selectedLanguages.add(language); // Add language
    }

    selectedIndexes.refresh();
    selectedLanguages.refresh();
    print('Selected languages: $selectedLanguages');
  }

  bool isSelected(int index) {
    if (index < 0 || index >= languages.length) {
      print('Invalid index in isSelected: $index');
      return false;
    }
    return selectedIndexes.contains(index);
  }

  var selectedRentalItem = ''.obs;
  var isRentalDropdownValid = true.obs;
  List<String> rentalItemList = [
    'Tractor',
    'Harvestor',
    'Pump / Machinary',
    'Others',
  ];

  void updateSelectedRentalItem(String value) {
    selectedRentalItem.value = value;
    isRentalDropdownValid.value = true;
  }

  bool validateRentalDropdown() {
    isRentalDropdownValid.value = selectedRentalItem.value.isNotEmpty;
    return isRentalDropdownValid.value;
  }

  // void initializeFromData(List<dynamic>? savedIndexes) {
  //   print('initializeFromData called with savedIndexes: $savedIndexes');
  //   if (savedIndexes != null) {
  //     selectedIndexes.clear();
  //     for (var index in savedIndexes) {
  //       int? parsed;
  //       if (index is String) {
  //         parsed = int.tryParse(index);
  //         if (parsed == null) {
  //           print('Invalid index in savedIndexes: $index');
  //           Get.snackbar(
  //             'Warning',
  //             'Invalid language selection: $index ignored',
  //             backgroundColor: AppColors.error,
  //             colorText: AppColors.white,
  //           );
  //           continue;
  //         }
  //       } else if (index is int) {
  //         parsed = index;
  //       } else {
  //         print('Unexpected index type in savedIndexes: $index');
  //         continue;
  //       }
  //       if (parsed != null && parsed >= 0 && parsed < languages.length) {
  //         selectedIndexes.add(parsed);
  //       } else {
  //         print('Invalid or out-of-range index: $parsed');
  //         Get.snackbar(
  //           'Warning',
  //           'Out-of-range language index: $parsed ignored',
  //           backgroundColor: AppColors.error,
  //           colorText: AppColors.white,
  //         );
  //       }
  //     }
  //     selectedIndexes.refresh();
  //     print('selectedIndexes updated: $selectedIndexes');
  //   } else {
  //     print('savedIndexes is null, no changes made to selectedIndexes');
  //   }
  // }

  // void initializeImages(String? logoImagePath, String? bannerImagePath) {
  //   print(
  //     'initializeImages: logoImagePath=$logoImagePath, bannerImagePath=$bannerImagePath',
  //   );
  //   // Validate logo image path
  //   if (logoImagePath != null && logoImagePath.isNotEmpty) {
  //     final file = File(logoImagePath);
  //     if (file.existsSync()) {
  //       selectedLogoPath.value = logoImagePath;
  //       print('initializeImages: Logo path set to $logoImagePath');
  //     } else {
  //       selectedLogoPath.value = '';
  //       print('initializeImages: Invalid logo path: $logoImagePath');
  //       Get.snackbar(
  //         'Error',
  //         'Invalid logo image path',
  //         backgroundColor: AppColors.error,
  //         colorText: AppColors.white,
  //       );
  //     }
  //   } else {
  //     selectedLogoPath.value = '';
  //     print('initializeImages: No logo path provided');
  //   }

  //   // Validate banner image path
  //   if (bannerImagePath != null && bannerImagePath.isNotEmpty) {
  //     final file = File(bannerImagePath);
  //     if (file.existsSync()) {
  //       selectedBannerPath.value = bannerImagePath;
  //       isBannerValid.value = true;
  //       print('initializeImages: Banner path set to $bannerImagePath');
  //     } else {
  //       selectedBannerPath.value = '';
  //       isBannerValid.value = false;
  //       print('initializeImages: Invalid banner path: $bannerImagePath');
  //       Get.snackbar(
  //         'Error',
  //         'Invalid banner image path',
  //         backgroundColor: AppColors.error,
  //         colorText: AppColors.white,
  //       );
  //     }
  //   } else {
  //     selectedBannerPath.value = '';
  //     isBannerValid.value = false;
  //     print('initializeImages: No banner path provided');
  //   }

  //   // Force UI update
  //   selectedLogoPath.refresh();
  //   selectedBannerPath.refresh();
  // }

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
        'about': about.text.trim(),
        'store_name': '${name.text.trim()} Farmitra Expert',
        'vendor_name': name.text.trim(),
        'whatsapp_no': whatsAppNumber.text.trim(),
        'email': email.text.trim(),
        'address': storeLocationController.combinedController.text.trim(),
        'landmark': storeLocationController.landmark.text.trim(),
        'pincode': storeLocationController.pincode.text.trim(),
        'language': selectedLanguages,
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

      if (response['success'] == true && response['statusCode'] == 200) {
        final userId = response['data']?['data']?['vendor']?['id'];
        final receivedUserType = response['data']?['data']?['roles'];
        final user_details = response['data']['vendor'] ?? {};
        box.write('user_details', response);
        box.write('user_id', userId);
        box.write('user_role', receivedUserType);

        print(
          'Stored response in local ${box.read('user_details')},${box.read('user_id')},${box.read('user_role')},',
        );
        if (Get.isDialogOpen ?? false) Get.back();
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

  @override
  void onClose() {
    super.onClose();
  }
}
