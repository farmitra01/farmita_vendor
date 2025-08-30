import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// this is just for testing 
class RewardController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final RxBool isScrolled = false.obs;
  @override
  void onInit() {
    super.onInit();
    // Attach listener to scrollController
    scrollController.addListener(() {
      if (scrollController.offset > 250 && !isScrolled.value) {
        isScrolled.value = true; // Mark as scrolled
      } else if (scrollController.offset <= 250 && isScrolled.value) {
        isScrolled.value = false; // Reset when scrolled back to top
      }
    });
  }
  @override
  void onClose() {
    scrollController.dispose(); // Dispose of controller when not in use
    super.onClose();
  }

  final selectedIndex = 0.obs;
  void updateSelectedTab(int index) {
    selectedIndex.value = index;
  }
  RxList transactions = [
    {'type': 'earned', 'points': 150, 'date': '24 JAN 2025'},
    {'type': 'redeemed', 'points': -50, 'date': '20 JAN 2025'},
    {'type': 'redeemed', 'points': -100, 'date': '18 JAN 2025'},
    {'type': 'redeemed', 'points': 500, 'date': '29 JAN 2025'},
    {'type': 'earned', 'points': 150, 'date': '24 JAN 2025'},
    {'type': 'redeemed', 'points': -50, 'date': '20 JAN 2025'},
    {'type': 'redeemed', 'points': -100, 'date': '18 JAN 2025'},
    {'type': 'redeemed', 'points': 500, 'date': '29 JAN 2025'},
    {'type': 'earned', 'points': 150, 'date': '24 JAN 2025'},
    {'type': 'redeemed', 'points': -50, 'date': '20 JAN 2025'},
    {'type': 'redeemed', 'points': -100, 'date': '18 JAN 2025'},
    {'type': 'redeemed', 'points': 500, 'date': '29 JAN 2025'},
    {'type': 'redeemed', 'points': -100, 'date': '18 JAN 2025'},
    {'type': 'redeemed', 'points': 500, 'date': '29 JAN 2025'},
    {'type': 'earned', 'points': 150, 'date': '24 JAN 2025'},
    {'type': 'redeemed', 'points': -50, 'date': '20 JAN 2025'},
    {'type': 'redeemed', 'points': -100, 'date': '18 JAN 2025'},
    {'type': 'redeemed', 'points': 500, 'date': '29 JAN 2025'},
  ].obs;

  List get filteredTransactions {
    if (selectedIndex.value == 0) {
      return transactions.where((t) => t['points'] > 0).toList(); // Earned
    } else {
      return transactions.where((t) => t['points'] < 0).toList(); // Redeemed
    }
  }
}