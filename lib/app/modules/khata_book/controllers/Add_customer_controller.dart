import 'package:farmitra/app/modules/khata_book/controllers/khata_book_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddCustomerController extends GetxController {
  final KhataBookController khataBookController = Get.put(
    KhataBookController(),
  );

  final count = 0.obs;

  var name = TextEditingController();
  var number = TextEditingController();
  var gst = TextEditingController();

  late RxString selectedRole;

  @override
  void onInit() {
    super.onInit();

    // Initialize selectedRole based on currentTabIndex
    selectedRole =
        (khataBookController.currentTabIndex.value == 0
                ? 'Customer'
                : 'Supplier')
            .obs;
  }

  void setRole(String role) {
    selectedRole.value = role;
  }

  void increment() => count.value++;
}
