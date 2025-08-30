import 'package:farmitra/app/constants/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppcolorsettingController extends  GetxController {
  final appbarColor = TextEditingController();
  final gradianMixColor = TextEditingController();
  final buttonFirstGradiantColor = TextEditingController();
  final buttonSecondGradiatColor = TextEditingController();

void applyColors() {
    try {
      // AppColors.appBarColor = _parseColor(appbarColor.text);
      // AppColors.primaryGradinatMixColor = _parseColor(gradianMixColor.text);
      // AppColors.primaryFirstGradiant = _parseColor(buttonFirstGradiantColor.text);
      // AppColors.primarySecondGradiant = _parseColor(buttonSecondGradiatColor.text);
      update(); // notify any UI using GetBuilder if needed
    } catch (e) {
      Get.snackbar("Invalid Color", "Please enter valid hex color codes like #123456");
    }
  }

  Color _parseColor(String hexCode) {
    hexCode = hexCode.replaceAll('#', '');
    if (hexCode.length == 6) {
      hexCode = 'FF$hexCode'; 
    }
    return Color(int.parse('0x$hexCode'));
  }

  @override
  void onClose() {
    appbarColor.dispose();
    gradianMixColor.dispose();
    buttonFirstGradiantColor.dispose();
    buttonSecondGradiatColor.dispose();
    super.onClose();
  }

}