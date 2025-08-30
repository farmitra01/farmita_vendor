import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddCouponsController extends GetxController {
  final TextEditingController couponCode = TextEditingController();
  final RxString appliedCoupon = ''.obs;
  final RxDouble discountAmount = 0.0.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Observable list for coupons
  final RxList<Map<String, dynamic>> validCoupons =
      <Map<String, dynamic>>[].obs;

  // Observable list for switch states
  final RxList<RxBool> isSwitched = <RxBool>[].obs;

  // Filtered coupons by coupon_type
  List<Map<String, dynamic>> getPromotionalCoupons() {
    return validCoupons
        .where((coupon) => coupon['coupon_type'] == 'Promotional')
        .toList();
  }

  List<Map<String, dynamic>> getRegularCoupons() {
    return validCoupons
        .where((coupon) => coupon['coupon_type'] == 'Regular')
        .toList();
  }

  List<Map<String, dynamic>> getOtherCoupons() {
    return validCoupons
        .where((coupon) => coupon['coupon_type'] == 'Others')
        .toList();
  }

  // For demo purposes - replace with actual cart total
  final double cartTotal = 520.0;

  @override
  void onInit() {
    super.onInit();
    // Log raw Get.arguments for debugging
    print('Raw Get.arguments: ${Get.arguments}');
    print('Get.arguments type: ${Get.arguments.runtimeType}');

    // Initialize coupons from Get.arguments
    final couponData = Get.arguments;
    if (couponData is List<Map<String, dynamic>> && couponData.isNotEmpty) {
      try {
        validCoupons.assignAll(
          couponData.map((coupon) {
            final couponType =
                coupon['coupon_type']?.toString().trim() ?? 'Others';
            final discountType =
                coupon['discount_type']?.toString().trim() ?? 'Percentage';
            // Normalize coupon type to handle case sensitivity
            final normalizedCouponType =
                ['Promotional', 'Regular', 'Others'].contains(couponType)
                    ? couponType
                    : 'Others';
            final processedCoupon = {
              'code':
                  coupon['coupon_code']?.toString().trim().toUpperCase() ??
                  'UNKNOWN',
              'discount':
                  int.tryParse(coupon['discount']?.toString() ?? '0') ?? 0,
              'discount_type':
                  discountType == 'Amount' ? 'Amount' : 'Percentage',
              'min_cart_value':
                  int.tryParse(coupon['minimum_purchase']?.toString() ?? '0') ??
                  0,
              'max_discount':
                  int.tryParse(coupon['maximum_discount']?.toString() ?? '0') ??
                  0,
              'description':
                  coupon['title']?.toString().trim() ?? 'No description',
              'is_active':
                  normalizedCouponType == 'Promotional' ||
                  normalizedCouponType == 'Regular',
              'coupon_type': normalizedCouponType,
              'user_limit': coupon['user_limit']?.toString().trim() ?? '0',
              'start_date': coupon['start_date']?.toString().trim() ?? 'N/A',
              'end_date': coupon['end_date']?.toString().trim() ?? 'N/A',
            };
            print('Processed coupon: $processedCoupon');
            return processedCoupon;
          }).toList(),
        );
        print('Total coupons loaded: ${validCoupons.length}');
        print('Processed validCoupons: ${validCoupons.toJson()}');
        validCoupons.refresh(); // Force UI update
      } catch (e) {
        Get.snackbar('Error', 'Failed to load coupon data: $e');
        print('Error processing Get.arguments: $e');
        validCoupons.clear();
      }
    } else {
      Get.snackbar('Warning', 'No valid coupon data provided in arguments');
      print('Invalid or empty Get.arguments: $couponData');
      validCoupons.clear();
    }
    // Initialize switch states based on is_active
    initializeSwitches();
  }

  void applyCoupon() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final code = couponCode.text.trim().toUpperCase();
      if (code.isEmpty) {
        errorMessage.value = 'Please enter a coupon code';
        return;
      }

      final coupon = validCoupons.firstWhereOrNull((c) => c['code'] == code);
      if (coupon == null) {
        errorMessage.value = 'Invalid coupon code';
        return;
      }

      if (!(coupon['is_active'] ?? false)) {
        errorMessage.value = 'This coupon has expired';
        return;
      }

      // Check if coupon is expired based on end_date
      final endDateStr = coupon['end_date'] as String?;
      if (endDateStr != null && endDateStr != 'N/A') {
        try {
          final endDate = DateFormat('dd-MM-yyyy').parse(endDateStr);
          if (endDate.isBefore(DateTime.now())) {
            coupon['is_active'] = false; // Update status to expired
            initializeSwitches(); // Re-sync switches
            validCoupons.refresh();
            errorMessage.value = 'This coupon has expired';
            return;
          }
        } catch (e) {
          errorMessage.value = 'Invalid coupon end date format';
          return;
        }
      }

      final discount = _calculateDiscount(coupon);
      if (discount <= 0) {
        errorMessage.value = 'Coupon not applicable to this cart';
        return;
      }

      appliedCoupon.value = code;
      discountAmount.value = discount;
      Get.snackbar('Success', 'Coupon $code applied! Discount: ₹$discount');
      Get.closeAllSnackbars();
      Get.back(closeOverlays: true);
      (result: {'code': code, 'discount': discount});
    } catch (e) {
      errorMessage.value = 'Error applying coupon: $e';
      print('Error applying coupon: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void addCoupon({
    required String code,
    required int discount,
    required String discountType,
    required int minCartValue,
    required int maxDiscount,
    required String description,
    String couponType = 'Promotional',
    String userLimit = '0',
    String startDate = '',
    String endDate = '',
  }) {
    if (code.isEmpty ||
        discount <= 0 ||
        minCartValue <= 0 ||
        maxDiscount <= 0) {
      Get.snackbar('Error', 'Please fill all fields with valid values');
      return;
    }

    // Validate coupon type
    if (!['Promotional', 'Regular', 'Others'].contains(couponType)) {
      Get.snackbar('Error', 'Invalid coupon type');
      return;
    }

    // Validate discount type
    if (!['Percentage', 'Amount'].contains(discountType)) {
      Get.snackbar('Error', 'Invalid discount type');
      return;
    }

    // Validate date formats
    if (startDate.isNotEmpty && startDate != 'N/A') {
      try {
        DateFormat('dd-MM-yyyy').parse(startDate);
      } catch (e) {
        Get.snackbar('Error', 'Invalid start date format');
        return;
      }
    }
    if (endDate.isNotEmpty && endDate != 'N/A') {
      try {
        DateFormat('dd-MM-yyyy').parse(endDate);
      } catch (e) {
        Get.snackbar('Error', 'Invalid end date format');
        return;
      }
    }

    validCoupons.add({
      'code': code.toUpperCase(),
      'discount': discount,
      'discount_type': discountType,
      'min_cart_value': minCartValue,
      'max_discount': maxDiscount,
      'description': description.isEmpty ? 'No description' : description,
      'is_active': couponType != 'Others',
      'coupon_type': couponType,
      'user_limit': userLimit,
      'start_date': startDate.isEmpty ? 'N/A' : startDate,
      'end_date': endDate.isEmpty ? 'N/A' : endDate,
    });
    isSwitched.add(RxBool(couponType != 'Others'));
    validCoupons.refresh();
    Get.snackbar('Success', 'Coupon $code added!');
    print('Added coupon: $code');
  }

  void deleteCoupon(int index) {
    if (index >= 0 && index < validCoupons.length) {
      final code = validCoupons[index]['code'];
      validCoupons.removeAt(index);
      isSwitched.removeAt(index);
      validCoupons.refresh();
      Get.snackbar('Deleted', 'Coupon $code removed');
      print('Deleted coupon: $code');
    }
  }

  double _calculateDiscount(Map<String, dynamic> coupon) {
    final discount = (coupon['discount'] as int?) ?? 0;
    final discountType = coupon['discount_type'] as String? ?? 'Percentage';
    final minCartValue = (coupon['min_cart_value'] as int?) ?? 0;
    final maxDiscount = (coupon['max_discount'] as int?) ?? 0;

    if (cartTotal < minCartValue) return 0.0;

    double calculatedDiscount;
    if (discountType == 'Amount') {
      calculatedDiscount = discount.toDouble();
    } else {
      calculatedDiscount = (cartTotal * discount) / 100;
    }

    return calculatedDiscount > maxDiscount
        ? maxDiscount.toDouble()
        : calculatedDiscount;
  }

  void clearCoupon() {
    couponCode.clear();
    appliedCoupon.value = '';
    discountAmount.value = 0.0;
    errorMessage.value = '';
  }

  void initializeSwitches() {
    isSwitched.assignAll(
      validCoupons
          .map<RxBool>((coupon) => RxBool(coupon['is_active'] ?? false))
          .toList(),
    );
    print('Switches initialized for ${validCoupons.length} coupons');
  }

  void toggleSwitch(int index, bool value) {
    if (index >= 0 && index < isSwitched.length) {
      isSwitched[index].value = value;
      validCoupons[index]['is_active'] = value;
      validCoupons.refresh();
      print('Toggled switch for coupon at index $index to $value');
    }
  }

  @override
  void onClose() {
    couponCode.dispose();
    for (var switchState in isSwitched) {
      switchState.close();
    }
    super.onClose();
  }
}
