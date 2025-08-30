import 'package:farmitra/app/modules/registration/controllers/store_category_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertprofileController extends GetxController {
  final StoreCategoryController storeCategoryController = Get.put(
    StoreCategoryController(),
  );
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

  List<Map<String, dynamic>> getDetailsList() {
    return [
      // {'icon': Icons.manage_accounts_sharp, 'details': 'My Profile'},
      {'icon': Icons.layers, 'details': 'My Feed'},
      {'icon': Icons.calendar_month, 'details': 'My Appointments'},
      {'icon': Icons.business_center, 'details': 'Expert Profile'},
      // {
      //   'icon': Icons.assignment_add,
      //   'details':
      //       storeCategoryController.previousPageGridTitle == 'Expert'
      //           ? 'Expert KYC'
      //           : storeCategoryController.previousPageGridTitle == 'Rental'
      //           ? 'Rental KYC'
      //           : 'Expert KYC',
      // },
      {'icon': Icons.payments, 'details': 'Bank Details'},
      {'icon': Icons.event_note, 'details': 'Manage Appointment'},
      {'icon': Icons.shopping_cart, 'details': 'My Shopping Cart'},
      {'icon': Icons.privacy_tip_sharp, 'details': 'Privacy Policy'},
      {'icon': Icons.verified_user, 'details': 'Terms & Conditions'},
      {'icon': Icons.settings, 'details': 'Settings'},
    ];
  }
}
