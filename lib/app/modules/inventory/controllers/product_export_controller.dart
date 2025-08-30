import 'package:get/get.dart';

class ProductExportController extends GetxController {
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

  final List<String> items = [
    'All Data',
    'Category ',
    'Sub - Category ',
    'Date',
    'ID'
  ];
  var selectedItem = Rxn<String>();

  final List<String> Instructions = [
    'Download the format file and fill it with the required data',
    'Refer to the example file for correct formatting.',
    'Ensure the file is in .xls or .xlsx format before uploading.',
    'Enter data as per the given format.',
    'Set parent category position as 0 and sub-category as 1.',
    'Leave the parent ID empty for main categories and assign it for subcategories.',
    'Select the upload option and submit the .xls/.xlsx file.',
    'Click the upload button to process the import.',
    'Upload category images and copy their paths if needed.'
  ];
}
