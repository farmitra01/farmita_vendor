import 'dart:io';

import 'package:farmitra/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

class EditProductController extends GetxController {
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

  RxBool showGrid = false.obs;
  var selectedBrand = ''.obs;
  var selectedCategory = ''.obs;
  var selectedUnit = ''.obs;
  var selectedSubCategory = ''.obs;
  var selectedgst = ''.obs;

  var search = TextEditingController();
  var purchasePriceTax = ''.obs;
  var purchasePriceTax1 = ''.obs;
  var product_priceTax = ''.obs; // Use RxString for reactivity
  var producName = TextEditingController();
  var productDiscription = TextEditingController();
  var storeChannel = Rx<String?>(null);
  var brand = Rx<String?>(null);
  var category = Rx<String?>(null);
  var sub_category = Rx<String?>(null);
  var product_price = TextEditingController();
  var tax_amount = TextEditingController();
  var product_unit = Rx<String?>(null);
  var discount = TextEditingController();
  var max_limit = TextEditingController();
  var SKUs = TextEditingController();
  var SKUs2 = TextEditingController();
  var variation = TextEditingController();
  var price = TextEditingController();
  var availbility = Rx<String?>(null);
  var purchase_price_tax = TextEditingController();
  var purchase_price_tax1 = TextEditingController();
  var hsn_Code = TextEditingController();
  var assign_barcode = TextEditingController();
  var assign_barcode1 = TextEditingController();

  RxList<String> availableItems =
      [
        "Vegitables & Fruits",
        "Vegitables",
        "Green veggie",
        "Organic",
        "Healthy",
        "Fruits",
      ].obs;
  RxList selectedItems = [].obs;

  void selectItem(String item) {
    if (availableItems.contains(item)) {
      availableItems.remove(item);
      selectedItems.add(item);
    }
  }

  void removeItem(String item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
      availableItems.add(item);
    }
  }

  var selectedImages = <File>[].obs; // Observable list of images

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImages(ImageSource source) async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      selectedImages.addAll(
        pickedFiles.map((file) => File(file.path)),
      ); // Add images to the list
      Get.closeAllSnackbars();
      Get.back(closeOverlays: true);
      (); // Close the dialog after selecting images
    }
  }

  RxBool isAvailable = false.obs;

  var selectedImageIndex = 0.obs;

  // List of images for the grid (you can replace it with your actual image data)
  var imagePaths =
      [
        'assets/images/Null_image.png',
        'assets/images/Null_image.png',
        'assets/images/Null_image.png',
        'assets/images/Null_image.png',
      ].obs;

  // Nested grid image paths (can be dynamic based on your data)
  var nestedImagePaths =
      [
        'assets/images/Null_image.png',
        'assets/images/Null_image.png',
        'assets/images/Null_image.png',
        'assets/images/Null_image.png',
      ].obs;
  final List<String> brands = [
    'FlipKart',
    'Amazon',
    'Meesho',
    'BlinkIt',
    'Zepto',
  ];
  final List<String> categories = [
    'Category-1',
    'Category-2',
    'Category-3',
    'Category-4',
    'Category-5',
  ];
  final List<String> subCatogory = [
    'Sub-Category-1',
    'Sub-Category-2',
    'Sub-Category-3',
    'Sub-Category-4',
    'Sub-Category-4',
  ];
  final List<String> productUnit = [
    'Mili Gram',
    'Kilo Gram',
    'Quintal',
    'Tonne',
  ];

  final List<String> gstRate = [
    'Exampted  0.0',
    'GST@0%',
    'GST@0.25%',
    'GST@3%',
    'GST@12%',
    'IGST@12%',
    'GST@18%',
    'GST@28%',
  ];

  var filteredSuggestions = <String>[].obs;

  void updateSuggestions(List<String> list, String query) {
    if (query.isEmpty) {
      filteredSuggestions.clear();
    } else {
      filteredSuggestions.value =
          list
              .where((item) => item.toLowerCase().contains(query.toLowerCase()))
              .toList();
    }
  }

  void clearSuggestions() {
    search.clear();
    filteredSuggestions.clear();
  }

  var showVariationForm = false.obs;

  var variations = <VariationFormModel>[].obs;

  void addVariation() {
    variations.add(VariationFormModel());
  }

  void removeVariation(int index) {
    if (index >= 0 && index < variations.length) {
      variations.removeAt(index);
    }
  }
}

class VariationFormModel {
  TextEditingController assignBarcode = TextEditingController();
  TextEditingController variation = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController purchasePriceTax = TextEditingController();
  TextEditingController skus = TextEditingController();
  var purchasePriceTaxType = 'Percent'.obs;
}
