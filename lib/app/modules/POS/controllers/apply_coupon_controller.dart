import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ApplyCouponController extends GetxController {
  final TextEditingController couponCode = TextEditingController();
  final RxString appliedCoupon = RxString('');
  final RxDouble discountAmount = 0.0.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = RxString('');

  // Sample coupon data (replace with your actual data source)
  final Map<String, dynamic> validCoupons = {
    'TRYNEW': {
      'discount_percent': 60,
      'min_cart_value': 500,
      'max_discount': 1000,
      'description': 'First time shopping coupon',
    },
    'WELCOME20': {
      'discount_percent': 20,
      'min_cart_value': 1000,
      'max_discount': 500,
      'description': 'Welcome discount coupon',
    },
  };

  // For demo purposes - replace with actual cart total from your state
  final double cartTotal = 520.0;

  void applyCoupon() async {
    try {
      isLoading(true);
      errorMessage('');

      final code = couponCode.text.trim().toUpperCase();

      if (code.isEmpty) {
        errorMessage('Please enter a coupon code');
        return;
      }

      if (!validCoupons.containsKey(code)) {
        errorMessage('Invalid coupon code');
        return;
      }

      final coupon = validCoupons[code];
      final discount = _calculateDiscount(coupon!);

      if (discount <= 0) {
        errorMessage('Coupon not applicable to this cart');
        return;
      }

      appliedCoupon(code);
      discountAmount(discount);
      Get.closeAllSnackbars();
      Get.back(closeOverlays: true);
      (result: {'code': code, 'discount': discount});
    } catch (e) {
      errorMessage('Error applying coupon');
    } finally {
      isLoading(false);
    }
  }

  double _calculateDiscount(Map<String, dynamic> coupon) {
    final discountPercent = coupon['discount_percent'] as int;
    final minCartValue = coupon['min_cart_value'] as int;
    final maxDiscount = coupon['max_discount'] as int;

    if (cartTotal < minCartValue) return 0;

    final calculatedDiscount = (cartTotal * discountPercent) / 100;
    return calculatedDiscount > maxDiscount
        ? maxDiscount.toDouble()
        : calculatedDiscount;
  }

  void clearCoupon() {
    couponCode.clear();
    appliedCoupon('');
    discountAmount(0.0);
    errorMessage('');
  }

  @override
  void onClose() {
    couponCode.dispose();
    super.onClose();
  }
}
