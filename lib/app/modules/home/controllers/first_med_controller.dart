import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstMedController extends GetxController
    with GetTickerProviderStateMixin {
  final count = 0.obs;
  late TabController tabController;
  late TabController threeController;
  late TabController fourTabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    threeController = TabController(length: 3, vsync: this);
    fourTabController = TabController(length: 4, vsync: this);
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }  
   
 final isPrescriptionTapped = true.obs;
  final isNormalTapped = false.obs;


}
