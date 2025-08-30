import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewCouponController extends GetxController {
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Check if editing an existing coupon
    if (Get.arguments is Map<String, dynamic>) {
      final coupon = Get.arguments as Map<String, dynamic>;
      title.text = coupon['title']?.toString() ?? '';
      couponcode.text = coupon['coupon_code']?.toString() ?? '';
      userlimit.text = coupon['user_limit']?.toString() ?? '';
      minpurchase.text = coupon['minimum_purchase']?.toString() ?? '';
      discount.text = coupon['discount']?.toString() ?? '';
      maxdiscount.text = coupon['maximum_discount']?.toString() ?? '';
      selectedItem.value = coupon['coupon_type']?.toString() ?? '';
      selectedDiscount.value = coupon['discount_type'] == 'Percentage' ? 'Percent' : coupon['discount_type']?.toString() ?? '';
      startDate.value = coupon['start_date']?.toString() ?? '';
      endDate.value = coupon['end_date']?.toString() ?? '';
      print('Editing coupon: $coupon');
    }
  }

  @override
  void onClose() {
    title.dispose();
    couponcode.dispose();
    userlimit.dispose();
    minpurchase.dispose();
    discount.dispose();
    maxdiscount.dispose();
    super.onClose();
  }

  final title = TextEditingController();
  final couponcode = TextEditingController();
  final userlimit = TextEditingController();
  final minpurchase = TextEditingController();
  final discount = TextEditingController();
  final maxdiscount = TextEditingController();

  final selectedItem = ''.obs;
  final isDropdownValid = true.obs;
  final List<String> couponTypes = ['Promotional', 'Regular', 'Others'];

  void updatedSelectedValue(String value) {
    selectedItem.value = value;
    isDropdownValid.value = true;
    print('Selected coupon type: $value');
  }

  bool validateDropdown() {
    if (selectedItem.value.isEmpty) {
      isDropdownValid.value = false;
      return false;
    }
    return true;
  }

  final selectedDiscount = ''.obs;
  final List<String> discountTypes = ['Percent', 'Amount'];

  void updateSelectedDiscount(String value) {
    selectedDiscount.value = value;
    isDropdownValid.value = true;
    print('Selected discount type: $value');
  }

  final startDate = ''.obs;
  final endDate = ''.obs;

  void pickDate({required bool isStartDate, required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
      if (isStartDate) {
        startDate.value = formattedDate;
      } else {
        endDate.value = formattedDate;
      }
      print('${isStartDate ? 'Start' : 'End'} date selected: $formattedDate');
    }
  }

  bool validateInputs() {
    bool isValid = true;
    if (title.text.trim().isEmpty) {
      Get.snackbar('Error', 'Title is required');
      isValid = false;
    }
    if (couponcode.text.trim().isEmpty || couponcode.text.trim().length < 4) {
      Get.snackbar('Error', 'Coupon code must be at least 4 characters');
      isValid = false;
    }
    if (userlimit.text.trim().isEmpty || int.tryParse(userlimit.text.trim()) == null || int.parse(userlimit.text.trim()) <= 0) {
      Get.snackbar('Error', 'Valid user limit is required');
      isValid = false;
    }
    if (minpurchase.text.trim().isEmpty ||
        int.tryParse(minpurchase.text.trim()) == null ||
        int.parse(minpurchase.text.trim()) <= 0) {
      Get.snackbar('Error', 'Valid minimum purchase is required');
      isValid = false;
    }
    if (discount.text.trim().isEmpty || int.tryParse(discount.text.trim()) == null || int.parse(discount.text.trim()) <= 0) {
      Get.snackbar('Error', 'Valid discount is required');
      isValid = false;
    }
    if (maxdiscount.text.trim().isEmpty ||
        int.tryParse(maxdiscount.text.trim()) == null ||
        int.parse(maxdiscount.text.trim()) <= 0) {
      Get.snackbar('Error', 'Valid maximum discount is required');
      isValid = false;
    }
    if (!validateDropdown()) {
      Get.snackbar('Error', 'Coupon type is required');
      isValid = false;
    }
    if (selectedDiscount.value.isEmpty) {
      Get.snackbar('Error', 'Discount type is required');
      isValid = false;
    }
    if (startDate.value.isEmpty) {
      Get.snackbar('Error', 'Start date is required');
      isValid = false;
    }
    if (endDate.value.isEmpty) {
      Get.snackbar('Error', 'End date is required');
      isValid = false;
    }
    print('Input validation result: $isValid');
    return isValid;
  }

  Map<String, dynamic> collectCouponData() {
    final couponData = {
      'title': title.text.trim(),
      'coupon_code': couponcode.text.trim(),
      'user_limit': userlimit.text.trim(),
      'minimum_purchase': minpurchase.text.trim(),
      'discount': discount.text.trim(),
      'maximum_discount': maxdiscount.text.trim(),
      'coupon_type': selectedItem.value,
      'discount_type': selectedDiscount.value == 'Percent' ? 'Percentage' : 'Amount',
      'start_date': startDate.value,
      'end_date': endDate.value,
    };
    print('Collected coupon data: $couponData');
    return couponData;
  }
}