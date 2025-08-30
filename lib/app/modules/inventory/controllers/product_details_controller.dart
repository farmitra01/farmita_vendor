
import 'package:farmitra/app/data/models/inventory_model/bottom_sheet_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  // Initialize the TabController when the controller is created
  @override
  void onInit() {
    super.onInit();
    tabController =
        TabController(length: 6, vsync: this); // Set the number of tabs here
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  RxBool isSwitched = false.obs;

  RxBool isChecked = false.obs;
  RxList<bool> switchStates = List.generate(15, (index) => false).obs;
  RxBool isAllSelected = false.obs; // To track "select all" checkbox state
  RxList<bool> productSelections =
      List.generate(15, (index) => false).obs; // For 15 products
  RxInt selectedIndex = (-1).obs;
  RxList<bool> selectedItems =
      List<bool>.filled(15, false).obs; // Initial 15 items on hold check box
  RxBool isSwitchedState = false.obs;
  void selectIndex(int index) {
    selectedIndex.value = index;
  }

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

//  switck
  void toggleSwitch(int index, bool value) {
    switchStates[index] = value;
  }

//  on hold press check box
  void toggleSelection(int index) {
    selectedItems[index] = !selectedItems[index]; // Toggle selection
  }

  List<BottomSheetData> bottom_sheet_data = [
    BottomSheetData(
        icon: Icon(Icons.move_to_inbox_outlined), text: 'Move to\ninventry'),
    BottomSheetData(icon: Icon(Icons.edit_outlined), text: "Edit" ),
    BottomSheetData(icon: Icon(Icons.delete_outline), text: "Delete\nProduct"),
    BottomSheetData(icon: Icon(Icons.print_rounded), text: 'Print'),
  ];
}
