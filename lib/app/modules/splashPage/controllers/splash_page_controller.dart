import 'package:farmitra/app/modules/home/views/home_bottom_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    // Get.closeAllSnackbars();
    print('Stored Vendor Details on splash page ${box.read('user_details')} ');
    print('Stored Vendor Role on splash page ${box.read('user_role')}');

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    animationController.forward();

    Future.delayed(const Duration(seconds: 1), () {
      // final box = GetStorage();

      // ✅ Corrected here
      if ((box.read('user_token') != null) && box.read('user_role') != null) {
        print('User Type : ${box.read('user_role')}');
        Get.offAll(() => HomeBottomBarView());
      } else if (box.read('user_token') == null ||
          box.read('user_token') != null) {
        Get.offAllNamed('/login');
      }
    });
  }

  void closeOpenedSnackbar() {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
