import 'package:get/get.dart';

class ReviewUploadFileController extends GetxController {
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

  var isImport = false.obs;
  var isShowCheckBox = false.obs;
  var isChecked = false.obs;

  RxBool isAllSelected = false.obs; // To track "select all" checkbox state
  RxList<bool> productSelections =
      List.generate(15, (index) => false).obs; // For 15 products
  RxInt selectedIndex = (-1).obs;
  RxList<bool> selectedItems = List<bool>.filled(15, false).obs;

  void toggleSelectAll(bool value) {
    isAllSelected.value = value;
    // Update all product selections based on the "select all" state
    productSelections.fillRange(0, productSelections.length, value);
  }

  // Toggle individual product selection
  void toggleProductSelection(int index, bool value) {
    productSelections[index] = value;
  }

  void showCheckBox() {
    isChecked.value = !isChecked.value;
  }
   void toggleSelection(int index) {
    selectedItems[index] = !selectedItems[index]; // Toggle selection
  }
}
