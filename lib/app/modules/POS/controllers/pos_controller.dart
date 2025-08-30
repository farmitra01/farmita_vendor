import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PosController extends GetxController {
  //TODO: Implement PosController

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

  var isShowItemAddedBar = false.obs;

  var searchbar = TextEditingController();
  void increment() => count.value++;

  RxList<int> quantities = List.filled(20, 0).obs;
  void incrementQuantity(int index) {
    quantities[index]++; 
  }

  void decrementQuantity(int index) {
    if (quantities[index] > 0) {
      quantities[index]--;
    }
  }

  List<Map<String, dynamic>> categoryList = [
    {'icon': Icons.local_grocery_store, 'name': 'Grocery'},
    {'icon': Icons.headphones, 'name': 'HeadPhones'},
    {'icon': Icons.health_and_safety, 'name': 'Beauty'},
    {'icon': Icons.smartphone, 'name': 'SmartPhone'},
    {'icon': Icons.child_care, 'name': 'Kids'},
    {'icon': Icons.toys, 'name': 'Toys'},
  ];
}
