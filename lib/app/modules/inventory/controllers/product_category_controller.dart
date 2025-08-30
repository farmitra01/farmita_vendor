import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCategoryController extends GetxController
     {
  
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

  RxBool isSwitched = false.obs;

  var selectedIndex = 0.obs;

  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}
