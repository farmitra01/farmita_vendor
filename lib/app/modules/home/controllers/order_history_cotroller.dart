import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistory_Controller extends GetxController with GetTickerProviderStateMixin {
  final count = 0.obs;
  late TabController tabController;
  late TabController threeTabController;
  
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync:  this);
    threeTabController = TabController(length: 3, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();

  }
}