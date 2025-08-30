import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewAdsController extends GetxController {
  final count = 0.obs;
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

  void increment() => count.value++;

  var title = TextEditingController();
  var description = TextEditingController();

  var selectedItem = ''.obs;

  var isDropdownValid = true.obs;
  List<String> couponTypes = [
    'Video Promotional',
    'Banner Promotional',
    'Others',
  ];
  void updatedSelectedValue(String value) {
    selectedItem.value = value;
    isDropdownValid.value = true; // Reset validation when an item is selected
  }

  bool validateDropdown() {
    if (selectedItem.value.isEmpty) {
      isDropdownValid.value = false;
      return false;
    }
    return true;
  }

  // bool validateDropdown

  var startDate = ''.obs;
  var endDate = ''.obs;

  void pickDate({
    required bool isStartDate,
    required BuildContext context,
  }) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.day.toString().padLeft(2, '0')}-"
          "${pickedDate.month.toString().padLeft(2, '0')}-"
          "${pickedDate.year}";
      if (isStartDate) {
        startDate.value = formattedDate;
      } else {
        endDate.value = formattedDate;
      }
    }
  }
   var selectedFiles = <File>[].obs;

  Future<void> pickMediaFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mov'],
    );

    if (result != null) {
      selectedFiles.value = result.paths.map((path) => File(path!)).toList();
    }
  }
}
