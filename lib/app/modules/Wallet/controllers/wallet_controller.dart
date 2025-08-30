import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletController extends GetxController with GetTickerProviderStateMixin {
  //TODO: Implement WalletController
  late TabController tabController;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    withdrawalRequests.addAll([
      {
        'amount': '21.23',
        'timestamp': '18 Apr 2025 03:17 PM',
        'type': 'UPI',
        'status': 'Pending',
      },
      {
        'amount': '51.23',
        'timestamp': '18 Apr 2025 03:17 PM',
        'type': 'Bank Account',
        'status': 'Pending',
      },
      {
        'amount': '22.23',
        'timestamp': '18 Apr 2025 03:17 PM',
        'type': 'UPI',
        'status': 'Pending',
      },
    ]);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    account.dispose();
    tabController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
  var amountType = <Map<String, String>>[].obs;
  var isWithdrawal = false.obs;
  var isUpi = true.obs;
  var isAccount = false.obs;
  var account = TextEditingController();
  var withdrawalRequests = <Map<String, String>>[].obs; //
}
