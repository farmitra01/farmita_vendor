import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventryController extends GetxController {
  //TODO: Implement InventryController

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
   
   var searchbar = TextEditingController();

  RxBool isSwitched = false.obs;

  RxBool isCheck = false.obs;
  RxList<bool> switchStates = List.generate(15, (index) => true).obs;
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
    isCheck.value = !isCheck.value;
  }

//  switck
  void toggleSwitch(int index, bool value) {
    switchStates[index] = value;
  }

//  on hold press check box
  void toggleSelection(int index) {
    selectedItems[index] = !selectedItems[index]; // Toggle selection
  }

  var isTabActiev = false.obs;
  void toggletabbar() {
    // ✅ Returns a value
    isTabActiev.value = !isTabActiev.value;
    // return isTabActiev.value ? Colors.black : Colors.grey;
  }


  List<Map<String, dynamic>> seeOptionList = [
    {'text': 'Edit', 'icon': Icons.edit_outlined},
    {
      'text': 'Out of\nStock',
      'icon': Icons.shopping_cart_checkout
    }, // ✅ Fixed key
    {'text': 'Add to\nCollection', 'icon': Icons.dataset_outlined}, // ✅ Fixed key
    {'text': 'Delete\nProduct', 'icon': Icons.delete_outline},
    {'text': 'Print', 'icon': Icons.print_rounded},
  ];

  // List<BottomSheetData> bottom_sheet_data = [
  //   BottomSheetData(
  //       icon: Icon(Icons.move_to_inbox_outlined), text: 'Move to\ninventry'),
  //   BottomSheetData(icon: Icon(Icons.edit_outlined), text: "Edit"),
  //   BottomSheetData(icon: Icon(Icons.delete_outline), text: "Delete\nProduct"),
  //   BottomSheetData(icon: Icon(Icons.print_rounded), text: 'Print'),
  // ];
}
