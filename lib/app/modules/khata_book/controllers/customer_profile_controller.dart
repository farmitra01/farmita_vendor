import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerProfileController extends GetxController {
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

  List<Map<String, dynamic>> profileList = [
    {'icon': Icons.person_2_rounded, 'name': 'Shankar Rane'},
    {'icon': Icons.call_end_rounded, 'name': '9555032605'},
    {'icon': Icons.location_on, 'name': 'Address'},
    {'icon': Icons.description, 'name': 'GST Number'},
    {'icon': Icons.account_balance, 'name': 'Add Bank'},
    {'icon': Icons.swap_horiz, 'name': 'Change to Supplier'},
    {'icon': Icons.settings, 'name': 'Setting'},
  ];
}
