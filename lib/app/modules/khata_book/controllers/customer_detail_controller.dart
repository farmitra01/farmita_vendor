import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerDetailController extends GetxController {
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initializeCheckboxes();
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

  var date = TextEditingController();
  void pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final formattedDate =
          "${pickedDate.day.toString().padLeft(2, '0')}-"
          "${pickedDate.month.toString().padLeft(2, '0')}-"
          "${pickedDate.year}";
      date.text = formattedDate;
    }
  }

  void addTransection() {
    if (requestMoney.text.isNotEmpty &&
        requestMoneydate.text.isNotEmpty &&
        purpose.text.isNotEmpty) {
      // Validate that requestMoney is a valid number
      if (double.tryParse(requestMoney.text) == null) {
        Get.snackbar("Validation Error", "Amount must be a valid number");
        return;
      }

      print(
        'Inserting transaction at index 0: ${requestMoney.text}, ${requestMoneydate.text}, ${purpose.text}',
      );
      transectionlist.insert(0, <String, String>{
        'orderid': 'You Give',
        'dueAmount': requestMoney.text,
        'date&time': requestMoneydate.text,
        'purpose': purpose.text,
        'status': 'Reminder',
      });

      initializeCheckboxes();
      clearForm();
    } else {
      Get.snackbar("Validation Error", "All fields are required");
    }
  }

  void pickRequestMoneyDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      requestMoneydate.text =
          "${pickedDate.day.toString().padLeft(2, '0')} ${_monthString(pickedDate.month)} ${pickedDate.year}, ${TimeOfDay.now().format(context)}";
    }
  }

  String _monthString(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  void clearForm() {
    requestMoney.clear();
    requestMoneydate.clear();
    purpose.clear();
  }

  var requestMoney = TextEditingController();
  var requestMoneydate = TextEditingController();
  var purpose = TextEditingController();
  RxBool isShowCheckbox = false.obs;
  RxBool allSelected = false.obs;
  RxList<bool> selectedList = <bool>[].obs;

  void toggleAll(bool? value) {
    allSelected.value = value ?? false;
    selectedList.value = List.filled(transectionlist.length, allSelected.value);
    allSelected.value == true
        ? isShowCheckbox.value = true
        : isShowCheckbox.value = false;
  }

  void toggleIndividual(int index, bool? value) {
    selectedList[index] = value ?? false;
    allSelected.value = selectedList.every((element) => element == true);
  }

  void initializeCheckboxes() {
    selectedList.value = List.generate(
      transectionlist.length,
      (index) => false,
    );
  }

  RxList<Map<String, String>> transectionlist =
      [
        {
          'orderid': 'You Give',
          'dueAmount': '4532',
          'date&time': '02 May 2025, 06:10 PM',
          'purpose': 'For Food',
          'status': 'Reminder',
        },
        {
          'orderid': 'You Receive',
          'dueAmount': '4532',
          'date&time': '02 May 2025, 06:10 PM',
          'purpose': 'For Fuel',
          'status': 'Reminder',
        },
        {
          'orderid': 'You Give',
          'dueAmount': '4532',
          'date&time': '02 May 2025, 06:10 PM',
          'purpose': 'For Food',
          'status': 'Pay',
        },
        {
          'orderid': 'You Give',
          'dueAmount': '4532',
          'date&time': '02 May 2025, 06:10 PM',
          'purpose': 'For Food',
          'status': 'Reminder',
        },
        {
          'orderid': 'You Receive',
          'dueAmount': '4532',
          'date&time': '02 May 2025, 06:10 PM',
          'purpose': 'For Fuel',
          'status': 'Pay',
        },
      ].obs;

  var checkBoxList = List.generate(5, (index) => false.obs).obs;

  void toggleCheckbox(int index, bool value) {
    checkBoxList[index].value = value;
  }

  final TextEditingController totalBillAmount = TextEditingController();
  final int totalAmount = 800; // Initial amount
  var remainingAmount = 800.obs; // Observable value

  void updateRemainingAmount(String value) {
    int enteredAmount = int.tryParse(value) ?? 0;
    remainingAmount.value = totalAmount - enteredAmount;
  }

  var giveAmount = TextEditingController();
  var givepurpose = TextEditingController();
  var givedate = TextEditingController();
  RxString selectedMethod = 'Cash'.obs;
}
