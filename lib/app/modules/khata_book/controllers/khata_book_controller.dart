import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KhataBookController extends GetxController
    with GetTickerProviderStateMixin {
  //TODO: Implement KhataBookController
  late TabController tabController;
  final count = 0.obs;
  final currentTabIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      currentTabIndex.value = tabController.index;
    });
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
  var search = TextEditingController();

  var listCategories = ['All', 'Due Today ', 'Upcoming', 'No Due Date'].obs;

  var selectedIndex = 0.obs;

  void selectCategories(int index) {
    selectedIndex.value = index;
  }
}
