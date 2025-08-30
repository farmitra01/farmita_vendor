import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SuggestProductController extends GetxController {
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
  final List<String> imagePaths = [
    'assets/images/damage_leaves_01.jpg',
    'assets/images/damage_leaves_02.jpg',
    'assets/images/damage_leaves_03.jpg',
  ];
  var search = TextEditingController();
  var isChecked = false.obs;
  var selectedProducts = <int>{}.obs; // Set to track selected indices
  var isShowCheckbox = false.obs;
  
}
