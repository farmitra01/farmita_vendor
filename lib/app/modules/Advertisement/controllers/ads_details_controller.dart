import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class AdsDetailsController extends GetxController {
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
