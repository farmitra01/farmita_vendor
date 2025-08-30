import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class BulkUploadController extends GetxController {
  var showDownload = false.obs;
  var selectedFile = Rxn<File>(); // Correct Rxn<File> declaration
  @override
  void onInit() {
    // selectedFile.value = null; // Proper clean
    showDownload.value = false;
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Function to pick a file
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xls', 'xlsx'], // Restrict to Excel files
    );

    if (result != null && result.files.single.path != null) {
      selectedFile.value =
          File(result.files.single.path!); // ✅ Correct assignment
      print("Selected File: ${selectedFile.value?.path}");
    } else {
      print("No file selected");
    }
  }

  // Function to delete the selected file
  void deleteFile() {
    selectedFile.value = null;
  }

  var checkBoxList = List.generate(5, (index) => false.obs).obs;

  void toggleCheckbox(int index, bool value) {
    checkBoxList[index].value = value;
  }

  var isCheckedShow = false.obs;
}
