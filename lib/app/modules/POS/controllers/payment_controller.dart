import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
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

  // var totalBillAmount = TextEditingController();

  List<Map<String, dynamic>> billDetails = [
    {'type': 'Total Item', 'amount': '₹470'},
    {'type': 'Delievery Fee: 3.7 KM', 'amount': '₹35'},
    {'type': 'Handling Charges', 'amount': '₹15'},
    {'type': 'Taxes and charges', 'amount': '₹50'},
  ];

  // var isPaymentMethodSelected = false.obs;
  var selectedPaymentIndex = Rx<int?>(null);

  // Method to toggle the selection
  void toggleSelection(int index) {
    if (selectedPaymentIndex.value == index) {
      // If the same item is tapped, deselect it
      selectedPaymentIndex.value = null;
    } else {
      // Select the new item
      selectedPaymentIndex.value = index;
    }
  }

  var checkBoxList = List.generate(5, (index) => false.obs).obs;

  void toggleCheckbox(int index, bool value) {
    checkBoxList[index].value = value;
  }

  final TextEditingController totalBillAmount = TextEditingController();
  final int totalAmount = 1320; // Initial amount
  var remainingAmount = 1320.obs; // Observable value

  void updateRemainingAmount(String value) {
    int enteredAmount = int.tryParse(value) ?? 0;
    remainingAmount.value = totalAmount - enteredAmount;
  }

 List<Map<String, dynamic>> paymentMethod = [
  {'icon': Icons.account_balance, 'type': 'Bank Transfer'},
  {'icon': Icons.credit_card, 'type': 'Card Payment'},
  {'icon': Icons.qr_code, 'type': 'UPI-QR'},  // Fixed: 'upi_pay' is incorrect
  {'icon': Icons.account_balance_wallet, 'type': 'Wallet Transfer'},
  {'icon': Icons.payments, 'type': 'Cash'},
];
}
