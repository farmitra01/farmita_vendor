import 'package:get/get.dart';

class BillDetailsController extends GetxController {
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

  List<Map<String, dynamic>> billDetails =
      [
        {'title': 'Item Total', 'amount': '₹470'},
        {'title': 'Delivery Fee: 3.7 Km', 'amount': '₹35'},
        {'title': 'Handling Charges', 'amount': '₹15'},
        {'title': 'Taxes And Charges', 'amount': '₹50'},
      ].obs;
}
